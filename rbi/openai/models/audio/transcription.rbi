# typed: strong

module OpenAI
  module Models
    module Audio
      class Transcription < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The transcribed text.
        sig { returns(String) }
        attr_accessor :text

        # The log probabilities of the tokens in the transcription. Only returned with the
        # models `gpt-4o-transcribe` and `gpt-4o-mini-transcribe` if `logprobs` is added
        # to the `include` array.
        sig do
          returns(T.nilable(T::Array[OpenAI::Audio::Transcription::Logprob]))
        end
        attr_reader :logprobs

        sig do
          params(
            logprobs: T::Array[OpenAI::Audio::Transcription::Logprob::OrHash]
          ).void
        end
        attr_writer :logprobs

        # Represents a transcription response returned by model, based on the provided
        # input.
        sig do
          params(
            text: String,
            logprobs: T::Array[OpenAI::Audio::Transcription::Logprob::OrHash]
          ).returns(T.attached_class)
        end
        def self.new(
          # The transcribed text.
          text:,
          # The log probabilities of the tokens in the transcription. Only returned with the
          # models `gpt-4o-transcribe` and `gpt-4o-mini-transcribe` if `logprobs` is added
          # to the `include` array.
          logprobs: nil
        )
        end

        sig do
          override.returns(
            {
              text: String,
              logprobs: T::Array[OpenAI::Audio::Transcription::Logprob]
            }
          )
        end
        def to_hash
        end

        class Logprob < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

          # The token in the transcription.
          sig { returns(T.nilable(String)) }
          attr_reader :token

          sig { params(token: String).void }
          attr_writer :token

          # The bytes of the token.
          sig { returns(T.nilable(T::Array[Float])) }
          attr_reader :bytes

          sig { params(bytes: T::Array[Float]).void }
          attr_writer :bytes

          # The log probability of the token.
          sig { returns(T.nilable(Float)) }
          attr_reader :logprob

          sig { params(logprob: Float).void }
          attr_writer :logprob

          sig do
            params(
              token: String,
              bytes: T::Array[Float],
              logprob: Float
            ).returns(T.attached_class)
          end
          def self.new(
            # The token in the transcription.
            token: nil,
            # The bytes of the token.
            bytes: nil,
            # The log probability of the token.
            logprob: nil
          )
          end

          sig do
            override.returns(
              { token: String, bytes: T::Array[Float], logprob: Float }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
