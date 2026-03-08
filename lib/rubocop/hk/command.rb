# frozen_string_literal: true

require "thor"

require "rubocop/hk"

module Rubocop
  module Hk
    ##
    # CLI entry point for commands
    #
    class Command < Thor
      def self.exit_on_failure?
        true
      end

      desc "version", "Get the version of rubocop-hk"
      option :plain, type: :boolean, default: false, aliases: ["-p"]
      def version
        return puts Rubocop::Hk::VERSION if options[:plain]

        puts "rubocop-hk version: #{Rubocop::Hk::VERSION}"
      end
      map ["-v", "--version"] => :version
    end
  end
end
