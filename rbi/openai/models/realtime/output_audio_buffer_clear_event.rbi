# typed: strong

module OpenAI
  module Models
    module Realtime
      class OutputAudioBufferClearEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::OutputAudioBufferClearEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The event type, must be `output_audio_buffer.clear`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The unique ID of the client event used for error handling.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # **WebRTC Only:** Emit to cut off the current audio response. This will trigger
        # the server to stop generating audio and emit a `output_audio_buffer.cleared`
        # event. This event should be preceded by a `response.cancel` client event to stop
        # the generation of the current response.
        # [Learn more](https://platform.openai.com/docs/guides/realtime-conversations#client-and-server-events-for-audio-in-webrtc).
        sig { params(event_id: String, type: Symbol).returns(T.attached_class) }
        def self.new(
          # The unique ID of the client event used for error handling.
          event_id: nil,
          # The event type, must be `output_audio_buffer.clear`.
          type: :"output_audio_buffer.clear"
        )
        end

        sig { override.returns({ type: Symbol, event_id: String }) }
        def to_hash
        end
      end
    end
  end
end
