# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Ruby Version Compatibility" do
  describe "Ruby version requirements" do
    it "supports Ruby 3.2+" do
      expect(Gem::Version.new(RUBY_VERSION)).to be >= Gem::Version.new("3.2.0")
    end

    it "has correct Ruby version requirement in gemspec" do
      gemspec = Gem::Specification.load("rubocop-hk.gemspec")
      expect(gemspec.required_ruby_version).to satisfy do |requirement|
        requirement.satisfied_by?(Gem::Version.new("3.2.0"))
      end
    end
  end

  describe "RuboCop configuration loading" do
    it "loads default configuration without errors" do
      expect do
        RuboCop::ConfigLoader.load_file("config/default.yml")
      end.not_to raise_error
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
        "config/rubocop-lint.yml",
      ]

      config_files.each do |config_file|
        expect do
          RuboCop::ConfigLoader.load_file(config_file)
        end.not_to raise_error, "Failed to load #{config_file}"
      end
    end

    it "validates performance cops are available" do
      default_config = RuboCop::ConfigLoader.load_file("config/default.yml")

      # Test that performance plugin is loaded via main config
      yaml_config = YAML.load_file("config/default.yml")
      expect(yaml_config["plugins"]).to include("rubocop-performance")

      # Performance cops are enabled globally through rubocop-performance plugin
      expect(default_config["Performance"]["Enabled"]).to be true
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
      expect(rubocop_dep.requirement.to_s).to include("1.80")
    end

    it "has compatible rubocop-rails dependency" do
      rails_dep = gemspec.dependencies.find { |dep| dep.name == "rubocop-rails" }
      expect(rails_dep).not_to be_nil
      expect(rails_dep.requirement.to_s).to include("2.33")
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
