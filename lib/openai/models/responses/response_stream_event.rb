# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # Emitted when there is a partial audio response.
      module ResponseStreamEvent
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Emitted when there is a partial audio response.
        variant :"response.audio.delta", -> { OpenAI::Responses::ResponseAudioDeltaEvent }

        # Emitted when the audio response is complete.
        variant :"response.audio.done", -> { OpenAI::Responses::ResponseAudioDoneEvent }

        # Emitted when there is a partial transcript of audio.
        variant :"response.audio.transcript.delta",
                -> {
                  OpenAI::Responses::ResponseAudioTranscriptDeltaEvent
                }

        # Emitted when the full audio transcript is completed.
        variant :"response.audio.transcript.done", -> { OpenAI::Responses::ResponseAudioTranscriptDoneEvent }

        # Emitted when a partial code snippet is added by the code interpreter.
        variant :"response.code_interpreter_call.code.delta",
                -> { OpenAI::Responses::ResponseCodeInterpreterCallCodeDeltaEvent }

        # Emitted when code snippet output is finalized by the code interpreter.
        variant :"response.code_interpreter_call.code.done",
                -> { OpenAI::Responses::ResponseCodeInterpreterCallCodeDoneEvent }

        # Emitted when the code interpreter call is completed.
        variant :"response.code_interpreter_call.completed",
                -> { OpenAI::Responses::ResponseCodeInterpreterCallCompletedEvent }

        # Emitted when a code interpreter call is in progress.
        variant :"response.code_interpreter_call.in_progress",
                -> { OpenAI::Responses::ResponseCodeInterpreterCallInProgressEvent }

        # Emitted when the code interpreter is actively interpreting the code snippet.
        variant :"response.code_interpreter_call.interpreting",
                -> { OpenAI::Responses::ResponseCodeInterpreterCallInterpretingEvent }

        # Emitted when the model response is complete.
        variant :"response.completed", -> { OpenAI::Responses::ResponseCompletedEvent }

        # Emitted when a new content part is added.
        variant :"response.content_part.added", -> { OpenAI::Responses::ResponseContentPartAddedEvent }

        # Emitted when a content part is done.
        variant :"response.content_part.done", -> { OpenAI::Responses::ResponseContentPartDoneEvent }

        # An event that is emitted when a response is created.
        variant :"response.created", -> { OpenAI::Responses::ResponseCreatedEvent }

        # Emitted when an error occurs.
        variant :error, -> { OpenAI::Responses::ResponseErrorEvent }

        # Emitted when a file search call is completed (results found).
        variant :"response.file_search_call.completed",
                -> { OpenAI::Responses::ResponseFileSearchCallCompletedEvent }

        # Emitted when a file search call is initiated.
        variant :"response.file_search_call.in_progress",
                -> { OpenAI::Responses::ResponseFileSearchCallInProgressEvent }

        # Emitted when a file search is currently searching.
        variant :"response.file_search_call.searching",
                -> { OpenAI::Responses::ResponseFileSearchCallSearchingEvent }

        # Emitted when there is a partial function-call arguments delta.
        variant :"response.function_call_arguments.delta",
                -> { OpenAI::Responses::ResponseFunctionCallArgumentsDeltaEvent }

        # Emitted when function-call arguments are finalized.
        variant :"response.function_call_arguments.done",
                -> { OpenAI::Responses::ResponseFunctionCallArgumentsDoneEvent }

        # Emitted when the response is in progress.
        variant :"response.in_progress", -> { OpenAI::Responses::ResponseInProgressEvent }

        # An event that is emitted when a response fails.
        variant :"response.failed", -> { OpenAI::Responses::ResponseFailedEvent }

        # An event that is emitted when a response finishes as incomplete.
        variant :"response.incomplete", -> { OpenAI::Responses::ResponseIncompleteEvent }

        # Emitted when a new output item is added.
        variant :"response.output_item.added", -> { OpenAI::Responses::ResponseOutputItemAddedEvent }

        # Emitted when an output item is marked done.
        variant :"response.output_item.done", -> { OpenAI::Responses::ResponseOutputItemDoneEvent }

        # Emitted when a new reasoning summary part is added.
        variant :"response.reasoning_summary_part.added",
                -> { OpenAI::Responses::ResponseReasoningSummaryPartAddedEvent }

        # Emitted when a reasoning summary part is completed.
        variant :"response.reasoning_summary_part.done",
                -> { OpenAI::Responses::ResponseReasoningSummaryPartDoneEvent }

        # Emitted when a delta is added to a reasoning summary text.
        variant :"response.reasoning_summary_text.delta",
                -> { OpenAI::Responses::ResponseReasoningSummaryTextDeltaEvent }

        # Emitted when a reasoning summary text is completed.
        variant :"response.reasoning_summary_text.done",
                -> { OpenAI::Responses::ResponseReasoningSummaryTextDoneEvent }

        # Emitted when there is a partial refusal text.
        variant :"response.refusal.delta", -> { OpenAI::Responses::ResponseRefusalDeltaEvent }

        # Emitted when refusal text is finalized.
        variant :"response.refusal.done", -> { OpenAI::Responses::ResponseRefusalDoneEvent }

        # Emitted when a text annotation is added.
        variant :"response.output_text.annotation.added",
                -> { OpenAI::Responses::ResponseTextAnnotationDeltaEvent }

        # Emitted when there is an additional text delta.
        variant :"response.output_text.delta", -> { OpenAI::Responses::ResponseTextDeltaEvent }

        # Emitted when text content is finalized.
        variant :"response.output_text.done", -> { OpenAI::Responses::ResponseTextDoneEvent }

        # Emitted when a web search call is completed.
        variant :"response.web_search_call.completed",
                -> { OpenAI::Responses::ResponseWebSearchCallCompletedEvent }

        # Emitted when a web search call is initiated.
        variant :"response.web_search_call.in_progress",
                -> { OpenAI::Responses::ResponseWebSearchCallInProgressEvent }

        # Emitted when a web search call is executing.
        variant :"response.web_search_call.searching",
                -> { OpenAI::Responses::ResponseWebSearchCallSearchingEvent }

        # Emitted when an image generation tool call has completed and the final image is available.
        variant :"response.image_generation_call.completed",
                -> { OpenAI::Responses::ResponseImageGenCallCompletedEvent }

        # Emitted when an image generation tool call is actively generating an image (intermediate state).
        variant :"response.image_generation_call.generating",
                -> { OpenAI::Responses::ResponseImageGenCallGeneratingEvent }

        # Emitted when an image generation tool call is in progress.
        variant :"response.image_generation_call.in_progress",
                -> { OpenAI::Responses::ResponseImageGenCallInProgressEvent }

        # Emitted when a partial image is available during image generation streaming.
        variant :"response.image_generation_call.partial_image",
                -> { OpenAI::Responses::ResponseImageGenCallPartialImageEvent }

        # Emitted when there is a delta (partial update) to the arguments of an MCP tool call.
        variant :"response.mcp_call.arguments_delta",
                -> {
                  OpenAI::Responses::ResponseMcpCallArgumentsDeltaEvent
                }

        # Emitted when the arguments for an MCP tool call are finalized.
        variant :"response.mcp_call.arguments_done",
                -> {
                  OpenAI::Responses::ResponseMcpCallArgumentsDoneEvent
                }

        # Emitted when an MCP  tool call has completed successfully.
        variant :"response.mcp_call.completed", -> { OpenAI::Responses::ResponseMcpCallCompletedEvent }

        # Emitted when an MCP  tool call has failed.
        variant :"response.mcp_call.failed", -> { OpenAI::Responses::ResponseMcpCallFailedEvent }

        # Emitted when an MCP  tool call is in progress.
        variant :"response.mcp_call.in_progress", -> { OpenAI::Responses::ResponseMcpCallInProgressEvent }

        # Emitted when the list of available MCP tools has been successfully retrieved.
        variant :"response.mcp_list_tools.completed",
                -> {
                  OpenAI::Responses::ResponseMcpListToolsCompletedEvent
                }

        # Emitted when the attempt to list available MCP tools has failed.
        variant :"response.mcp_list_tools.failed", -> { OpenAI::Responses::ResponseMcpListToolsFailedEvent }

        # Emitted when the system is in the process of retrieving the list of available MCP tools.
        variant :"response.mcp_list_tools.in_progress",
                -> { OpenAI::Responses::ResponseMcpListToolsInProgressEvent }

        # Emitted when an annotation is added to output text content.
        variant :"response.output_text_annotation.added",
                -> { OpenAI::Responses::ResponseOutputTextAnnotationAddedEvent }

        # Emitted when a response is queued and waiting to be processed.
        variant :"response.queued", -> { OpenAI::Responses::ResponseQueuedEvent }

        # Emitted when there is a delta (partial update) to the reasoning content.
        variant :"response.reasoning.delta", -> { OpenAI::Responses::ResponseReasoningDeltaEvent }

        # Emitted when the reasoning content is finalized for an item.
        variant :"response.reasoning.done", -> { OpenAI::Responses::ResponseReasoningDoneEvent }

        # Emitted when there is a delta (partial update) to the reasoning summary content.
        variant :"response.reasoning_summary.delta",
                -> {
                  OpenAI::Responses::ResponseReasoningSummaryDeltaEvent
                }

        # Emitted when the reasoning summary content is finalized for an item.
        variant :"response.reasoning_summary.done",
                -> {
                  OpenAI::Responses::ResponseReasoningSummaryDoneEvent
                }

        # @!method self.variants
        #   @return [Array(OpenAI::Responses::ResponseAudioDeltaEvent, OpenAI::Responses::ResponseAudioDoneEvent, OpenAI::Responses::ResponseAudioTranscriptDeltaEvent, OpenAI::Responses::ResponseAudioTranscriptDoneEvent, OpenAI::Responses::ResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Responses::ResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Responses::ResponseCodeInterpreterCallCompletedEvent, OpenAI::Responses::ResponseCodeInterpreterCallInProgressEvent, OpenAI::Responses::ResponseCodeInterpreterCallInterpretingEvent, OpenAI::Responses::ResponseCompletedEvent, OpenAI::Responses::ResponseContentPartAddedEvent, OpenAI::Responses::ResponseContentPartDoneEvent, OpenAI::Responses::ResponseCreatedEvent, OpenAI::Responses::ResponseErrorEvent, OpenAI::Responses::ResponseFileSearchCallCompletedEvent, OpenAI::Responses::ResponseFileSearchCallInProgressEvent, OpenAI::Responses::ResponseFileSearchCallSearchingEvent, OpenAI::Responses::ResponseFunctionCallArgumentsDeltaEvent, OpenAI::Responses::ResponseFunctionCallArgumentsDoneEvent, OpenAI::Responses::ResponseInProgressEvent, OpenAI::Responses::ResponseFailedEvent, OpenAI::Responses::ResponseIncompleteEvent, OpenAI::Responses::ResponseOutputItemAddedEvent, OpenAI::Responses::ResponseOutputItemDoneEvent, OpenAI::Responses::ResponseReasoningSummaryPartAddedEvent, OpenAI::Responses::ResponseReasoningSummaryPartDoneEvent, OpenAI::Responses::ResponseReasoningSummaryTextDeltaEvent, OpenAI::Responses::ResponseReasoningSummaryTextDoneEvent, OpenAI::Responses::ResponseRefusalDeltaEvent, OpenAI::Responses::ResponseRefusalDoneEvent, OpenAI::Responses::ResponseTextAnnotationDeltaEvent, OpenAI::Responses::ResponseTextDeltaEvent, OpenAI::Responses::ResponseTextDoneEvent, OpenAI::Responses::ResponseWebSearchCallCompletedEvent, OpenAI::Responses::ResponseWebSearchCallInProgressEvent, OpenAI::Responses::ResponseWebSearchCallSearchingEvent, OpenAI::Responses::ResponseImageGenCallCompletedEvent, OpenAI::Responses::ResponseImageGenCallGeneratingEvent, OpenAI::Responses::ResponseImageGenCallInProgressEvent, OpenAI::Responses::ResponseImageGenCallPartialImageEvent, OpenAI::Responses::ResponseMcpCallArgumentsDeltaEvent, OpenAI::Responses::ResponseMcpCallArgumentsDoneEvent, OpenAI::Responses::ResponseMcpCallCompletedEvent, OpenAI::Responses::ResponseMcpCallFailedEvent, OpenAI::Responses::ResponseMcpCallInProgressEvent, OpenAI::Responses::ResponseMcpListToolsCompletedEvent, OpenAI::Responses::ResponseMcpListToolsFailedEvent, OpenAI::Responses::ResponseMcpListToolsInProgressEvent, OpenAI::Responses::ResponseOutputTextAnnotationAddedEvent, OpenAI::Responses::ResponseQueuedEvent, OpenAI::Responses::ResponseReasoningDeltaEvent, OpenAI::Responses::ResponseReasoningDoneEvent, OpenAI::Responses::ResponseReasoningSummaryDeltaEvent, OpenAI::Responses::ResponseReasoningSummaryDoneEvent)]
      end
    end
  end
end
