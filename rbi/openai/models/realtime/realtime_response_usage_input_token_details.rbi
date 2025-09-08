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

        # The number of audio tokens used as input for the Response.
        sig { returns(T.nilable(Integer)) }
        attr_reader :audio_tokens

        sig { params(audio_tokens: Integer).void }
        attr_writer :audio_tokens

        # The number of cached tokens used as input for the Response.
        sig { returns(T.nilable(Integer)) }
        attr_reader :cached_tokens

        sig { params(cached_tokens: Integer).void }
        attr_writer :cached_tokens

        # Details about the cached tokens used as input for the Response.
        sig do
          returns(
            T.nilable(
              OpenAI::Realtime::RealtimeResponseUsageInputTokenDetails::CachedTokensDetails
            )
          )
        end
        attr_reader :cached_tokens_details

        sig do
          params(
            cached_tokens_details:
              OpenAI::Realtime::RealtimeResponseUsageInputTokenDetails::CachedTokensDetails::OrHash
          ).void
        end
        attr_writer :cached_tokens_details

        # The number of image tokens used as input for the Response.
        sig { returns(T.nilable(Integer)) }
        attr_reader :image_tokens

        sig { params(image_tokens: Integer).void }
        attr_writer :image_tokens

        # The number of text tokens used as input for the Response.
        sig { returns(T.nilable(Integer)) }
        attr_reader :text_tokens

        sig { params(text_tokens: Integer).void }
        attr_writer :text_tokens

        # Details about the input tokens used in the Response. Cached tokens are tokens
        # from previous turns in the conversation that are included as context for the
        # current response. Cached tokens here are counted as a subset of input tokens,
        # meaning input tokens will include cached and uncached tokens.
        sig do
          params(
            audio_tokens: Integer,
            cached_tokens: Integer,
            cached_tokens_details:
              OpenAI::Realtime::RealtimeResponseUsageInputTokenDetails::CachedTokensDetails::OrHash,
            image_tokens: Integer,
            text_tokens: Integer
          ).returns(T.attached_class)
        end
        def self.new(
          # The number of audio tokens used as input for the Response.
          audio_tokens: nil,
          # The number of cached tokens used as input for the Response.
          cached_tokens: nil,
          # Details about the cached tokens used as input for the Response.
          cached_tokens_details: nil,
          # The number of image tokens used as input for the Response.
          image_tokens: nil,
          # The number of text tokens used as input for the Response.
          text_tokens: nil
        )
        end

        sig do
          override.returns(
            {
              audio_tokens: Integer,
              cached_tokens: Integer,
              cached_tokens_details:
                OpenAI::Realtime::RealtimeResponseUsageInputTokenDetails::CachedTokensDetails,
              image_tokens: Integer,
              text_tokens: Integer
            }
          )
        end
        def to_hash
        end

        class CachedTokensDetails < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeResponseUsageInputTokenDetails::CachedTokensDetails,
                OpenAI::Internal::AnyHash
              )
            end

          # The number of cached audio tokens used as input for the Response.
          sig { returns(T.nilable(Integer)) }
          attr_reader :audio_tokens

          sig { params(audio_tokens: Integer).void }
          attr_writer :audio_tokens

          # The number of cached image tokens used as input for the Response.
          sig { returns(T.nilable(Integer)) }
          attr_reader :image_tokens

          sig { params(image_tokens: Integer).void }
          attr_writer :image_tokens

          # The number of cached text tokens used as input for the Response.
          sig { returns(T.nilable(Integer)) }
          attr_reader :text_tokens

          sig { params(text_tokens: Integer).void }
          attr_writer :text_tokens

          # Details about the cached tokens used as input for the Response.
          sig do
            params(
              audio_tokens: Integer,
              image_tokens: Integer,
              text_tokens: Integer
            ).returns(T.attached_class)
          end
          def self.new(
            # The number of cached audio tokens used as input for the Response.
            audio_tokens: nil,
            # The number of cached image tokens used as input for the Response.
            image_tokens: nil,
            # The number of cached text tokens used as input for the Response.
            text_tokens: nil
          )
          end

          sig do
            override.returns(
              {
                audio_tokens: Integer,
                image_tokens: Integer,
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
end
