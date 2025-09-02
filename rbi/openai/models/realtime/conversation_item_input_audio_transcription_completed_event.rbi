# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConversationItemInputAudioTranscriptionCompletedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the content part containing the audio.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the user message item containing the audio.
        sig { returns(String) }
        attr_accessor :item_id

        # The transcribed text.
        sig { returns(String) }
        attr_accessor :transcript

        # The event type, must be `conversation.item.input_audio_transcription.completed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Usage statistics for the transcription.
        sig do
          returns(
            T.any(
              OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens,
              OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageDuration
            )
          )
        end
        attr_accessor :usage

        # The log probabilities of the transcription.
        sig do
          returns(T.nilable(T::Array[OpenAI::Realtime::LogProbProperties]))
        end
        attr_accessor :logprobs

        # This event is the output of audio transcription for user audio written to the
        # user audio buffer. Transcription begins when the input audio buffer is committed
        # by the client or server (in `server_vad` mode). Transcription runs
        # asynchronously with Response creation, so this event may come before or after
        # the Response events.
        #
        # Realtime API models accept audio natively, and thus input transcription is a
        # separate process run on a separate ASR (Automatic Speech Recognition) model. The
        # transcript may diverge somewhat from the model's interpretation, and should be
        # treated as a rough guide.
        sig do
          params(
            content_index: Integer,
            event_id: String,
            item_id: String,
            transcript: String,
            usage:
              T.any(
                OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens::OrHash,
                OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageDuration::OrHash
              ),
            logprobs:
              T.nilable(T::Array[OpenAI::Realtime::LogProbProperties::OrHash]),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the content part containing the audio.
          content_index:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the user message item containing the audio.
          item_id:,
          # The transcribed text.
          transcript:,
          # Usage statistics for the transcription.
          usage:,
          # The log probabilities of the transcription.
          logprobs: nil,
          # The event type, must be `conversation.item.input_audio_transcription.completed`.
          type: :"conversation.item.input_audio_transcription.completed"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              event_id: String,
              item_id: String,
              transcript: String,
              type: Symbol,
              usage:
                T.any(
                  OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens,
                  OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageDuration
                ),
              logprobs: T.nilable(T::Array[OpenAI::Realtime::LogProbProperties])
            }
          )
        end
        def to_hash
        end

        # Usage statistics for the transcription.
        module Usage
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens,
                OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageDuration
              )
            end

          class TranscriptTextUsageTokens < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens,
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
                  OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens::InputTokenDetails
                )
              )
            end
            attr_reader :input_token_details

            sig do
              params(
                input_token_details:
                  OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens::InputTokenDetails::OrHash
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
                  OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens::InputTokenDetails::OrHash,
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
                    OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens::InputTokenDetails
                }
              )
            end
            def to_hash
            end

            class InputTokenDetails < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageTokens::InputTokenDetails,
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

          class TranscriptTextUsageDuration < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::TranscriptTextUsageDuration,
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
              T::Array[
                OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent::Usage::Variants
              ]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
