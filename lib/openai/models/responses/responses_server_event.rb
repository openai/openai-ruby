# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # Server events emitted by the Responses WebSocket server.
      module ResponsesServerEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Emitted when an error occurs while processing a Responses WebSocket request.
        variant :error, -> { OpenAI::Responses::ResponsesServerEvent::ResponseWsError }

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
        variant :"response.steer.accepted", -> { OpenAI::Responses::ResponseSteerAcceptedEvent }

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
        variant :"response.steer.pending", -> { OpenAI::Responses::ResponseSteerPendingEvent }

        # Emitted when steering input is rejected or cannot be committed to a
        # successor response. Returns the original, uncommitted input so the client
        # can carry it into `response.create` when appropriate. Invalid input must
        # be corrected before retrying.
        #
        # Failures after acceptance include the same steering ID. Failures before an
        # ID is allocated omit `steer.id`. A lost connection or missing acknowledgement
        # leaves the outcome unknown; it is not proof that the input was rejected.
        variant :"response.steer.failed", -> { OpenAI::Responses::ResponseSteerFailedEvent }

        # Emitted when there is a partial audio response.
        variant :"response.audio.delta", -> { OpenAI::Responses::ResponsesServerEvent::ResponseAudioWsDelta }

        # Emitted when the audio response is complete.
        variant :"response.audio.done", -> { OpenAI::Responses::ResponsesServerEvent::ResponseAudioWsDone }

        # Emitted when there is a partial transcript of audio.
        variant(
          :"response.audio.transcript.delta",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDelta }
        )

        # Emitted when the full audio transcript is completed.
        variant(
          :"response.audio.transcript.done",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDone }
        )

        # Emitted when a partial code snippet is streamed by the code interpreter.
        variant(
          :"response.code_interpreter_call_code.delta",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDelta }
        )

        # Emitted when the code snippet is finalized by the code interpreter.
        variant(
          :"response.code_interpreter_call_code.done",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDone }
        )

        # Emitted when the code interpreter call is completed.
        variant(
          :"response.code_interpreter_call.completed",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsCompleted }
        )

        # Emitted when a code interpreter call is in progress.
        variant(
          :"response.code_interpreter_call.in_progress",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallInWsProgress }
        )

        # Emitted when the code interpreter is actively interpreting the code snippet.
        variant(
          :"response.code_interpreter_call.interpreting",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsInterpreting }
        )

        # Emitted when the model response is complete.
        variant :"response.completed", -> { OpenAI::Responses::ResponsesServerEvent::ResponseWsCompleted }

        # Emitted when a new content part is added.
        variant(
          :"response.content_part.added",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseContentPartWsAdded }
        )

        # Emitted when a content part is done.
        variant(
          :"response.content_part.done",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseContentPartWsDone }
        )

        # An event that is emitted when a response is created.
        variant :"response.created", -> { OpenAI::Responses::ResponsesServerEvent::ResponseWsCreated }

        # Emitted when a file search call is completed (results found).
        variant(
          :"response.file_search_call.completed",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseFileSearchCallWsCompleted }
        )

        # Emitted when a file search call is initiated.
        variant(
          :"response.file_search_call.in_progress",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseFileSearchCallInWsProgress }
        )

        # Emitted when a file search is currently searching.
        variant(
          :"response.file_search_call.searching",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseFileSearchCallWsSearching }
        )

        # Emitted when there is a partial function-call arguments delta.
        variant(
          :"response.function_call_arguments.delta",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDelta }
        )

        # Emitted when function-call arguments are finalized.
        variant(
          :"response.function_call_arguments.done",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDone }
        )

        # A streaming event that indicated a shell command was added to a tool call.
        variant(
          :"response.shell_call_command.added",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseShellCallCommandWsAdded }
        )

        # A streaming event that indicated a shell command was incrementally updated.
        variant(
          :"response.shell_call_command.delta",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseShellCallCommandWsDelta }
        )

        # A streaming event that indicated a shell command was completed.
        variant(
          :"response.shell_call_command.done",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseShellCallCommandWsDone }
        )

        # A streaming event that indicated shell call output was incrementally added.
        variant(
          :"response.shell_call_output_content.delta",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseShellCallOutputContentWsDelta }
        )

        # A streaming event that indicated shell call output was completed.
        variant(
          :"response.shell_call_output_content.done",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseShellCallOutputContentWsDone }
        )

        # Emitted when the response is in progress.
        variant :"response.in_progress", -> { OpenAI::Responses::ResponsesServerEvent::ResponseInWsProgress }

        # An event that is emitted when a response fails.
        variant :"response.failed", -> { OpenAI::Responses::ResponsesServerEvent::ResponseWsFailed }

        # An event that is emitted when a response finishes as incomplete.
        #
        # Over WebSocket, steering can finish a response with
        # `response.incomplete_details.reason` set to `steered`, followed automatically
        # by a successor `response.created` that commits the queued steering input.
        variant :"response.incomplete", -> { OpenAI::Responses::ResponsesServerEvent::ResponseWsIncomplete }

        # Emitted when a new output item is added.
        variant(
          :"response.output_item.added",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseOutputItemWsAdded }
        )

        # Emitted when an output item is marked done.
        variant(
          :"response.output_item.done",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseOutputItemWsDone }
        )

        # Emitted when a new reasoning summary part is added.
        variant(
          :"response.reasoning_summary_part.added",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsAdded }
        )

        # Emitted when a reasoning summary part is completed.
        variant(
          :"response.reasoning_summary_part.done",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsDone }
        )

        # Emitted when a delta is added to a reasoning summary text.
        variant(
          :"response.reasoning_summary_text.delta",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDelta }
        )

        # Emitted when a reasoning summary text is completed.
        variant(
          :"response.reasoning_summary_text.done",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDone }
        )

        # Emitted when a delta is added to a reasoning text.
        variant(
          :"response.reasoning_text.delta",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseReasoningTextWsDelta }
        )

        # Emitted when a reasoning text is completed.
        variant(
          :"response.reasoning_text.done",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseReasoningTextWsDone }
        )

        # Emitted when there is a partial refusal text.
        variant :"response.refusal.delta", -> { OpenAI::Responses::ResponsesServerEvent::ResponseRefusalWsDelta }

        # Emitted when refusal text is finalized.
        variant :"response.refusal.done", -> { OpenAI::Responses::ResponsesServerEvent::ResponseRefusalWsDone }

        # Emitted when there is an additional text delta.
        variant :"response.output_text.delta", -> { OpenAI::Responses::ResponsesServerEvent::ResponseTextWsDelta }

        # Emitted when text content is finalized.
        variant :"response.output_text.done", -> { OpenAI::Responses::ResponsesServerEvent::ResponseTextWsDone }

        # Emitted when a web search call is completed.
        variant(
          :"response.web_search_call.completed",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseWebSearchCallWsCompleted }
        )

        # Emitted when a web search call is initiated.
        variant(
          :"response.web_search_call.in_progress",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseWebSearchCallInWsProgress }
        )

        # Emitted when a web search call is executing.
        variant(
          :"response.web_search_call.searching",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseWebSearchCallWsSearching }
        )

        # Emitted when an image generation tool call has completed and the final image is available.
        variant(
          :"response.image_generation_call.completed",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallWsCompleted }
        )

        # Emitted when an image generation tool call is actively generating an image (intermediate state).
        variant(
          :"response.image_generation_call.generating",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallWsGenerating }
        )

        # Emitted when an image generation tool call is in progress.
        variant(
          :"response.image_generation_call.in_progress",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallInWsProgress }
        )

        # Emitted when a partial image is available during image generation streaming.
        variant(
          :"response.image_generation_call.partial_image",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallPartialWsImage }
        )

        # Emitted when there is a delta (partial update) to the arguments of an MCP tool call.
        variant(
          :"response.mcp_call_arguments.delta",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDelta }
        )

        # Emitted when the arguments for an MCP tool call are finalized.
        variant(
          :"response.mcp_call_arguments.done",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDone }
        )

        # Emitted when an MCP  tool call has completed successfully.
        variant(
          :"response.mcp_call.completed",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallWsCompleted }
        )

        # Emitted when an MCP  tool call has failed.
        variant(
          :"response.mcp_call.failed",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallWsFailed }
        )

        # Emitted when an MCP  tool call is in progress.
        variant(
          :"response.mcp_call.in_progress",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallInWsProgress }
        )

        # Emitted when the list of available MCP tools has been successfully retrieved.
        variant(
          :"response.mcp_list_tools.completed",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpListToolsWsCompleted }
        )

        # Emitted when the attempt to list available MCP tools has failed.
        variant(
          :"response.mcp_list_tools.failed",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpListToolsWsFailed }
        )

        # Emitted when the system is in the process of retrieving the list of available MCP tools.
        variant(
          :"response.mcp_list_tools.in_progress",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpListToolsInWsProgress }
        )

        # Emitted when an annotation is added to output text content.
        variant(
          :"response.output_text.annotation.added",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseOutputTextAnnotationWsAdded }
        )

        # Emitted when a response is queued and waiting to be processed.
        variant :"response.queued", -> { OpenAI::Responses::ResponsesServerEvent::ResponseWsQueued }

        # Event representing a delta (partial update) to the input of a custom tool call.
        variant(
          :"response.custom_tool_call_input.delta",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDelta }
        )

        # Event indicating that input for a custom tool call is complete.
        variant(
          :"response.custom_tool_call_input.done",
          -> { OpenAI::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDone }
        )

        class ResponseAudioWsDelta < OpenAI::Models::Responses::ResponseAudioDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(delta:, sequence_number:, stream_id: nil, type: :"response.audio.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioWsDelta} for more
          #   details.
          #
          #   Emitted when there is a partial audio response.
          #
          #   @param delta [String] A chunk of Base64 encoded response audio bytes.
          #
          #   @param sequence_number [Integer] A sequence number for this chunk of the stream response.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.audio.delta"] The type of the event. Always `response.audio.delta`.
        end

        class ResponseAudioWsDone < OpenAI::Models::Responses::ResponseAudioDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(sequence_number:, stream_id: nil, type: :"response.audio.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioWsDone} for more
          #   details.
          #
          #   Emitted when the audio response is complete.
          #
          #   @param sequence_number [Integer] The sequence number of the delta.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.audio.done"] The type of the event. Always `response.audio.done`.
        end

        class ResponseAudioTranscriptWsDelta < OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(delta:, sequence_number:, stream_id: nil, type: :"response.audio.transcript.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDelta}
          #   for more details.
          #
          #   Emitted when there is a partial transcript of audio.
          #
          #   @param delta [String] The partial transcript of the audio response.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.audio.transcript.delta"] The type of the event. Always `response.audio.transcript.delta`.
        end

        class ResponseAudioTranscriptWsDone < OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(sequence_number:, stream_id: nil, type: :"response.audio.transcript.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDone}
          #   for more details.
          #
          #   Emitted when the full audio transcript is completed.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.audio.transcript.done"] The type of the event. Always `response.audio.transcript.done`.
        end

        class ResponseCodeInterpreterCallCodeWsDelta < OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(delta:, item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.code_interpreter_call_code.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDelta}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.code_interpreter_call_code.delta"] The type of the event. Always `response.code_interpreter_call_code.delta`.
        end

        class ResponseCodeInterpreterCallCodeWsDone < OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(code:, item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.code_interpreter_call_code.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDone}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.code_interpreter_call_code.done"] The type of the event. Always `response.code_interpreter_call_code.done`.
        end

        class ResponseCodeInterpreterCallWsCompleted < OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.code_interpreter_call.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsCompleted}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.code_interpreter_call.completed"] The type of the event. Always `response.code_interpreter_call.completed`.
        end

        class ResponseCodeInterpreterCallInWsProgress < OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.code_interpreter_call.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallInWsProgress}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.code_interpreter_call.in_progress"] The type of the event. Always `response.code_interpreter_call.in_progress`.
        end

        class ResponseCodeInterpreterCallWsInterpreting < OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.code_interpreter_call.interpreting")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsInterpreting}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.code_interpreter_call.interpreting"] The type of the event. Always `response.code_interpreter_call.interpreting`.
        end

        class ResponseWsCompleted < OpenAI::Models::Responses::ResponseCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(response:, sequence_number:, stream_id: nil, type: :"response.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsCompleted} for more
          #   details.
          #
          #   Emitted when the model response is complete.
          #
          #   @param response [OpenAI::Models::Responses::Response] Properties of the completed response.
          #
          #   @param sequence_number [Integer] The sequence number for this event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.completed"] The type of the event. Always `response.completed`.
        end

        class ResponseContentPartWsAdded < OpenAI::Models::Responses::ResponseContentPartAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, item_id:, output_index:, part:, sequence_number:, stream_id: nil, type: :"response.content_part.added")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseContentPartWsAdded}
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
          #   @param part [OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal, OpenAI::Models::Responses::ResponseContentPartAddedEvent::Part::ReasoningText] The content part that was added.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.content_part.added"] The type of the event. Always `response.content_part.added`.
        end

        class ResponseContentPartWsDone < OpenAI::Models::Responses::ResponseContentPartDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, item_id:, output_index:, part:, sequence_number:, stream_id: nil, type: :"response.content_part.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseContentPartWsDone} for
          #   more details.
          #
          #   Emitted when a content part is done.
          #
          #   @param content_index [Integer] The index of the content part that is done.
          #
          #   @param item_id [String] The ID of the output item that the content part was added to.
          #
          #   @param output_index [Integer] The index of the output item that the content part was added to.
          #
          #   @param part [OpenAI::Models::Responses::ResponseOutputText, OpenAI::Models::Responses::ResponseOutputRefusal, OpenAI::Models::Responses::ResponseContentPartDoneEvent::Part::ReasoningText] The content part that is done.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.content_part.done"] The type of the event. Always `response.content_part.done`.
        end

        class ResponseWsCreated < OpenAI::Models::Responses::ResponseCreatedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(response:, sequence_number:, stream_id: nil, type: :"response.created")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsCreated} for more
          #   details.
          #
          #   An event that is emitted when a response is created.
          #
          #   @param response [OpenAI::Models::Responses::Response] The response that was created.
          #
          #   @param sequence_number [Integer] The sequence number for this event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.created"] The type of the event. Always `response.created`.
        end

        class ResponseFileSearchCallWsCompleted < OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.file_search_call.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseFileSearchCallWsCompleted}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.file_search_call.completed"] The type of the event. Always `response.file_search_call.completed`.
        end

        class ResponseFileSearchCallInWsProgress < OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.file_search_call.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseFileSearchCallInWsProgress}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.file_search_call.in_progress"] The type of the event. Always `response.file_search_call.in_progress`.
        end

        class ResponseFileSearchCallWsSearching < OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.file_search_call.searching")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseFileSearchCallWsSearching}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.file_search_call.searching"] The type of the event. Always `response.file_search_call.searching`.
        end

        class ResponseFunctionCallArgumentsWsDelta < OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(delta:, item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.function_call_arguments.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDelta}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.function_call_arguments.delta"] The type of the event. Always `response.function_call_arguments.delta`.
        end

        class ResponseFunctionCallArgumentsWsDone < OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(arguments:, item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.function_call_arguments.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDone}
          #   for more details.
          #
          #   Emitted when function-call arguments are finalized.
          #
          #   @param arguments [String] The function-call arguments.
          #
          #   @param item_id [String] The ID of the item.
          #
          #   @param output_index [Integer] The index of the output item.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.function_call_arguments.done"]
        end

        class ResponseShellCallCommandWsAdded < OpenAI::Models::Responses::ResponseShellCallCommandAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(command:, command_index:, output_index:, sequence_number:, stream_id: nil, type: :"response.shell_call_command.added")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseShellCallCommandWsAdded}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.shell_call_command.added"] The type of the event, always `response.shell_call_command.added`.
        end

        class ResponseShellCallCommandWsDelta < OpenAI::Models::Responses::ResponseShellCallCommandDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(command_index:, delta:, output_index:, sequence_number:, obfuscation: nil, stream_id: nil, type: :"response.shell_call_command.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseShellCallCommandWsDelta}
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
          #   @param obfuscation [String] An obfuscation string that was added to pad the event payload.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.shell_call_command.delta"] The type of the event, always `response.shell_call_command.delta`.
        end

        class ResponseShellCallCommandWsDone < OpenAI::Models::Responses::ResponseShellCallCommandDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(command:, command_index:, output_index:, sequence_number:, stream_id: nil, type: :"response.shell_call_command.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseShellCallCommandWsDone}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.shell_call_command.done"] The type of the event, always `response.shell_call_command.done`.
        end

        class ResponseShellCallOutputContentWsDelta < OpenAI::Models::Responses::ResponseShellCallOutputContentDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(command_index:, delta:, item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.shell_call_output_content.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseShellCallOutputContentWsDelta}
          #   for more details.
          #
          #   A streaming event that indicated shell call output was incrementally added.
          #
          #   @param command_index [Integer] The index of the shell command that produced output.
          #
          #   @param delta [OpenAI::Models::Responses::ResponseShellCallOutputContentDeltaEvent::Delta] The stdout/stderr delta that was emitted.
          #
          #   @param item_id [String] The ID of the output item that was updated.
          #
          #   @param output_index [Integer] The index of the output item that was updated.
          #
          #   @param sequence_number [Integer] The sequence number of the event that was emitted.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.shell_call_output_content.delta"] The type of the event, always `response.shell_call_output_content.delta`.
        end

        class ResponseShellCallOutputContentWsDone < OpenAI::Models::Responses::ResponseShellCallOutputContentDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(command_index:, item_id:, output:, output_index:, sequence_number:, stream_id: nil, type: :"response.shell_call_output_content.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseShellCallOutputContentWsDone}
          #   for more details.
          #
          #   A streaming event that indicated shell call output was completed.
          #
          #   @param command_index [Integer] The index of the shell command that produced output.
          #
          #   @param item_id [String] The ID of the output item that was updated.
          #
          #   @param output [Array<OpenAI::Models::Responses::ResponseShellCallOutputContentDoneEvent::Output>] The output contents emitted for the shell command.
          #
          #   @param output_index [Integer] The index of the output item that was updated.
          #
          #   @param sequence_number [Integer] The sequence number of the event that was emitted.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.shell_call_output_content.done"] The type of the event, always `response.shell_call_output_content.done`.
        end

        class ResponseInWsProgress < OpenAI::Models::Responses::ResponseInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(response:, sequence_number:, stream_id: nil, type: :"response.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseInWsProgress} for more
          #   details.
          #
          #   Emitted when the response is in progress.
          #
          #   @param response [OpenAI::Models::Responses::Response] The response that is in progress.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.in_progress"] The type of the event. Always `response.in_progress`.
        end

        class ResponseWsFailed < OpenAI::Models::Responses::ResponseFailedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(response:, sequence_number:, stream_id: nil, type: :"response.failed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsFailed} for more
          #   details.
          #
          #   An event that is emitted when a response fails.
          #
          #   @param response [OpenAI::Models::Responses::Response] The response that failed.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.failed"] The type of the event. Always `response.failed`.
        end

        class ResponseWsIncomplete < OpenAI::Models::Responses::ResponseIncompleteEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(response:, sequence_number:, stream_id: nil, type: :"response.incomplete")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsIncomplete} for more
          #   details.
          #
          #   An event that is emitted when a response finishes as incomplete.
          #
          #   Over WebSocket, steering can finish a response with
          #   `response.incomplete_details.reason` set to `steered`, followed automatically by
          #   a successor `response.created` that commits the queued steering input.
          #
          #   @param response [OpenAI::Models::Responses::Response] The response that was incomplete.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.incomplete"] The type of the event. Always `response.incomplete`.
        end

        class ResponseOutputItemWsAdded < OpenAI::Models::Responses::ResponseOutputItemAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item:, output_index:, sequence_number:, stream_id: nil, type: :"response.output_item.added")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseOutputItemWsAdded} for
          #   more details.
          #
          #   Emitted when a new output item is added.
          #
          #   @param item [OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseOutputItem::Program, OpenAI::Models::Responses::ResponseOutputItem::ProgramOutput, OpenAI::Models::Responses::ResponseToolSearchCall, OpenAI::Models::Responses::ResponseToolSearchOutputItem, OpenAI::Models::Responses::ResponseOutputItem::AdditionalTools, OpenAI::Models::Responses::ResponseCompactionItem, OpenAI::Models::Responses::ResponseOutputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseOutputItem::LocalShellCall, OpenAI::Models::Responses::ResponseOutputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseFunctionShellToolCall, OpenAI::Models::Responses::ResponseFunctionShellToolCallOutput, OpenAI::Models::Responses::ResponseApplyPatchToolCall, OpenAI::Models::Responses::ResponseApplyPatchToolCallOutput, OpenAI::Models::Responses::ResponseOutputItem::McpCall, OpenAI::Models::Responses::ResponseOutputItem::McpListTools, OpenAI::Models::Responses::ResponseOutputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseOutputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseCustomToolCallOutputItem] The output item that was added. For reasoning items, `encrypted_content`
          #
          #   @param output_index [Integer] The index of the output item that was added.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.output_item.added"] The type of the event. Always `response.output_item.added`.
        end

        class ResponseOutputItemWsDone < OpenAI::Models::Responses::ResponseOutputItemDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item:, output_index:, sequence_number:, stream_id: nil, type: :"response.output_item.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseOutputItemWsDone} for
          #   more details.
          #
          #   Emitted when an output item is marked done.
          #
          #   @param item [OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseFunctionToolCallOutputItem, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseComputerToolCallOutputItem, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseOutputItem::Program, OpenAI::Models::Responses::ResponseOutputItem::ProgramOutput, OpenAI::Models::Responses::ResponseToolSearchCall, OpenAI::Models::Responses::ResponseToolSearchOutputItem, OpenAI::Models::Responses::ResponseOutputItem::AdditionalTools, OpenAI::Models::Responses::ResponseCompactionItem, OpenAI::Models::Responses::ResponseOutputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseOutputItem::LocalShellCall, OpenAI::Models::Responses::ResponseOutputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseFunctionShellToolCall, OpenAI::Models::Responses::ResponseFunctionShellToolCallOutput, OpenAI::Models::Responses::ResponseApplyPatchToolCall, OpenAI::Models::Responses::ResponseApplyPatchToolCallOutput, OpenAI::Models::Responses::ResponseOutputItem::McpCall, OpenAI::Models::Responses::ResponseOutputItem::McpListTools, OpenAI::Models::Responses::ResponseOutputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseOutputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseCustomToolCallOutputItem] The output item that was marked done.
          #
          #   @param output_index [Integer] The index of the output item that was marked done.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.output_item.done"] The type of the event. Always `response.output_item.done`.
        end

        class ResponseReasoningSummaryPartWsAdded < OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, part:, sequence_number:, summary_index:, stream_id: nil, type: :"response.reasoning_summary_part.added")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsAdded}
          #   for more details.
          #
          #   Emitted when a new reasoning summary part is added.
          #
          #   @param item_id [String] The ID of the item this summary part is associated with.
          #
          #   @param output_index [Integer] The index of the output item this summary part is associated with.
          #
          #   @param part [OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent::Part] The summary part that was added.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param summary_index [Integer] The index of the summary part within the reasoning summary.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.reasoning_summary_part.added"] The type of the event. Always `response.reasoning_summary_part.added`.
        end

        class ResponseReasoningSummaryPartWsDone < OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, part:, sequence_number:, summary_index:, status: nil, stream_id: nil, type: :"response.reasoning_summary_part.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsDone}
          #   for more details.
          #
          #   Emitted when a reasoning summary part is completed.
          #
          #   @param item_id [String] The ID of the item this summary part is associated with.
          #
          #   @param output_index [Integer] The index of the output item this summary part is associated with.
          #
          #   @param part [OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent::Part] The completed summary part.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param summary_index [Integer] The index of the summary part within the reasoning summary.
          #
          #   @param status [Symbol, OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent::Status] The completion status of the summary part. Omitted when the part completed
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.reasoning_summary_part.done"] The type of the event. Always `response.reasoning_summary_part.done`.
        end

        class ResponseReasoningSummaryTextWsDelta < OpenAI::Models::Responses::ResponseReasoningSummaryTextDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(delta:, item_id:, output_index:, sequence_number:, summary_index:, stream_id: nil, type: :"response.reasoning_summary_text.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDelta}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.reasoning_summary_text.delta"] The type of the event. Always `response.reasoning_summary_text.delta`.
        end

        class ResponseReasoningSummaryTextWsDone < OpenAI::Models::Responses::ResponseReasoningSummaryTextDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, summary_index:, text:, stream_id: nil, type: :"response.reasoning_summary_text.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDone}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.reasoning_summary_text.done"] The type of the event. Always `response.reasoning_summary_text.done`.
        end

        class ResponseReasoningTextWsDelta < OpenAI::Models::Responses::ResponseReasoningTextDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, delta:, item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.reasoning_text.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningTextWsDelta}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.reasoning_text.delta"] The type of the event. Always `response.reasoning_text.delta`.
        end

        class ResponseReasoningTextWsDone < OpenAI::Models::Responses::ResponseReasoningTextDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, item_id:, output_index:, sequence_number:, text:, stream_id: nil, type: :"response.reasoning_text.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningTextWsDone}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.reasoning_text.done"] The type of the event. Always `response.reasoning_text.done`.
        end

        class ResponseRefusalWsDelta < OpenAI::Models::Responses::ResponseRefusalDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, delta:, item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.refusal.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseRefusalWsDelta} for
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.refusal.delta"] The type of the event. Always `response.refusal.delta`.
        end

        class ResponseRefusalWsDone < OpenAI::Models::Responses::ResponseRefusalDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, item_id:, output_index:, refusal:, sequence_number:, stream_id: nil, type: :"response.refusal.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseRefusalWsDone} for
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.refusal.done"] The type of the event. Always `response.refusal.done`.
        end

        class ResponseTextWsDelta < OpenAI::Models::Responses::ResponseTextDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, delta:, item_id:, logprobs:, output_index:, sequence_number:, stream_id: nil, type: :"response.output_text.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseTextWsDelta} for more
          #   details.
          #
          #   Emitted when there is an additional text delta.
          #
          #   @param content_index [Integer] The index of the content part that the text delta was added to.
          #
          #   @param delta [String] The text delta that was added.
          #
          #   @param item_id [String] The ID of the output item that the text delta was added to.
          #
          #   @param logprobs [Array<OpenAI::Models::Responses::ResponseTextDeltaEvent::Logprob>] The log probabilities of the tokens in the delta.
          #
          #   @param output_index [Integer] The index of the output item that the text delta was added to.
          #
          #   @param sequence_number [Integer] The sequence number for this event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.output_text.delta"] The type of the event. Always `response.output_text.delta`.
        end

        class ResponseTextWsDone < OpenAI::Models::Responses::ResponseTextDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(content_index:, item_id:, logprobs:, output_index:, sequence_number:, text:, stream_id: nil, type: :"response.output_text.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseTextWsDone} for more
          #   details.
          #
          #   Emitted when text content is finalized.
          #
          #   @param content_index [Integer] The index of the content part that the text content is finalized.
          #
          #   @param item_id [String] The ID of the output item that the text content is finalized.
          #
          #   @param logprobs [Array<OpenAI::Models::Responses::ResponseTextDoneEvent::Logprob>] The log probabilities of the tokens in the delta.
          #
          #   @param output_index [Integer] The index of the output item that the text content is finalized.
          #
          #   @param sequence_number [Integer] The sequence number for this event.
          #
          #   @param text [String] The text content that is finalized.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.output_text.done"] The type of the event. Always `response.output_text.done`.
        end

        class ResponseWebSearchCallWsCompleted < OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.web_search_call.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWebSearchCallWsCompleted}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.web_search_call.completed"] The type of the event. Always `response.web_search_call.completed`.
        end

        class ResponseWebSearchCallInWsProgress < OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.web_search_call.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWebSearchCallInWsProgress}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.web_search_call.in_progress"] The type of the event. Always `response.web_search_call.in_progress`.
        end

        class ResponseWebSearchCallWsSearching < OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.web_search_call.searching")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWebSearchCallWsSearching}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.web_search_call.searching"] The type of the event. Always `response.web_search_call.searching`.
        end

        class ResponseImageGenCallWsCompleted < OpenAI::Models::Responses::ResponseImageGenCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.image_generation_call.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallWsCompleted}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.image_generation_call.completed"] The type of the event. Always 'response.image_generation_call.completed'.
        end

        class ResponseImageGenCallWsGenerating < OpenAI::Models::Responses::ResponseImageGenCallGeneratingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.image_generation_call.generating")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallWsGenerating}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.image_generation_call.generating"] The type of the event. Always 'response.image_generation_call.generating'.
        end

        class ResponseImageGenCallInWsProgress < OpenAI::Models::Responses::ResponseImageGenCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.image_generation_call.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallInWsProgress}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.image_generation_call.in_progress"] The type of the event. Always 'response.image_generation_call.in_progress'.
        end

        class ResponseImageGenCallPartialWsImage < OpenAI::Models::Responses::ResponseImageGenCallPartialImageEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, partial_image_b64:, partial_image_index:, sequence_number:, background: nil, output_format: nil, quality: nil, size: nil, stream_id: nil, type: :"response.image_generation_call.partial_image")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallPartialWsImage}
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

        class ResponseMcpCallArgumentsWsDelta < OpenAI::Models::Responses::ResponseMcpCallArgumentsDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(delta:, item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.mcp_call_arguments.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDelta}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_call_arguments.delta"] The type of the event. Always 'response.mcp_call_arguments.delta'.
        end

        class ResponseMcpCallArgumentsWsDone < OpenAI::Models::Responses::ResponseMcpCallArgumentsDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(arguments:, item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.mcp_call_arguments.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDone}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_call_arguments.done"] The type of the event. Always 'response.mcp_call_arguments.done'.
        end

        class ResponseMcpCallWsCompleted < OpenAI::Models::Responses::ResponseMcpCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.mcp_call.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallWsCompleted}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_call.completed"] The type of the event. Always 'response.mcp_call.completed'.
        end

        class ResponseMcpCallWsFailed < OpenAI::Models::Responses::ResponseMcpCallFailedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.mcp_call.failed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallWsFailed} for
          #   more details.
          #
          #   Emitted when an MCP tool call has failed.
          #
          #   @param item_id [String] The ID of the MCP tool call item that failed.
          #
          #   @param output_index [Integer] The index of the output item that failed.
          #
          #   @param sequence_number [Integer] The sequence number of this event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_call.failed"] The type of the event. Always 'response.mcp_call.failed'.
        end

        class ResponseMcpCallInWsProgress < OpenAI::Models::Responses::ResponseMcpCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.mcp_call.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallInWsProgress}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_call.in_progress"] The type of the event. Always 'response.mcp_call.in_progress'.
        end

        class ResponseMcpListToolsWsCompleted < OpenAI::Models::Responses::ResponseMcpListToolsCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.mcp_list_tools.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpListToolsWsCompleted}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_list_tools.completed"] The type of the event. Always 'response.mcp_list_tools.completed'.
        end

        class ResponseMcpListToolsWsFailed < OpenAI::Models::Responses::ResponseMcpListToolsFailedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.mcp_list_tools.failed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpListToolsWsFailed}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_list_tools.failed"] The type of the event. Always 'response.mcp_list_tools.failed'.
        end

        class ResponseMcpListToolsInWsProgress < OpenAI::Models::Responses::ResponseMcpListToolsInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.mcp_list_tools.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpListToolsInWsProgress}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.mcp_list_tools.in_progress"] The type of the event. Always 'response.mcp_list_tools.in_progress'.
        end

        class ResponseOutputTextAnnotationWsAdded < OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(annotation:, annotation_index:, content_index:, item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.output_text.annotation.added")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseOutputTextAnnotationWsAdded}
          #   for more details.
          #
          #   Emitted when an annotation is added to output text content.
          #
          #   @param annotation [OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::FileCitation, OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::URLCitation, OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::ContainerFileCitation, OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::FilePath, nil] An annotation that applies to a span of output text.
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.output_text.annotation.added"] The type of the event. Always 'response.output_text.annotation.added'.
        end

        class ResponseWsQueued < OpenAI::Models::Responses::ResponseQueuedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(response:, sequence_number:, stream_id: nil, type: :"response.queued")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsQueued} for more
          #   details.
          #
          #   Emitted when a response is queued and waiting to be processed.
          #
          #   @param response [OpenAI::Models::Responses::Response] The full response object that is queued.
          #
          #   @param sequence_number [Integer] The sequence number for this event.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.queued"] The type of the event. Always 'response.queued'.
        end

        class ResponseCustomToolCallInputWsDelta < OpenAI::Models::Responses::ResponseCustomToolCallInputDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(delta:, item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.custom_tool_call_input.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDelta}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.custom_tool_call_input.delta"] The event type identifier.
        end

        class ResponseCustomToolCallInputWsDone < OpenAI::Models::Responses::ResponseCustomToolCallInputDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(input:, item_id:, output_index:, sequence_number:, stream_id: nil, type: :"response.custom_tool_call_input.done")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDone}
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
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
          #
          #   @param type [Symbol, :"response.custom_tool_call_input.done"] The event type identifier.
        end

        class ResponseWsError < OpenAI::Internal::Type::BaseModel
          # @!attribute error
          #   Details about the error.
          #
          #   @return [OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError::Error]
          required :error, -> { OpenAI::Responses::ResponsesServerEvent::ResponseWsError::Error }

          # @!attribute type
          #   The type of the event. Always `error`.
          #
          #   @return [Symbol, :error]
          required :type, const: :error

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

          # @!method initialize(error:, sequence_number: nil, status: nil, stream_id: nil, type: :error)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError} for more
          #   details.
          #
          #   Emitted when an error occurs while processing a Responses WebSocket request.
          #
          #   @param error [OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError::Error] Details about the error.
          #
          #   @param sequence_number [Integer] The sequence number of an error emitted by the response stream.
          #
          #   @param status [Integer] The HTTP status code associated with a WebSocket protocol error.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present when the
          #
          #   @param type [Symbol, :error] The type of the event. Always `error`.

          # @see OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError#error
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
            #   @return [OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment, nil]
            optional(
              :misalignment,
              -> { OpenAI::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment }
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
            #   @param misalignment [OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment]

            # @see OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError::Error#misalignment
            class Misalignment < OpenAI::Internal::Type::BaseModel
              # @!attribute detailed_explanation
              #   The public explanation for this block.
              #
              #   @return [String, nil]
              optional :detailed_explanation, String

              # @!attribute error_type
              #   An optional classification; clients must accept additional values.
              #
              #   @return [String, Symbol, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment::ErrorType, nil]
              optional(
                :error_type,
                union: -> { OpenAI::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment::ErrorType }
              )

              # @!attribute steer
              #   An optional public continuation instruction.
              #
              #   @return [OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment::Steer, nil]
              optional(
                :steer,
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment::Steer }
              )

              # @!method initialize(detailed_explanation: nil, error_type: nil, steer: nil)
              #   @param detailed_explanation [String] The public explanation for this block.
              #
              #   @param error_type [String, Symbol, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment::ErrorType] An optional classification; clients must accept additional values.
              #
              #   @param steer [OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment::Steer] An optional public continuation instruction.

              # An optional classification; clients must accept additional values.
              #
              # @see OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment#error_type
              module ErrorType
                extend OpenAI::Internal::Type::Union

                variant String

                variant(
                  const: -> {
                    OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment::ErrorType::POTENTIALLY_UNINTENDED_DATA_TRANSFER
                  }
                )

                variant(
                  const: -> {
                    OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment::ErrorType::POTENTIALLY_UNINTENDED_DATA_ACCESS
                  }
                )

                variant(
                  const: -> {
                    OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment::ErrorType::POTENTIALLY_UNINTENDED_DESTRUCTIVE_ACTIVITY
                  }
                )

                variant(
                  const: -> {
                    OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment::ErrorType::OTHER
                  }
                )

                # @!method self.variants
                #   @return [Array(String, Symbol)]

                define_sorbet_constant!(:Variants) do
                  T.type_alias do
                    T.any(
                      String,
                      OpenAI::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment::ErrorType::TaggedSymbol
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

              # @see OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError::Error::Misalignment#steer
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
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError, OpenAI::Models::Responses::ResponseSteerAcceptedEvent, OpenAI::Models::Responses::ResponseSteerPendingEvent, OpenAI::Models::Responses::ResponseSteerFailedEvent, OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsCompleted, OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallInWsProgress, OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsInterpreting, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsCompleted, OpenAI::Models::Responses::ResponsesServerEvent::ResponseContentPartWsAdded, OpenAI::Models::Responses::ResponsesServerEvent::ResponseContentPartWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsCreated, OpenAI::Models::Responses::ResponsesServerEvent::ResponseFileSearchCallWsCompleted, OpenAI::Models::Responses::ResponsesServerEvent::ResponseFileSearchCallInWsProgress, OpenAI::Models::Responses::ResponsesServerEvent::ResponseFileSearchCallWsSearching, OpenAI::Models::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseShellCallCommandWsAdded, OpenAI::Models::Responses::ResponsesServerEvent::ResponseShellCallCommandWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseShellCallCommandWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseShellCallOutputContentWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseShellCallOutputContentWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseInWsProgress, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsFailed, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsIncomplete, OpenAI::Models::Responses::ResponsesServerEvent::ResponseOutputItemWsAdded, OpenAI::Models::Responses::ResponsesServerEvent::ResponseOutputItemWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsAdded, OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningTextWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningTextWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseRefusalWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseRefusalWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseTextWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseTextWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWebSearchCallWsCompleted, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWebSearchCallInWsProgress, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWebSearchCallWsSearching, OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallWsCompleted, OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallWsGenerating, OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallInWsProgress, OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallPartialWsImage, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallWsCompleted, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallWsFailed, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallInWsProgress, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpListToolsWsCompleted, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpListToolsWsFailed, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpListToolsInWsProgress, OpenAI::Models::Responses::ResponsesServerEvent::ResponseOutputTextAnnotationWsAdded, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsQueued, OpenAI::Models::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDone)]
      end
    end
  end
end
