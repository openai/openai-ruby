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

        # Emitted when there is a partial audio response.
        variant :"response.audio.delta", -> { OpenAI::Responses::ResponsesServerEvent::ResponseAudioWsDelta }

        # Emitted when the audio response is complete.
        variant :"response.audio.done", -> { OpenAI::Responses::ResponsesServerEvent::ResponseAudioWsDone }

        # Emitted when there is a partial transcript of audio.
        variant :"response.audio.transcript.delta",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDelta }

        # Emitted when the full audio transcript is completed.
        variant :"response.audio.transcript.done",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDone }

        # Emitted when a partial code snippet is streamed by the code interpreter.
        variant :"response.code_interpreter_call_code.delta",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDelta }

        # Emitted when the code snippet is finalized by the code interpreter.
        variant :"response.code_interpreter_call_code.done",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDone }

        # Emitted when the code interpreter call is completed.
        variant :"response.code_interpreter_call.completed",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsCompleted }

        # Emitted when a code interpreter call is in progress.
        variant :"response.code_interpreter_call.in_progress",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallInWsProgress }

        # Emitted when the code interpreter is actively interpreting the code snippet.
        variant :"response.code_interpreter_call.interpreting",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsInterpreting }

        # Emitted when the model response is complete.
        variant :"response.completed", -> { OpenAI::Responses::ResponsesServerEvent::ResponseWsCompleted }

        # Emitted when a new content part is added.
        variant :"response.content_part.added",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseContentPartWsAdded }

        # Emitted when a content part is done.
        variant :"response.content_part.done",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseContentPartWsDone }

        # An event that is emitted when a response is created.
        variant :"response.created", -> { OpenAI::Responses::ResponsesServerEvent::ResponseWsCreated }

        # Emitted when a file search call is completed (results found).
        variant :"response.file_search_call.completed",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseFileSearchCallWsCompleted }

        # Emitted when a file search call is initiated.
        variant :"response.file_search_call.in_progress",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseFileSearchCallInWsProgress }

        # Emitted when a file search is currently searching.
        variant :"response.file_search_call.searching",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseFileSearchCallWsSearching }

        # Emitted when there is a partial function-call arguments delta.
        variant :"response.function_call_arguments.delta",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDelta }

        # Emitted when function-call arguments are finalized.
        variant :"response.function_call_arguments.done",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDone }

        # Emitted when the response is in progress.
        variant :"response.in_progress", -> { OpenAI::Responses::ResponsesServerEvent::ResponseInWsProgress }

        # An event that is emitted when a response fails.
        variant :"response.failed", -> { OpenAI::Responses::ResponsesServerEvent::ResponseWsFailed }

        # An event that is emitted when a response finishes as incomplete.
        variant :"response.incomplete", -> { OpenAI::Responses::ResponsesServerEvent::ResponseWsIncomplete }

        # Emitted when a new output item is added.
        variant :"response.output_item.added",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseOutputItemWsAdded }

        # Emitted when an output item is marked done.
        variant :"response.output_item.done",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseOutputItemWsDone }

        # Emitted when a new reasoning summary part is added.
        variant :"response.reasoning_summary_part.added",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsAdded }

        # Emitted when a reasoning summary part is completed.
        variant :"response.reasoning_summary_part.done",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsDone }

        # Emitted when a delta is added to a reasoning summary text.
        variant :"response.reasoning_summary_text.delta",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDelta }

        # Emitted when a reasoning summary text is completed.
        variant :"response.reasoning_summary_text.done",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDone }

        # Emitted when a delta is added to a reasoning text.
        variant :"response.reasoning_text.delta",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseReasoningTextWsDelta }

        # Emitted when a reasoning text is completed.
        variant :"response.reasoning_text.done",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseReasoningTextWsDone }

        # Emitted when there is a partial refusal text.
        variant :"response.refusal.delta", -> { OpenAI::Responses::ResponsesServerEvent::ResponseRefusalWsDelta }

        # Emitted when refusal text is finalized.
        variant :"response.refusal.done", -> { OpenAI::Responses::ResponsesServerEvent::ResponseRefusalWsDone }

        # Emitted when there is an additional text delta.
        variant :"response.output_text.delta", -> { OpenAI::Responses::ResponsesServerEvent::ResponseTextWsDelta }

        # Emitted when text content is finalized.
        variant :"response.output_text.done", -> { OpenAI::Responses::ResponsesServerEvent::ResponseTextWsDone }

        # Emitted when a web search call is completed.
        variant :"response.web_search_call.completed",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseWebSearchCallWsCompleted }

        # Emitted when a web search call is initiated.
        variant :"response.web_search_call.in_progress",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseWebSearchCallInWsProgress }

        # Emitted when a web search call is executing.
        variant :"response.web_search_call.searching",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseWebSearchCallWsSearching }

        # Emitted when an image generation tool call has completed and the final image is available.
        variant :"response.image_generation_call.completed",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallWsCompleted }

        # Emitted when an image generation tool call is actively generating an image (intermediate state).
        variant :"response.image_generation_call.generating",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallWsGenerating }

        # Emitted when an image generation tool call is in progress.
        variant :"response.image_generation_call.in_progress",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallInWsProgress }

        # Emitted when a partial image is available during image generation streaming.
        variant :"response.image_generation_call.partial_image",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallPartialWsImage }

        # Emitted when there is a delta (partial update) to the arguments of an MCP tool call.
        variant :"response.mcp_call_arguments.delta",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDelta }

        # Emitted when the arguments for an MCP tool call are finalized.
        variant :"response.mcp_call_arguments.done",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDone }

        # Emitted when an MCP  tool call has completed successfully.
        variant :"response.mcp_call.completed",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallWsCompleted }

        # Emitted when an MCP  tool call has failed.
        variant :"response.mcp_call.failed",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallWsFailed }

        # Emitted when an MCP  tool call is in progress.
        variant :"response.mcp_call.in_progress",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallInWsProgress }

        # Emitted when the list of available MCP tools has been successfully retrieved.
        variant :"response.mcp_list_tools.completed",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpListToolsWsCompleted }

        # Emitted when the attempt to list available MCP tools has failed.
        variant :"response.mcp_list_tools.failed",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpListToolsWsFailed }

        # Emitted when the system is in the process of retrieving the list of available MCP tools.
        variant :"response.mcp_list_tools.in_progress",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseMcpListToolsInWsProgress }

        # Emitted when an annotation is added to output text content.
        variant :"response.output_text.annotation.added",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseOutputTextAnnotationWsAdded }

        # Emitted when a response is queued and waiting to be processed.
        variant :"response.queued", -> { OpenAI::Responses::ResponsesServerEvent::ResponseWsQueued }

        # Event representing a delta (partial update) to the input of a custom tool call.
        variant :"response.custom_tool_call_input.delta",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDelta }

        # Event indicating that input for a custom tool call is complete.
        variant :"response.custom_tool_call_input.done",
                -> { OpenAI::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDone }

        class ResponseAudioWsDelta < OpenAI::Models::Responses::ResponseAudioDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioWsDelta} for more
          #   details.
          #
          #   Emitted when there is a partial audio response.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseAudioWsDone < OpenAI::Models::Responses::ResponseAudioDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioWsDone} for more
          #   details.
          #
          #   Emitted when the audio response is complete.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseAudioTranscriptWsDelta < OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDelta}
          #   for more details.
          #
          #   Emitted when there is a partial transcript of audio.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseAudioTranscriptWsDone < OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDone}
          #   for more details.
          #
          #   Emitted when the full audio transcript is completed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseCodeInterpreterCallCodeWsDelta < OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDelta}
          #   for more details.
          #
          #   Emitted when a partial code snippet is streamed by the code interpreter.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseCodeInterpreterCallCodeWsDone < OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDone}
          #   for more details.
          #
          #   Emitted when the code snippet is finalized by the code interpreter.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseCodeInterpreterCallWsCompleted < OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsCompleted}
          #   for more details.
          #
          #   Emitted when the code interpreter call is completed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseCodeInterpreterCallInWsProgress < OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallInWsProgress}
          #   for more details.
          #
          #   Emitted when a code interpreter call is in progress.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseCodeInterpreterCallWsInterpreting < OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsInterpreting}
          #   for more details.
          #
          #   Emitted when the code interpreter is actively interpreting the code snippet.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseWsCompleted < OpenAI::Models::Responses::ResponseCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsCompleted} for more
          #   details.
          #
          #   Emitted when the model response is complete.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseContentPartWsAdded < OpenAI::Models::Responses::ResponseContentPartAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseContentPartWsAdded}
          #   for more details.
          #
          #   Emitted when a new content part is added.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseContentPartWsDone < OpenAI::Models::Responses::ResponseContentPartDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseContentPartWsDone} for
          #   more details.
          #
          #   Emitted when a content part is done.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseWsCreated < OpenAI::Models::Responses::ResponseCreatedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsCreated} for more
          #   details.
          #
          #   An event that is emitted when a response is created.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseFileSearchCallWsCompleted < OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseFileSearchCallWsCompleted}
          #   for more details.
          #
          #   Emitted when a file search call is completed (results found).
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseFileSearchCallInWsProgress < OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseFileSearchCallInWsProgress}
          #   for more details.
          #
          #   Emitted when a file search call is initiated.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseFileSearchCallWsSearching < OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseFileSearchCallWsSearching}
          #   for more details.
          #
          #   Emitted when a file search is currently searching.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseFunctionCallArgumentsWsDelta < OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDelta}
          #   for more details.
          #
          #   Emitted when there is a partial function-call arguments delta.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseFunctionCallArgumentsWsDone < OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDone}
          #   for more details.
          #
          #   Emitted when function-call arguments are finalized.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseInWsProgress < OpenAI::Models::Responses::ResponseInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseInWsProgress} for more
          #   details.
          #
          #   Emitted when the response is in progress.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseWsFailed < OpenAI::Models::Responses::ResponseFailedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsFailed} for more
          #   details.
          #
          #   An event that is emitted when a response fails.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseWsIncomplete < OpenAI::Models::Responses::ResponseIncompleteEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsIncomplete} for more
          #   details.
          #
          #   An event that is emitted when a response finishes as incomplete.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseOutputItemWsAdded < OpenAI::Models::Responses::ResponseOutputItemAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseOutputItemWsAdded} for
          #   more details.
          #
          #   Emitted when a new output item is added.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseOutputItemWsDone < OpenAI::Models::Responses::ResponseOutputItemDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseOutputItemWsDone} for
          #   more details.
          #
          #   Emitted when an output item is marked done.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseReasoningSummaryPartWsAdded < OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsAdded}
          #   for more details.
          #
          #   Emitted when a new reasoning summary part is added.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseReasoningSummaryPartWsDone < OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsDone}
          #   for more details.
          #
          #   Emitted when a reasoning summary part is completed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseReasoningSummaryTextWsDelta < OpenAI::Models::Responses::ResponseReasoningSummaryTextDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDelta}
          #   for more details.
          #
          #   Emitted when a delta is added to a reasoning summary text.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseReasoningSummaryTextWsDone < OpenAI::Models::Responses::ResponseReasoningSummaryTextDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDone}
          #   for more details.
          #
          #   Emitted when a reasoning summary text is completed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseReasoningTextWsDelta < OpenAI::Models::Responses::ResponseReasoningTextDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningTextWsDelta}
          #   for more details.
          #
          #   Emitted when a delta is added to a reasoning text.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseReasoningTextWsDone < OpenAI::Models::Responses::ResponseReasoningTextDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningTextWsDone}
          #   for more details.
          #
          #   Emitted when a reasoning text is completed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseRefusalWsDelta < OpenAI::Models::Responses::ResponseRefusalDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseRefusalWsDelta} for
          #   more details.
          #
          #   Emitted when there is a partial refusal text.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseRefusalWsDone < OpenAI::Models::Responses::ResponseRefusalDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseRefusalWsDone} for
          #   more details.
          #
          #   Emitted when refusal text is finalized.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseTextWsDelta < OpenAI::Models::Responses::ResponseTextDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseTextWsDelta} for more
          #   details.
          #
          #   Emitted when there is an additional text delta.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseTextWsDone < OpenAI::Models::Responses::ResponseTextDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseTextWsDone} for more
          #   details.
          #
          #   Emitted when text content is finalized.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseWebSearchCallWsCompleted < OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWebSearchCallWsCompleted}
          #   for more details.
          #
          #   Emitted when a web search call is completed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseWebSearchCallInWsProgress < OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWebSearchCallInWsProgress}
          #   for more details.
          #
          #   Emitted when a web search call is initiated.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseWebSearchCallWsSearching < OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWebSearchCallWsSearching}
          #   for more details.
          #
          #   Emitted when a web search call is executing.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseImageGenCallWsCompleted < OpenAI::Models::Responses::ResponseImageGenCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallWsCompleted}
          #   for more details.
          #
          #   Emitted when an image generation tool call has completed and the final image is
          #   available.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseImageGenCallWsGenerating < OpenAI::Models::Responses::ResponseImageGenCallGeneratingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallWsGenerating}
          #   for more details.
          #
          #   Emitted when an image generation tool call is actively generating an image
          #   (intermediate state).
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseImageGenCallInWsProgress < OpenAI::Models::Responses::ResponseImageGenCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallInWsProgress}
          #   for more details.
          #
          #   Emitted when an image generation tool call is in progress.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseImageGenCallPartialWsImage < OpenAI::Models::Responses::ResponseImageGenCallPartialImageEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallPartialWsImage}
          #   for more details.
          #
          #   Emitted when a partial image is available during image generation streaming.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseMcpCallArgumentsWsDelta < OpenAI::Models::Responses::ResponseMcpCallArgumentsDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDelta}
          #   for more details.
          #
          #   Emitted when there is a delta (partial update) to the arguments of an MCP tool
          #   call.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseMcpCallArgumentsWsDone < OpenAI::Models::Responses::ResponseMcpCallArgumentsDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDone}
          #   for more details.
          #
          #   Emitted when the arguments for an MCP tool call are finalized.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseMcpCallWsCompleted < OpenAI::Models::Responses::ResponseMcpCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallWsCompleted}
          #   for more details.
          #
          #   Emitted when an MCP tool call has completed successfully.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseMcpCallWsFailed < OpenAI::Models::Responses::ResponseMcpCallFailedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallWsFailed} for
          #   more details.
          #
          #   Emitted when an MCP tool call has failed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseMcpCallInWsProgress < OpenAI::Models::Responses::ResponseMcpCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallInWsProgress}
          #   for more details.
          #
          #   Emitted when an MCP tool call is in progress.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseMcpListToolsWsCompleted < OpenAI::Models::Responses::ResponseMcpListToolsCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpListToolsWsCompleted}
          #   for more details.
          #
          #   Emitted when the list of available MCP tools has been successfully retrieved.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseMcpListToolsWsFailed < OpenAI::Models::Responses::ResponseMcpListToolsFailedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpListToolsWsFailed}
          #   for more details.
          #
          #   Emitted when the attempt to list available MCP tools has failed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseMcpListToolsInWsProgress < OpenAI::Models::Responses::ResponseMcpListToolsInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpListToolsInWsProgress}
          #   for more details.
          #
          #   Emitted when the system is in the process of retrieving the list of available
          #   MCP tools.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseOutputTextAnnotationWsAdded < OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseOutputTextAnnotationWsAdded}
          #   for more details.
          #
          #   Emitted when an annotation is added to output text content.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseWsQueued < OpenAI::Models::Responses::ResponseQueuedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsQueued} for more
          #   details.
          #
          #   Emitted when a response is queued and waiting to be processed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseCustomToolCallInputWsDelta < OpenAI::Models::Responses::ResponseCustomToolCallInputDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDelta}
          #   for more details.
          #
          #   Event representing a delta (partial update) to the input of a custom tool call.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class ResponseCustomToolCallInputWsDone < OpenAI::Models::Responses::ResponseCustomToolCallInputDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDone}
          #   for more details.
          #
          #   Event indicating that input for a custom tool call is complete.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
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

            # @!method initialize(code:, message:, param:, type:, headers: nil)
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
          end
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsError, OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsCompleted, OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallInWsProgress, OpenAI::Models::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsInterpreting, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsCompleted, OpenAI::Models::Responses::ResponsesServerEvent::ResponseContentPartWsAdded, OpenAI::Models::Responses::ResponsesServerEvent::ResponseContentPartWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsCreated, OpenAI::Models::Responses::ResponsesServerEvent::ResponseFileSearchCallWsCompleted, OpenAI::Models::Responses::ResponsesServerEvent::ResponseFileSearchCallInWsProgress, OpenAI::Models::Responses::ResponsesServerEvent::ResponseFileSearchCallWsSearching, OpenAI::Models::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseInWsProgress, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsFailed, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsIncomplete, OpenAI::Models::Responses::ResponsesServerEvent::ResponseOutputItemWsAdded, OpenAI::Models::Responses::ResponsesServerEvent::ResponseOutputItemWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsAdded, OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningTextWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseReasoningTextWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseRefusalWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseRefusalWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseTextWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseTextWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWebSearchCallWsCompleted, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWebSearchCallInWsProgress, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWebSearchCallWsSearching, OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallWsCompleted, OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallWsGenerating, OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallInWsProgress, OpenAI::Models::Responses::ResponsesServerEvent::ResponseImageGenCallPartialWsImage, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDone, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallWsCompleted, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallWsFailed, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpCallInWsProgress, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpListToolsWsCompleted, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpListToolsWsFailed, OpenAI::Models::Responses::ResponsesServerEvent::ResponseMcpListToolsInWsProgress, OpenAI::Models::Responses::ResponsesServerEvent::ResponseOutputTextAnnotationWsAdded, OpenAI::Models::Responses::ResponsesServerEvent::ResponseWsQueued, OpenAI::Models::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDelta, OpenAI::Models::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDone)]
      end
    end
  end
end
