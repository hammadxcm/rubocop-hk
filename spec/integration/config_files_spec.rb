# frozen_string_literal: true

RSpec.describe "Configuration Files Integration" do
  let(:config_dir) { "config" }
  let(:config_files) do
    %w[
      default.yml
      rubocop-layout.yml
      rubocop-lint.yml
      rubocop-metrics.yml
      rubocop-performance.yml
      rubocop-rails.yml
      rubocop-rspec.yml
      rubocop-style.yml
    ]
  end

  describe "all configuration files" do
    it "are present in the config directory" do
      config_files.each do |file|
        expect(File.exist?(File.join(config_dir, file))).to be true
      end
    end

    it "contain valid YAML syntax" do
      config_files.each do |file|
        path = File.join(config_dir, file)
        expect { YAML.load_file(path) }.not_to raise_error
      end
    end

    it "can be loaded by RuboCop without errors" do
      config_files.each do |file|
        path = File.join(config_dir, file)
        expect { RuboCop::ConfigLoader.load_file(path) }.not_to raise_error
      end
    end
  end

  describe "default.yml" do
    let(:config) { YAML.load_file("config/default.yml") }

    it "includes all required plugins" do
      expect(config["plugins"]).to include("rubocop-rails")
      expect(config["plugins"]).to include("rubocop-rspec")
      expect(config["plugins"]).to include("rubocop-performance")
    end

    it "inherits from all modular config files" do
      expected_inherits = %w[
        rubocop-layout.yml
        rubocop-lint.yml
        rubocop-metrics.yml
        rubocop-rspec.yml
        rubocop-rails.yml
        rubocop-style.yml
        rubocop-performance.yml
      ]

      expect(config["inherit_from"]).to match_array(expected_inherits)
    end

    it "has proper Rails configuration" do
      expect(config["Rails"]["Enabled"]).to be true
    end

    it "targets modern Ruby and Rails versions" do
      expect(config["AllCops"]["TargetRubyVersion"]).to eq(3.3)
      expect(config["AllCops"]["TargetRailsVersion"]).to eq(8.0)
    end
  end

  describe "rubocop-performance.yml" do
    let(:config) { YAML.load_file("config/rubocop-performance.yml") }

    it "enables performance cops globally" do
      expect(config["Performance"]["Enabled"]).to be true
    end

    it "has performance-specific configurations" do
      expect(config).to have_key("Performance/OpenStruct")
      expect(config).to have_key("Performance/StringIdentifierArgument")
      expect(config).to have_key("Performance/ChainArrayAllocation")
      expect(config).to have_key("Performance/CollectionLiteralInLoop")
    end
  end

  describe "rubocop-style.yml" do
    let(:config) { YAML.load_file("config/rubocop-style.yml") }

    it "enforces double quotes" do
      expect(config["Style/StringLiterals"]["EnforcedStyle"]).to eq("double_quotes")
    end

    it "enables frozen string literal" do
      expect(config["Style/FrozenStringLiteralComment"]["Enabled"]).to be true
    end

    it "configures trailing commas consistently" do
      expect(config["Style/TrailingCommaInArrayLiteral"]["EnforcedStyleForMultiline"]).to eq("consistent_comma")
      expect(config["Style/TrailingCommaInHashLiteral"]["EnforcedStyleForMultiline"]).to eq("consistent_comma")
    end
  end

  describe "rubocop-rails.yml" do
    let(:config) { YAML.load_file("config/rubocop-rails.yml") }

    it "enables Rails-specific cops" do
      expect(config["Rails/EnumHash"]["Enabled"]).to be true
      expect(config["Rails/FilePath"]["Enabled"]).to be true
      expect(config["Rails/IndexBy"]["Enabled"]).to be true
    end
  end

  describe "rubocop-rspec.yml" do
    let(:config) { YAML.load_file("config/rubocop-rspec.yml") }

    it "configures RSpec-specific cops" do
      expect(config["RSpec/ExampleLength"]["Enabled"]).to be false
      expect(config["RSpec/MultipleExpectations"]["Enabled"]).to be false
      expect(config["RSpec/ContextWording"]["Enabled"]).to be true
    end
  end

  describe "config file inheritance" do
    it "loads the complete configuration tree without conflicts" do
      expect { RuboCop::ConfigLoader.load_file("config/default.yml") }.not_to raise_error
    end

    it "resolves all inherited configurations successfully" do
      config = RuboCop::ConfigLoader.load_file("config/default.yml")

      # Verify that cops from inherited files are present
      expect(config["Style/StringLiterals"]).not_to be_nil
      expect(config["Performance"]["Enabled"]).to be true # Performance cops enabled globally
      expect(config["Rails/IndexBy"]).not_to be_nil
      expect(config["RSpec/ExampleLength"]).not_to be_nil
    end
  end
end
