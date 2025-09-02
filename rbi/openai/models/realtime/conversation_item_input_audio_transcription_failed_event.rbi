# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConversationItemInputAudioTranscriptionFailedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationItemInputAudioTranscriptionFailedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the content part containing the audio.
        sig { returns(Integer) }
        attr_accessor :content_index

        # Details of the transcription error.
        sig do
          returns(
            OpenAI::Realtime::ConversationItemInputAudioTranscriptionFailedEvent::Error
          )
        end
        attr_reader :error

        sig do
          params(
            error:
              OpenAI::Realtime::ConversationItemInputAudioTranscriptionFailedEvent::Error::OrHash
          ).void
        end
        attr_writer :error

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the user message item.
        sig { returns(String) }
        attr_accessor :item_id

        # The event type, must be `conversation.item.input_audio_transcription.failed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when input audio transcription is configured, and a transcription
        # request for a user message failed. These events are separate from other `error`
        # events so that the client can identify the related Item.
        sig do
          params(
            content_index: Integer,
            error:
              OpenAI::Realtime::ConversationItemInputAudioTranscriptionFailedEvent::Error::OrHash,
            event_id: String,
            item_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the content part containing the audio.
          content_index:,
          # Details of the transcription error.
          error:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the user message item.
          item_id:,
          # The event type, must be `conversation.item.input_audio_transcription.failed`.
          type: :"conversation.item.input_audio_transcription.failed"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              error:
                OpenAI::Realtime::ConversationItemInputAudioTranscriptionFailedEvent::Error,
              event_id: String,
              item_id: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Error < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::ConversationItemInputAudioTranscriptionFailedEvent::Error,
                OpenAI::Internal::AnyHash
              )
            end

          # Error code, if any.
          sig { returns(T.nilable(String)) }
          attr_reader :code

          sig { params(code: String).void }
          attr_writer :code

          # A human-readable error message.
          sig { returns(T.nilable(String)) }
          attr_reader :message

          sig { params(message: String).void }
          attr_writer :message

          # Parameter related to the error, if any.
          sig { returns(T.nilable(String)) }
          attr_reader :param

          sig { params(param: String).void }
          attr_writer :param

          # The type of error.
          sig { returns(T.nilable(String)) }
          attr_reader :type

          sig { params(type: String).void }
          attr_writer :type

          # Details of the transcription error.
          sig do
            params(
              code: String,
              message: String,
              param: String,
              type: String
            ).returns(T.attached_class)
          end
          def self.new(
            # Error code, if any.
            code: nil,
            # A human-readable error message.
            message: nil,
            # Parameter related to the error, if any.
            param: nil,
            # The type of error.
            type: nil
          )
          end

          sig do
            override.returns(
              { code: String, message: String, param: String, type: String }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
