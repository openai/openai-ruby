# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      # @return [OpenAI::Resources::Beta::VectorStores]
      attr_reader :vector_stores

      # @return [OpenAI::Resources::Beta::Assistants]
      attr_reader :assistants

      # @return [OpenAI::Resources::Beta::Threads]
      attr_reader :threads

      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @vector_stores = OpenAI::Resources::Beta::VectorStores.new(client: client)
        @assistants = OpenAI::Resources::Beta::Assistants.new(client: client)
        @threads = OpenAI::Resources::Beta::Threads.new(client: client)
      end
    end
  end
end
