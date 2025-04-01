# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      # @return [OpenAI::Resources::Beta::Assistants]
      attr_reader :assistants

      # @return [OpenAI::Resources::Beta::Threads]
      attr_reader :threads

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @assistants = OpenAI::Resources::Beta::Assistants.new(client: client)
        @threads = OpenAI::Resources::Beta::Threads.new(client: client)
      end
    end
  end
end
