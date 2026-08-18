# typed: strong

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferTimeoutTriggered < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::InputAudioBufferTimeoutTriggered,
              OpenAI::Internal::AnyHash
            )
          end

        # Millisecond offset of audio written to the input audio buffer at the time the
        # timeout was triggered.
        sig { returns(Integer) }
        attr_accessor :audio_end_ms

        # Millisecond offset of audio written to the input audio buffer that was after the
        # playback time of the last model response.
        sig { returns(Integer) }
        attr_accessor :audio_start_ms

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the item associated with this segment.
        sig { returns(String) }
        attr_accessor :item_id

        # The event type, must be `input_audio_buffer.timeout_triggered`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when the Server VAD timeout is triggered for the input audio buffer.
        # This is configured with `idle_timeout_ms` in the `turn_detection` settings of
        # the session, and it indicates that there hasn't been any speech detected for the
        # configured duration.
        #
        # The `audio_start_ms` and `audio_end_ms` fields indicate the segment of audio
        # after the last model response up to the triggering time, as an offset from the
        # beginning of audio written to the input audio buffer. This means it demarcates
        # the segment of audio that was silent and the difference between the start and
        # end values will roughly match the configured timeout.
        #
        # The empty audio will be committed to the conversation as an `input_audio` item
        # (there will be a `input_audio_buffer.committed` event) and a model response will
        # be generated. There may be speech that didn't trigger VAD but is still detected
        # by the model, so the model may respond with something relevant to the
        # conversation or a prompt to continue speaking.
        sig do
          params(
            audio_end_ms: Integer,
            audio_start_ms: Integer,
            event_id: String,
            item_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Millisecond offset of audio written to the input audio buffer at the time the
          # timeout was triggered.
          audio_end_ms:,
          # Millisecond offset of audio written to the input audio buffer that was after the
          # playback time of the last model response.
          audio_start_ms:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the item associated with this segment.
          item_id:,
          # The event type, must be `input_audio_buffer.timeout_triggered`.
          type: :"input_audio_buffer.timeout_triggered"
        )
        end

        sig do
          override.returns(
            {
              audio_end_ms: Integer,
              audio_start_ms: Integer,
              event_id: String,
              item_id: String,
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
