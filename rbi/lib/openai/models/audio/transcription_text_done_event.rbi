# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionTextDoneEvent < OpenAI::BaseModel
        # The text that was transcribed.
        sig { returns(String) }
        def text
        end

        sig { params(_: String).returns(String) }
        def text=(_)
        end

        # The type of the event. Always `transcript.text.done`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # The log probabilities of the individual tokens in the transcription. Only
        #   included if you
        #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #   with the `include[]` parameter set to `logprobs`.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Audio::TranscriptionTextDoneEvent::Logprob])) }
        def logprobs
        end

        sig do
          params(
            _: T::Array[T.any(OpenAI::Models::Audio::TranscriptionTextDoneEvent::Logprob, OpenAI::Util::AnyHash)]
          )
            .returns(
              T::Array[T.any(OpenAI::Models::Audio::TranscriptionTextDoneEvent::Logprob, OpenAI::Util::AnyHash)]
            )
        end
        def logprobs=(_)
        end

        # Emitted when the transcription is complete. Contains the complete transcription
        #   text. Only emitted when you
        #   [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        #   with the `Stream` parameter set to `true`.
        sig do
          params(
            text: String,
            logprobs: T::Array[T.any(OpenAI::Models::Audio::TranscriptionTextDoneEvent::Logprob, OpenAI::Util::AnyHash)],
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(text:, logprobs: nil, type: :"transcript.text.done")
        end

        sig do
          override
            .returns(
              {text: String, type: Symbol, logprobs: T::Array[OpenAI::Models::Audio::TranscriptionTextDoneEvent::Logprob]}
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
