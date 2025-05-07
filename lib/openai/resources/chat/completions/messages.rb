# frozen_string_literal: true

module OpenAI
  module Resources
    class Chat
      class Completions
        class Messages
          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Chat::Completions::MessageListParams} for more details.
          #
          # Get the messages in a stored chat completion. Only Chat Completions that have
          # been created with the `store` parameter set to `true` will be returned.
          #
          # @overload list(completion_id, after: nil, limit: nil, order: nil, request_options: {})
          #
          # @param completion_id [String] The ID of the chat completion to retrieve messages from.
          #
          # @param after [String] Identifier for the last message from the previous pagination request.
          #
          # @param limit [Integer] Number of messages to retrieve.
          #
          # @param order [Symbol, OpenAI::Chat::Completions::MessageListParams::Order] Sort order for messages by timestamp. Use `asc` for ascending order or `desc` fo
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Chat::ChatCompletionStoreMessage>]
          #
          # @see OpenAI::Models::Chat::Completions::MessageListParams
          def list(completion_id, params = {})
            parsed, options = OpenAI::Chat::Completions::MessageListParams.dump_request(params)
            @client.request(
              method: :get,
              path: ["chat/completions/%1$s/messages", completion_id],
              query: parsed,
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Chat::ChatCompletionStoreMessage,
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
