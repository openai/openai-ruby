# typed: strong

module OpenAI
  module Models
    module Audio
      class Transcription < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Audio::Transcription, OpenAI::Internal::AnyHash)
          end

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

        # Token usage statistics for the request.
        sig do
          returns(T.nilable(OpenAI::Audio::Transcription::Usage::Variants))
        end
        attr_reader :usage

        sig do
          params(
            usage:
              T.any(
                OpenAI::Audio::Transcription::Usage::Tokens::OrHash,
                OpenAI::Audio::Transcription::Usage::Duration::OrHash
              )
          ).void
        end
        attr_writer :usage

        # Represents a transcription response returned by model, based on the provided
        # input.
        sig do
          params(
            text: String,
            logprobs: T::Array[OpenAI::Audio::Transcription::Logprob::OrHash],
            usage:
              T.any(
                OpenAI::Audio::Transcription::Usage::Tokens::OrHash,
                OpenAI::Audio::Transcription::Usage::Duration::OrHash
              )
          ).returns(T.attached_class)
        end
        def self.new(
          # The transcribed text.
          text:,
          # The log probabilities of the tokens in the transcription. Only returned with the
          # models `gpt-4o-transcribe` and `gpt-4o-mini-transcribe` if `logprobs` is added
          # to the `include` array.
          logprobs: nil,
          # Token usage statistics for the request.
          usage: nil
        )
        end

        sig do
          override.returns(
            {
              text: String,
              logprobs: T::Array[OpenAI::Audio::Transcription::Logprob],
              usage: OpenAI::Audio::Transcription::Usage::Variants
            }
          )
        end
        def to_hash
        end

        class Logprob < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Audio::Transcription::Logprob,
                OpenAI::Internal::AnyHash
              )
            end

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

        # Token usage statistics for the request.
        module Usage
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Audio::Transcription::Usage::Tokens,
                OpenAI::Audio::Transcription::Usage::Duration
              )
            end

          class Tokens < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Audio::Transcription::Usage::Tokens,
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
                  OpenAI::Audio::Transcription::Usage::Tokens::InputTokenDetails
                )
              )
            end
            attr_reader :input_token_details

            sig do
              params(
                input_token_details:
                  OpenAI::Audio::Transcription::Usage::Tokens::InputTokenDetails::OrHash
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
                  OpenAI::Audio::Transcription::Usage::Tokens::InputTokenDetails::OrHash,
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
                    OpenAI::Audio::Transcription::Usage::Tokens::InputTokenDetails
                }
              )
            end
            def to_hash
            end

            class InputTokenDetails < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Audio::Transcription::Usage::Tokens::InputTokenDetails,
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
                  OpenAI::Audio::Transcription::Usage::Duration,
                  OpenAI::Internal::AnyHash
                )
              end

            # Duration of the input audio in seconds.
            sig { returns(Float) }
            attr_accessor :duration

            # The type of the usage object. Always `duration` for this variant.
            sig { returns(Symbol) }
            attr_accessor :type

            # Usage statistics for models billed by audio input duration.
            sig do
              params(duration: Float, type: Symbol).returns(T.attached_class)
            end
            def self.new(
              # Duration of the input audio in seconds.
              duration:,
              # The type of the usage object. Always `duration` for this variant.
              type: :duration
            )
            end

            sig { override.returns({ duration: Float, type: Symbol }) }
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[OpenAI::Audio::Transcription::Usage::Variants]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
