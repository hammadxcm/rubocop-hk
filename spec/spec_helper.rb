# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  add_filter "/spec/"
  add_filter "/vendor/"

  # Explicitly track all Ruby files in lib
  track_files "lib/**/*.rb"

  # Add specific files to ensure they're tracked
  add_group "Main Library", "lib/rubocop/hk.rb"
  add_group "Version", "lib/rubocop/hk/version.rb"
  add_group "Command", "lib/rubocop/hk/command.rb"

  # Coverage thresholds - target 90%+
  minimum_coverage 90
  minimum_coverage_by_file 90

  # HTML and console output
  formatter SimpleCov::Formatter::MultiFormatter.new([
                                                       SimpleCov::Formatter::HTMLFormatter,
                                                       SimpleCov::Formatter::SimpleFormatter,
                                                     ])
end

require "webmock/rspec"
require "rubocop"
require "rubocop-rails"
require "rubocop-rspec"
require "rubocop-performance"
require "rubocop/hk"
require "rubocop/hk/command"
require "thor"

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.order = :random
  config.profile_examples = 10
end
