# frozen_string_literal: true

module OpenAI
  module Resources
    class Chat
      class Completions
        class Messages
          # Get the messages in a stored chat completion. Only Chat Completions that have
          #   been created with the `store` parameter set to `true` will be returned.
          #
          # @param completion_id [String] The ID of the chat completion to retrieve messages from.
          #
          # @param params [OpenAI::Models::Chat::Completions::MessageListParams, Hash{Symbol=>Object}] .
          #
          #   @option params [String] :after Identifier for the last message from the previous pagination request.
          #
          #   @option params [Integer] :limit Number of messages to retrieve.
          #
          #   @option params [Symbol, OpenAI::Models::Chat::Completions::MessageListParams::Order] :order Sort order for messages by timestamp. Use `asc` for ascending order or `desc`
          #     for descending order. Defaults to `asc`.
          #
          #   @option params [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil] :request_options
          #
          # @return [OpenAI::CursorPage<OpenAI::Models::Chat::ChatCompletionStoreMessage>]
          #
          # @see OpenAI::Models::Chat::Completions::MessageListParams
          def list(completion_id, params = {})
            parsed, options = OpenAI::Models::Chat::Completions::MessageListParams.dump_request(params)
            @client.request(
              method: :get,
              path: ["chat/completions/%1$s/messages", completion_id],
              query: parsed,
              page: OpenAI::CursorPage,
              model: OpenAI::Models::Chat::ChatCompletionStoreMessage,
              options: options
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
          end
        end
      end
    end
  end
end
