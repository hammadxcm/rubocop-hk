#!/usr/bin/env ruby
# frozen_string_literal: true

# RuboCop Warning Promotion Script
# Usage: ruby scripts/promote-warnings.rb <cop_name1> <cop_name2> ...
# Example: ruby scripts/promote-warnings.rb Style/FetchEnvVar Rails/EnumSyntax

require "English"
require "yaml"
require "fileutils"

# Manages backup operations for configuration files
class BackupManager
  def initialize(backup_dir)
    @backup_dir = backup_dir
  end

  def create_backups(config_files)
    FileUtils.mkdir_p(@backup_dir)

    config_files.each do |file|
      next unless File.exist?(file)

      backup_file = File.join(@backup_dir, File.basename(file))
      FileUtils.cp(file, backup_file)
      puts "📄 Backed up #{file} to #{backup_file}"
    end
  end

  def restore_backups(config_files)
    puts "🔄 Restoring backups due to configuration errors..."

    config_files.each do |file|
      backup_file = File.join(@backup_dir, File.basename(file))
      next unless File.exist?(backup_file)

      FileUtils.cp(backup_file, file)
      puts "📄 Restored #{file} from backup"
    end
  end
end

# Handles the actual promotion of cops from warnings to errors
class CopPromoter
  attr_reader :promoted_count, :not_found_cops

  def initialize
    @promoted_count = 0
    @not_found_cops = []
  end

  def promote_cops(cop_names, config_files)
    config_files.each do |file|
      promote_cops_in_file(file, cop_names) if File.exist?(file)
    end
  end

  private

  def promote_cops_in_file(file, cop_names)
    content = File.read(file)
    original_content = content.dup

    cop_names.each do |cop_name|
      if promote_cop_in_content?(content, cop_name)
        @promoted_count += 1
        puts "✅ Promoted #{cop_name} in #{file}"
      elsif @not_found_cops.exclude?(cop_name) && content.exclude?(cop_name)
        @not_found_cops << cop_name
      end
    end

    File.write(file, content) if content != original_content
  end

  def promote_cop_in_content?(content, cop_name)
    # Pattern to match cop with Severity: warning
    pattern = /^(#{Regexp.escape(cop_name)}:.*?)\n  Severity: warning$/m

    if content.match?(pattern)
      # Remove the Severity: warning line
      content.gsub!(pattern, '\1')
      return true
    end

    false
  end
end

# Main class that orchestrates the warning promotion workflow
class WarningPromoter
  CONFIG_FILES = %w[
    config/rubocop-style.yml
    config/rubocop-rails.yml
    config/rubocop-rspec.yml
    config/rubocop-performance.yml
    config/rubocop-lint.yml
  ].freeze

  def initialize(cop_names)
    @cop_names = cop_names
    @backup_dir = "config/backups/#{Time.now.utc.strftime('%Y%m%d_%H%M%S')}"
    @backup_manager = BackupManager.new(@backup_dir)
    @cop_promoter = CopPromoter.new
  end

  def promote!
    return usage if @cop_names.empty?

    puts "🚀 Promoting #{@cop_names.length} cops from warnings to errors..."

    @backup_manager.create_backups(CONFIG_FILES)
    @cop_promoter.promote_cops(@cop_names, CONFIG_FILES)
    verify_configuration
    show_summary
  end

  private

  def usage
    puts <<~USAGE
      RuboCop Warning Promotion Script

      Usage: ruby scripts/promote-warnings.rb <cop_name1> <cop_name2> ...

      Examples:
        ruby scripts/promote-warnings.rb Style/FetchEnvVar
        ruby scripts/promote-warnings.rb Rails/EnumSyntax Performance/ConstantRegexp
      #{'  '}
      Available cops to promote:
      #{available_warning_cops.map { |cop| "  - #{cop}" }.join("\n")}
    USAGE
  end

  def verify_configuration
    puts "\n🔍 Verifying configuration..."

    system("rubocop --config config/default.yml --format simple --dry-run lib/ > /dev/null 2>&1")

    if $CHILD_STATUS.success?
      puts "✅ Configuration is valid"
    else
      puts "❌ Configuration has errors - check syntax"
      @backup_manager.restore_backups(CONFIG_FILES)
    end
  end

  def show_summary
    puts "\n📊 Summary:"
    puts "  ✅ Successfully promoted: #{@cop_promoter.promoted_count} cops"

    if @cop_promoter.not_found_cops.any?
      puts "  ❓ Not found: #{@cop_promoter.not_found_cops.join(', ')}"
      puts "     (These cops might not exist or are already promoted)"
    end

    puts "\n🎯 Next steps:"
    puts "  1. Run tests: bundle exec rspec"
    puts "  2. Check for new errors: rubocop"
    puts "  3. If issues arise, restore backups from: #{@backup_dir}"

    puts "\n📈 Track progress:"
    puts "  rubocop --format json | jq '.summary.offense_count'"
  end

  def available_warning_cops
    warning_cops = []

    CONFIG_FILES.each do |file|
      next unless File.exist?(file)

      content = File.read(file)

      # Find all cops with Severity: warning
      content.scan(/^([A-Z][^:]+):.*?\n  Severity: warning$/m) do |match|
        warning_cops << match[0]
      end
    end

    warning_cops.uniq.sort
  end
end

# Script execution
if __FILE__ == $PROGRAM_NAME
  promoter = WarningPromoter.new(ARGV)
  promoter.promote!
end
