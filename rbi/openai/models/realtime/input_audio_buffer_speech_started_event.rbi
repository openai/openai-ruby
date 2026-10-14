# typed: strong

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferSpeechStartedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::InputAudioBufferSpeechStartedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Milliseconds from the start of all audio written to the buffer during the
        # session when speech was first detected. This will correspond to the beginning of
        # audio sent to the model, and thus includes the `prefix_padding_ms` configured in
        # the Session.
        sig { returns(Integer) }
        attr_accessor :audio_start_ms

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the user message item that will be created when speech stops.
        sig { returns(String) }
        attr_accessor :item_id

        # The event type, must be `input_audio_buffer.speech_started`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Sent by the server when in `server_vad` mode to indicate that speech has been
        # detected in the audio buffer. This can happen any time audio is added to the
        # buffer (unless speech is already detected). The client may want to use this
        # event to interrupt audio playback or provide visual feedback to the user.
        #
        # The client should expect to receive a `input_audio_buffer.speech_stopped` event
        # when speech stops. The `item_id` property is the ID of the user message item
        # that will be created when speech stops and will also be included in the
        # `input_audio_buffer.speech_stopped` event (unless the client manually commits
        # the audio buffer during VAD activation).
        sig do
          params(
            audio_start_ms: Integer,
            event_id: String,
            item_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Milliseconds from the start of all audio written to the buffer during the
          # session when speech was first detected. This will correspond to the beginning of
          # audio sent to the model, and thus includes the `prefix_padding_ms` configured in
          # the Session.
          audio_start_ms:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the user message item that will be created when speech stops.
          item_id:,
          # The event type, must be `input_audio_buffer.speech_started`.
          type: :"input_audio_buffer.speech_started"
        )
        end

        sig do
          override.returns(
            {
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
