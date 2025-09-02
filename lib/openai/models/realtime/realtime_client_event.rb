# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # A realtime client event.
      module RealtimeClientEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Add a new Item to the Conversation's context, including messages, function
        # calls, and function call responses. This event can be used both to populate a
        # "history" of the conversation and to add new items mid-stream, but has the
        # current limitation that it cannot populate assistant audio messages.
        #
        # If successful, the server will respond with a `conversation.item.created`
        # event, otherwise an `error` event will be sent.
        variant :"conversation.item.create", -> { OpenAI::Realtime::ConversationItemCreateEvent }

        # Send this event when you want to remove any item from the conversation
        # history. The server will respond with a `conversation.item.deleted` event,
        # unless the item does not exist in the conversation history, in which case the
        # server will respond with an error.
        variant :"conversation.item.delete", -> { OpenAI::Realtime::ConversationItemDeleteEvent }

        # Send this event when you want to retrieve the server's representation of a specific item in the conversation history. This is useful, for example, to inspect user audio after noise cancellation and VAD.
        # The server will respond with a `conversation.item.retrieved` event,
        # unless the item does not exist in the conversation history, in which case the
        # server will respond with an error.
        variant :"conversation.item.retrieve", -> { OpenAI::Realtime::ConversationItemRetrieveEvent }

        # Send this event to truncate a previous assistant message’s audio. The server
        # will produce audio faster than realtime, so this event is useful when the user
        # interrupts to truncate audio that has already been sent to the client but not
        # yet played. This will synchronize the server's understanding of the audio with
        # the client's playback.
        #
        # Truncating audio will delete the server-side text transcript to ensure there
        # is not text in the context that hasn't been heard by the user.
        #
        # If successful, the server will respond with a `conversation.item.truncated`
        # event.
        variant :"conversation.item.truncate", -> { OpenAI::Realtime::ConversationItemTruncateEvent }

        # Send this event to append audio bytes to the input audio buffer. The audio
        # buffer is temporary storage you can write to and later commit. In Server VAD
        # mode, the audio buffer is used to detect speech and the server will decide
        # when to commit. When Server VAD is disabled, you must commit the audio buffer
        # manually.
        #
        # The client may choose how much audio to place in each event up to a maximum
        # of 15 MiB, for example streaming smaller chunks from the client may allow the
        # VAD to be more responsive. Unlike made other client events, the server will
        # not send a confirmation response to this event.
        variant :"input_audio_buffer.append", -> { OpenAI::Realtime::InputAudioBufferAppendEvent }

        # Send this event to clear the audio bytes in the buffer. The server will
        # respond with an `input_audio_buffer.cleared` event.
        variant :"input_audio_buffer.clear", -> { OpenAI::Realtime::InputAudioBufferClearEvent }

        # **WebRTC Only:** Emit to cut off the current audio response. This will trigger the server to
        # stop generating audio and emit a `output_audio_buffer.cleared` event. This
        # event should be preceded by a `response.cancel` client event to stop the
        # generation of the current response.
        # [Learn more](https://platform.openai.com/docs/guides/realtime-conversations#client-and-server-events-for-audio-in-webrtc).
        variant :"output_audio_buffer.clear", -> { OpenAI::Realtime::OutputAudioBufferClearEvent }

        # Send this event to commit the user input audio buffer, which will create a
        # new user message item in the conversation. This event will produce an error
        # if the input audio buffer is empty. When in Server VAD mode, the client does
        # not need to send this event, the server will commit the audio buffer
        # automatically.
        #
        # Committing the input audio buffer will trigger input audio transcription
        # (if enabled in session configuration), but it will not create a response
        # from the model. The server will respond with an `input_audio_buffer.committed`
        # event.
        variant :"input_audio_buffer.commit", -> { OpenAI::Realtime::InputAudioBufferCommitEvent }

        # Send this event to cancel an in-progress response. The server will respond
        # with a `response.done` event with a status of `response.status=cancelled`. If
        # there is no response to cancel, the server will respond with an error.
        variant :"response.cancel", -> { OpenAI::Realtime::ResponseCancelEvent }

        # This event instructs the server to create a Response, which means triggering
        # model inference. When in Server VAD mode, the server will create Responses
        # automatically.
        #
        # A Response will include at least one Item, and may have two, in which case
        # the second will be a function call. These Items will be appended to the
        # conversation history.
        #
        # The server will respond with a `response.created` event, events for Items
        # and content created, and finally a `response.done` event to indicate the
        # Response is complete.
        #
        # The `response.create` event includes inference configuration like
        # `instructions`, and `temperature`. These fields will override the Session's
        # configuration for this Response only.
        variant :"response.create", -> { OpenAI::Realtime::ResponseCreateEvent }

        # Send this event to update the session’s default configuration.
        # The client may send this event at any time to update any field,
        # except for `voice`. However, note that once a session has been
        # initialized with a particular `model`, it can’t be changed to
        # another model using `session.update`.
        #
        # When the server receives a `session.update`, it will respond
        # with a `session.updated` event showing the full, effective configuration.
        # Only the fields that are present are updated. To clear a field like
        # `instructions`, pass an empty string.
        variant :"session.update", -> { OpenAI::Realtime::SessionUpdateEvent }

        # Send this event to update a transcription session.
        variant :"transcription_session.update", -> { OpenAI::Realtime::TranscriptionSessionUpdate }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Realtime::ConversationItemCreateEvent, OpenAI::Models::Realtime::ConversationItemDeleteEvent, OpenAI::Models::Realtime::ConversationItemRetrieveEvent, OpenAI::Models::Realtime::ConversationItemTruncateEvent, OpenAI::Models::Realtime::InputAudioBufferAppendEvent, OpenAI::Models::Realtime::InputAudioBufferClearEvent, OpenAI::Models::Realtime::OutputAudioBufferClearEvent, OpenAI::Models::Realtime::InputAudioBufferCommitEvent, OpenAI::Models::Realtime::ResponseCancelEvent, OpenAI::Models::Realtime::ResponseCreateEvent, OpenAI::Models::Realtime::SessionUpdateEvent, OpenAI::Models::Realtime::TranscriptionSessionUpdate)]
      end
    end
  end
end
