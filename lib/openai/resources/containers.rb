# frozen_string_literal: true

module OpenAI
  module Resources
    class Containers
      # @return [OpenAI::Resources::Containers::Files]
      attr_reader :files

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @files = OpenAI::Resources::Containers::Files.new(client: client)
      end
    end
  end
end
