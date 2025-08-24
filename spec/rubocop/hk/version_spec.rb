# frozen_string_literal: true

require "rubocop/hk/version"

RSpec.describe "Rubocop::Hk::VERSION" do
  it "is defined as a string constant" do
    expect(Rubocop::Hk::VERSION).to be_a(String)
  end

  it "follows semantic versioning format" do
    expect(Rubocop::Hk::VERSION).to match(/\A\d+\.\d+\.\d+(\.\w+)?\z/)
  end

  it "has the expected value" do
    expect(Rubocop::Hk::VERSION).to eq("1.0.9")
  end

  it "is accessible from the main module" do
    expect(Rubocop::Hk::VERSION).to eq("1.0.9")
  end

  it "is frozen" do
    expect(Rubocop::Hk::VERSION).to be_frozen
  end

  it "can be compared with other versions" do
    expect(Gem::Version.new(Rubocop::Hk::VERSION)).to be >= Gem::Version.new("0.1.0")
  end

  describe "version module structure" do
    it "is defined in the correct module hierarchy" do
      expect(Rubocop::Hk.const_defined?(:VERSION)).to be true
    end

    it "is directly accessible" do
      expect { Rubocop::Hk::VERSION }.not_to raise_error
    end
  end
end
