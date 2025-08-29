#!/usr/bin/env ruby
# frozen_string_literal: true

# RuboCop Warning Promotion Script
# Usage: ruby scripts/promote-warnings.rb <cop_name1> <cop_name2> ...
# Example: ruby scripts/promote-warnings.rb Style/FetchEnvVar Rails/EnumSyntax

require "English"
require "yaml"
require "fileutils"

# Handles promotion of RuboCop warning rules to errors
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
  end

  def promote!
    return usage if @cop_names.empty?

    puts "🚀 Promoting #{@cop_names.length} cops from warnings to errors..."

    create_backups
    promote_cops
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

  def create_backups
    FileUtils.mkdir_p(@backup_dir)

    CONFIG_FILES.each do |file|
      next unless File.exist?(file)

      backup_file = File.join(@backup_dir, File.basename(file))
      FileUtils.cp(file, backup_file)
      puts "📄 Backed up #{file} to #{backup_file}"
    end
  end

  def promote_cops
    @promoted_count = 0
    @not_found = []

    CONFIG_FILES.each do |file|
      next unless File.exist?(file)

      content = File.read(file)
      original_content = content.dup

      @cop_names.each do |cop_name|
        if promote_cop_in_content?(content, cop_name)
          @promoted_count += 1
          puts "✅ Promoted #{cop_name} in #{file}"
        elsif @not_found.exclude?(cop_name) && content.exclude?(cop_name)
          @not_found << cop_name
        end
      end

      File.write(file, content) if content != original_content
    end
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

  def verify_configuration
    puts "\n🔍 Verifying configuration..."

    system("rubocop --config config/default.yml --format simple --dry-run lib/ > /dev/null 2>&1")

    if $CHILD_STATUS.success?
      puts "✅ Configuration is valid"
    else
      puts "❌ Configuration has errors - check syntax"
      restore_backups
    end
  end

  def restore_backups
    puts "🔄 Restoring backups due to configuration errors..."

    CONFIG_FILES.each do |file|
      backup_file = File.join(@backup_dir, File.basename(file))
      next unless File.exist?(backup_file)

      FileUtils.cp(backup_file, file)
      puts "📄 Restored #{file} from backup"
    end
  end

  def show_summary
    puts "\n📊 Summary:"
    puts "  ✅ Successfully promoted: #{@promoted_count} cops"

    if @not_found.any?
      puts "  ❓ Not found: #{@not_found.join(', ')}"
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
