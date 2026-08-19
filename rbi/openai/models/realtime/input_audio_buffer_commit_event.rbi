# typed: strong

module OpenAI
  module Models

    module Realtime

      class InputAudioBufferCommitEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Realtime::InputAudioBufferCommitEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The event type, must be `input_audio_buffer.commit`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # Send this event to commit the user input audio buffer, which will create a new
        # user message item in the conversation. This event will produce an error if the
        # input audio buffer is empty. When in Server VAD mode, the client does not need
        # to send this event, the server will commit the audio buffer automatically.
        #
        # Committing the input audio buffer will trigger input audio transcription (if
        # enabled in session configuration), but it will not create a response from the
        # model. The server will respond with an `input_audio_buffer.committed` event.
        sig do
          params(

            event_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Optional client-generated ID used to identify this event.
          event_id: nil,

          # The event type, must be `input_audio_buffer.commit`.

          type: :"input_audio_buffer.commit"
        )
        end

        sig do
          override.returns(
            {type: Symbol, event_id: String}
          )
        end
        def to_hash
        end

      end

    end

  end
end
