# typed: strong

module OpenAI
  module Models
    module Audio
      class Transcription < OpenAI::Internal::Type::BaseModel
        # The transcribed text.
        sig { returns(String) }
        attr_accessor :text

        # The log probabilities of the tokens in the transcription. Only returned with the
        #   models `gpt-4o-transcribe` and `gpt-4o-mini-transcribe` if `logprobs` is added
        #   to the `include` array.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Audio::Transcription::Logprob])) }
        attr_reader :logprobs

        sig do
          params(
            logprobs: T::Array[T.any(OpenAI::Models::Audio::Transcription::Logprob, OpenAI::Internal::AnyHash)]
          )
            .void
        end
        attr_writer :logprobs

        # Represents a transcription response returned by model, based on the provided
        #   input.
        sig do
          params(
            text: String,
            logprobs: T::Array[T.any(OpenAI::Models::Audio::Transcription::Logprob, OpenAI::Internal::AnyHash)]
          )
            .returns(T.attached_class)
        end
        def self.new(text:, logprobs: nil)
        end

        sig { override.returns({text: String, logprobs: T::Array[OpenAI::Models::Audio::Transcription::Logprob]}) }
        def to_hash
        end

        class Logprob < OpenAI::Internal::Type::BaseModel
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

          sig { params(token: String, bytes: T::Array[Float], logprob: Float).returns(T.attached_class) }
          def self.new(token: nil, bytes: nil, logprob: nil)
          end

          sig { override.returns({token: String, bytes: T::Array[Float], logprob: Float}) }
          def to_hash
          end
        end
      end
    end
  end
end
