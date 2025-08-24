require "thor"

require "rubocop/sendoso"

module Rubocop
  module Sendoso
    ##
    # CLI entry point for commands
    #
    class Command < Thor
      def self.exit_on_failure?
        true
      end

      desc "version", "Get the version of rubocop-sendoso"
      option :plain, type: :boolean, default: false, aliases: ["-p"]
      def version
        return puts Rubocop::Sendoso::VERSION if options[:plain]

        puts "rubocop-sendoso version: #{Rubocop::Sendoso::VERSION}"
      end
      map ["-v", "--version"] => :version
    end
  end
end
