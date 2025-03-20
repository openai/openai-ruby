# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # Emitted when there is a partial audio response.
      module ResponseStreamEvent
        extend OpenAI::Union

        discriminator :type

        # Emitted when there is a partial audio response.
        variant :"response.audio.delta", -> { OpenAI::Models::Responses::ResponseAudioDeltaEvent }

        # Emitted when the audio response is complete.
        variant :"response.audio.done", -> { OpenAI::Models::Responses::ResponseAudioDoneEvent }

        # Emitted when there is a partial transcript of audio.
        variant :"response.audio.transcript.delta",
                -> { OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent }

        # Emitted when the full audio transcript is completed.
        variant :"response.audio.transcript.done",
                -> { OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent }

        # Emitted when a partial code snippet is added by the code interpreter.
        variant :"response.code_interpreter_call.code.delta",
                -> { OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent }

        # Emitted when code snippet output is finalized by the code interpreter.
        variant :"response.code_interpreter_call.code.done",
                -> { OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent }

        # Emitted when the code interpreter call is completed.
        variant :"response.code_interpreter_call.completed",
                -> { OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent }

        # Emitted when a code interpreter call is in progress.
        variant :"response.code_interpreter_call.in_progress",
                -> { OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent }

        # Emitted when the code interpreter is actively interpreting the code snippet.
        variant :"response.code_interpreter_call.interpreting",
                -> { OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent }

        # Emitted when the model response is complete.
        variant :"response.completed", -> { OpenAI::Models::Responses::ResponseCompletedEvent }

        # Emitted when a new content part is added.
        variant :"response.content_part.added", -> { OpenAI::Models::Responses::ResponseContentPartAddedEvent }

        # Emitted when a content part is done.
        variant :"response.content_part.done", -> { OpenAI::Models::Responses::ResponseContentPartDoneEvent }

        # An event that is emitted when a response is created.
        variant :"response.created", -> { OpenAI::Models::Responses::ResponseCreatedEvent }

        # Emitted when an error occurs.
        variant :error, -> { OpenAI::Models::Responses::ResponseErrorEvent }

        # Emitted when a file search call is completed (results found).
        variant :"response.file_search_call.completed",
                -> { OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent }

        # Emitted when a file search call is initiated.
        variant :"response.file_search_call.in_progress",
                -> { OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent }

        # Emitted when a file search is currently searching.
        variant :"response.file_search_call.searching",
                -> { OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent }

        # Emitted when there is a partial function-call arguments delta.
        variant :"response.function_call_arguments.delta",
                -> { OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent }

        # Emitted when function-call arguments are finalized.
        variant :"response.function_call_arguments.done",
                -> { OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent }

        # Emitted when the response is in progress.
        variant :"response.in_progress", -> { OpenAI::Models::Responses::ResponseInProgressEvent }

        # An event that is emitted when a response fails.
        variant :"response.failed", -> { OpenAI::Models::Responses::ResponseFailedEvent }

        # An event that is emitted when a response finishes as incomplete.
        variant :"response.incomplete", -> { OpenAI::Models::Responses::ResponseIncompleteEvent }

        # Emitted when a new output item is added.
        variant :"response.output_item.added", -> { OpenAI::Models::Responses::ResponseOutputItemAddedEvent }

        # Emitted when an output item is marked done.
        variant :"response.output_item.done", -> { OpenAI::Models::Responses::ResponseOutputItemDoneEvent }

        # Emitted when there is a partial refusal text.
        variant :"response.refusal.delta", -> { OpenAI::Models::Responses::ResponseRefusalDeltaEvent }

        # Emitted when refusal text is finalized.
        variant :"response.refusal.done", -> { OpenAI::Models::Responses::ResponseRefusalDoneEvent }

        # Emitted when a text annotation is added.
        variant :"response.output_text.annotation.added",
                -> { OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent }

        # Emitted when there is an additional text delta.
        variant :"response.output_text.delta", -> { OpenAI::Models::Responses::ResponseTextDeltaEvent }

        # Emitted when text content is finalized.
        variant :"response.output_text.done", -> { OpenAI::Models::Responses::ResponseTextDoneEvent }

        # Emitted when a web search call is completed.
        variant :"response.web_search_call.completed",
                -> { OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent }

        # Emitted when a web search call is initiated.
        variant :"response.web_search_call.in_progress",
                -> { OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent }

        # Emitted when a web search call is executing.
        variant :"response.web_search_call.searching",
                -> { OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent }

        # @!parse
        #   class << self
        #     # @return [Array(OpenAI::Models::Responses::ResponseAudioDeltaEvent, OpenAI::Models::Responses::ResponseAudioDoneEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent, OpenAI::Models::Responses::ResponseCompletedEvent, OpenAI::Models::Responses::ResponseContentPartAddedEvent, OpenAI::Models::Responses::ResponseContentPartDoneEvent, OpenAI::Models::Responses::ResponseCreatedEvent, OpenAI::Models::Responses::ResponseErrorEvent, OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent, OpenAI::Models::Responses::ResponseInProgressEvent, OpenAI::Models::Responses::ResponseFailedEvent, OpenAI::Models::Responses::ResponseIncompleteEvent, OpenAI::Models::Responses::ResponseOutputItemAddedEvent, OpenAI::Models::Responses::ResponseOutputItemDoneEvent, OpenAI::Models::Responses::ResponseRefusalDeltaEvent, OpenAI::Models::Responses::ResponseRefusalDoneEvent, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent, OpenAI::Models::Responses::ResponseTextDeltaEvent, OpenAI::Models::Responses::ResponseTextDoneEvent, OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent)]
        #     def variants; end
        #   end
      end
    end
  end
end
