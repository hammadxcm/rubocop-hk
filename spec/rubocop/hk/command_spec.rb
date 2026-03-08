# frozen_string_literal: true

RSpec.describe Rubocop::Hk::Command do
  describe ".exit_on_failure?" do
    it "returns true" do
      expect(described_class.exit_on_failure?).to be true
    end

    it "is a class method" do
      expect(described_class).to respond_to(:exit_on_failure?)
    end
  end

  describe "#version" do
    let(:command) { described_class.new }

    context "when plain option is false" do
      it "outputs formatted version" do
        allow(command).to receive(:options).and_return(plain: false)

        expect { command.version }.to output("rubocop-hk version: #{Rubocop::Hk::VERSION}\n").to_stdout
      end

      it "outputs formatted version when plain is explicitly false" do
        allow(command).to receive(:options).and_return({ plain: false })

        expect { command.version }.to output("rubocop-hk version: #{Rubocop::Hk::VERSION}\n").to_stdout
      end

      it "handles options hash correctly" do
        allow(command).to receive(:options).and_return({})

        expect { command.version }.to output("rubocop-hk version: #{Rubocop::Hk::VERSION}\n").to_stdout
      end
    end

    context "when plain option is true" do
      it "outputs plain version" do
        allow(command).to receive(:options).and_return(plain: true)

        expect { command.version }.to output("#{Rubocop::Hk::VERSION}\n").to_stdout
      end

      it "outputs plain version when plain is explicitly true" do
        allow(command).to receive(:options).and_return({ plain: true })

        expect { command.version }.to output("#{Rubocop::Hk::VERSION}\n").to_stdout
      end

      it "returns early when plain is true" do
        allow(command).to receive(:options).and_return(plain: true)
        allow(command).to receive(:puts)

        expect(command.version).to be_nil
        expect(command).to have_received(:puts).with(Rubocop::Hk::VERSION)
      end
    end

    context "when using version aliases" do
      it "maps -v to version" do
        expect(described_class.map["-v"]).to eq(:version)
      end

      it "maps --version to version" do
        expect(described_class.map["--version"]).to eq(:version)
      end

      it "has both aliases mapped" do
        expect(described_class.map).to include("-v", "--version")
      end
    end

    context "version command metadata" do
      let(:version_command) { described_class.commands["version"] }

      it "has correct description" do
        expect(version_command.description).to eq("Get the version of rubocop-hk")
      end

      it "has plain option configured" do
        expect(version_command.options).to have_key(:plain)
      end

      it "has plain option as boolean type" do
        expect(version_command.options[:plain].type).to eq(:boolean)
      end

      it "has plain option defaulting to false" do
        expect(version_command.options[:plain].default).to be false
      end

      it "has plain option with -p alias" do
        expect(version_command.options[:plain].aliases).to include("-p")
      end
    end
  end

  describe "class structure and inheritance" do
    it "inherits from Thor" do
      expect(described_class.ancestors).to include(Thor)
    end

    it "is defined in correct module hierarchy" do
      expect(described_class.name).to eq("Rubocop::Hk::Command")
    end

    it "has version command registered" do
      expect(described_class.commands).to have_key("version")
    end

    it "can be instantiated" do
      expect { described_class.new }.not_to raise_error
    end
  end

  describe "command-line integration" do
    it "can be used as CLI entry point" do
      expect(described_class).to respond_to(:start)
    end

    it "has proper command mapping setup" do
      expect(described_class.map).to be_a(Hash)
    end

    it "includes version in available commands" do
      expect(described_class.commands.keys).to include("version")
    end
  end

  describe "module requirements" do
    it "requires thor" do
      expect(defined?(Thor)).to eq("constant")
    end

    it "requires rubocop/hk" do
      expect(defined?(Rubocop::Hk)).to eq("constant")
    end

    it "has access to VERSION constant" do
      expect(defined?(Rubocop::Hk::VERSION)).to eq("constant")
    end
  end
end
