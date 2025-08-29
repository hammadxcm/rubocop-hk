# frozen_string_literal: true

require "spec_helper"

RSpec.describe "Modern Rules Integration", type: :integration do
  let(:config) { RuboCop::ConfigLoader.load_file("config/default.yml") }
  
  describe "Modern Style Rules (2025)" do
    context "Ruby 3.3 specific cops" do
      it "enables Style/FetchEnvVar with warning severity" do
        expect(config.for_cop("Style/FetchEnvVar")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end

      it "enables Style/ArgumentsForwarding for modern delegation" do
        expect(config.for_cop("Style/ArgumentsForwarding")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end

      it "enables Style/CollectionCompact for cleaner nil handling" do
        expect(config.for_cop("Style/CollectionCompact")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end

      it "enables Style/HashTransformKeys for modern hash operations" do
        expect(config.for_cop("Style/HashTransformKeys")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end
    end

    context "configuration descriptions" do
      it "provides detailed explanations for new Style cops" do
        style_config = YAML.load_file("config/rubocop-style.yml")
        
        expect(style_config["Style/FetchEnvVar"]["Description"]).to include("ENV.fetch")
        expect(style_config["Style/FetchEnvVar"]["Description"]).to include("error handling")
        expect(style_config["Style/ArgumentsForwarding"]["Description"]).to include("Ruby 2.7+")
      end
    end
  end

  describe "Rails 8.0 Compatibility Rules" do
    context "critical Rails 8.0 cops" do
      it "enables Rails/EnumSyntax for Rails 8.0 compatibility" do
        expect(config.for_cop("Rails/EnumSyntax")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end

      it "enables Rails/DeprecatedActiveModelErrorsMethods" do
        expect(config.for_cop("Rails/DeprecatedActiveModelErrorsMethods")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end

      it "enables Rails/ResponseParsedBody for modern test patterns" do
        expect(config.for_cop("Rails/ResponseParsedBody")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end
    end

    context "Rails configuration descriptions" do
      it "provides Rails 8.0 specific guidance" do
        rails_config = YAML.load_file("config/rubocop-rails.yml")
        
        expect(rails_config["Rails/EnumSyntax"]["Description"]).to include("Rails 8.0+")
        expect(rails_config["Rails/EnumSyntax"]["Description"]).to include("positional arguments")
      end
    end
  end

  describe "RSpec Modern Testing Rules" do
    context "improved test quality cops" do
      it "enables RSpec/BeNil for better matchers" do
        expect(config.for_cop("RSpec/BeNil")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end

      it "enables RSpec/ChangeByZero for clearer intent" do
        expect(config.for_cop("RSpec/ChangeByZero")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end

      it "enables RSpec/ClassCheck for inheritance testing" do
        expect(config.for_cop("RSpec/ClassCheck")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end
    end

    context "RSpec cop flexibility" do
      it "keeps RSpec/VerifiedDoubles disabled for flexibility" do
        expect(config.for_cop("RSpec/VerifiedDoubles")).to include(
          "Enabled" => false
        )
      end

      it "keeps RSpec/MessageChain disabled for receive_message_chain usage" do
        expect(config.for_cop("RSpec/MessageChain")).to include(
          "Enabled" => false
        )
      end
    end
  end

  describe "Performance Enhancement Rules" do
    context "performance-critical cops" do
      it "enables Performance/ConstantRegexp for better performance" do
        expect(config.for_cop("Performance/ConstantRegexp")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end

      it "enables Performance/RangeInclude for O(1) operations" do
        expect(config.for_cop("Performance/RangeInclude")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end

      it "enables Performance/Sum for optimized numeric operations" do
        expect(config.for_cop("Performance/Sum")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end
    end
  end

  describe "Security and Quality (Lint) Rules" do
    context "bug prevention cops" do
      it "enables Lint/RequireRangeParentheses for precedence safety" do
        expect(config.for_cop("Lint/RequireRangeParentheses")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end

      it "enables Lint/EmptyBlock for incomplete code detection" do
        expect(config.for_cop("Lint/EmptyBlock")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end

      it "enables Lint/DuplicateBranch for logic error detection" do
        expect(config.for_cop("Lint/DuplicateBranch")).to include(
          "Enabled" => true,
          "Severity" => "warning"
        )
      end
    end
  end

  describe "Warning-Only Implementation" do
    let(:all_modern_cops) do
      %w[
        Style/FetchEnvVar Style/ArgumentsForwarding Style/CollectionCompact
        Rails/EnumSyntax Rails/ResponseParsedBody Rails/DeprecatedActiveModelErrorsMethods
        RSpec/BeNil RSpec/ChangeByZero RSpec/ClassCheck
        Performance/ConstantRegexp Performance/RangeInclude Performance/Sum
        Lint/RequireRangeParentheses Lint/EmptyBlock Lint/DuplicateBranch
      ]
    end

    it "ensures all modern cops are warnings only" do
      all_modern_cops.each do |cop_name|
        cop_config = config.for_cop(cop_name)
        expect(cop_config["Severity"]).to eq("warning"), 
          "#{cop_name} should be warning-only but has severity: #{cop_config['Severity']}"
      end
    end

    it "ensures all modern cops are enabled" do
      all_modern_cops.each do |cop_name|
        cop_config = config.for_cop(cop_name)
        expect(cop_config["Enabled"]).to be(true),
          "#{cop_name} should be enabled but is: #{cop_config['Enabled']}"
      end
    end
  end

  describe "Configuration File Structure" do
    it "has modern cops sections in each config file" do
      style_config = File.read("config/rubocop-style.yml")
      rails_config = File.read("config/rubocop-rails.yml")
      rspec_config = File.read("config/rubocop-rspec.yml")
      performance_config = File.read("config/rubocop-performance.yml")
      lint_config = File.read("config/rubocop-lint.yml")

      expect(style_config).to include("Modern Ruby 3.3 Style Cops (2025)")
      expect(rails_config).to include("Rails 8.0+ Modern Cops (2025)")
      expect(rspec_config).to include("Modern RSpec Cops (2025)")
      expect(performance_config).to include("Modern Performance Cops (2025)")
      expect(lint_config).to include("Modern Security & Quality Lint Cops (2025)")
    end

    it "provides warning-only documentation in all sections" do
      config_files = Dir.glob("config/rubocop-*.yml")
      
      config_files.each do |file|
        content = File.read(file)
        next unless content.include?("WARNING ONLY")
        
        expect(content).to include("All WARNING ONLY"),
          "#{file} should indicate all new cops are warning-only"
      end
    end
  end

  describe "Backward Compatibility" do
    it "maintains all existing cop configurations" do
      # Test that we haven't broken existing configurations
      expect(config.for_cop("Style/StringLiterals")["EnforcedStyle"]).to eq("double_quotes")
      expect(config.for_cop("Layout/LineLength")["Max"]).to eq(100)
      expect(config.for_cop("Rails/Output")["Enabled"]).to be(true)
    end

    it "preserves existing disabled cops" do
      expect(config.for_cop("RSpec/ExampleLength")["Enabled"]).to be(false)
      expect(config.for_cop("RSpec/MultipleExpectations")["Enabled"]).to be(false)
      expect(config.for_cop("Metrics/AbcSize")["Enabled"]).to be(false)
    end
  end
end