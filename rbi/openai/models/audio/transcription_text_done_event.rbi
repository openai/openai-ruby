# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionTextDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Audio::TranscriptionTextDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The text that was transcribed.
        sig { returns(String) }
        attr_accessor :text

        # The type of the event. Always `transcript.text.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The log probabilities of the individual tokens in the transcription. Only
        # included if you
        # [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        # with the `include[]` parameter set to `logprobs`.
        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::Audio::TranscriptionTextDoneEvent::Logprob]
            )
          )
        end
        attr_reader :logprobs

        sig do
          params(
            logprobs:
              T::Array[
                OpenAI::Audio::TranscriptionTextDoneEvent::Logprob::OrHash
              ]
          ).void
        end
        attr_writer :logprobs

        # Emitted when the transcription is complete. Contains the complete transcription
        # text. Only emitted when you
        # [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        # with the `Stream` parameter set to `true`.
        sig do
          params(
            text: String,
            logprobs:
              T::Array[
                OpenAI::Audio::TranscriptionTextDoneEvent::Logprob::OrHash
              ],
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The text that was transcribed.
          text:,
          # The log probabilities of the individual tokens in the transcription. Only
          # included if you
          # [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
          # with the `include[]` parameter set to `logprobs`.
          logprobs: nil,
          # The type of the event. Always `transcript.text.done`.
          type: :"transcript.text.done"
        )
        end

        sig do
          override.returns(
            {
              text: String,
              type: Symbol,
              logprobs:
                T::Array[OpenAI::Audio::TranscriptionTextDoneEvent::Logprob]
            }
          )
        end
        def to_hash
        end

        class Logprob < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Audio::TranscriptionTextDoneEvent::Logprob,
                OpenAI::Internal::AnyHash
              )
            end

          # The token that was used to generate the log probability.
          sig { returns(T.nilable(String)) }
          attr_reader :token

          sig { params(token: String).void }
          attr_writer :token

          # The bytes that were used to generate the log probability.
          sig { returns(T.nilable(T::Array[T.anything])) }
          attr_reader :bytes

          sig { params(bytes: T::Array[T.anything]).void }
          attr_writer :bytes

          # The log probability of the token.
          sig { returns(T.nilable(Float)) }
          attr_reader :logprob

          sig { params(logprob: Float).void }
          attr_writer :logprob

          sig do
            params(
              token: String,
              bytes: T::Array[T.anything],
              logprob: Float
            ).returns(T.attached_class)
          end
          def self.new(
            # The token that was used to generate the log probability.
            token: nil,
            # The bytes that were used to generate the log probability.
            bytes: nil,
            # The log probability of the token.
            logprob: nil
          )
          end

          sig do
            override.returns(
              { token: String, bytes: T::Array[T.anything], logprob: Float }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
