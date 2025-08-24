# frozen_string_literal: true

RSpec.describe "Gem Integration" do
  describe "gem loading and requirements" do
    it "loads all required dependencies" do
      expect { require "rubocop" }.not_to raise_error
      expect { require "rubocop-rails" }.not_to raise_error  
      expect { require "rubocop-rspec" }.not_to raise_error
      expect { require "rubocop-performance" }.not_to raise_error
      expect { require "thor" }.not_to raise_error
    end

    it "loads main gem file" do
      expect { require "rubocop/hk" }.not_to raise_error
    end

    it "loads command file" do
      expect { require "rubocop/hk/command" }.not_to raise_error
    end

    it "has all required constants defined" do
      expect(defined?(Rubocop::Hk)).to eq("constant")
      expect(defined?(Rubocop::Hk::VERSION)).to eq("constant")
      expect(defined?(Rubocop::Hk::Error)).to eq("constant")
      expect(defined?(Rubocop::Hk::Command)).to eq("constant")
    end
  end

  describe "gem structure validation" do
    it "has proper version constant" do
      expect(Rubocop::Hk::VERSION).to be_a(String)
      expect(Rubocop::Hk::VERSION).not_to be_empty
    end

    it "has working command class" do
      command = Rubocop::Hk::Command.new
      expect(command).to respond_to(:version)
      expect(Rubocop::Hk::Command).to respond_to(:exit_on_failure?)
    end

    it "has proper error class hierarchy" do
      expect(Rubocop::Hk::Error.superclass).to eq(StandardError)
    end
  end

  describe "configuration files integration" do
    let(:config_files) do
      %w[
        config/default.yml
        config/rubocop-layout.yml
        config/rubocop-lint.yml
        config/rubocop-metrics.yml
        config/rubocop-performance.yml
        config/rubocop-rails.yml
        config/rubocop-rspec.yml
        config/rubocop-style.yml
      ]
    end

    it "has all configuration files present" do
      config_files.each do |file|
        expect(File.exist?(file)).to be(true), "Expected #{file} to exist"
      end
    end

    it "can load all configuration files through RuboCop" do
      config_files.each do |file|
        expect { RuboCop::ConfigLoader.load_file(file) }.not_to raise_error
      end
    end

    it "main config inherits from all sub-configs" do
      default_config = YAML.load_file("config/default.yml")
      expected_inherits = config_files.reject { |f| f.include?("default") }
                                    .map { |f| File.basename(f) }

      expect(default_config["inherit_from"]).to match_array(expected_inherits)
    end
  end

  describe "RuboCop integration" do
    it "can be used as a RuboCop configuration" do
      expect { RuboCop::ConfigLoader.load_file("config/default.yml") }.not_to raise_error
    end

    it "loads with all required plugins" do
      config = YAML.load_file("config/default.yml")
      expect(config["plugins"]).to include("rubocop-rails")
      expect(config["plugins"]).to include("rubocop-rspec")
      expect(config["plugins"]).to include("rubocop-performance")
    end

    it "has proper AllCops configuration" do
      config = RuboCop::ConfigLoader.load_file("config/default.yml")
      expect(config["AllCops"]["TargetRubyVersion"]).to eq(3.1)
      expect(config["AllCops"]["TargetRailsVersion"]).to eq(8.0)
      expect(config["AllCops"]["NewCops"]).to eq("enable")
    end
  end

  describe "CLI command integration" do
    let(:command) { Rubocop::Hk::Command.new }

    it "provides version through CLI" do
      allow(command).to receive(:options).and_return({})
      expect { command.version }.to output(/rubocop-hk version: \d+\.\d+\.\d+/).to_stdout
    end

    it "provides plain version through CLI" do
      allow(command).to receive(:options).and_return(plain: true)
      expect { command.version }.to output(/\A\d+\.\d+\.\d+\n\z/).to_stdout
    end
  end

  describe "file structure validation" do
    it "has lib directory with proper structure" do
      expect(Dir.exist?("lib")).to be true
      expect(Dir.exist?("lib/rubocop")).to be true
      expect(Dir.exist?("lib/rubocop/hk")).to be true
    end

    it "has all required Ruby files" do
      expect(File.exist?("lib/rubocop/hk.rb")).to be true
      expect(File.exist?("lib/rubocop/hk/version.rb")).to be true
      expect(File.exist?("lib/rubocop/hk/command.rb")).to be true
    end

    it "has configuration directory" do
      expect(Dir.exist?("config")).to be true
    end

    it "has spec directory with tests" do
      expect(Dir.exist?("spec")).to be true
      expect(Dir.glob("spec/**/*_spec.rb").length).to be > 0
    end
  end
end