# typed: strong

module OpenAI
  module Models
    ChatCompletionStreamOptions = Chat::ChatCompletionStreamOptions

    module Chat
      class ChatCompletionStreamOptions < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionStreamOptions,
              OpenAI::Internal::AnyHash
            )
          end

        # When true, stream obfuscation will be enabled. Stream obfuscation adds random
        # characters to an `obfuscation` field on streaming delta events to normalize
        # payload sizes as a mitigation to certain side-channel attacks. These obfuscation
        # fields are included by default, but add a small amount of overhead to the data
        # stream. You can set `include_obfuscation` to false to optimize for bandwidth if
        # you trust the network links between your application and the OpenAI API.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :include_obfuscation

        sig { params(include_obfuscation: T::Boolean).void }
        attr_writer :include_obfuscation

        # If set, an additional chunk will be streamed before the `data: [DONE]` message.
        # The `usage` field on this chunk shows the token usage statistics for the entire
        # request, and the `choices` field will always be an empty array.
        #
        # All other chunks will also include a `usage` field, but with a null value.
        # **NOTE:** If the stream is interrupted, you may not receive the final usage
        # chunk which contains the total token usage for the request.
        sig { returns(T.nilable(T::Boolean)) }
        attr_reader :include_usage

        sig { params(include_usage: T::Boolean).void }
        attr_writer :include_usage

        # Options for streaming response. Only set this when you set `stream: true`.
        sig do
          params(
            include_obfuscation: T::Boolean,
            include_usage: T::Boolean
          ).returns(T.attached_class)
        end
        def self.new(
          # When true, stream obfuscation will be enabled. Stream obfuscation adds random
          # characters to an `obfuscation` field on streaming delta events to normalize
          # payload sizes as a mitigation to certain side-channel attacks. These obfuscation
          # fields are included by default, but add a small amount of overhead to the data
          # stream. You can set `include_obfuscation` to false to optimize for bandwidth if
          # you trust the network links between your application and the OpenAI API.
          include_obfuscation: nil,
          # If set, an additional chunk will be streamed before the `data: [DONE]` message.
          # The `usage` field on this chunk shows the token usage statistics for the entire
          # request, and the `choices` field will always be an empty array.
          #
          # All other chunks will also include a `usage` field, but with a null value.
          # **NOTE:** If the stream is interrupted, you may not receive the final usage
          # chunk which contains the total token usage for the request.
          include_usage: nil
        )
        end

        sig do
          override.returns(
            { include_obfuscation: T::Boolean, include_usage: T::Boolean }
          )
        end
        def to_hash
        end
      end
    end
  end
end
