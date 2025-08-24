# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Configuration Compatibility" do
  describe "Modern conventions" do
    let(:style_config) { RuboCop::ConfigLoader.load_file("config/rubocop-style.yml") }

    it "enforces double quotes" do
      expect(style_config["Style/StringLiterals"]["EnforcedStyle"]).to eq("double_quotes")
    end

    it "enforces frozen string literals" do
      expect(style_config["Style/FrozenStringLiteralComment"]["Enabled"]).to be true
      expect(style_config["Style/FrozenStringLiteralComment"]["EnforcedStyle"]).to eq("always_true")
    end

    it "enforces consistent trailing commas" do
      expect(style_config["Style/TrailingCommaInArrayLiteral"]["EnforcedStyleForMultiline"]).to eq("consistent_comma")
      expect(style_config["Style/TrailingCommaInHashLiteral"]["EnforcedStyleForMultiline"]).to eq("consistent_comma")
    end
  end

  describe "Plugin configuration" do
    let(:default_config) { RuboCop::ConfigLoader.load_file("config/default.yml") }
    let(:yaml_config) { YAML.load_file("config/default.yml") }

    it "uses modern plugin architecture" do
      expect(yaml_config["plugins"]).to include("rubocop-rails")
      expect(yaml_config["plugins"]).to include("rubocop-rspec")
      expect(yaml_config["plugins"]).to include("rubocop-performance")
    end

    it "targets modern Ruby and Rails versions" do
      expect(default_config["AllCops"]["TargetRubyVersion"]).to eq(3.1)
      expect(default_config["AllCops"]["TargetRailsVersion"]).to eq(8.0)
    end

    it "enables new cops" do
      expect(default_config["AllCops"]["NewCops"]).to eq("enable")
    end

    it "suggests performance extensions" do
      expect(default_config["AllCops"]["SuggestExtensions"]["rubocop-performance"]).to be true
    end
  end

  describe "Exclusions" do
    let(:yaml_config) { YAML.load_file("config/default.yml") }

    it "excludes standard Rails directories" do
      exclusions = yaml_config["AllCops"]["Exclude"]

      expect(exclusions).to include("bin/**/*")
      expect(exclusions).to include("db/**/*")
      expect(exclusions).to include("tmp/**/*")
      expect(exclusions).to include("log/**/*")
      expect(exclusions).to include("public/**/*")
      expect(exclusions).to include("storage/**/*")
      expect(exclusions).to include("node_modules/**/*")
    end

    it "excludes Rails configuration files" do
      exclusions = yaml_config["AllCops"]["Exclude"]

      expect(exclusions).to include("config/boot.rb")
      expect(exclusions).to include("config/environment.rb")
      expect(exclusions).to include("config/puma.rb")
      expect(exclusions).to include("config/spring.rb")
    end
  end

  describe "Rails configuration" do
    let(:rails_config) { RuboCop::ConfigLoader.load_file("config/rubocop-rails.yml") }

    it "enables Rails cops" do
      expect(rails_config["Rails/EnumHash"]["Enabled"]).to be true
      expect(rails_config["Rails/FilePath"]["Enabled"]).to be true
      expect(rails_config["Rails/IndexBy"]["Enabled"]).to be true
    end
  end

  describe "Performance configuration" do
    let(:performance_config) { RuboCop::ConfigLoader.load_file("config/rubocop-performance.yml") }

    it "enables key performance cops" do
      expect(performance_config["Performance/FlatMap"]["Enabled"]).to be true
      expect(performance_config["Performance/Count"]["Enabled"]).to be true
      expect(performance_config["Performance/MapCompact"]["Enabled"]).to be true
    end
  end
end
