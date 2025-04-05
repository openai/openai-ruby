# frozen_string_literal: true

module OpenAI
  module Resources
    class Chat
      class Completions
        class Messages
          # Get the messages in a stored chat completion. Only Chat Completions that have
          # been created with the `store` parameter set to `true` will be returned.
          #
          # @overload list(completion_id, after: nil, limit: nil, order: nil, request_options: {})
          #
          # @param completion_id [String]
          # @param after [String]
          # @param limit [Integer]
          # @param order [Symbol, OpenAI::Models::Chat::Completions::MessageListParams::Order]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Chat::ChatCompletionStoreMessage>]
          #
          # @see OpenAI::Models::Chat::Completions::MessageListParams
          def list(completion_id, params = {})
            parsed, options = OpenAI::Models::Chat::Completions::MessageListParams.dump_request(params)
            @client.request(
              method: :get,
              path: ["chat/completions/%1$s/messages", completion_id],
              query: parsed,
              page: OpenAI::Internal::CursorPage,
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
