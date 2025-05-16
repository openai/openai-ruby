# typed: strong

module OpenAI
  module Resources
    class Chat
      class Completions
        class Messages
          # Get the messages in a stored chat completion. Only Chat Completions that have
          # been created with the `store` parameter set to `true` will be returned.
          sig do
            params(
              completion_id: String,
              after: String,
              limit: Integer,
              order:
                OpenAI::Chat::Completions::MessageListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::CursorPage[
                OpenAI::Chat::ChatCompletionStoreMessage
              ]
            )
          end
          def list(
            # The ID of the chat completion to retrieve messages from.
            completion_id,
            # Identifier for the last message from the previous pagination request.
            after: nil,
            # Number of messages to retrieve.
            limit: nil,
            # Sort order for messages by timestamp. Use `asc` for ascending order or `desc`
            # for descending order. Defaults to `asc`.
            order: nil,
            request_options: {}
          )
          end

          # @api private
          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end
