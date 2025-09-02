# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeResponseUsageInputTokenDetails < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeResponseUsageInputTokenDetails,
              OpenAI::Internal::AnyHash
            )
          end

        # The number of audio tokens used in the Response.
        sig { returns(T.nilable(Integer)) }
        attr_reader :audio_tokens

        sig { params(audio_tokens: Integer).void }
        attr_writer :audio_tokens

        # The number of cached tokens used in the Response.
        sig { returns(T.nilable(Integer)) }
        attr_reader :cached_tokens

        sig { params(cached_tokens: Integer).void }
        attr_writer :cached_tokens

        # The number of text tokens used in the Response.
        sig { returns(T.nilable(Integer)) }
        attr_reader :text_tokens

        sig { params(text_tokens: Integer).void }
        attr_writer :text_tokens

        # Details about the input tokens used in the Response.
        sig do
          params(
            audio_tokens: Integer,
            cached_tokens: Integer,
            text_tokens: Integer
          ).returns(T.attached_class)
        end
        def self.new(
          # The number of audio tokens used in the Response.
          audio_tokens: nil,
          # The number of cached tokens used in the Response.
          cached_tokens: nil,
          # The number of text tokens used in the Response.
          text_tokens: nil
        )
        end

        sig do
          override.returns(
            {
              audio_tokens: Integer,
              cached_tokens: Integer,
              text_tokens: Integer
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
