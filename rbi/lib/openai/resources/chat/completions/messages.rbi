# typed: strong

module OpenAI
  module Resources
    class Chat
      class Completions
        class Messages
          # Get the messages in a stored chat completion. Only Chat Completions that have
          #   been created with the `store` parameter set to `true` will be returned.
          sig do
            params(
              completion_id: String,
              after: String,
              limit: Integer,
              order: Symbol,
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::CursorPage[OpenAI::Models::Chat::ChatCompletionStoreMessage])
          end
          def list(completion_id, after: nil, limit: nil, order: nil, request_options: {})
          end

          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end
