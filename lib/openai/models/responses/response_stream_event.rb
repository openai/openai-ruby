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
                -> { OpenAI::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded }

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

        class ResponseOutputTextAnnotationAdded < OpenAI::Internal::Type::BaseModel
          # @!attribute annotation
          #   A citation to a file.
          #
          #   @return [OpenAI::Models::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded::Annotation::FileCitation, OpenAI::Models::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded::Annotation::URLCitation, OpenAI::Models::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded::Annotation::FilePath]
          required :annotation,
                   union: -> {
                     OpenAI::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded::Annotation
                   }

          # @!attribute annotation_index
          #   The index of the annotation that was added.
          #
          #   @return [Integer]
          required :annotation_index, Integer

          # @!attribute content_index
          #   The index of the content part that the text annotation was added to.
          #
          #   @return [Integer]
          required :content_index, Integer

          # @!attribute item_id
          #   The ID of the output item that the text annotation was added to.
          #
          #   @return [String]
          required :item_id, String

          # @!attribute output_index
          #   The index of the output item that the text annotation was added to.
          #
          #   @return [Integer]
          required :output_index, Integer

          # @!attribute type
          #   The type of the event. Always `response.output_text.annotation.added`.
          #
          #   @return [Symbol, :"response.output_text.annotation.added"]
          required :type, const: :"response.output_text.annotation.added"

          # @!method initialize(annotation:, annotation_index:, content_index:, item_id:, output_index:, type: :"response.output_text.annotation.added")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded}
          #   for more details.
          #
          #   Emitted when a text annotation is added.
          #
          #   @param annotation [OpenAI::Models::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded::Annotation::FileCitation, OpenAI::Models::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded::Annotation::URLCitation, OpenAI::Models::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded::Annotation::FilePath] A citation to a file.
          #
          #   @param annotation_index [Integer] The index of the annotation that was added.
          #
          #   @param content_index [Integer] The index of the content part that the text annotation was added to.
          #
          #   @param item_id [String] The ID of the output item that the text annotation was added to.
          #
          #   @param output_index [Integer] The index of the output item that the text annotation was added to.
          #
          #   @param type [Symbol, :"response.output_text.annotation.added"] The type of the event. Always `response.output_text.annotation.added`.

          # A citation to a file.
          #
          # @see OpenAI::Models::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded#annotation
          module Annotation
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # A citation to a file.
            variant :file_citation,
                    -> {
                      OpenAI::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded::Annotation::FileCitation
                    }

            # A citation for a web resource used to generate a model response.
            variant :url_citation,
                    -> {
                      OpenAI::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded::Annotation::URLCitation
                    }

            # A path to a file.
            variant :file_path,
                    -> {
                      OpenAI::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded::Annotation::FilePath
                    }

            class FileCitation < OpenAI::Internal::Type::BaseModel
              # @!attribute file_id
              #   The ID of the file.
              #
              #   @return [String]
              required :file_id, String

              # @!attribute index
              #   The index of the file in the list of files.
              #
              #   @return [Integer]
              required :index, Integer

              # @!attribute type
              #   The type of the file citation. Always `file_citation`.
              #
              #   @return [Symbol, :file_citation]
              required :type, const: :file_citation

              # @!method initialize(file_id:, index:, type: :file_citation)
              #   A citation to a file.
              #
              #   @param file_id [String] The ID of the file.
              #
              #   @param index [Integer] The index of the file in the list of files.
              #
              #   @param type [Symbol, :file_citation] The type of the file citation. Always `file_citation`.
            end

            class URLCitation < OpenAI::Internal::Type::BaseModel
              # @!attribute end_index
              #   The index of the last character of the URL citation in the message.
              #
              #   @return [Integer]
              required :end_index, Integer

              # @!attribute start_index
              #   The index of the first character of the URL citation in the message.
              #
              #   @return [Integer]
              required :start_index, Integer

              # @!attribute title
              #   The title of the web resource.
              #
              #   @return [String]
              required :title, String

              # @!attribute type
              #   The type of the URL citation. Always `url_citation`.
              #
              #   @return [Symbol, :url_citation]
              required :type, const: :url_citation

              # @!attribute url
              #   The URL of the web resource.
              #
              #   @return [String]
              required :url, String

              # @!method initialize(end_index:, start_index:, title:, url:, type: :url_citation)
              #   A citation for a web resource used to generate a model response.
              #
              #   @param end_index [Integer] The index of the last character of the URL citation in the message.
              #
              #   @param start_index [Integer] The index of the first character of the URL citation in the message.
              #
              #   @param title [String] The title of the web resource.
              #
              #   @param url [String] The URL of the web resource.
              #
              #   @param type [Symbol, :url_citation] The type of the URL citation. Always `url_citation`.
            end

            class FilePath < OpenAI::Internal::Type::BaseModel
              # @!attribute file_id
              #   The ID of the file.
              #
              #   @return [String]
              required :file_id, String

              # @!attribute index
              #   The index of the file in the list of files.
              #
              #   @return [Integer]
              required :index, Integer

              # @!attribute type
              #   The type of the file path. Always `file_path`.
              #
              #   @return [Symbol, :file_path]
              required :type, const: :file_path

              # @!method initialize(file_id:, index:, type: :file_path)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded::Annotation::FilePath}
              #   for more details.
              #
              #   A path to a file.
              #
              #   @param file_id [String] The ID of the file.
              #
              #   @param index [Integer] The index of the file in the list of files.
              #
              #   @param type [Symbol, :file_path] The type of the file path. Always `file_path`.
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded::Annotation::FileCitation, OpenAI::Models::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded::Annotation::URLCitation, OpenAI::Models::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded::Annotation::FilePath)]
          end
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Responses::ResponseAudioDeltaEvent, OpenAI::Models::Responses::ResponseAudioDoneEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent, OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent, OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent, OpenAI::Models::Responses::ResponseCompletedEvent, OpenAI::Models::Responses::ResponseContentPartAddedEvent, OpenAI::Models::Responses::ResponseContentPartDoneEvent, OpenAI::Models::Responses::ResponseCreatedEvent, OpenAI::Models::Responses::ResponseErrorEvent, OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent, OpenAI::Models::Responses::ResponseInProgressEvent, OpenAI::Models::Responses::ResponseFailedEvent, OpenAI::Models::Responses::ResponseIncompleteEvent, OpenAI::Models::Responses::ResponseOutputItemAddedEvent, OpenAI::Models::Responses::ResponseOutputItemDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent, OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent, OpenAI::Models::Responses::ResponseReasoningSummaryTextDeltaEvent, OpenAI::Models::Responses::ResponseReasoningSummaryTextDoneEvent, OpenAI::Models::Responses::ResponseRefusalDeltaEvent, OpenAI::Models::Responses::ResponseRefusalDoneEvent, OpenAI::Models::Responses::ResponseStreamEvent::ResponseOutputTextAnnotationAdded, OpenAI::Models::Responses::ResponseTextDeltaEvent, OpenAI::Models::Responses::ResponseTextDoneEvent, OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent, OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent, OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent)]
      end
    end
  end
end
