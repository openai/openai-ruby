# typed: strong

module OpenAI
  module Models
    module Realtime
      class ConversationItemInputAudioTranscriptionSegment < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationItemInputAudioTranscriptionSegment,
              OpenAI::Internal::AnyHash
            )
          end

        # The segment identifier.
        sig { returns(String) }
        attr_accessor :id

        # The index of the input audio content part within the item.
        sig { returns(Integer) }
        attr_accessor :content_index

        # End time of the segment in seconds.
        sig { returns(Float) }
        attr_accessor :end_

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the item containing the input audio content.
        sig { returns(String) }
        attr_accessor :item_id

        # The detected speaker label for this segment.
        sig { returns(String) }
        attr_accessor :speaker

        # Start time of the segment in seconds.
        sig { returns(Float) }
        attr_accessor :start

        # The text for this segment.
        sig { returns(String) }
        attr_accessor :text

        # The event type, must be `conversation.item.input_audio_transcription.segment`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when an input audio transcription segment is identified for an item.
        sig do
          params(
            id: String,
            content_index: Integer,
            end_: Float,
            event_id: String,
            item_id: String,
            speaker: String,
            start: Float,
            text: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The segment identifier.
          id:,
          # The index of the input audio content part within the item.
          content_index:,
          # End time of the segment in seconds.
          end_:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the item containing the input audio content.
          item_id:,
          # The detected speaker label for this segment.
          speaker:,
          # Start time of the segment in seconds.
          start:,
          # The text for this segment.
          text:,
          # The event type, must be `conversation.item.input_audio_transcription.segment`.
          type: :"conversation.item.input_audio_transcription.segment"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              content_index: Integer,
              end_: Float,
              event_id: String,
              item_id: String,
              speaker: String,
              start: Float,
              text: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
