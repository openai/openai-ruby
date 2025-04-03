# typed: strong

module OpenAI
  module Models
    module Chat
      class ChatCompletionStreamOptions < OpenAI::Internal::Type::BaseModel
        # If set, an additional chunk will be streamed before the `data: [DONE]` message.
        #   The `usage` field on this chunk shows the token usage statistics for the entire
        #   request, and the `choices` field will always be an empty array.
        #
        #   All other chunks will also include a `usage` field, but with a null value.
        #   **NOTE:** If the stream is interrupted, you may not receive the final usage
        #   chunk which contains the total token usage for the request.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :include_usage

        sig { params(include_usage: T::Boolean).void }
        attr_writer :include_usage

        # Options for streaming response. Only set this when you set `stream: true`.
        sig { params(include_usage: T::Boolean).returns(T.attached_class) }
        def self.new(include_usage: nil)
        end

        sig { override.returns({include_usage: T::Boolean}) }
        def to_hash
        end
      end
    end

    ChatCompletionStreamOptions = Chat::ChatCompletionStreamOptions
  end
end
