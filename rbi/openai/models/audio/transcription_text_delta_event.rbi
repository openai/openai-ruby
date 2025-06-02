# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Audio::TranscriptionTextDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The text delta that was additionally transcribed.
        sig { returns(String) }
        attr_accessor :delta

        # The type of the event. Always `transcript.text.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The log probabilities of the delta. Only included if you
        # [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        # with the `include[]` parameter set to `logprobs`.
        sig do
          returns(
            T.nilable(
              T::Array[OpenAI::Audio::TranscriptionTextDeltaEvent::Logprob]
            )
          )
        end
        attr_reader :logprobs

        sig do
          params(
            logprobs:
              T::Array[
                OpenAI::Audio::TranscriptionTextDeltaEvent::Logprob::OrHash
              ]
          ).void
        end
        attr_writer :logprobs

        # Emitted when there is an additional text delta. This is also the first event
        # emitted when the transcription starts. Only emitted when you
        # [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
        # with the `Stream` parameter set to `true`.
        sig do
          params(
            delta: String,
            logprobs:
              T::Array[
                OpenAI::Audio::TranscriptionTextDeltaEvent::Logprob::OrHash
              ],
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The text delta that was additionally transcribed.
          delta:,
          # The log probabilities of the delta. Only included if you
          # [create a transcription](https://platform.openai.com/docs/api-reference/audio/create-transcription)
          # with the `include[]` parameter set to `logprobs`.
          logprobs: nil,
          # The type of the event. Always `transcript.text.delta`.
          type: :"transcript.text.delta"
        )
        end

        sig do
          override.returns(
            {
              delta: String,
              type: Symbol,
              logprobs:
                T::Array[OpenAI::Audio::TranscriptionTextDeltaEvent::Logprob]
            }
          )
        end
        def to_hash
        end

        class Logprob < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Audio::TranscriptionTextDeltaEvent::Logprob,
                OpenAI::Internal::AnyHash
              )
            end

          # The token that was used to generate the log probability.
          sig { returns(T.nilable(String)) }
          attr_reader :token

          sig { params(token: String).void }
          attr_writer :token

          # The bytes that were used to generate the log probability.
          sig { returns(T.nilable(T::Array[Integer])) }
          attr_reader :bytes

          sig { params(bytes: T::Array[Integer]).void }
          attr_writer :bytes

          # The log probability of the token.
          sig { returns(T.nilable(Float)) }
          attr_reader :logprob

          sig { params(logprob: Float).void }
          attr_writer :logprob

          sig do
            params(
              token: String,
              bytes: T::Array[Integer],
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
              { token: String, bytes: T::Array[Integer], logprob: Float }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
