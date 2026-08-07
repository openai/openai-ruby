# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Resources
    class Chat
      # Given a list of messages comprising a conversation, the model will return a
      # response.
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
