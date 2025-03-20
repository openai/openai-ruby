# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionTextDeltaEvent < OpenAI::BaseModel
        # The text delta that was additionally transcribed.
        sig { returns(String) }
        def delta
        end

        sig { params(_: String).returns(String) }
        def delta=(_)
        end

        # The type of the event. Always `transcript.text.delta`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # The log probabilities of the delta. Only included if you
        #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #   with the `include[]` parameter set to `logprobs`.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob])) }
        def logprobs
        end

        sig do
          params(_: T::Array[OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob])
            .returns(T::Array[OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob])
        end
        def logprobs=(_)
        end

        # Emitted when there is an additional text delta. This is also the first event
        #   emitted when the transcription starts. Only emitted when you
        #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #   with the `Stream` parameter set to `true`.
        sig do
          params(
            delta: String,
            logprobs: T::Array[OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob],
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(delta:, logprobs: nil, type: :"transcript.text.delta")
        end

        sig do
          override
            .returns(
              {delta: String, type: Symbol, logprobs: T::Array[OpenAI::Models::Audio::TranscriptionTextDeltaEvent::Logprob]}
            )
        end
        def to_hash
        end

        class Logprob < OpenAI::BaseModel
          # The token that was used to generate the log probability.
          sig { returns(T.nilable(String)) }
          def token
          end

          sig { params(_: String).returns(String) }
          def token=(_)
          end

          # The bytes that were used to generate the log probability.
          sig { returns(T.nilable(T::Array[T.anything])) }
          def bytes
          end

          sig { params(_: T::Array[T.anything]).returns(T::Array[T.anything]) }
          def bytes=(_)
          end

          # The log probability of the token.
          sig { returns(T.nilable(Float)) }
          def logprob
          end

          sig { params(_: Float).returns(Float) }
          def logprob=(_)
          end

          sig { params(token: String, bytes: T::Array[T.anything], logprob: Float).returns(T.attached_class) }
          def self.new(token: nil, bytes: nil, logprob: nil)
          end

          sig { override.returns({token: String, bytes: T::Array[T.anything], logprob: Float}) }
          def to_hash
          end
        end
      end
    end
  end
end
