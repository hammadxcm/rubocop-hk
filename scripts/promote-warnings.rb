#!/usr/bin/env ruby
# frozen_string_literal: true

# RuboCop Warning Promotion Script
# Usage: ruby scripts/promote-warnings.rb <cop_name1> <cop_name2> ...
# Example: ruby scripts/promote-warnings.rb Style/FetchEnvVar Rails/EnumSyntax

require "English"
require "yaml"
require "fileutils"

# Handles file backup operations
class BackupManager
  def initialize(backup_dir)
    @backup_dir = backup_dir
  end

  def create_backups(config_files)
    puts "📁 Creating backups..."
    FileUtils.mkdir_p(@backup_dir)

    config_files.each do |file|
      next unless File.exist?(file)

      backup_file = File.join(@backup_dir, File.basename(file))
      FileUtils.cp(file, backup_file)
      puts "  ✅ Backed up #{file} to #{backup_file}"
    end
  end

  def restore_backups(config_files)
    puts "🔄 Restoring backups due to configuration errors..."

    config_files.each do |file|
      backup_file = File.join(@backup_dir, File.basename(file))
      next unless File.exist?(backup_file)

      FileUtils.cp(backup_file, file)
      puts "  ↩️  Restored #{file}"
    end
  end
end

# Handles cop promotion operations
class CopPromoter
  def initialize
    @promoted_count = 0
    @not_found = []
  end

  def promote_cops(cop_names, config_files)
    config_files.each do |file|
      process_config_file(file, cop_names)
    end
  end

  attr_reader :promoted_count, :not_found_cops

  private

  def process_config_file(file, cop_names)
    return unless File.exist?(file)

    content = File.read(file)
    original_content = content.dup

    cop_names.each do |cop_name|
      if promote_cop_in_content?(content, cop_name)
        @promoted_count += 1
        puts "✅ Promoted #{cop_name} in #{file}"
      elsif @not_found.exclude?(cop_name) && content.exclude?(cop_name)
        @not_found << cop_name
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

# Main class for promoting RuboCop warning rules to errors
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
    @backup_manager = BackupManager.new("config/backups/#{Time.now.utc.strftime('%Y%m%d_%H%M%S')}")
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
      Usage: ruby scripts/promote-warnings.rb <cop_name1> <cop_name2> ...

      Examples:
        ruby scripts/promote-warnings.rb Style/FetchEnvVar
        ruby scripts/promote-warnings.rb Style/FetchEnvVar Rails/EnumSyntax

      Available cops to promote:
    USAGE

    show_available_cops
  end

  def show_available_cops
    CONFIG_FILES.each do |file|
      next unless File.exist?(file)

      puts "\n#{file}:"
      content = File.read(file)
      cops_with_warnings = content.scan(%r{^(\w+/\w+):.*?\n  Severity: warning}m).flatten
      cops_with_warnings.each { |cop| puts "  - #{cop}" }
    end
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
    puts "  Promoted: #{@cop_promoter.promoted_count} cops"

    return if @cop_promoter.not_found_cops.empty?

    puts "  ⚠️  Not found: #{@cop_promoter.not_found_cops.join(', ')}"
    puts "\nNote: Some cops may not exist in the current configuration or"
    puts "may already be promoted. Check the config files manually."
  end
end

# Script execution
if __FILE__ == $PROGRAM_NAME
  promoter = WarningPromoter.new(ARGV)
  promoter.promote!
end
