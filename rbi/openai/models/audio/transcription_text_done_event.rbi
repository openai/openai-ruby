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

        # Usage statistics for models billed by token usage.
        sig do
          returns(T.nilable(OpenAI::Audio::TranscriptionTextDoneEvent::Usage))
        end
        attr_reader :usage

        sig do
          params(
            usage: OpenAI::Audio::TranscriptionTextDoneEvent::Usage::OrHash
          ).void
        end
        attr_writer :usage

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
            usage: OpenAI::Audio::TranscriptionTextDoneEvent::Usage::OrHash,
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
          # Usage statistics for models billed by token usage.
          usage: nil,
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
                T::Array[OpenAI::Audio::TranscriptionTextDoneEvent::Logprob],
              usage: OpenAI::Audio::TranscriptionTextDoneEvent::Usage
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

        class Usage < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Audio::TranscriptionTextDoneEvent::Usage,
                OpenAI::Internal::AnyHash
              )
            end

          # Number of input tokens billed for this request.
          sig { returns(Integer) }
          attr_accessor :input_tokens

          # Number of output tokens generated.
          sig { returns(Integer) }
          attr_accessor :output_tokens

          # Total number of tokens used (input + output).
          sig { returns(Integer) }
          attr_accessor :total_tokens

          # The type of the usage object. Always `tokens` for this variant.
          sig { returns(Symbol) }
          attr_accessor :type

          # Details about the input tokens billed for this request.
          sig do
            returns(
              T.nilable(
                OpenAI::Audio::TranscriptionTextDoneEvent::Usage::InputTokenDetails
              )
            )
          end
          attr_reader :input_token_details

          sig do
            params(
              input_token_details:
                OpenAI::Audio::TranscriptionTextDoneEvent::Usage::InputTokenDetails::OrHash
            ).void
          end
          attr_writer :input_token_details

          # Usage statistics for models billed by token usage.
          sig do
            params(
              input_tokens: Integer,
              output_tokens: Integer,
              total_tokens: Integer,
              input_token_details:
                OpenAI::Audio::TranscriptionTextDoneEvent::Usage::InputTokenDetails::OrHash,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Number of input tokens billed for this request.
            input_tokens:,
            # Number of output tokens generated.
            output_tokens:,
            # Total number of tokens used (input + output).
            total_tokens:,
            # Details about the input tokens billed for this request.
            input_token_details: nil,
            # The type of the usage object. Always `tokens` for this variant.
            type: :tokens
          )
          end

          sig do
            override.returns(
              {
                input_tokens: Integer,
                output_tokens: Integer,
                total_tokens: Integer,
                type: Symbol,
                input_token_details:
                  OpenAI::Audio::TranscriptionTextDoneEvent::Usage::InputTokenDetails
              }
            )
          end
          def to_hash
          end

          class InputTokenDetails < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Audio::TranscriptionTextDoneEvent::Usage::InputTokenDetails,
                  OpenAI::Internal::AnyHash
                )
              end

            # Number of audio tokens billed for this request.
            sig { returns(T.nilable(Integer)) }
            attr_reader :audio_tokens

            sig { params(audio_tokens: Integer).void }
            attr_writer :audio_tokens

            # Number of text tokens billed for this request.
            sig { returns(T.nilable(Integer)) }
            attr_reader :text_tokens

            sig { params(text_tokens: Integer).void }
            attr_writer :text_tokens

            # Details about the input tokens billed for this request.
            sig do
              params(audio_tokens: Integer, text_tokens: Integer).returns(
                T.attached_class
              )
            end
            def self.new(
              # Number of audio tokens billed for this request.
              audio_tokens: nil,
              # Number of text tokens billed for this request.
              text_tokens: nil
            )
            end

            sig do
              override.returns({ audio_tokens: Integer, text_tokens: Integer })
            end
            def to_hash
            end
          end
        end
      end
    end
  end
end
