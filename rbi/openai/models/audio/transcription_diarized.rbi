# typed: strong

module OpenAI
  module Models
    module Audio
      class TranscriptionDiarized < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Audio::TranscriptionDiarized,
              OpenAI::Internal::AnyHash
            )
          end

        # Duration of the input audio in seconds.
        sig { returns(Float) }
        attr_accessor :duration

        # Segments of the transcript annotated with timestamps and speaker labels.
        sig { returns(T::Array[OpenAI::Audio::TranscriptionDiarizedSegment]) }
        attr_accessor :segments

        # The type of task that was run. Always `transcribe`.
        sig { returns(Symbol) }
        attr_accessor :task

        # The concatenated transcript text for the entire audio input.
        sig { returns(String) }
        attr_accessor :text

        # Token or duration usage statistics for the request.
        sig do
          returns(
            T.nilable(OpenAI::Audio::TranscriptionDiarized::Usage::Variants)
          )
        end
        attr_reader :usage

        sig do
          params(
            usage:
              T.any(
                OpenAI::Audio::TranscriptionDiarized::Usage::Tokens::OrHash,
                OpenAI::Audio::TranscriptionDiarized::Usage::Duration::OrHash
              )
          ).void
        end
        attr_writer :usage

        # Represents a diarized transcription response returned by the model, including
        # the combined transcript and speaker-segment annotations.
        sig do
          params(
            duration: Float,
            segments:
              T::Array[OpenAI::Audio::TranscriptionDiarizedSegment::OrHash],
            text: String,
            usage:
              T.any(
                OpenAI::Audio::TranscriptionDiarized::Usage::Tokens::OrHash,
                OpenAI::Audio::TranscriptionDiarized::Usage::Duration::OrHash
              ),
            task: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Duration of the input audio in seconds.
          duration:,
          # Segments of the transcript annotated with timestamps and speaker labels.
          segments:,
          # The concatenated transcript text for the entire audio input.
          text:,
          # Token or duration usage statistics for the request.
          usage: nil,
          # The type of task that was run. Always `transcribe`.
          task: :transcribe
        )
        end

        sig do
          override.returns(
            {
              duration: Float,
              segments: T::Array[OpenAI::Audio::TranscriptionDiarizedSegment],
              task: Symbol,
              text: String,
              usage: OpenAI::Audio::TranscriptionDiarized::Usage::Variants
            }
          )
        end
        def to_hash
        end

        # Token or duration usage statistics for the request.
        module Usage
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Audio::TranscriptionDiarized::Usage::Tokens,
                OpenAI::Audio::TranscriptionDiarized::Usage::Duration
              )
            end

          class Tokens < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Audio::TranscriptionDiarized::Usage::Tokens,
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
                  OpenAI::Audio::TranscriptionDiarized::Usage::Tokens::InputTokenDetails
                )
              )
            end
            attr_reader :input_token_details

            sig do
              params(
                input_token_details:
                  OpenAI::Audio::TranscriptionDiarized::Usage::Tokens::InputTokenDetails::OrHash
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
                  OpenAI::Audio::TranscriptionDiarized::Usage::Tokens::InputTokenDetails::OrHash,
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
                    OpenAI::Audio::TranscriptionDiarized::Usage::Tokens::InputTokenDetails
                }
              )
            end
            def to_hash
            end

            class InputTokenDetails < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Audio::TranscriptionDiarized::Usage::Tokens::InputTokenDetails,
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
                override.returns(
                  { audio_tokens: Integer, text_tokens: Integer }
                )
              end
              def to_hash
              end
            end
          end

          class Duration < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Audio::TranscriptionDiarized::Usage::Duration,
                  OpenAI::Internal::AnyHash
                )
              end

            # Duration of the input audio in seconds.
            sig { returns(Float) }
            attr_accessor :seconds

            # The type of the usage object. Always `duration` for this variant.
            sig { returns(Symbol) }
            attr_accessor :type

            # Usage statistics for models billed by audio input duration.
            sig do
              params(seconds: Float, type: Symbol).returns(T.attached_class)
            end
            def self.new(
              # Duration of the input audio in seconds.
              seconds:,
              # The type of the usage object. Always `duration` for this variant.
              type: :duration
            )
            end

            sig { override.returns({ seconds: Float, type: Symbol }) }
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[OpenAI::Audio::TranscriptionDiarized::Usage::Variants]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
