# frozen_string_literal: true

module OpenAI
  module Resources
    class Chat
      # @return [OpenAI::Resources::Chat::Completions]
      attr_reader :completions

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @completions = OpenAI::Resources::Chat::Completions.new(client: client)
      end
    end
  end
end
