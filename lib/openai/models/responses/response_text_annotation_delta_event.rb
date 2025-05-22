# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseTextAnnotationDeltaEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute annotation
        #   A citation to a file.
        #
        #   @return [OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath]
        required :annotation, union: -> { OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation }

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

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always `response.output_text.annotation.added`.
        #
        #   @return [Symbol, :"response.output_text.annotation.added"]
        required :type, const: :"response.output_text.annotation.added"

        # @!method initialize(annotation:, annotation_index:, content_index:, item_id:, output_index:, sequence_number:, type: :"response.output_text.annotation.added")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent} for more details.
        #
        #   Emitted when a text annotation is added.
        #
        #   @param annotation [OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath] A citation to a file.
        #
        #   @param annotation_index [Integer] The index of the annotation that was added.
        #
        #   @param content_index [Integer] The index of the content part that the text annotation was added to.
        #
        #   @param item_id [String] The ID of the output item that the text annotation was added to.
        #
        #   @param output_index [Integer] The index of the output item that the text annotation was added to.
        #
        #   @param sequence_number [Integer] The sequence number of this event.
        #
        #   @param type [Symbol, :"response.output_text.annotation.added"] The type of the event. Always `response.output_text.annotation.added`.

        # A citation to a file.
        #
        # @see OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent#annotation
        module Annotation
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A citation to a file.
          variant :file_citation,
                  -> { OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation }

          # A citation for a web resource used to generate a model response.
          variant :url_citation,
                  -> {
                    OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation
                  }

          # A path to a file.
          variant :file_path, -> { OpenAI::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath }

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
            #   {OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath}
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
          #   @return [Array(OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath)]
        end
      end
    end
  end
end
