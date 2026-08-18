# typed: strong

module OpenAI
  module Models
    module Realtime
      class ResponseAudioTranscriptDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ResponseAudioTranscriptDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the content part in the item's content array.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The transcript delta.
        sig { returns(String) }
        attr_accessor :delta

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The ID of the response.
        sig { returns(String) }
        attr_accessor :response_id

        # The event type, must be `response.output_audio_transcript.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when the model-generated transcription of audio output is updated.
        sig do
          params(
            content_index: Integer,
            delta: String,
            event_id: String,
            item_id: String,
            output_index: Integer,
            response_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the content part in the item's content array.
          content_index:,
          # The transcript delta.
          delta:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the item.
          item_id:,
          # The index of the output item in the response.
          output_index:,
          # The ID of the response.
          response_id:,
          # The event type, must be `response.output_audio_transcript.delta`.
          type: :"response.output_audio_transcript.delta"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              delta: String,
              event_id: String,
              item_id: String,
              output_index: Integer,
              response_id: String,
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
