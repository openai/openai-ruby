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
        variant :"response.audio.transcript.delta",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDelta }

        # Emitted when the full audio transcript is completed.
        variant :"response.audio.transcript.done",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDone }

        # Emitted when a partial code snippet is streamed by the code interpreter.
        variant :"response.code_interpreter_call_code.delta",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDelta }

        # Emitted when the code snippet is finalized by the code interpreter.
        variant :"response.code_interpreter_call_code.done",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDone }

        # Emitted when the code interpreter call is completed.
        variant :"response.code_interpreter_call.completed",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsCompleted }

        # Emitted when a code interpreter call is in progress.
        variant :"response.code_interpreter_call.in_progress",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallInWsProgress }

        # Emitted when the code interpreter is actively interpreting the code snippet.
        variant :"response.code_interpreter_call.interpreting",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsInterpreting }

        # Emitted when the model response is complete.
        variant :"response.completed", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsCompleted }

        # Emitted when a new content part is added.
        variant :"response.content_part.added",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsAdded }

        # Emitted when a content part is done.
        variant :"response.content_part.done",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsDone }

        # An event that is emitted when a response is created.
        variant :"response.created", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsCreated }

        # Emitted when a file search call is completed (results found).
        variant :"response.file_search_call.completed",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsCompleted }

        # Emitted when a file search call is initiated.
        variant :"response.file_search_call.in_progress",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallInWsProgress }

        # Emitted when a file search is currently searching.
        variant :"response.file_search_call.searching",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsSearching }

        # Emitted when there is a partial function-call arguments delta.
        variant :"response.function_call_arguments.delta",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDelta }

        # Emitted when function-call arguments are finalized.
        variant :"response.function_call_arguments.done",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDone }

        # Emitted when the response is in progress.
        variant :"response.in_progress", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseInWsProgress }

        # An event that is emitted when a response fails.
        variant :"response.failed", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsFailed }

        # An event that is emitted when a response finishes as incomplete.
        variant :"response.incomplete", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsIncomplete }

        # Emitted when a new output item is added.
        variant :"response.output_item.added",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsAdded }

        # Emitted when an output item is marked done.
        variant :"response.output_item.done",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsDone }

        # Emitted when a new reasoning summary part is added.
        variant :"response.reasoning_summary_part.added",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsAdded }

        # Emitted when a reasoning summary part is completed.
        variant :"response.reasoning_summary_part.done",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsDone }

        # Emitted when a delta is added to a reasoning summary text.
        variant :"response.reasoning_summary_text.delta",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDelta }

        # Emitted when a reasoning summary text is completed.
        variant :"response.reasoning_summary_text.done",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDone }

        # Emitted when a delta is added to a reasoning text.
        variant :"response.reasoning_text.delta",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDelta }

        # Emitted when a reasoning text is completed.
        variant :"response.reasoning_text.done",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDone }

        # Emitted when there is a partial refusal text.
        variant :"response.refusal.delta",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDelta }

        # Emitted when refusal text is finalized.
        variant :"response.refusal.done", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDone }

        # Emitted when there is an additional text delta.
        variant :"response.output_text.delta",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseTextWsDelta }

        # Emitted when text content is finalized.
        variant :"response.output_text.done",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseTextWsDone }

        # Emitted when a web search call is completed.
        variant :"response.web_search_call.completed",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsCompleted }

        # Emitted when a web search call is initiated.
        variant :"response.web_search_call.in_progress",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallInWsProgress }

        # Emitted when a web search call is executing.
        variant :"response.web_search_call.searching",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsSearching }

        # Emitted when an image generation tool call has completed and the final image is available.
        variant :"response.image_generation_call.completed",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsCompleted }

        # Emitted when an image generation tool call is actively generating an image (intermediate state).
        variant :"response.image_generation_call.generating",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsGenerating }

        # Emitted when an image generation tool call is in progress.
        variant :"response.image_generation_call.in_progress",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallInWsProgress }

        # Emitted when a partial image is available during image generation streaming.
        variant :"response.image_generation_call.partial_image",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallPartialWsImage }

        # Emitted when there is a delta (partial update) to the arguments of an MCP tool call.
        variant :"response.mcp_call_arguments.delta",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDelta }

        # Emitted when the arguments for an MCP tool call are finalized.
        variant :"response.mcp_call_arguments.done",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDone }

        # Emitted when an MCP  tool call has completed successfully.
        variant :"response.mcp_call.completed",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsCompleted }

        # Emitted when an MCP  tool call has failed.
        variant :"response.mcp_call.failed",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsFailed }

        # Emitted when an MCP  tool call is in progress.
        variant :"response.mcp_call.in_progress",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallInWsProgress }

        # Emitted when the list of available MCP tools has been successfully retrieved.
        variant :"response.mcp_list_tools.completed",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsCompleted }

        # Emitted when the attempt to list available MCP tools has failed.
        variant :"response.mcp_list_tools.failed",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsFailed }

        # Emitted when the system is in the process of retrieving the list of available MCP tools.
        variant :"response.mcp_list_tools.in_progress",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsInWsProgress }

        # Emitted when an annotation is added to output text content.
        variant :"response.output_text.annotation.added",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseOutputTextAnnotationWsAdded }

        # Emitted when a response is queued and waiting to be processed.
        variant :"response.queued", -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsQueued }

        # Event representing a delta (partial update) to the input of a custom tool call.
        variant :"response.custom_tool_call_input.delta",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDelta }

        # Event indicating that input for a custom tool call is complete.
        variant :"response.custom_tool_call_input.done",
                -> { OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDone }

        class BetaResponseAudioWsDelta < OpenAI::Models::Beta::BetaResponseAudioDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioWsDelta} for
          #   more details.
          #
          #   Emitted when there is a partial audio response.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseAudioWsDone < OpenAI::Models::Beta::BetaResponseAudioDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioWsDone} for
          #   more details.
          #
          #   Emitted when the audio response is complete.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseAudioTranscriptWsDelta < OpenAI::Models::Beta::BetaResponseAudioTranscriptDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDelta}
          #   for more details.
          #
          #   Emitted when there is a partial transcript of audio.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseAudioTranscriptWsDone < OpenAI::Models::Beta::BetaResponseAudioTranscriptDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDone}
          #   for more details.
          #
          #   Emitted when the full audio transcript is completed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseCodeInterpreterCallCodeWsDelta < OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDelta}
          #   for more details.
          #
          #   Emitted when a partial code snippet is streamed by the code interpreter.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseCodeInterpreterCallCodeWsDone < OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDone}
          #   for more details.
          #
          #   Emitted when the code snippet is finalized by the code interpreter.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseCodeInterpreterCallWsCompleted < OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsCompleted}
          #   for more details.
          #
          #   Emitted when the code interpreter call is completed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseCodeInterpreterCallInWsProgress < OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallInWsProgress}
          #   for more details.
          #
          #   Emitted when a code interpreter call is in progress.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseCodeInterpreterCallWsInterpreting < OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInterpretingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsInterpreting}
          #   for more details.
          #
          #   Emitted when the code interpreter is actively interpreting the code snippet.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseWsCompleted < OpenAI::Models::Beta::BetaResponseCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsCompleted} for
          #   more details.
          #
          #   Emitted when the model response is complete.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseContentPartWsAdded < OpenAI::Models::Beta::BetaResponseContentPartAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsAdded}
          #   for more details.
          #
          #   Emitted when a new content part is added.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseContentPartWsDone < OpenAI::Models::Beta::BetaResponseContentPartDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsDone}
          #   for more details.
          #
          #   Emitted when a content part is done.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseWsCreated < OpenAI::Models::Beta::BetaResponseCreatedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsCreated} for more
          #   details.
          #
          #   An event that is emitted when a response is created.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseFileSearchCallWsCompleted < OpenAI::Models::Beta::BetaResponseFileSearchCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsCompleted}
          #   for more details.
          #
          #   Emitted when a file search call is completed (results found).
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseFileSearchCallInWsProgress < OpenAI::Models::Beta::BetaResponseFileSearchCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallInWsProgress}
          #   for more details.
          #
          #   Emitted when a file search call is initiated.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseFileSearchCallWsSearching < OpenAI::Models::Beta::BetaResponseFileSearchCallSearchingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsSearching}
          #   for more details.
          #
          #   Emitted when a file search is currently searching.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseFunctionCallArgumentsWsDelta < OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDelta}
          #   for more details.
          #
          #   Emitted when there is a partial function-call arguments delta.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseFunctionCallArgumentsWsDone < OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDone}
          #   for more details.
          #
          #   Emitted when function-call arguments are finalized.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseInWsProgress < OpenAI::Models::Beta::BetaResponseInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseInWsProgress} for
          #   more details.
          #
          #   Emitted when the response is in progress.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseWsFailed < OpenAI::Models::Beta::BetaResponseFailedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsFailed} for more
          #   details.
          #
          #   An event that is emitted when a response fails.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseWsIncomplete < OpenAI::Models::Beta::BetaResponseIncompleteEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsIncomplete} for
          #   more details.
          #
          #   An event that is emitted when a response finishes as incomplete.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseOutputItemWsAdded < OpenAI::Models::Beta::BetaResponseOutputItemAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsAdded}
          #   for more details.
          #
          #   Emitted when a new output item is added.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseOutputItemWsDone < OpenAI::Models::Beta::BetaResponseOutputItemDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsDone}
          #   for more details.
          #
          #   Emitted when an output item is marked done.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseReasoningSummaryPartWsAdded < OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsAdded}
          #   for more details.
          #
          #   Emitted when a new reasoning summary part is added.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseReasoningSummaryPartWsDone < OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsDone}
          #   for more details.
          #
          #   Emitted when a reasoning summary part is completed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseReasoningSummaryTextWsDelta < OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDelta}
          #   for more details.
          #
          #   Emitted when a delta is added to a reasoning summary text.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseReasoningSummaryTextWsDone < OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDone}
          #   for more details.
          #
          #   Emitted when a reasoning summary text is completed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseReasoningTextWsDelta < OpenAI::Models::Beta::BetaResponseReasoningTextDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDelta}
          #   for more details.
          #
          #   Emitted when a delta is added to a reasoning text.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseReasoningTextWsDone < OpenAI::Models::Beta::BetaResponseReasoningTextDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDone}
          #   for more details.
          #
          #   Emitted when a reasoning text is completed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseRefusalWsDelta < OpenAI::Models::Beta::BetaResponseRefusalDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDelta} for
          #   more details.
          #
          #   Emitted when there is a partial refusal text.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseRefusalWsDone < OpenAI::Models::Beta::BetaResponseRefusalDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDone} for
          #   more details.
          #
          #   Emitted when refusal text is finalized.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseTextWsDelta < OpenAI::Models::Beta::BetaResponseTextDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseTextWsDelta} for
          #   more details.
          #
          #   Emitted when there is an additional text delta.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseTextWsDone < OpenAI::Models::Beta::BetaResponseTextDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseTextWsDone} for
          #   more details.
          #
          #   Emitted when text content is finalized.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseWebSearchCallWsCompleted < OpenAI::Models::Beta::BetaResponseWebSearchCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsCompleted}
          #   for more details.
          #
          #   Emitted when a web search call is completed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseWebSearchCallInWsProgress < OpenAI::Models::Beta::BetaResponseWebSearchCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallInWsProgress}
          #   for more details.
          #
          #   Emitted when a web search call is initiated.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseWebSearchCallWsSearching < OpenAI::Models::Beta::BetaResponseWebSearchCallSearchingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsSearching}
          #   for more details.
          #
          #   Emitted when a web search call is executing.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseImageGenCallWsCompleted < OpenAI::Models::Beta::BetaResponseImageGenCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsCompleted}
          #   for more details.
          #
          #   Emitted when an image generation tool call has completed and the final image is
          #   available.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseImageGenCallWsGenerating < OpenAI::Models::Beta::BetaResponseImageGenCallGeneratingEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsGenerating}
          #   for more details.
          #
          #   Emitted when an image generation tool call is actively generating an image
          #   (intermediate state).
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseImageGenCallInWsProgress < OpenAI::Models::Beta::BetaResponseImageGenCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallInWsProgress}
          #   for more details.
          #
          #   Emitted when an image generation tool call is in progress.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseImageGenCallPartialWsImage < OpenAI::Models::Beta::BetaResponseImageGenCallPartialImageEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallPartialWsImage}
          #   for more details.
          #
          #   Emitted when a partial image is available during image generation streaming.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseMcpCallArgumentsWsDelta < OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDelta}
          #   for more details.
          #
          #   Emitted when there is a delta (partial update) to the arguments of an MCP tool
          #   call.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseMcpCallArgumentsWsDone < OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDone}
          #   for more details.
          #
          #   Emitted when the arguments for an MCP tool call are finalized.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseMcpCallWsCompleted < OpenAI::Models::Beta::BetaResponseMcpCallCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsCompleted}
          #   for more details.
          #
          #   Emitted when an MCP tool call has completed successfully.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseMcpCallWsFailed < OpenAI::Models::Beta::BetaResponseMcpCallFailedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsFailed}
          #   for more details.
          #
          #   Emitted when an MCP tool call has failed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseMcpCallInWsProgress < OpenAI::Models::Beta::BetaResponseMcpCallInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallInWsProgress}
          #   for more details.
          #
          #   Emitted when an MCP tool call is in progress.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseMcpListToolsWsCompleted < OpenAI::Models::Beta::BetaResponseMcpListToolsCompletedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsCompleted}
          #   for more details.
          #
          #   Emitted when the list of available MCP tools has been successfully retrieved.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseMcpListToolsWsFailed < OpenAI::Models::Beta::BetaResponseMcpListToolsFailedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsFailed}
          #   for more details.
          #
          #   Emitted when the attempt to list available MCP tools has failed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseMcpListToolsInWsProgress < OpenAI::Models::Beta::BetaResponseMcpListToolsInProgressEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsInWsProgress}
          #   for more details.
          #
          #   Emitted when the system is in the process of retrieving the list of available
          #   MCP tools.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseOutputTextAnnotationWsAdded < OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseOutputTextAnnotationWsAdded}
          #   for more details.
          #
          #   Emitted when an annotation is added to output text content.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseWsQueued < OpenAI::Models::Beta::BetaResponseQueuedEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsQueued} for more
          #   details.
          #
          #   Emitted when a response is queued and waiting to be processed.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseCustomToolCallInputWsDelta < OpenAI::Models::Beta::BetaResponseCustomToolCallInputDeltaEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDelta}
          #   for more details.
          #
          #   Event representing a delta (partial update) to the input of a custom tool call.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
        end

        class BetaResponseCustomToolCallInputWsDone < OpenAI::Models::Beta::BetaResponseCustomToolCallInputDoneEvent
          # @!attribute stream_id
          #   The WebSocket lane that emitted this event. This field is present when the
          #   originating `response.create` event supplied a `stream_id`.
          #
          #   @return [String, nil]
          optional :stream_id, String

          # @!method initialize(stream_id: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDone}
          #   for more details.
          #
          #   Event indicating that input for a custom tool call is complete.
          #
          #   @param stream_id [String] The WebSocket lane that emitted this event. This field is present
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
          optional :agent,
                   -> {
                     OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Agent
                   },
                   nil?: true

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
        #   @return [Array(OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsError, OpenAI::Models::Beta::BetaResponseInjectCreatedEvent, OpenAI::Models::Beta::BetaResponseInjectFailedEvent, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsCompleted, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallInWsProgress, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsInterpreting, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsCompleted, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsAdded, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsCreated, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsCompleted, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallInWsProgress, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsSearching, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseInWsProgress, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsFailed, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsIncomplete, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsAdded, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsAdded, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseTextWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseTextWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsCompleted, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallInWsProgress, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsSearching, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsCompleted, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsGenerating, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallInWsProgress, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallPartialWsImage, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDone, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsCompleted, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsFailed, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpCallInWsProgress, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsCompleted, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsFailed, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsInWsProgress, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseOutputTextAnnotationWsAdded, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseWsQueued, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDelta, OpenAI::Models::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDone)]
      end
    end

    BetaResponsesServerEvent = Beta::BetaResponsesServerEvent
  end
end
