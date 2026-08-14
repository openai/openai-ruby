# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseOutputTextAnnotationAddedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute annotation
        #   An annotation that applies to a span of output text.
        #
        #   @return [OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::FileCitation, OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::URLCitation, OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::ContainerFileCitation, OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::FilePath, nil]
        required :annotation,
                 union: -> { OpenAI::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation },
                 nil?: true

        # @!attribute annotation_index
        #   The index of the annotation within the content part.
        #
        #   @return [Integer]
        required :annotation_index, Integer

        # @!attribute content_index
        #   The index of the content part within the output item.
        #
        #   @return [Integer]
        required :content_index, Integer

        # @!attribute item_id
        #   The unique identifier of the item to which the annotation is being added.
        #
        #   @return [String]
        required :item_id, String

        # @!attribute output_index
        #   The index of the output item in the response's output array.
        #
        #   @return [Integer]
        required :output_index, Integer

        # @!attribute sequence_number
        #   The sequence number of this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The type of the event. Always 'response.output_text.annotation.added'.
        #
        #   @return [Symbol, :"response.output_text.annotation.added"]
        required :type, const: :"response.output_text.annotation.added"

        # @!method initialize(annotation:, annotation_index:, content_index:, item_id:, output_index:, sequence_number:, type: :"response.output_text.annotation.added")
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
        #   @param type [Symbol, :"response.output_text.annotation.added"] The type of the event. Always 'response.output_text.annotation.added'.

        # An annotation that applies to a span of output text.
        #
        # @see OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent#annotation
        module Annotation
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A citation to a file.
          variant :file_citation,
                  -> { OpenAI::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::FileCitation }

          # A citation for a web resource used to generate a model response.
          variant :url_citation,
                  -> { OpenAI::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::URLCitation }

          # A citation for a container file used to generate a model response.
          variant :container_file_citation,
                  -> { OpenAI::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::ContainerFileCitation }

          # A path to a file.
          variant :file_path, -> { OpenAI::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::FilePath }

          class FileCitation < OpenAI::Internal::Type::BaseModel
            # @!attribute file_id
            #   The ID of the file.
            #
            #   @return [String]
            required :file_id, String

            # @!attribute filename
            #   The filename of the file cited.
            #
            #   @return [String]
            required :filename, String

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

            # @!method initialize(file_id:, filename:, index:, type: :file_citation)
            #   A citation to a file.
            #
            #   @param file_id [String] The ID of the file.
            #
            #   @param filename [String] The filename of the file cited.
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

          class ContainerFileCitation < OpenAI::Internal::Type::BaseModel
            # @!attribute container_id
            #   The ID of the container file.
            #
            #   @return [String]
            required :container_id, String

            # @!attribute end_index
            #   The index of the last character of the container file citation in the message.
            #
            #   @return [Integer]
            required :end_index, Integer

            # @!attribute file_id
            #   The ID of the file.
            #
            #   @return [String]
            required :file_id, String

            # @!attribute filename
            #   The filename of the container file cited.
            #
            #   @return [String]
            required :filename, String

            # @!attribute start_index
            #   The index of the first character of the container file citation in the message.
            #
            #   @return [Integer]
            required :start_index, Integer

            # @!attribute type
            #   The type of the container file citation. Always `container_file_citation`.
            #
            #   @return [Symbol, :container_file_citation]
            required :type, const: :container_file_citation

            # @!method initialize(container_id:, end_index:, file_id:, filename:, start_index:, type: :container_file_citation)
            #   A citation for a container file used to generate a model response.
            #
            #   @param container_id [String] The ID of the container file.
            #
            #   @param end_index [Integer] The index of the last character of the container file citation in the message.
            #
            #   @param file_id [String] The ID of the file.
            #
            #   @param filename [String] The filename of the container file cited.
            #
            #   @param start_index [Integer] The index of the first character of the container file citation in the message.
            #
            #   @param type [Symbol, :container_file_citation] The type of the container file citation. Always `container_file_citation`.
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
            #   {OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::FilePath}
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
          #   @return [Array(OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::FileCitation, OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::URLCitation, OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::ContainerFileCitation, OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent::Annotation::FilePath)]
        end
      end
    end
  end
end
