# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Ruby Version Compatibility" do
  describe "Ruby version requirements" do
    it "supports Ruby 3.1+" do
      expect(Gem::Version.new(RUBY_VERSION)).to be >= Gem::Version.new("3.1.0")
    end

    it "has correct Ruby version requirement in gemspec" do
      gemspec = Gem::Specification.load("rubocop-hk.gemspec")
      expect(gemspec.required_ruby_version).to satisfy do |requirement|
        requirement.satisfied_by?(Gem::Version.new("3.1.0"))
      end
    end
  end

  describe "RuboCop configuration loading" do
    it "loads default configuration without errors" do
      expect {
        RuboCop::ConfigLoader.load_file("config/default.yml")
      }.not_to raise_error
    end

    it "loads all configuration files without errors" do
      config_files = [
        "config/default.yml",
        "config/rubocop-rails.yml",
        "config/rubocop-rspec.yml",
        "config/rubocop-performance.yml",
        "config/rubocop-style.yml",
        "config/rubocop-layout.yml",
        "config/rubocop-metrics.yml",
        "config/rubocop-lint.yml"
      ]

      config_files.each do |config_file|
        expect {
          RuboCop::ConfigLoader.load_file(config_file)
        }.not_to raise_error, "Failed to load #{config_file}"
      end
    end

    it "validates performance cops are available" do
      config = RuboCop::ConfigLoader.load_file("config/rubocop-performance.yml")
      performance_cops = config.keys.select { |key| key.start_with?("Performance/") }
      
      expect(performance_cops).not_to be_empty
      expect(performance_cops.size).to be >= 30
    end
  end

  describe "Gem dependencies" do
    it "loads rubocop-performance successfully" do
      expect { require "rubocop-performance" }.not_to raise_error
    end

    it "loads rubocop-rails successfully" do
      expect { require "rubocop-rails" }.not_to raise_error
    end

    it "loads rubocop-rspec successfully" do
      expect { require "rubocop-rspec" }.not_to raise_error
    end
  end

  describe "Version compatibility" do
    let(:gemspec) { Gem::Specification.load("rubocop-hk.gemspec") }

    it "has compatible RuboCop dependency" do
      rubocop_dep = gemspec.dependencies.find { |dep| dep.name == "rubocop" }
      expect(rubocop_dep).not_to be_nil
      expect(rubocop_dep.requirement.to_s).to include("1.79")
    end

    it "has compatible rubocop-rails dependency" do
      rails_dep = gemspec.dependencies.find { |dep| dep.name == "rubocop-rails" }
      expect(rails_dep).not_to be_nil
      expect(rails_dep.requirement.to_s).to include("2.32")
    end

    it "has compatible rubocop-rspec dependency" do
      rspec_dep = gemspec.dependencies.find { |dep| dep.name == "rubocop-rspec" }
      expect(rspec_dep).not_to be_nil
      expect(rspec_dep.requirement.to_s).to include("3.6")
    end

    it "has rubocop-performance dependency" do
      performance_dep = gemspec.dependencies.find { |dep| dep.name == "rubocop-performance" }
      expect(performance_dep).not_to be_nil
      expect(performance_dep.requirement.to_s).to include("1.25")
    end
  end
end