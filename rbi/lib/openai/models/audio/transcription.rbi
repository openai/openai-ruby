# typed: strong

module OpenAI
  module Models
    module Audio
      class Transcription < OpenAI::BaseModel
        # The transcribed text.
        sig { returns(String) }
        def text
        end

        sig { params(_: String).returns(String) }
        def text=(_)
        end

        # The log probabilities of the tokens in the transcription. Only returned with the
        #   models `gpt-4o-transcribe` and `gpt-4o-mini-transcribe` if `logprobs` is added
        #   to the `include` array.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Audio::Transcription::Logprob])) }
        def logprobs
        end

        sig do
          params(_: T::Array[OpenAI::Models::Audio::Transcription::Logprob])
            .returns(T::Array[OpenAI::Models::Audio::Transcription::Logprob])
        end
        def logprobs=(_)
        end

        # Represents a transcription response returned by model, based on the provided
        #   input.
        sig do
          params(text: String, logprobs: T::Array[OpenAI::Models::Audio::Transcription::Logprob])
            .returns(T.attached_class)
        end
        def self.new(text:, logprobs: nil)
        end

        sig { override.returns({text: String, logprobs: T::Array[OpenAI::Models::Audio::Transcription::Logprob]}) }
        def to_hash
        end

        class Logprob < OpenAI::BaseModel
          # The token in the transcription.
          sig { returns(T.nilable(String)) }
          def token
          end

          sig { params(_: String).returns(String) }
          def token=(_)
          end

          # The bytes of the token.
          sig { returns(T.nilable(T::Array[Float])) }
          def bytes
          end

          sig { params(_: T::Array[Float]).returns(T::Array[Float]) }
          def bytes=(_)
          end

          # The log probability of the token.
          sig { returns(T.nilable(Float)) }
          def logprob
          end

          sig { params(_: Float).returns(Float) }
          def logprob=(_)
          end

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
