# frozen_string_literal: true

RSpec.describe Rubocop::Hk do
  describe "module constants and structure" do
    it "has a version number" do
      expect(Rubocop::Hk::VERSION).not_to be_nil
    end

    it "has the correct version format" do
      expect(Rubocop::Hk::VERSION).to match(/\A\d+\.\d+\.\d+\z/)
    end

    it "has the expected version" do
      expect(Rubocop::Hk::VERSION).to eq("1.2.1")
    end

    it "is nested under Rubocop module" do
      expect(described_class.name).to eq("Rubocop::Hk")
    end

    it "includes the version submodule" do
      expect(defined?(Rubocop::Hk::VERSION)).to eq("constant")
    end

    it "is a proper Ruby module" do
      expect(described_class).to be_a(Module)
    end

    it "belongs to the Rubocop namespace" do
      expect(described_class.name).to start_with("Rubocop::")
    end
  end

  describe "Error class" do
    it "defines a custom error class" do
      expect(Rubocop::Hk::Error).to be < StandardError
    end

    it "can be instantiated without message" do
      error = Rubocop::Hk::Error.new
      expect(error).to be_a(StandardError)
      expect(error.message).to eq("Rubocop::Hk::Error")
    end

    it "can be instantiated with message" do
      error = Rubocop::Hk::Error.new("test message")
      expect(error).to be_a(StandardError)
      expect(error.message).to eq("test message")
    end

    it "can be raised and caught" do
      expect do
        raise Rubocop::Hk::Error, "test error"
      end.to raise_error(Rubocop::Hk::Error, "test error")
    end

    it "can be raised without message" do
      expect do
        raise Rubocop::Hk::Error
      end.to raise_error(Rubocop::Hk::Error)
    end

    it "inherits StandardError methods" do
      error = Rubocop::Hk::Error.new("test")
      expect(error).to respond_to(:message)
      expect(error).to respond_to(:backtrace)
      expect(error).to respond_to(:to_s)
    end

    it "is a proper exception class" do
      expect(Rubocop::Hk::Error).to be_a(Class)
      expect(Rubocop::Hk::Error.superclass).to eq(StandardError)
    end
  end

  describe "module hierarchy and relationships" do
    it "is defined within Rubocop module" do
      expect(Rubocop.constants).to include(:Hk)
    end

    it "defines its own constants" do
      expect(described_class.constants).to include(:VERSION, :Error)
    end

    it "can access parent module" do
      expect(described_class.name.split("::").first).to eq("Rubocop")
    end
  end

  describe "module loading and requirements" do
    it "loads version submodule" do
      expect { Rubocop::Hk::VERSION }.not_to raise_error
    end

    it "has proper file structure loaded" do
      # Version should be loaded via require_relative
      expect(defined?(Rubocop::Hk::VERSION)).to eq("constant")
    end

    it "can be used for namespace purposes" do
      # Should be able to define new classes/modules within it
      expect do
        module Rubocop
          module Hk
            class TestClass; end
          end
        end
      end.not_to raise_error

      # Clean up
      described_class.send(:remove_const, :TestClass)
    end
  end

  describe "integration with gem structure" do
    it "provides access to version for gemspec" do
      expect(Rubocop::Hk::VERSION).to be_a(String)
      expect(Rubocop::Hk::VERSION.length).to be > 0
    end

    it "has consistent naming with gem name" do
      # Module name should relate to gem name rubocop-hk
      expect(described_class.name.downcase.gsub("::", "-")).to include("hk")
    end
  end
end
