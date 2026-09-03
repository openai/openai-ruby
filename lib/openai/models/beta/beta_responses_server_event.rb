# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # Server events emitted by the Responses WebSocket server.
      module BetaResponsesServerEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Emitted when an error occurs while processing a Responses WebSocket request.
        variant :error, -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError }

        # Emitted when steering input has been validated and queued. Acceptance means
        # the server owns the input, not that it has been applied. The successor's
        # `response.created` event is the commit point. If accepted input cannot be
        # committed, `response.steer.failed` returns it with the same steering ID.
        #
        # When the response stops for client-owned tool output or approval, the input
        # remains queued and `response.steer.pending` is emitted after
        # `response.completed`. Fill the pending event's `required_input` stubs with
        # saved results and send one matching explicit `response.create` per parent.
        # Do not resend accepted input while it is still queued.
        variant :"response.steer.accepted", -> { OpenAI::Beta::BetaResponseSteerAcceptedEvent }

        # Emitted when accepted steering input remains queued after the target
        # response completes. The server still owns the input. Do not resend it.
        # The successor's `response.created` event is the commit point.
        #
        # When `reason` is `waiting_for_required_input`, this event follows
        # `response.completed` while the response waits for the tool results or
        # approval decisions identified by `required_input`. Copy those stubs, fill
        # their result fields using the ordinary `response.create` input schemas,
        # and submit one continuation per parent with the same `previous_response_id`
        # and WebSocket lane. Use saved results without rerunning tools. The queued
        # steering input is prepended in submission order to the continuation's
        # input. That explicit request retains its own settings.
        #
        # This notification is emitted at most once per steering submission. Multiple
        # submissions for the same parent can report the same required inputs; they
        # do not each require a separate continuation.
        variant :"response.steer.pending", -> { OpenAI::Beta::BetaResponseSteerPendingEvent }

        # Emitted when steering input is rejected or cannot be committed to a
        # successor response. Returns the original, uncommitted input so the client
        # can carry it into `response.create` when appropriate. Invalid input must
        # be corrected before retrying.
        #
        # Failures after acceptance include the same steering ID. Failures before an
        # ID is allocated omit `steer.id`. A lost connection or missing acknowledgement
        # leaves the outcome unknown; it is not proof that the input was rejected.
        variant :"response.steer.failed", -> { OpenAI::Beta::BetaResponseSteerFailedEvent }

        # Emitted when all injected input items were validated and committed to the
        # active response.
        variant :"response.inject.created", -> { OpenAI::Beta::BetaResponseInjectCreatedEvent }

        # Emitted when injected input could not be committed to a response. The event
        # returns the uncommitted raw input so the client can retry it in another
        # response when appropriate.
        variant :"response.inject.failed", -> { OpenAI::Beta::BetaResponseInjectFailedEvent }

        # Emitted when there is a partial audio response.
        variant :"response.audio.delta", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseAudioWsDelta }

        # Emitted when the audio response is complete.
        variant :"response.audio.done", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseAudioWsDone }

        # Emitted when there is a partial transcript of audio.
        variant(
          :"response.audio.transcript.delta",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDelta }
        )

        # Emitted when the full audio transcript is completed.
        variant(
          :"response.audio.transcript.done",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDone }
        )

        # Emitted when a partial code snippet is streamed by the code interpreter.
        variant(
          :"response.code_interpreter_call_code.delta",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDelta }
        )

        # Emitted when the code snippet is finalized by the code interpreter.
        variant(
          :"response.code_interpreter_call_code.done",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDone }
        )

        # Emitted when the code interpreter call is completed.
        variant(
          :"response.code_interpreter_call.completed",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsCompleted }
        )

        # Emitted when a code interpreter call is in progress.
        variant(
          :"response.code_interpreter_call.in_progress",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallInWsProgress }
        )

        # Emitted when the code interpreter is actively interpreting the code snippet.
        variant(
          :"response.code_interpreter_call.interpreting",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsInterpreting }
        )

        # Emitted when the model response is complete.
        variant :"response.completed", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsCompleted }

        # Emitted when a new content part is added.
        variant(
          :"response.content_part.added",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsAdded }
        )

        # Emitted when a content part is done.
        variant(
          :"response.content_part.done",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsDone }
        )

        # An event that is emitted when a response is created.
        variant :"response.created", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsCreated }

        # Emitted when a file search call is completed (results found).
        variant(
          :"response.file_search_call.completed",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsCompleted }
        )

        # Emitted when a file search call is initiated.
        variant(
          :"response.file_search_call.in_progress",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallInWsProgress }
        )

        # Emitted when a file search is currently searching.
        variant(
          :"response.file_search_call.searching",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsSearching }
        )

        # Emitted when there is a partial function-call arguments delta.
        variant(
          :"response.function_call_arguments.delta",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDelta }
        )

        # Emitted when function-call arguments are finalized.
        variant(
          :"response.function_call_arguments.done",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDone }
        )

        # A streaming event that indicated a shell command was added to a tool call.
        variant(
          :"response.shell_call_command.added",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseShellCallCommandWsAdded }
        )

        # A streaming event that indicated a shell command was incrementally updated.
        variant(
          :"response.shell_call_command.delta",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseShellCallCommandWsDelta }
        )

        # A streaming event that indicated a shell command was completed.
        variant(
          :"response.shell_call_command.done",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseShellCallCommandWsDone }
        )

        # A streaming event that indicated shell call output was incrementally added.
        variant(
          :"response.shell_call_output_content.delta",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseShellCallOutputContentWsDelta }
        )

        # A streaming event that indicated shell call output was completed.
        variant(
          :"response.shell_call_output_content.done",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseShellCallOutputContentWsDone }
        )

        # Emitted when the response is in progress.
        variant :"response.in_progress", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseInWsProgress }

        # An event that is emitted when a response fails.
        variant :"response.failed", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsFailed }

        # An event that is emitted when a response finishes as incomplete.
        #
        # Over WebSocket, steering can finish a response with
        # `response.incomplete_details.reason` set to `steered`, followed automatically
        # by a successor `response.created` that commits the queued steering input.
        variant :"response.incomplete", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsIncomplete }

        # Emitted when a new output item is added.
        variant(
          :"response.output_item.added",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsAdded }
        )

        # Emitted when an output item is marked done.
        variant(
          :"response.output_item.done",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsDone }
        )

        # Emitted when a new reasoning summary part is added.
        variant(
          :"response.reasoning_summary_part.added",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsAdded }
        )

        # Emitted when a reasoning summary part is completed.
        variant(
          :"response.reasoning_summary_part.done",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsDone }
        )

        # Emitted when a delta is added to a reasoning summary text.
        variant(
          :"response.reasoning_summary_text.delta",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDelta }
        )

        # Emitted when a reasoning summary text is completed.
        variant(
          :"response.reasoning_summary_text.done",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDone }
        )

        # Emitted when a delta is added to a reasoning text.
        variant(
          :"response.reasoning_text.delta",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDelta }
        )

        # Emitted when a reasoning text is completed.
        variant(
          :"response.reasoning_text.done",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDone }
        )

        # Emitted when there is a partial refusal text.
        variant(
          :"response.refusal.delta",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDelta }
        )

        # Emitted when refusal text is finalized.
        variant :"response.refusal.done", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDone }

        # Emitted when there is an additional text delta.
        variant(
          :"response.output_text.delta",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseTextWsDelta }
        )

        # Emitted when text content is finalized.
        variant(
          :"response.output_text.done",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseTextWsDone }
        )

        # Emitted when a web search call is completed.
        variant(
          :"response.web_search_call.completed",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsCompleted }
        )

        # Emitted when a web search call is initiated.
        variant(
          :"response.web_search_call.in_progress",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallInWsProgress }
        )

        # Emitted when a web search call is executing.
        variant(
          :"response.web_search_call.searching",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsSearching }
        )

        # Emitted when an image generation tool call has completed and the final image is available.
        variant(
          :"response.image_generation_call.completed",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsCompleted }
        )

        # Emitted when an image generation tool call is actively generating an image (intermediate state).
        variant(
          :"response.image_generation_call.generating",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsGenerating }
        )

        # Emitted when an image generation tool call is in progress.
        variant(
          :"response.image_generation_call.in_progress",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallInWsProgress }
        )

        # Emitted when a partial image is available during image generation streaming.
        variant(
          :"response.image_generation_call.partial_image",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallPartialWsImage }
        )

        # Emitted when there is a delta (partial update) to the arguments of an MCP tool call.
        variant(
          :"response.mcp_call_arguments.delta",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDelta }
        )

        # Emitted when the arguments for an MCP tool call are finalized.
        variant(
          :"response.mcp_call_arguments.done",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDone }
        )

        # Emitted when an MCP  tool call has completed successfully.
        variant(
          :"response.mcp_call.completed",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsCompleted }
        )

        # Emitted when an MCP  tool call has failed.
        variant(
          :"response.mcp_call.failed",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsFailed }
        )

        # Emitted when an MCP  tool call is in progress.
        variant(
          :"response.mcp_call.in_progress",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallInWsProgress }
        )

        # Emitted when the list of available MCP tools has been successfully retrieved.
        variant(
          :"response.mcp_list_tools.completed",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsCompleted }
        )

        # Emitted when the attempt to list available MCP tools has failed.
        variant(
          :"response.mcp_list_tools.failed",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsFailed }
        )

        # Emitted when the system is in the process of retrieving the list of available MCP tools.
        variant(
          :"response.mcp_list_tools.in_progress",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsInWsProgress }
        )

        # Emitted when an annotation is added to output text content.
        variant(
          :"response.output_text.annotation.added",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseOutputTextAnnotationWsAdded }
        )

        # Emitted when a response is queued and waiting to be processed.
        variant :"response.queued", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsQueued }

        # Event representing a delta (partial update) to the input of a custom tool call.
        variant(
          :"response.custom_tool_call_input.delta",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDelta }
        )

        # Event indicating that input for a custom tool call is complete.
        variant(
          :"response.custom_tool_call_input.done",
          -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDone }
        )

        class BetaResponseAudioWsDelta < OpenAI::Models::Beta::BetaResponseAudioDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(delta:, sequence_number:, agent: nil, stream_id: nil, type: :"response.audio.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioWsDelta} for
          #   more details.
          #
          #   Emitted when there is a partial audio response.
          #
          #   @param delta [String] A chunk of Base64 encoded response audio bytes.
          #
          #   @param sequence_number [Integer] A sequence number for this chunk of the stream response.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseAudioDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.audio.delta"] The type of the event. Always `response.audio.delta`.
        end

        class BetaResponseAudioWsDone < OpenAI::Models::Beta::BetaResponseAudioDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(sequence_number:, agent: nil, stream_id: nil, type: :"response.audio.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioWsDone} for
          #   more details.
          #
          #   Emitted when the audio response is complete.
          #
          #   @param sequence_number [Integer] The sequence number of the delta.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseAudioDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.audio.done"] The type of the event. Always `response.audio.done`.
        end

        class BetaResponseAudioTranscriptWsDelta < OpenAI::Models::Beta::BetaResponseAudioTranscriptDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(delta:, sequence_number:, agent: nil, stream_id: nil, type: :"response.audio.transcript.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDelta}
          #   for more details.
          #
          #   Emitted when there is a partial transcript of audio.
          #
          #   @param delta [String] The partial transcript of the audio response.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseAudioTranscriptDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.audio.transcript.delta"] The type of the event. Always `response.audio.transcript.delta`.
        end

        class BetaResponseAudioTranscriptWsDone < OpenAI::Models::Beta::BetaResponseAudioTranscriptDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(sequence_number:, agent: nil, stream_id: nil, type: :"response.audio.transcript.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDone}
          #   for more details.
          #
          #   Emitted when the full audio transcript is completed.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseAudioTranscriptDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.audio.transcript.done"] The type of the event. Always `response.audio.transcript.done`.
        end

        class BetaResponseCodeInterpreterCallCodeWsDelta < OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(delta:, item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.code_interpreter_call_code.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDelta}
          #   for more details.
          #
          #   Emitted when a partial code snippet is streamed by the code interpreter.
          #
          #   @param delta [String] The partial code snippet being streamed by the code interpreter.
          #
          #   @param item_id [String] The unique identifier of the code interpreter tool call item.
          #
          #   @param output_index [Integer] The index of the output item in the response for which the code is being streame
          #
          #   @param sequence_number [Integer] The sequence number of this event, used to order streaming events.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.code_interpreter_call_code.delta"] The type of the event. Always `response.code_interpreter_call_code.delta`.
        end

        class BetaResponseCodeInterpreterCallCodeWsDone < OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(code:, item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.code_interpreter_call_code.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDone}
          #   for more details.
          #
          #   Emitted when the code snippet is finalized by the code interpreter.
          #
          #   @param code [String] The final code snippet output by the code interpreter.
          #
          #   @param item_id [String] The unique identifier of the code interpreter tool call item.
          #
          #   @param output_index [Integer] The index of the output item in the response for which the code is finalized.
          #
          #   @param sequence_number [Integer] The sequence number of this event, used to order streaming events.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.code_interpreter_call_code.done"] The type of the event. Always `response.code_interpreter_call_code.done`.
        end

        class BetaResponseCodeInterpreterCallWsCompleted < OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.code_interpreter_call.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsCompleted}
          #   for more details.
          #
          #   Emitted when the code interpreter call is completed.
          #
          #   @param item_id [String] The unique identifier of the code interpreter tool call item.
          #
          #   @param output_index [Integer] The index of the output item in the response for which the code interpreter call
          #
          #   @param sequence_number [Integer] The sequence number of this event, used to order streaming events.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCompletedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.code_interpreter_call.completed"] The type of the event. Always `response.code_interpreter_call.completed`.
        end

        class BetaResponseCodeInterpreterCallInWsProgress < OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.code_interpreter_call.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallInWsProgress}
          #   for more details.
          #
          #   Emitted when a code interpreter call is in progress.
          #
          #   @param item_id [String] The unique identifier of the code interpreter tool call item.
          #
          #   @param output_index [Integer] The index of the output item in the response for which the code interpreter call
          #
          #   @param sequence_number [Integer] The sequence number of this event, used to order streaming events.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInProgressEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.code_interpreter_call.in_progress"] The type of the event. Always `response.code_interpreter_call.in_progress`.
        end

        class BetaResponseCodeInterpreterCallWsInterpreting < OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInterpretingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.code_interpreter_call.interpreting")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsInterpreting}
          #   for more details.
          #
          #   Emitted when the code interpreter is actively interpreting the code snippet.
          #
          #   @param item_id [String] The unique identifier of the code interpreter tool call item.
          #
          #   @param output_index [Integer] The index of the output item in the response for which the code interpreter is i
          #
          #   @param sequence_number [Integer] The sequence number of this event, used to order streaming events.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInterpretingEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.code_interpreter_call.interpreting"] The type of the event. Always `response.code_interpreter_call.interpreting`.
        end

        class BetaResponseWsCompleted < OpenAI::Models::Beta::BetaResponseCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(response:, sequence_number:, agent: nil, stream_id: nil, type: :"response.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsCompleted} for
          #   more details.
          #
          #   Emitted when the model response is complete.
          #
          #   @param response [OpenAI::Models::Beta::BetaResponse] Properties of the completed response.
          #
          #   @param sequence_number [Integer] The sequence number for this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseCompletedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.completed"] The type of the event. Always `response.completed`.
        end

        class BetaResponseContentPartWsAdded < OpenAI::Models::Beta::BetaResponseContentPartAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, item_id:, output_index:, part:, sequence_number:, agent: nil, stream_id: nil, type: :"response.content_part.added")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsAdded}
          #   for more details.
          #
          #   Emitted when a new content part is added.
          #
          #   @param content_index [Integer] The index of the content part that was added.
          #
          #   @param item_id [String] The ID of the output item that the content part was added to.
          #
          #   @param output_index [Integer] The index of the output item that the content part was added to.
          #
          #   @param part [OpenAI::Models::Beta::BetaResponseOutputText, OpenAI::Models::Beta::BetaResponseOutputRefusal, OpenAI::Models::Beta::BetaResponseContentPartAddedEvent::Part::ReasoningText] The content part that was added.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseContentPartAddedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.content_part.added"] The type of the event. Always `response.content_part.added`.
        end

        class BetaResponseContentPartWsDone < OpenAI::Models::Beta::BetaResponseContentPartDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, item_id:, output_index:, part:, sequence_number:, agent: nil, stream_id: nil, type: :"response.content_part.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsDone}
          #   for more details.
          #
          #   Emitted when a content part is done.
          #
          #   @param content_index [Integer] The index of the content part that is done.
          #
          #   @param item_id [String] The ID of the output item that the content part was added to.
          #
          #   @param output_index [Integer] The index of the output item that the content part was added to.
          #
          #   @param part [OpenAI::Models::Beta::BetaResponseOutputText, OpenAI::Models::Beta::BetaResponseOutputRefusal, OpenAI::Models::Beta::BetaResponseContentPartDoneEvent::Part::ReasoningText] The content part that is done.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseContentPartDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.content_part.done"] The type of the event. Always `response.content_part.done`.
        end

        class BetaResponseWsCreated < OpenAI::Models::Beta::BetaResponseCreatedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(response:, sequence_number:, agent: nil, stream_id: nil, type: :"response.created")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsCreated} for more
          #   details.
          #
          #   An event that is emitted when a response is created.
          #
          #   @param response [OpenAI::Models::Beta::BetaResponse] The response that was created.
          #
          #   @param sequence_number [Integer] The sequence number for this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseCreatedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.created"] The type of the event. Always `response.created`.
        end

        class BetaResponseFileSearchCallWsCompleted < OpenAI::Models::Beta::BetaResponseFileSearchCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.file_search_call.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsCompleted}
          #   for more details.
          #
          #   Emitted when a file search call is completed (results found).
          #
          #   @param item_id [String] The ID of the output item that the file search call is initiated.
          #
          #   @param output_index [Integer] The index of the output item that the file search call is initiated.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseFileSearchCallCompletedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.file_search_call.completed"] The type of the event. Always `response.file_search_call.completed`.
        end

        class BetaResponseFileSearchCallInWsProgress < OpenAI::Models::Beta::BetaResponseFileSearchCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.file_search_call.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallInWsProgress}
          #   for more details.
          #
          #   Emitted when a file search call is initiated.
          #
          #   @param item_id [String] The ID of the output item that the file search call is initiated.
          #
          #   @param output_index [Integer] The index of the output item that the file search call is initiated.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseFileSearchCallInProgressEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.file_search_call.in_progress"] The type of the event. Always `response.file_search_call.in_progress`.
        end

        class BetaResponseFileSearchCallWsSearching < OpenAI::Models::Beta::BetaResponseFileSearchCallSearchingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.file_search_call.searching")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsSearching}
          #   for more details.
          #
          #   Emitted when a file search is currently searching.
          #
          #   @param item_id [String] The ID of the output item that the file search call is initiated.
          #
          #   @param output_index [Integer] The index of the output item that the file search call is searching.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseFileSearchCallSearchingEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.file_search_call.searching"] The type of the event. Always `response.file_search_call.searching`.
        end

        class BetaResponseFunctionCallArgumentsWsDelta < OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(delta:, item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.function_call_arguments.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDelta}
          #   for more details.
          #
          #   Emitted when there is a partial function-call arguments delta.
          #
          #   @param delta [String] The function-call arguments delta that is added.
          #
          #   @param item_id [String] The ID of the output item that the function-call arguments delta is added to.
          #
          #   @param output_index [Integer] The index of the output item that the function-call arguments delta is added to.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.function_call_arguments.delta"] The type of the event. Always `response.function_call_arguments.delta`.
        end

        class BetaResponseFunctionCallArgumentsWsDone < OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(arguments:, item_id:, name:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.function_call_arguments.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDone}
          #   for more details.
          #
          #   Emitted when function-call arguments are finalized.
          #
          #   @param arguments [String] The function-call arguments.
          #
          #   @param item_id [String] The ID of the item.
          #
          #   @param name [String] The name of the function that was called.
          #
          #   @param output_index [Integer] The index of the output item.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.function_call_arguments.done"]
        end

        class BetaResponseShellCallCommandWsAdded < OpenAI::Models::Beta::BetaResponseShellCallCommandAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(command:, command_index:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.shell_call_command.added")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseShellCallCommandWsAdded}
          #   for more details.
          #
          #   A streaming event that indicated a shell command was added to a tool call.
          #
          #   @param command [String] The shell command that was added.
          #
          #   @param command_index [Integer] The index of the shell command that was added.
          #
          #   @param output_index [Integer] The index of the output item that was updated.
          #
          #   @param sequence_number [Integer] The sequence number of the event that was emitted.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseShellCallCommandAddedEvent::Agent] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.shell_call_command.added"] The type of the event, always `response.shell_call_command.added`.
        end

        class BetaResponseShellCallCommandWsDelta < OpenAI::Models::Beta::BetaResponseShellCallCommandDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(command_index:, delta:, output_index:, sequence_number:, agent: nil, obfuscation: nil, stream_id: nil, type: :"response.shell_call_command.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseShellCallCommandWsDelta}
          #   for more details.
          #
          #   A streaming event that indicated a shell command was incrementally updated.
          #
          #   @param command_index [Integer] The index of the shell command that was updated.
          #
          #   @param delta [String] The shell command delta that was appended.
          #
          #   @param output_index [Integer] The index of the output item that was updated.
          #
          #   @param sequence_number [Integer] The sequence number of the event that was emitted.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseShellCallCommandDeltaEvent::Agent] The agent that owns this multi-agent streaming event.
          #
          #   @param obfuscation [String] An obfuscation string that was added to pad the event payload.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.shell_call_command.delta"] The type of the event, always `response.shell_call_command.delta`.
        end

        class BetaResponseShellCallCommandWsDone < OpenAI::Models::Beta::BetaResponseShellCallCommandDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(command:, command_index:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.shell_call_command.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseShellCallCommandWsDone}
          #   for more details.
          #
          #   A streaming event that indicated a shell command was completed.
          #
          #   @param command [String] The final shell command that was emitted.
          #
          #   @param command_index [Integer] The index of the shell command that was completed.
          #
          #   @param output_index [Integer] The index of the output item that was updated.
          #
          #   @param sequence_number [Integer] The sequence number of the event that was emitted.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseShellCallCommandDoneEvent::Agent] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.shell_call_command.done"] The type of the event, always `response.shell_call_command.done`.
        end

        class BetaResponseShellCallOutputContentWsDelta < OpenAI::Models::Beta::BetaResponseShellCallOutputContentDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(command_index:, delta:, item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.shell_call_output_content.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseShellCallOutputContentWsDelta}
          #   for more details.
          #
          #   A streaming event that indicated shell call output was incrementally added.
          #
          #   @param command_index [Integer] The index of the shell command that produced output.
          #
          #   @param delta [OpenAI::Models::Beta::BetaResponseShellCallOutputContentDeltaEvent::Delta] The stdout/stderr delta that was emitted.
          #
          #   @param item_id [String] The ID of the output item that was updated.
          #
          #   @param output_index [Integer] The index of the output item that was updated.
          #
          #   @param sequence_number [Integer] The sequence number of the event that was emitted.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseShellCallOutputContentDeltaEvent::Agent] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.shell_call_output_content.delta"] The type of the event, always `response.shell_call_output_content.delta`.
        end

        class BetaResponseShellCallOutputContentWsDone < OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(command_index:, item_id:, output:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.shell_call_output_content.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseShellCallOutputContentWsDone}
          #   for more details.
          #
          #   A streaming event that indicated shell call output was completed.
          #
          #   @param command_index [Integer] The index of the shell command that produced output.
          #
          #   @param item_id [String] The ID of the output item that was updated.
          #
          #   @param output [Array<OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent::Output>] The output contents emitted for the shell command.
          #
          #   @param output_index [Integer] The index of the output item that was updated.
          #
          #   @param sequence_number [Integer] The sequence number of the event that was emitted.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent::Agent] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.shell_call_output_content.done"] The type of the event, always `response.shell_call_output_content.done`.
        end

        class BetaResponseInWsProgress < OpenAI::Models::Beta::BetaResponseInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(response:, sequence_number:, agent: nil, stream_id: nil, type: :"response.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseInWsProgress} for
          #   more details.
          #
          #   Emitted when the response is in progress.
          #
          #   @param response [OpenAI::Models::Beta::BetaResponse] The response that is in progress.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseInProgressEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.in_progress"] The type of the event. Always `response.in_progress`.
        end

        class BetaResponseWsFailed < OpenAI::Models::Beta::BetaResponseFailedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(response:, sequence_number:, agent: nil, stream_id: nil, type: :"response.failed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsFailed} for more
          #   details.
          #
          #   An event that is emitted when a response fails.
          #
          #   @param response [OpenAI::Models::Beta::BetaResponse] The response that failed.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseFailedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.failed"] The type of the event. Always `response.failed`.
        end

        class BetaResponseWsIncomplete < OpenAI::Models::Beta::BetaResponseIncompleteEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(response:, sequence_number:, agent: nil, stream_id: nil, type: :"response.incomplete")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsIncomplete} for
          #   more details.
          #
          #   An event that is emitted when a response finishes as incomplete.
          #
          #   Over WebSocket, steering can finish a response with
          #   `response.incomplete_details.reason` set to `steered`, followed automatically by
          #   a successor `response.created` that commits the queued steering input.
          #
          #   @param response [OpenAI::Models::Beta::BetaResponse] The response that was incomplete.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseIncompleteEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.incomplete"] The type of the event. Always `response.incomplete`.
        end

        class BetaResponseOutputItemWsAdded < OpenAI::Models::Beta::BetaResponseOutputItemAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.output_item.added")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsAdded}
          #   for more details.
          #
          #   Emitted when a new output item is added.
          #
          #   @param item [OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCallOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseOutputItem::Program, OpenAI::Models::Beta::BetaResponseOutputItem::ProgramOutput, OpenAI::Models::Beta::BetaResponseToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseCompactionItem, OpenAI::Models::Beta::BetaResponseOutputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseFunctionShellToolCall, OpenAI::Models::Beta::BetaResponseFunctionShellToolCallOutput, OpenAI::Models::Beta::BetaResponseApplyPatchToolCall, OpenAI::Models::Beta::BetaResponseApplyPatchToolCallOutput, OpenAI::Models::Beta::BetaResponseOutputItem::McpCall, OpenAI::Models::Beta::BetaResponseOutputItem::McpListTools, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutputItem] The output item that was added. For reasoning items, `encrypted_content`
          #
          #   @param output_index [Integer] The index of the output item that was added.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseOutputItemAddedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.output_item.added"] The type of the event. Always `response.output_item.added`.
        end

        class BetaResponseOutputItemWsDone < OpenAI::Models::Beta::BetaResponseOutputItemDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.output_item.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsDone}
          #   for more details.
          #
          #   Emitted when an output item is marked done.
          #
          #   @param item [OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseFunctionToolCallOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseOutputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCallOutputItem, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseOutputItem::Program, OpenAI::Models::Beta::BetaResponseOutputItem::ProgramOutput, OpenAI::Models::Beta::BetaResponseToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItem, OpenAI::Models::Beta::BetaResponseOutputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseCompactionItem, OpenAI::Models::Beta::BetaResponseOutputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseOutputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseFunctionShellToolCall, OpenAI::Models::Beta::BetaResponseFunctionShellToolCallOutput, OpenAI::Models::Beta::BetaResponseApplyPatchToolCall, OpenAI::Models::Beta::BetaResponseApplyPatchToolCallOutput, OpenAI::Models::Beta::BetaResponseOutputItem::McpCall, OpenAI::Models::Beta::BetaResponseOutputItem::McpListTools, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseOutputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutputItem] The output item that was marked done.
          #
          #   @param output_index [Integer] The index of the output item that was marked done.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseOutputItemDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.output_item.done"] The type of the event. Always `response.output_item.done`.
        end

        class BetaResponseReasoningSummaryPartWsAdded < OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, part:, sequence_number:, summary_index:, agent: nil, stream_id: nil, type: :"response.reasoning_summary_part.added")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsAdded}
          #   for more details.
          #
          #   Emitted when a new reasoning summary part is added.
          #
          #   @param item_id [String] The ID of the item this summary part is associated with.
          #
          #   @param output_index [Integer] The index of the output item this summary part is associated with.
          #
          #   @param part [OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent::Part] The summary part that was added.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param summary_index [Integer] The index of the summary part within the reasoning summary.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.reasoning_summary_part.added"] The type of the event. Always `response.reasoning_summary_part.added`.
        end

        class BetaResponseReasoningSummaryPartWsDone < OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, part:, sequence_number:, summary_index:, agent: nil, status: nil, stream_id: nil, type: :"response.reasoning_summary_part.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsDone}
          #   for more details.
          #
          #   Emitted when a reasoning summary part is completed.
          #
          #   @param item_id [String] The ID of the item this summary part is associated with.
          #
          #   @param output_index [Integer] The index of the output item this summary part is associated with.
          #
          #   @param part [OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent::Part] The completed summary part.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param summary_index [Integer] The index of the summary part within the reasoning summary.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param status [Symbol, OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent::Status] The completion status of the summary part. Omitted when the part completed
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.reasoning_summary_part.done"] The type of the event. Always `response.reasoning_summary_part.done`.
        end

        class BetaResponseReasoningSummaryTextWsDelta < OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(delta:, item_id:, output_index:, sequence_number:, summary_index:, agent: nil, stream_id: nil, type: :"response.reasoning_summary_text.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDelta}
          #   for more details.
          #
          #   Emitted when a delta is added to a reasoning summary text.
          #
          #   @param delta [String] The text delta that was added to the summary.
          #
          #   @param item_id [String] The ID of the item this summary text delta is associated with.
          #
          #   @param output_index [Integer] The index of the output item this summary text delta is associated with.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param summary_index [Integer] The index of the summary part within the reasoning summary.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.reasoning_summary_text.delta"] The type of the event. Always `response.reasoning_summary_text.delta`.
        end

        class BetaResponseReasoningSummaryTextWsDone < OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, summary_index:, text:, agent: nil, stream_id: nil, type: :"response.reasoning_summary_text.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDone}
          #   for more details.
          #
          #   Emitted when a reasoning summary text is completed.
          #
          #   @param item_id [String] The ID of the item this summary text is associated with.
          #
          #   @param output_index [Integer] The index of the output item this summary text is associated with.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param summary_index [Integer] The index of the summary part within the reasoning summary.
          #
          #   @param text [String] The full text of the completed reasoning summary.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.reasoning_summary_text.done"] The type of the event. Always `response.reasoning_summary_text.done`.
        end

        class BetaResponseReasoningTextWsDelta < OpenAI::Models::Beta::BetaResponseReasoningTextDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, delta:, item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.reasoning_text.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDelta}
          #   for more details.
          #
          #   Emitted when a delta is added to a reasoning text.
          #
          #   @param content_index [Integer] The index of the reasoning content part this delta is associated with.
          #
          #   @param delta [String] The text delta that was added to the reasoning content.
          #
          #   @param item_id [String] The ID of the item this reasoning text delta is associated with.
          #
          #   @param output_index [Integer] The index of the output item this reasoning text delta is associated with.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseReasoningTextDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.reasoning_text.delta"] The type of the event. Always `response.reasoning_text.delta`.
        end

        class BetaResponseReasoningTextWsDone < OpenAI::Models::Beta::BetaResponseReasoningTextDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, item_id:, output_index:, sequence_number:, text:, agent: nil, stream_id: nil, type: :"response.reasoning_text.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDone}
          #   for more details.
          #
          #   Emitted when a reasoning text is completed.
          #
          #   @param content_index [Integer] The index of the reasoning content part.
          #
          #   @param item_id [String] The ID of the item this reasoning text is associated with.
          #
          #   @param output_index [Integer] The index of the output item this reasoning text is associated with.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param text [String] The full text of the completed reasoning content.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseReasoningTextDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.reasoning_text.done"] The type of the event. Always `response.reasoning_text.done`.
        end

        class BetaResponseRefusalWsDelta < OpenAI::Models::Beta::BetaResponseRefusalDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, delta:, item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.refusal.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDelta} for
          #   more details.
          #
          #   Emitted when there is a partial refusal text.
          #
          #   @param content_index [Integer] The index of the content part that the refusal text is added to.
          #
          #   @param delta [String] The refusal text that is added.
          #
          #   @param item_id [String] The ID of the output item that the refusal text is added to.
          #
          #   @param output_index [Integer] The index of the output item that the refusal text is added to.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseRefusalDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.refusal.delta"] The type of the event. Always `response.refusal.delta`.
        end

        class BetaResponseRefusalWsDone < OpenAI::Models::Beta::BetaResponseRefusalDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, item_id:, output_index:, refusal:, sequence_number:, agent: nil, stream_id: nil, type: :"response.refusal.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDone} for
          #   more details.
          #
          #   Emitted when refusal text is finalized.
          #
          #   @param content_index [Integer] The index of the content part that the refusal text is finalized.
          #
          #   @param item_id [String] The ID of the output item that the refusal text is finalized.
          #
          #   @param output_index [Integer] The index of the output item that the refusal text is finalized.
          #
          #   @param refusal [String] The refusal text that is finalized.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseRefusalDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.refusal.done"] The type of the event. Always `response.refusal.done`.
        end

        class BetaResponseTextWsDelta < OpenAI::Models::Beta::BetaResponseTextDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, delta:, item_id:, logprobs:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.output_text.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseTextWsDelta} for
          #   more details.
          #
          #   Emitted when there is an additional text delta.
          #
          #   @param content_index [Integer] The index of the content part that the text delta was added to.
          #
          #   @param delta [String] The text delta that was added.
          #
          #   @param item_id [String] The ID of the output item that the text delta was added to.
          #
          #   @param logprobs [Array<OpenAI::Models::Beta::BetaResponseTextDeltaEvent::Logprob>] The log probabilities of the tokens in the delta.
          #
          #   @param output_index [Integer] The index of the output item that the text delta was added to.
          #
          #   @param sequence_number [Integer] The sequence number for this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseTextDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.output_text.delta"] The type of the event. Always `response.output_text.delta`.
        end

        class BetaResponseTextWsDone < OpenAI::Models::Beta::BetaResponseTextDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, item_id:, logprobs:, output_index:, sequence_number:, text:, agent: nil, stream_id: nil, type: :"response.output_text.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseTextWsDone} for
          #   more details.
          #
          #   Emitted when text content is finalized.
          #
          #   @param content_index [Integer] The index of the content part that the text content is finalized.
          #
          #   @param item_id [String] The ID of the output item that the text content is finalized.
          #
          #   @param logprobs [Array<OpenAI::Models::Beta::BetaResponseTextDoneEvent::Logprob>] The log probabilities of the tokens in the delta.
          #
          #   @param output_index [Integer] The index of the output item that the text content is finalized.
          #
          #   @param sequence_number [Integer] The sequence number for this event.
          #
          #   @param text [String] The text content that is finalized.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseTextDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.output_text.done"] The type of the event. Always `response.output_text.done`.
        end

        class BetaResponseWebSearchCallWsCompleted < OpenAI::Models::Beta::BetaResponseWebSearchCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.web_search_call.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsCompleted}
          #   for more details.
          #
          #   Emitted when a web search call is completed.
          #
          #   @param item_id [String] Unique ID for the output item associated with the web search call.
          #
          #   @param output_index [Integer] The index of the output item that the web search call is associated with.
          #
          #   @param sequence_number [Integer] The sequence number of the web search call being processed.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseWebSearchCallCompletedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.web_search_call.completed"] The type of the event. Always `response.web_search_call.completed`.
        end

        class BetaResponseWebSearchCallInWsProgress < OpenAI::Models::Beta::BetaResponseWebSearchCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.web_search_call.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallInWsProgress}
          #   for more details.
          #
          #   Emitted when a web search call is initiated.
          #
          #   @param item_id [String] Unique ID for the output item associated with the web search call.
          #
          #   @param output_index [Integer] The index of the output item that the web search call is associated with.
          #
          #   @param sequence_number [Integer] The sequence number of the web search call being processed.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseWebSearchCallInProgressEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.web_search_call.in_progress"] The type of the event. Always `response.web_search_call.in_progress`.
        end

        class BetaResponseWebSearchCallWsSearching < OpenAI::Models::Beta::BetaResponseWebSearchCallSearchingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.web_search_call.searching")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsSearching}
          #   for more details.
          #
          #   Emitted when a web search call is executing.
          #
          #   @param item_id [String] Unique ID for the output item associated with the web search call.
          #
          #   @param output_index [Integer] The index of the output item that the web search call is associated with.
          #
          #   @param sequence_number [Integer] The sequence number of the web search call being processed.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseWebSearchCallSearchingEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.web_search_call.searching"] The type of the event. Always `response.web_search_call.searching`.
        end

        class BetaResponseImageGenCallWsCompleted < OpenAI::Models::Beta::BetaResponseImageGenCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.image_generation_call.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsCompleted}
          #   for more details.
          #
          #   Emitted when an image generation tool call has completed and the final image is
          #   available.
          #
          #   @param item_id [String] The unique identifier of the image generation item being processed.
          #
          #   @param output_index [Integer] The index of the output item in the response's output array.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseImageGenCallCompletedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.image_generation_call.completed"] The type of the event. Always 'response.image_generation_call.completed'.
        end

        class BetaResponseImageGenCallWsGenerating < OpenAI::Models::Beta::BetaResponseImageGenCallGeneratingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.image_generation_call.generating")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsGenerating}
          #   for more details.
          #
          #   Emitted when an image generation tool call is actively generating an image
          #   (intermediate state).
          #
          #   @param item_id [String] The unique identifier of the image generation item being processed.
          #
          #   @param output_index [Integer] The index of the output item in the response's output array.
          #
          #   @param sequence_number [Integer] The sequence number of the image generation item being processed.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseImageGenCallGeneratingEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.image_generation_call.generating"] The type of the event. Always 'response.image_generation_call.generating'.
        end

        class BetaResponseImageGenCallInWsProgress < OpenAI::Models::Beta::BetaResponseImageGenCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.image_generation_call.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallInWsProgress}
          #   for more details.
          #
          #   Emitted when an image generation tool call is in progress.
          #
          #   @param item_id [String] The unique identifier of the image generation item being processed.
          #
          #   @param output_index [Integer] The index of the output item in the response's output array.
          #
          #   @param sequence_number [Integer] The sequence number of the image generation item being processed.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseImageGenCallInProgressEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.image_generation_call.in_progress"] The type of the event. Always 'response.image_generation_call.in_progress'.
        end

        class BetaResponseImageGenCallPartialWsImage < OpenAI::Models::Beta::BetaResponseImageGenCallPartialImageEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, partial_image_b64:, partial_image_index:, sequence_number:, agent: nil, background: nil, output_format: nil, quality: nil, size: nil, stream_id: nil, type: :"response.image_generation_call.partial_image")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallPartialWsImage}
          #   for more details.
          #
          #   Emitted when a partial image is available during image generation streaming.
          #
          #   @param item_id [String] The unique identifier of the image generation item being processed.
          #
          #   @param output_index [Integer] The index of the output item in the response's output array.
          #
          #   @param partial_image_b64 [String] Base64-encoded partial image data, suitable for rendering as an image.
          #
          #   @param partial_image_index [Integer] 0-based index for the partial image (backend is 1-based, but this is 0-based for
          #
          #   @param sequence_number [Integer] The sequence number of the image generation item being processed.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseImageGenCallPartialImageEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param background [String] The background setting that was used.
          #
          #   @param output_format [String] The output format that was used.
          #
          #   @param quality [String] The image quality that was used.
          #
          #   @param size [String] The image size that was used.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.image_generation_call.partial_image"] The type of the event. Always 'response.image_generation_call.partial_image'.
        end

        class BetaResponseMcpCallArgumentsWsDelta < OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(delta:, item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.mcp_call_arguments.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDelta}
          #   for more details.
          #
          #   Emitted when there is a delta (partial update) to the arguments of an MCP tool
          #   call.
          #
          #   @param delta [String] A JSON string containing the partial update to the arguments for the MCP tool ca
          #
          #   @param item_id [String] The unique identifier of the MCP tool call item being processed.
          #
          #   @param output_index [Integer] The index of the output item in the response's output array.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_call_arguments.delta"] The type of the event. Always 'response.mcp_call_arguments.delta'.
        end

        class BetaResponseMcpCallArgumentsWsDone < OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(arguments:, item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.mcp_call_arguments.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDone}
          #   for more details.
          #
          #   Emitted when the arguments for an MCP tool call are finalized.
          #
          #   @param arguments [String] A JSON string containing the finalized arguments for the MCP tool call.
          #
          #   @param item_id [String] The unique identifier of the MCP tool call item being processed.
          #
          #   @param output_index [Integer] The index of the output item in the response's output array.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_call_arguments.done"] The type of the event. Always 'response.mcp_call_arguments.done'.
        end

        class BetaResponseMcpCallWsCompleted < OpenAI::Models::Beta::BetaResponseMcpCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.mcp_call.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsCompleted}
          #   for more details.
          #
          #   Emitted when an MCP tool call has completed successfully.
          #
          #   @param item_id [String] The ID of the MCP tool call item that completed.
          #
          #   @param output_index [Integer] The index of the output item that completed.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseMcpCallCompletedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_call.completed"] The type of the event. Always 'response.mcp_call.completed'.
        end

        class BetaResponseMcpCallWsFailed < OpenAI::Models::Beta::BetaResponseMcpCallFailedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.mcp_call.failed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsFailed}
          #   for more details.
          #
          #   Emitted when an MCP tool call has failed.
          #
          #   @param item_id [String] The ID of the MCP tool call item that failed.
          #
          #   @param output_index [Integer] The index of the output item that failed.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseMcpCallFailedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_call.failed"] The type of the event. Always 'response.mcp_call.failed'.
        end

        class BetaResponseMcpCallInWsProgress < OpenAI::Models::Beta::BetaResponseMcpCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.mcp_call.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallInWsProgress}
          #   for more details.
          #
          #   Emitted when an MCP tool call is in progress.
          #
          #   @param item_id [String] The unique identifier of the MCP tool call item being processed.
          #
          #   @param output_index [Integer] The index of the output item in the response's output array.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseMcpCallInProgressEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_call.in_progress"] The type of the event. Always 'response.mcp_call.in_progress'.
        end

        class BetaResponseMcpListToolsWsCompleted < OpenAI::Models::Beta::BetaResponseMcpListToolsCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.mcp_list_tools.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsCompleted}
          #   for more details.
          #
          #   Emitted when the list of available MCP tools has been successfully retrieved.
          #
          #   @param item_id [String] The ID of the MCP tool call item that produced this output.
          #
          #   @param output_index [Integer] The index of the output item that was processed.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseMcpListToolsCompletedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_list_tools.completed"] The type of the event. Always 'response.mcp_list_tools.completed'.
        end

        class BetaResponseMcpListToolsWsFailed < OpenAI::Models::Beta::BetaResponseMcpListToolsFailedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.mcp_list_tools.failed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsFailed}
          #   for more details.
          #
          #   Emitted when the attempt to list available MCP tools has failed.
          #
          #   @param item_id [String] The ID of the MCP tool call item that failed.
          #
          #   @param output_index [Integer] The index of the output item that failed.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseMcpListToolsFailedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_list_tools.failed"] The type of the event. Always 'response.mcp_list_tools.failed'.
        end

        class BetaResponseMcpListToolsInWsProgress < OpenAI::Models::Beta::BetaResponseMcpListToolsInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.mcp_list_tools.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsInWsProgress}
          #   for more details.
          #
          #   Emitted when the system is in the process of retrieving the list of available
          #   MCP tools.
          #
          #   @param item_id [String] The ID of the MCP tool call item that is being processed.
          #
          #   @param output_index [Integer] The index of the output item that is being processed.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseMcpListToolsInProgressEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_list_tools.in_progress"] The type of the event. Always 'response.mcp_list_tools.in_progress'.
        end

        class BetaResponseOutputTextAnnotationWsAdded < OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(annotation:, annotation_index:, content_index:, item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.output_text.annotation.added")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseOutputTextAnnotationWsAdded}
          #   for more details.
          #
          #   Emitted when an annotation is added to output text content.
          #
          #   @param annotation [OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::FileCitation, OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::URLCitation, OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::ContainerFileCitation, OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::FilePath, nil] An annotation that applies to a span of output text.
          #
          #   @param annotation_index [Integer] The index of the annotation within the content part.
          #
          #   @param content_index [Integer] The index of the content part within the output item.
          #
          #   @param item_id [String] The unique identifier of the item to which the annotation is being added.
          #
          #   @param output_index [Integer] The index of the output item in the response's output array.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.output_text.annotation.added"] The type of the event. Always 'response.output_text.annotation.added'.
        end

        class BetaResponseWsQueued < OpenAI::Models::Beta::BetaResponseQueuedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(response:, sequence_number:, agent: nil, stream_id: nil, type: :"response.queued")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsQueued} for more
          #   details.
          #
          #   Emitted when a response is queued and waiting to be processed.
          #
          #   @param response [OpenAI::Models::Beta::BetaResponse] The full response object that is queued.
          #
          #   @param sequence_number [Integer] The sequence number for this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseQueuedEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.queued"] The type of the event. Always 'response.queued'.
        end

        class BetaResponseCustomToolCallInputWsDelta < OpenAI::Models::Beta::BetaResponseCustomToolCallInputDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(delta:, item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.custom_tool_call_input.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDelta}
          #   for more details.
          #
          #   Event representing a delta (partial update) to the input of a custom tool call.
          #
          #   @param delta [String] The incremental input data (delta) for the custom tool call.
          #
          #   @param item_id [String] Unique identifier for the API item associated with this event.
          #
          #   @param output_index [Integer] The index of the output this delta applies to.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseCustomToolCallInputDeltaEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.custom_tool_call_input.delta"] The event type identifier.
        end

        class BetaResponseCustomToolCallInputWsDone < OpenAI::Models::Beta::BetaResponseCustomToolCallInputDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(input:, item_id:, output_index:, sequence_number:, agent: nil, stream_id: nil, type: :"response.custom_tool_call_input.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDone}
          #   for more details.
          #
          #   Event indicating that input for a custom tool call is complete.
          #
          #   @param input [String] The complete input data for the custom tool call.
          #
          #   @param item_id [String] Unique identifier for the API item associated with this event.
          #
          #   @param output_index [Integer] The index of the output this event applies to.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponseCustomToolCallInputDoneEvent::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.custom_tool_call_input.done"] The event type identifier.
        end

        class BetaResponseWsError < OpenAI::Internal::Type::BaseModel
          # @!attribute error
          #   Details about the error.
          #
          #   @return [OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error]
          required :error, -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error }

          # @!attribute type
          #   The type of the event. Always `error`.
          #
          #   @return [Symbol, :error]
          required :type, const: :error

          # @!attribute agent
          #   The agent that owns this multi-agent streaming event.
          #
          #   @return [OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Agent, nil]
          optional(
            :agent,
            -> {
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Agent
            },
            nil?: true
          )

          # @!attribute sequence_number
          #   The sequence number of an error emitted by the response stream.
          #
          #   @return [Integer, nil]
          optional :sequence_number, Integer

          # @!attribute status
          #   The HTTP status code associated with a WebSocket protocol error.
          #
          #   @return [Integer, nil]
          optional :status, Integer

          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(error:, agent: nil, sequence_number: nil, status: nil, stream_id: nil, type: :error)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError} for more
          #   details.
          #
          #   Emitted when an error occurs while processing a Responses WebSocket request.
          #
          #   @param error [OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error] Details about the error.
          #
          #   @param agent [OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Agent, nil] The agent that owns this multi-agent streaming event.
          #
          #   @param sequence_number [Integer] The sequence number of an error emitted by the response stream.
          #
          #   @param status [Integer] The HTTP status code associated with a WebSocket protocol error.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present when the
          #
          #   @param type [Symbol, :error] The type of the event. Always `error`.

          # @see OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError#error
          class Error < OpenAI::Internal::Type::BaseModel
            # @!attribute code
            #   The error code that was emitted, if any.
            #
            #   @return [String, nil]
            required :code, String, nil?: true

            # @!attribute message
            #   The human-readable error message that was emitted.
            #
            #   @return [String]
            required :message, String

            # @!attribute param
            #   The parameter name that was associated with the error, if any.
            #
            #   @return [String, nil]
            required :param, String, nil?: true

            # @!attribute type
            #   The error type that was emitted.
            #
            #   @return [String]
            required :type, String

            # @!attribute headers
            #   The response headers that were emitted with the error, if any.
            #
            #   @return [Hash{Symbol=>String}, nil]
            optional :headers, OpenAI::Internal::Type::HashOf[String]

            # @!attribute misalignment
            #
            #   @return [OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment, nil]
            optional(
              :misalignment,
              -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment }
            )

            # @!method initialize(code:, message:, param:, type:, headers: nil, misalignment: nil)
            #   Details about the error.
            #
            #   @param code [String, nil] The error code that was emitted, if any.
            #
            #   @param message [String] The human-readable error message that was emitted.
            #
            #   @param param [String, nil] The parameter name that was associated with the error, if any.
            #
            #   @param type [String] The error type that was emitted.
            #
            #   @param headers [Hash{Symbol=>String}] The response headers that were emitted with the error, if any.
            #
            #   @param misalignment [OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment]

            # @see OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error#misalignment
            class Misalignment < OpenAI::Internal::Type::BaseModel
              # @!attribute detailed_explanation
              #   The public explanation for this block.
              #
              #   @return [String, nil]
              optional :detailed_explanation, String

              # @!attribute error_type
              #   An optional classification; clients must accept additional values.
              #
              #   @return [String, Symbol, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment::ErrorType, nil]
              optional(
                :error_type,
                union: -> {
                  OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment::ErrorType
                }
              )

              # @!attribute steer
              #   An optional public continuation instruction.
              #
              #   @return [OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment::Steer, nil]
              optional(
                :steer,
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment::Steer }
              )

              # @!method initialize(detailed_explanation: nil, error_type: nil, steer: nil)
              #   @param detailed_explanation [String] The public explanation for this block.
              #
              #   @param error_type [String, Symbol, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment::ErrorType] An optional classification; clients must accept additional values.
              #
              #   @param steer [OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment::Steer] An optional public continuation instruction.

              # An optional classification; clients must accept additional values.
              #
              # @see OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment#error_type
              module ErrorType
                extend OpenAI::Internal::Type::Union

                variant String

                variant(
                  const: -> {
                    OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment::ErrorType::POTENTIALLY_UNINTENDED_DATA_TRANSFER
                  }
                )

                variant(
                  const: -> {
                    OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment::ErrorType::POTENTIALLY_UNINTENDED_DATA_ACCESS
                  }
                )

                variant(
                  const: -> {
                    OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment::ErrorType::POTENTIALLY_UNINTENDED_DESTRUCTIVE_ACTIVITY
                  }
                )

                variant(
                  const: -> {
                    OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment::ErrorType::OTHER
                  }
                )

                # @!method self.variants
                #   @return [Array(String, Symbol)]

                define_sorbet_constant!(:Variants) do
                  T.type_alias do
                    T.any(
                      String,
                      OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment::ErrorType::TaggedSymbol
                    )
                  end
                end

                # @!group

                POTENTIALLY_UNINTENDED_DATA_TRANSFER = :potentially_unintended_data_transfer
                POTENTIALLY_UNINTENDED_DATA_ACCESS = :potentially_unintended_data_access
                POTENTIALLY_UNINTENDED_DESTRUCTIVE_ACTIVITY = :potentially_unintended_destructive_activity
                OTHER = :other

                # @!endgroup
              end

              # @see OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::Misalignment#steer
              class Steer < OpenAI::Internal::Type::BaseModel
                # @!attribute message
                #   The public continuation instruction.
                #
                #   @return [String]
                required :message, String

                # @!method initialize(message:)
                #   An optional public continuation instruction.
                #
                #   @param message [String] The public continuation instruction.
              end
            end
          end

          # @see OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError#agent
          class Agent < OpenAI::Internal::Type::BaseModel
            # @!attribute agent_name
            #   The canonical name of the agent that produced this item.
            #
            #   @return [String]
            required :agent_name, String

            # @!method initialize(agent_name:)
            #   The agent that owns this multi-agent streaming event.
            #
            #   @param agent_name [String] The canonical name of the agent that produced this item.
          end
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError, OpenAI::Models::Beta::BetaResponseSteerAcceptedEvent, OpenAI::Models::Beta::BetaResponseSteerPendingEvent, OpenAI::Models::Beta::BetaResponseSteerFailedEvent, OpenAI::Models::Beta::BetaResponseInjectCreatedEvent, OpenAI::Models::Beta::BetaResponseInjectFailedEvent, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsCompleted, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallInWsProgress, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsInterpreting, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsCompleted, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsAdded, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsCreated, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsCompleted, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallInWsProgress, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsSearching, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseShellCallCommandWsAdded, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseShellCallCommandWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseShellCallCommandWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseShellCallOutputContentWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseShellCallOutputContentWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseInWsProgress, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsFailed, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsIncomplete, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsAdded, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsAdded, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseTextWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseTextWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsCompleted, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallInWsProgress, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsSearching, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsCompleted, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsGenerating, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallInWsProgress, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallPartialWsImage, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsCompleted, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsFailed, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallInWsProgress, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsCompleted, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsFailed, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsInWsProgress, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseOutputTextAnnotationWsAdded, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsQueued, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDone)]
      end
    end

    BetaResponsesServerEvent = Beta::BetaResponsesServerEvent
  end
end
