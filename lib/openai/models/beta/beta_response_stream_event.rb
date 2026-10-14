# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # Emitted when there is a partial audio response.
      module BetaResponseStreamEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Emitted when there is a partial audio response.
        variant :"response.audio.delta", -> { OpenAI::Beta::BetaResponseAudioDeltaEvent }

        # Emitted when the audio response is complete.
        variant :"response.audio.done", -> { OpenAI::Beta::BetaResponseAudioDoneEvent }

        # Emitted when there is a partial transcript of audio.
        variant :"response.audio.transcript.delta", -> { OpenAI::Beta::BetaResponseAudioTranscriptDeltaEvent }

        # Emitted when the full audio transcript is completed.
        variant :"response.audio.transcript.done", -> { OpenAI::Beta::BetaResponseAudioTranscriptDoneEvent }

        # Emitted when a partial code snippet is streamed by the code interpreter.
        variant :"response.code_interpreter_call_code.delta",
                -> { OpenAI::Beta::BetaResponseCodeInterpreterCallCodeDeltaEvent }

        # Emitted when the code snippet is finalized by the code interpreter.
        variant :"response.code_interpreter_call_code.done",
                -> { OpenAI::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent }

        # Emitted when the code interpreter call is completed.
        variant :"response.code_interpreter_call.completed",
                -> { OpenAI::Beta::BetaResponseCodeInterpreterCallCompletedEvent }

        # Emitted when a code interpreter call is in progress.
        variant :"response.code_interpreter_call.in_progress",
                -> { OpenAI::Beta::BetaResponseCodeInterpreterCallInProgressEvent }

        # Emitted when the code interpreter is actively interpreting the code snippet.
        variant :"response.code_interpreter_call.interpreting",
                -> { OpenAI::Beta::BetaResponseCodeInterpreterCallInterpretingEvent }

        # Emitted when the model response is complete.
        variant :"response.completed", -> { OpenAI::Beta::BetaResponseCompletedEvent }

        # Emitted when a new content part is added.
        variant :"response.content_part.added", -> { OpenAI::Beta::BetaResponseContentPartAddedEvent }

        # Emitted when a content part is done.
        variant :"response.content_part.done", -> { OpenAI::Beta::BetaResponseContentPartDoneEvent }

        # An event that is emitted when a response is created.
        variant :"response.created", -> { OpenAI::Beta::BetaResponseCreatedEvent }

        # Emitted when an error occurs.
        variant :error, -> { OpenAI::Beta::BetaResponseErrorEvent }

        # Emitted when a file search call is completed (results found).
        variant :"response.file_search_call.completed",
                -> { OpenAI::Beta::BetaResponseFileSearchCallCompletedEvent }

        # Emitted when a file search call is initiated.
        variant :"response.file_search_call.in_progress",
                -> { OpenAI::Beta::BetaResponseFileSearchCallInProgressEvent }

        # Emitted when a file search is currently searching.
        variant :"response.file_search_call.searching",
                -> { OpenAI::Beta::BetaResponseFileSearchCallSearchingEvent }

        # Emitted when there is a partial function-call arguments delta.
        variant :"response.function_call_arguments.delta",
                -> { OpenAI::Beta::BetaResponseFunctionCallArgumentsDeltaEvent }

        # Emitted when function-call arguments are finalized.
        variant :"response.function_call_arguments.done",
                -> { OpenAI::Beta::BetaResponseFunctionCallArgumentsDoneEvent }

        # Emitted when the response is in progress.
        variant :"response.in_progress", -> { OpenAI::Beta::BetaResponseInProgressEvent }

        # An event that is emitted when a response fails.
        variant :"response.failed", -> { OpenAI::Beta::BetaResponseFailedEvent }

        # An event that is emitted when a response finishes as incomplete.
        variant :"response.incomplete", -> { OpenAI::Beta::BetaResponseIncompleteEvent }

        # Emitted when a new output item is added.
        variant :"response.output_item.added", -> { OpenAI::Beta::BetaResponseOutputItemAddedEvent }

        # Emitted when an output item is marked done.
        variant :"response.output_item.done", -> { OpenAI::Beta::BetaResponseOutputItemDoneEvent }

        # Emitted when a new reasoning summary part is added.
        variant :"response.reasoning_summary_part.added",
                -> { OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent }

        # Emitted when a reasoning summary part is completed.
        variant :"response.reasoning_summary_part.done",
                -> { OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent }

        # Emitted when a delta is added to a reasoning summary text.
        variant :"response.reasoning_summary_text.delta",
                -> { OpenAI::Beta::BetaResponseReasoningSummaryTextDeltaEvent }

        # Emitted when a reasoning summary text is completed.
        variant :"response.reasoning_summary_text.done",
                -> { OpenAI::Beta::BetaResponseReasoningSummaryTextDoneEvent }

        # Emitted when a delta is added to a reasoning text.
        variant :"response.reasoning_text.delta", -> { OpenAI::Beta::BetaResponseReasoningTextDeltaEvent }

        # Emitted when a reasoning text is completed.
        variant :"response.reasoning_text.done", -> { OpenAI::Beta::BetaResponseReasoningTextDoneEvent }

        # Emitted when there is a partial refusal text.
        variant :"response.refusal.delta", -> { OpenAI::Beta::BetaResponseRefusalDeltaEvent }

        # Emitted when refusal text is finalized.
        variant :"response.refusal.done", -> { OpenAI::Beta::BetaResponseRefusalDoneEvent }

        # Emitted when there is an additional text delta.
        variant :"response.output_text.delta", -> { OpenAI::Beta::BetaResponseTextDeltaEvent }

        # Emitted when text content is finalized.
        variant :"response.output_text.done", -> { OpenAI::Beta::BetaResponseTextDoneEvent }

        # Emitted when a web search call is completed.
        variant :"response.web_search_call.completed",
                -> { OpenAI::Beta::BetaResponseWebSearchCallCompletedEvent }

        # Emitted when a web search call is initiated.
        variant :"response.web_search_call.in_progress",
                -> { OpenAI::Beta::BetaResponseWebSearchCallInProgressEvent }

        # Emitted when a web search call is executing.
        variant :"response.web_search_call.searching",
                -> { OpenAI::Beta::BetaResponseWebSearchCallSearchingEvent }

        # Emitted when an image generation tool call has completed and the final image is available.
        variant :"response.image_generation_call.completed",
                -> { OpenAI::Beta::BetaResponseImageGenCallCompletedEvent }

        # Emitted when an image generation tool call is actively generating an image (intermediate state).
        variant :"response.image_generation_call.generating",
                -> { OpenAI::Beta::BetaResponseImageGenCallGeneratingEvent }

        # Emitted when an image generation tool call is in progress.
        variant :"response.image_generation_call.in_progress",
                -> { OpenAI::Beta::BetaResponseImageGenCallInProgressEvent }

        # Emitted when a partial image is available during image generation streaming.
        variant :"response.image_generation_call.partial_image",
                -> { OpenAI::Beta::BetaResponseImageGenCallPartialImageEvent }

        # Emitted when there is a delta (partial update) to the arguments of an MCP tool call.
        variant :"response.mcp_call_arguments.delta", -> { OpenAI::Beta::BetaResponseMcpCallArgumentsDeltaEvent }

        # Emitted when the arguments for an MCP tool call are finalized.
        variant :"response.mcp_call_arguments.done", -> { OpenAI::Beta::BetaResponseMcpCallArgumentsDoneEvent }

        # Emitted when an MCP  tool call has completed successfully.
        variant :"response.mcp_call.completed", -> { OpenAI::Beta::BetaResponseMcpCallCompletedEvent }

        # Emitted when an MCP  tool call has failed.
        variant :"response.mcp_call.failed", -> { OpenAI::Beta::BetaResponseMcpCallFailedEvent }

        # Emitted when an MCP  tool call is in progress.
        variant :"response.mcp_call.in_progress", -> { OpenAI::Beta::BetaResponseMcpCallInProgressEvent }

        # Emitted when the list of available MCP tools has been successfully retrieved.
        variant :"response.mcp_list_tools.completed", -> { OpenAI::Beta::BetaResponseMcpListToolsCompletedEvent }

        # Emitted when the attempt to list available MCP tools has failed.
        variant :"response.mcp_list_tools.failed", -> { OpenAI::Beta::BetaResponseMcpListToolsFailedEvent }

        # Emitted when the system is in the process of retrieving the list of available MCP tools.
        variant :"response.mcp_list_tools.in_progress",
                -> { OpenAI::Beta::BetaResponseMcpListToolsInProgressEvent }

        # Emitted when an annotation is added to output text content.
        variant :"response.output_text.annotation.added",
                -> { OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent }

        # Emitted when a response is queued and waiting to be processed.
        variant :"response.queued", -> { OpenAI::Beta::BetaResponseQueuedEvent }

        # Event representing a delta (partial update) to the input of a custom tool call.
        variant :"response.custom_tool_call_input.delta",
                -> { OpenAI::Beta::BetaResponseCustomToolCallInputDeltaEvent }

        # Event indicating that input for a custom tool call is complete.
        variant :"response.custom_tool_call_input.done",
                -> { OpenAI::Beta::BetaResponseCustomToolCallInputDoneEvent }

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::BetaResponseAudioDeltaEvent, OpenAI::Models::Beta::BetaResponseAudioDoneEvent, OpenAI::Models::Beta::BetaResponseAudioTranscriptDeltaEvent, OpenAI::Models::Beta::BetaResponseAudioTranscriptDoneEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCompletedEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInProgressEvent, OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInterpretingEvent, OpenAI::Models::Beta::BetaResponseCompletedEvent, OpenAI::Models::Beta::BetaResponseContentPartAddedEvent, OpenAI::Models::Beta::BetaResponseContentPartDoneEvent, OpenAI::Models::Beta::BetaResponseCreatedEvent, OpenAI::Models::Beta::BetaResponseErrorEvent, OpenAI::Models::Beta::BetaResponseFileSearchCallCompletedEvent, OpenAI::Models::Beta::BetaResponseFileSearchCallInProgressEvent, OpenAI::Models::Beta::BetaResponseFileSearchCallSearchingEvent, OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDeltaEvent, OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDoneEvent, OpenAI::Models::Beta::BetaResponseInProgressEvent, OpenAI::Models::Beta::BetaResponseFailedEvent, OpenAI::Models::Beta::BetaResponseIncompleteEvent, OpenAI::Models::Beta::BetaResponseOutputItemAddedEvent, OpenAI::Models::Beta::BetaResponseOutputItemDoneEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDeltaEvent, OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDoneEvent, OpenAI::Models::Beta::BetaResponseReasoningTextDeltaEvent, OpenAI::Models::Beta::BetaResponseReasoningTextDoneEvent, OpenAI::Models::Beta::BetaResponseRefusalDeltaEvent, OpenAI::Models::Beta::BetaResponseRefusalDoneEvent, OpenAI::Models::Beta::BetaResponseTextDeltaEvent, OpenAI::Models::Beta::BetaResponseTextDoneEvent, OpenAI::Models::Beta::BetaResponseWebSearchCallCompletedEvent, OpenAI::Models::Beta::BetaResponseWebSearchCallInProgressEvent, OpenAI::Models::Beta::BetaResponseWebSearchCallSearchingEvent, OpenAI::Models::Beta::BetaResponseImageGenCallCompletedEvent, OpenAI::Models::Beta::BetaResponseImageGenCallGeneratingEvent, OpenAI::Models::Beta::BetaResponseImageGenCallInProgressEvent, OpenAI::Models::Beta::BetaResponseImageGenCallPartialImageEvent, OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDeltaEvent, OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDoneEvent, OpenAI::Models::Beta::BetaResponseMcpCallCompletedEvent, OpenAI::Models::Beta::BetaResponseMcpCallFailedEvent, OpenAI::Models::Beta::BetaResponseMcpCallInProgressEvent, OpenAI::Models::Beta::BetaResponseMcpListToolsCompletedEvent, OpenAI::Models::Beta::BetaResponseMcpListToolsFailedEvent, OpenAI::Models::Beta::BetaResponseMcpListToolsInProgressEvent, OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent, OpenAI::Models::Beta::BetaResponseQueuedEvent, OpenAI::Models::Beta::BetaResponseCustomToolCallInputDeltaEvent, OpenAI::Models::Beta::BetaResponseCustomToolCallInputDoneEvent)]
      end
    end

    BetaResponseStreamEvent = Beta::BetaResponseStreamEvent
  end
end
