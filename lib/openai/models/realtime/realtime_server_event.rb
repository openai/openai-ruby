# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # A realtime server event.
      module RealtimeServerEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Returned when a conversation is created. Emitted right after session creation.
        variant :"conversation.created", -> { OpenAI::Realtime::ConversationCreatedEvent }

        # Returned when a conversation item is created. There are several scenarios that produce this event:
        #   - The server is generating a Response, which if successful will produce
        #     either one or two Items, which will be of type `message`
        #     (role `assistant`) or type `function_call`.
        #   - The input audio buffer has been committed, either by the client or the
        #     server (in `server_vad` mode). The server will take the content of the
        #     input audio buffer and add it to a new user message Item.
        #   - The client has sent a `conversation.item.create` event to add a new Item
        #     to the Conversation.
        variant :"conversation.item.created", -> { OpenAI::Realtime::ConversationItemCreatedEvent }

        # Returned when an item in the conversation is deleted by the client with a
        # `conversation.item.delete` event. This event is used to synchronize the
        # server's understanding of the conversation history with the client's view.
        variant :"conversation.item.deleted", -> { OpenAI::Realtime::ConversationItemDeletedEvent }

        # This event is the output of audio transcription for user audio written to the
        # user audio buffer. Transcription begins when the input audio buffer is
        # committed by the client or server (when VAD is enabled). Transcription runs
        # asynchronously with Response creation, so this event may come before or after
        # the Response events.
        #
        # Realtime API models accept audio natively, and thus input transcription is a
        # separate process run on a separate ASR (Automatic Speech Recognition) model.
        # The transcript may diverge somewhat from the model's interpretation, and
        # should be treated as a rough guide.
        variant :"conversation.item.input_audio_transcription.completed",
                -> { OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent }

        # Returned when the text value of an input audio transcription content part is updated with incremental transcription results.
        variant :"conversation.item.input_audio_transcription.delta",
                -> { OpenAI::Realtime::ConversationItemInputAudioTranscriptionDeltaEvent }

        # Returned when input audio transcription is configured, and a transcription
        # request for a user message failed. These events are separate from other
        # `error` events so that the client can identify the related Item.
        variant :"conversation.item.input_audio_transcription.failed",
                -> { OpenAI::Realtime::ConversationItemInputAudioTranscriptionFailedEvent }

        # Returned when a conversation item is retrieved with `conversation.item.retrieve`. This is provided as a way to fetch the server's representation of an item, for example to get access to the post-processed audio data after noise cancellation and VAD. It includes the full content of the Item, including audio data.
        variant :"conversation.item.retrieved",
                -> { OpenAI::Realtime::RealtimeServerEvent::ConversationItemRetrieved }

        # Returned when an earlier assistant audio message item is truncated by the
        # client with a `conversation.item.truncate` event. This event is used to
        # synchronize the server's understanding of the audio with the client's playback.
        #
        # This action will truncate the audio and remove the server-side text transcript
        # to ensure there is no text in the context that hasn't been heard by the user.
        variant :"conversation.item.truncated", -> { OpenAI::Realtime::ConversationItemTruncatedEvent }

        # Returned when an error occurs, which could be a client problem or a server
        # problem. Most errors are recoverable and the session will stay open, we
        # recommend to implementors to monitor and log error messages by default.
        variant :error, -> { OpenAI::Realtime::RealtimeErrorEvent }

        # Returned when the input audio buffer is cleared by the client with a
        # `input_audio_buffer.clear` event.
        variant :"input_audio_buffer.cleared", -> { OpenAI::Realtime::InputAudioBufferClearedEvent }

        # Returned when an input audio buffer is committed, either by the client or
        # automatically in server VAD mode. The `item_id` property is the ID of the user
        # message item that will be created, thus a `conversation.item.created` event
        # will also be sent to the client.
        variant :"input_audio_buffer.committed", -> { OpenAI::Realtime::InputAudioBufferCommittedEvent }

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
        variant :"input_audio_buffer.speech_started", -> { OpenAI::Realtime::InputAudioBufferSpeechStartedEvent }

        # Returned in `server_vad` mode when the server detects the end of speech in
        # the audio buffer. The server will also send an `conversation.item.created`
        # event with the user message item that is created from the audio buffer.
        variant :"input_audio_buffer.speech_stopped", -> { OpenAI::Realtime::InputAudioBufferSpeechStoppedEvent }

        # Emitted at the beginning of a Response to indicate the updated rate limits.
        # When a Response is created some tokens will be "reserved" for the output
        # tokens, the rate limits shown here reflect that reservation, which is then
        # adjusted accordingly once the Response is completed.
        variant :"rate_limits.updated", -> { OpenAI::Realtime::RateLimitsUpdatedEvent }

        # Returned when the model-generated audio is updated.
        variant :"response.output_audio.delta", -> { OpenAI::Realtime::ResponseAudioDeltaEvent }

        # Returned when the model-generated audio is done. Also emitted when a Response
        # is interrupted, incomplete, or cancelled.
        variant :"response.output_audio.done", -> { OpenAI::Realtime::ResponseAudioDoneEvent }

        # Returned when the model-generated transcription of audio output is updated.
        variant :"response.output_audio_transcript.delta",
                -> { OpenAI::Realtime::ResponseAudioTranscriptDeltaEvent }

        # Returned when the model-generated transcription of audio output is done
        # streaming. Also emitted when a Response is interrupted, incomplete, or
        # cancelled.
        variant :"response.output_audio_transcript.done",
                -> { OpenAI::Realtime::ResponseAudioTranscriptDoneEvent }

        # Returned when a new content part is added to an assistant message item during
        # response generation.
        variant :"response.content_part.added", -> { OpenAI::Realtime::ResponseContentPartAddedEvent }

        # Returned when a content part is done streaming in an assistant message item.
        # Also emitted when a Response is interrupted, incomplete, or cancelled.
        variant :"response.content_part.done", -> { OpenAI::Realtime::ResponseContentPartDoneEvent }

        # Returned when a new Response is created. The first event of response creation,
        # where the response is in an initial state of `in_progress`.
        variant :"response.created", -> { OpenAI::Realtime::ResponseCreatedEvent }

        # Returned when a Response is done streaming. Always emitted, no matter the
        # final state. The Response object included in the `response.done` event will
        # include all output Items in the Response but will omit the raw audio data.
        #
        # Clients should check the `status` field of the Response to determine if it was successful
        # (`completed`) or if there was another outcome: `cancelled`, `failed`, or `incomplete`.
        #
        # A response will contain all output items that were generated during the response, excluding
        # any audio content.
        variant :"response.done", -> { OpenAI::Realtime::ResponseDoneEvent }

        # Returned when the model-generated function call arguments are updated.
        variant :"response.function_call_arguments.delta",
                -> { OpenAI::Realtime::ResponseFunctionCallArgumentsDeltaEvent }

        # Returned when the model-generated function call arguments are done streaming.
        # Also emitted when a Response is interrupted, incomplete, or cancelled.
        variant :"response.function_call_arguments.done",
                -> { OpenAI::Realtime::ResponseFunctionCallArgumentsDoneEvent }

        # Returned when a new Item is created during Response generation.
        variant :"response.output_item.added", -> { OpenAI::Realtime::ResponseOutputItemAddedEvent }

        # Returned when an Item is done streaming. Also emitted when a Response is
        # interrupted, incomplete, or cancelled.
        variant :"response.output_item.done", -> { OpenAI::Realtime::ResponseOutputItemDoneEvent }

        # Returned when the text value of an "output_text" content part is updated.
        variant :"response.output_text.delta", -> { OpenAI::Realtime::ResponseTextDeltaEvent }

        # Returned when the text value of an "output_text" content part is done streaming. Also
        # emitted when a Response is interrupted, incomplete, or cancelled.
        variant :"response.output_text.done", -> { OpenAI::Realtime::ResponseTextDoneEvent }

        # Returned when a Session is created. Emitted automatically when a new
        # connection is established as the first server event. This event will contain
        # the default Session configuration.
        variant :"session.created", -> { OpenAI::Realtime::SessionCreatedEvent }

        # Returned when a session is updated with a `session.update` event, unless
        # there is an error.
        variant :"session.updated", -> { OpenAI::Realtime::SessionUpdatedEvent }

        # **WebRTC Only:** Emitted when the server begins streaming audio to the client. This event is
        # emitted after an audio content part has been added (`response.content_part.added`)
        # to the response.
        # [Learn more](https://platform.openai.com/docs/guides/realtime-conversations#client-and-server-events-for-audio-in-webrtc).
        variant :"output_audio_buffer.started",
                -> { OpenAI::Realtime::RealtimeServerEvent::OutputAudioBufferStarted }

        # **WebRTC Only:** Emitted when the output audio buffer has been completely drained on the server,
        # and no more audio is forthcoming. This event is emitted after the full response
        # data has been sent to the client (`response.done`).
        # [Learn more](https://platform.openai.com/docs/guides/realtime-conversations#client-and-server-events-for-audio-in-webrtc).
        variant :"output_audio_buffer.stopped",
                -> { OpenAI::Realtime::RealtimeServerEvent::OutputAudioBufferStopped }

        # **WebRTC Only:** Emitted when the output audio buffer is cleared. This happens either in VAD
        # mode when the user has interrupted (`input_audio_buffer.speech_started`),
        # or when the client has emitted the `output_audio_buffer.clear` event to manually
        # cut off the current audio response.
        # [Learn more](https://platform.openai.com/docs/guides/realtime-conversations#client-and-server-events-for-audio-in-webrtc).
        variant :"output_audio_buffer.cleared",
                -> { OpenAI::Realtime::RealtimeServerEvent::OutputAudioBufferCleared }

        # Sent by the server when an Item is added to the default Conversation. This can happen in several cases:
        # - When the client sends a `conversation.item.create` event.
        # - When the input audio buffer is committed. In this case the item will be a user message containing the audio from the buffer.
        # - When the model is generating a Response. In this case the `conversation.item.added` event will be sent when the model starts generating a specific Item, and thus it will not yet have any content (and `status` will be `in_progress`).
        #
        # The event will include the full content of the Item (except when model is generating a Response) except for audio data, which can be retrieved separately with a `conversation.item.retrieve` event if necessary.
        variant :"conversation.item.added", -> { OpenAI::Realtime::ConversationItemAdded }

        # Returned when a conversation item is finalized.
        #
        # The event will include the full content of the Item except for audio data, which can be retrieved separately with a `conversation.item.retrieve` event if needed.
        variant :"conversation.item.done", -> { OpenAI::Realtime::ConversationItemDone }

        # Returned when the server VAD timeout is triggered for the input audio buffer.
        variant :"input_audio_buffer.timeout_triggered", -> { OpenAI::Realtime::InputAudioBufferTimeoutTriggered }

        # Returned when an input audio transcription segment is identified for an item.
        variant :"conversation.item.input_audio_transcription.segment",
                -> { OpenAI::Realtime::ConversationItemInputAudioTranscriptionSegment }

        # Returned when listing MCP tools is in progress for an item.
        variant :"mcp_list_tools.in_progress", -> { OpenAI::Realtime::McpListToolsInProgress }

        # Returned when listing MCP tools has completed for an item.
        variant :"mcp_list_tools.completed", -> { OpenAI::Realtime::McpListToolsCompleted }

        # Returned when listing MCP tools has failed for an item.
        variant :"mcp_list_tools.failed", -> { OpenAI::Realtime::McpListToolsFailed }

        # Returned when MCP tool call arguments are updated during response generation.
        variant :"response.mcp_call_arguments.delta", -> { OpenAI::Realtime::ResponseMcpCallArgumentsDelta }

        # Returned when MCP tool call arguments are finalized during response generation.
        variant :"response.mcp_call_arguments.done", -> { OpenAI::Realtime::ResponseMcpCallArgumentsDone }

        # Returned when an MCP tool call has started and is in progress.
        variant :"response.mcp_call.in_progress", -> { OpenAI::Realtime::ResponseMcpCallInProgress }

        # Returned when an MCP tool call has completed successfully.
        variant :"response.mcp_call.completed", -> { OpenAI::Realtime::ResponseMcpCallCompleted }

        # Returned when an MCP tool call has failed.
        variant :"response.mcp_call.failed", -> { OpenAI::Realtime::ResponseMcpCallFailed }

        class ConversationItemRetrieved < OpenAI::Internal::Type::BaseModel
          # @!attribute event_id
          #   The unique ID of the server event.
          #
          #   @return [String]
          required :event_id, String

          # @!attribute item
          #   A single item within a Realtime conversation.
          #
          #   @return [OpenAI::Models::Realtime::RealtimeConversationItemSystemMessage, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput, OpenAI::Models::Realtime::RealtimeMcpApprovalResponse, OpenAI::Models::Realtime::RealtimeMcpListTools, OpenAI::Models::Realtime::RealtimeMcpToolCall, OpenAI::Models::Realtime::RealtimeMcpApprovalRequest]
          required :item, union: -> { OpenAI::Realtime::ConversationItem }

          # @!attribute type
          #   The event type, must be `conversation.item.retrieved`.
          #
          #   @return [Symbol, :"conversation.item.retrieved"]
          required :type, const: :"conversation.item.retrieved"

          # @!method initialize(event_id:, item:, type: :"conversation.item.retrieved")
          #   Returned when a conversation item is retrieved with
          #   `conversation.item.retrieve`. This is provided as a way to fetch the server's
          #   representation of an item, for example to get access to the post-processed audio
          #   data after noise cancellation and VAD. It includes the full content of the Item,
          #   including audio data.
          #
          #   @param event_id [String] The unique ID of the server event.
          #
          #   @param item [OpenAI::Models::Realtime::RealtimeConversationItemSystemMessage, OpenAI::Models::Realtime::RealtimeConversationItemUserMessage, OpenAI::Models::Realtime::RealtimeConversationItemAssistantMessage, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCall, OpenAI::Models::Realtime::RealtimeConversationItemFunctionCallOutput, OpenAI::Models::Realtime::RealtimeMcpApprovalResponse, OpenAI::Models::Realtime::RealtimeMcpListTools, OpenAI::Models::Realtime::RealtimeMcpToolCall, OpenAI::Models::Realtime::RealtimeMcpApprovalRequest] A single item within a Realtime conversation.
          #
          #   @param type [Symbol, :"conversation.item.retrieved"] The event type, must be `conversation.item.retrieved`.
        end

        class OutputAudioBufferStarted < OpenAI::Internal::Type::BaseModel
          # @!attribute event_id
          #   The unique ID of the server event.
          #
          #   @return [String]
          required :event_id, String

          # @!attribute response_id
          #   The unique ID of the response that produced the audio.
          #
          #   @return [String]
          required :response_id, String

          # @!attribute type
          #   The event type, must be `output_audio_buffer.started`.
          #
          #   @return [Symbol, :"output_audio_buffer.started"]
          required :type, const: :"output_audio_buffer.started"

          # @!method initialize(event_id:, response_id:, type: :"output_audio_buffer.started")
          #   **WebRTC Only:** Emitted when the server begins streaming audio to the client.
          #   This event is emitted after an audio content part has been added
          #   (`response.content_part.added`) to the response.
          #   [Learn more](https://platform.openai.com/docs/guides/realtime-conversations#client-and-server-events-for-audio-in-webrtc).
          #
          #   @param event_id [String] The unique ID of the server event.
          #
          #   @param response_id [String] The unique ID of the response that produced the audio.
          #
          #   @param type [Symbol, :"output_audio_buffer.started"] The event type, must be `output_audio_buffer.started`.
        end

        class OutputAudioBufferStopped < OpenAI::Internal::Type::BaseModel
          # @!attribute event_id
          #   The unique ID of the server event.
          #
          #   @return [String]
          required :event_id, String

          # @!attribute response_id
          #   The unique ID of the response that produced the audio.
          #
          #   @return [String]
          required :response_id, String

          # @!attribute type
          #   The event type, must be `output_audio_buffer.stopped`.
          #
          #   @return [Symbol, :"output_audio_buffer.stopped"]
          required :type, const: :"output_audio_buffer.stopped"

          # @!method initialize(event_id:, response_id:, type: :"output_audio_buffer.stopped")
          #   **WebRTC Only:** Emitted when the output audio buffer has been completely
          #   drained on the server, and no more audio is forthcoming. This event is emitted
          #   after the full response data has been sent to the client (`response.done`).
          #   [Learn more](https://platform.openai.com/docs/guides/realtime-conversations#client-and-server-events-for-audio-in-webrtc).
          #
          #   @param event_id [String] The unique ID of the server event.
          #
          #   @param response_id [String] The unique ID of the response that produced the audio.
          #
          #   @param type [Symbol, :"output_audio_buffer.stopped"] The event type, must be `output_audio_buffer.stopped`.
        end

        class OutputAudioBufferCleared < OpenAI::Internal::Type::BaseModel
          # @!attribute event_id
          #   The unique ID of the server event.
          #
          #   @return [String]
          required :event_id, String

          # @!attribute response_id
          #   The unique ID of the response that produced the audio.
          #
          #   @return [String]
          required :response_id, String

          # @!attribute type
          #   The event type, must be `output_audio_buffer.cleared`.
          #
          #   @return [Symbol, :"output_audio_buffer.cleared"]
          required :type, const: :"output_audio_buffer.cleared"

          # @!method initialize(event_id:, response_id:, type: :"output_audio_buffer.cleared")
          #   **WebRTC Only:** Emitted when the output audio buffer is cleared. This happens
          #   either in VAD mode when the user has interrupted
          #   (`input_audio_buffer.speech_started`), or when the client has emitted the
          #   `output_audio_buffer.clear` event to manually cut off the current audio
          #   response.
          #   [Learn more](https://platform.openai.com/docs/guides/realtime-conversations#client-and-server-events-for-audio-in-webrtc).
          #
          #   @param event_id [String] The unique ID of the server event.
          #
          #   @param response_id [String] The unique ID of the response that produced the audio.
          #
          #   @param type [Symbol, :"output_audio_buffer.cleared"] The event type, must be `output_audio_buffer.cleared`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Realtime::ConversationCreatedEvent, OpenAI::Models::Realtime::ConversationItemCreatedEvent, OpenAI::Models::Realtime::ConversationItemDeletedEvent, OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent, OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionDeltaEvent, OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionFailedEvent, OpenAI::Models::Realtime::RealtimeServerEvent::ConversationItemRetrieved, OpenAI::Models::Realtime::ConversationItemTruncatedEvent, OpenAI::Models::Realtime::RealtimeErrorEvent, OpenAI::Models::Realtime::InputAudioBufferClearedEvent, OpenAI::Models::Realtime::InputAudioBufferCommittedEvent, OpenAI::Models::Realtime::InputAudioBufferSpeechStartedEvent, OpenAI::Models::Realtime::InputAudioBufferSpeechStoppedEvent, OpenAI::Models::Realtime::RateLimitsUpdatedEvent, OpenAI::Models::Realtime::ResponseAudioDeltaEvent, OpenAI::Models::Realtime::ResponseAudioDoneEvent, OpenAI::Models::Realtime::ResponseAudioTranscriptDeltaEvent, OpenAI::Models::Realtime::ResponseAudioTranscriptDoneEvent, OpenAI::Models::Realtime::ResponseContentPartAddedEvent, OpenAI::Models::Realtime::ResponseContentPartDoneEvent, OpenAI::Models::Realtime::ResponseCreatedEvent, OpenAI::Models::Realtime::ResponseDoneEvent, OpenAI::Models::Realtime::ResponseFunctionCallArgumentsDeltaEvent, OpenAI::Models::Realtime::ResponseFunctionCallArgumentsDoneEvent, OpenAI::Models::Realtime::ResponseOutputItemAddedEvent, OpenAI::Models::Realtime::ResponseOutputItemDoneEvent, OpenAI::Models::Realtime::ResponseTextDeltaEvent, OpenAI::Models::Realtime::ResponseTextDoneEvent, OpenAI::Models::Realtime::SessionCreatedEvent, OpenAI::Models::Realtime::SessionUpdatedEvent, OpenAI::Models::Realtime::RealtimeServerEvent::OutputAudioBufferStarted, OpenAI::Models::Realtime::RealtimeServerEvent::OutputAudioBufferStopped, OpenAI::Models::Realtime::RealtimeServerEvent::OutputAudioBufferCleared, OpenAI::Models::Realtime::ConversationItemAdded, OpenAI::Models::Realtime::ConversationItemDone, OpenAI::Models::Realtime::InputAudioBufferTimeoutTriggered, OpenAI::Models::Realtime::ConversationItemInputAudioTranscriptionSegment, OpenAI::Models::Realtime::McpListToolsInProgress, OpenAI::Models::Realtime::McpListToolsCompleted, OpenAI::Models::Realtime::McpListToolsFailed, OpenAI::Models::Realtime::ResponseMcpCallArgumentsDelta, OpenAI::Models::Realtime::ResponseMcpCallArgumentsDone, OpenAI::Models::Realtime::ResponseMcpCallInProgress, OpenAI::Models::Realtime::ResponseMcpCallCompleted, OpenAI::Models::Realtime::ResponseMcpCallFailed)]
      end
    end
  end
end
