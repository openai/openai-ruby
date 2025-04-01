# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseTextAnnotationDeltaEvent < OpenAI::BaseModel
        # @!attribute annotation
        #   A citation to a file.
        #
        #   @return [OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath]
        required :annotation,
                 union: -> { OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation }

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

        # @!parse
        #   # Emitted when a text annotation is added.
        #   #
        #   # @param annotation [OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath]
        #   # @param annotation_index [Integer]
        #   # @param content_index [Integer]
        #   # @param item_id [String]
        #   # @param output_index [Integer]
        #   # @param type [Symbol, :"response.output_text.annotation.added"]
        #   #
        #   def initialize(
        #     annotation:,
        #     annotation_index:,
        #     content_index:,
        #     item_id:,
        #     output_index:,
        #     type: :"response.output_text.annotation.added",
        #     **
        #   )
        #     super
        #   end

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # A citation to a file.
        #
        # @see OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent#annotation
        module Annotation
          extend OpenAI::Union

          discriminator :type

          # A citation to a file.
          variant :file_citation,
                  -> { OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation }

          # A citation for a web resource used to generate a model response.
          variant :url_citation,
                  -> { OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation }

          # A path to a file.
          variant :file_path,
                  -> { OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath }

          class FileCitation < OpenAI::BaseModel
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

            # @!parse
            #   # A citation to a file.
            #   #
            #   # @param file_id [String]
            #   # @param index [Integer]
            #   # @param type [Symbol, :file_citation]
            #   #
            #   def initialize(file_id:, index:, type: :file_citation, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void
          end

          class URLCitation < OpenAI::BaseModel
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

            # @!parse
            #   # A citation for a web resource used to generate a model response.
            #   #
            #   # @param end_index [Integer]
            #   # @param start_index [Integer]
            #   # @param title [String]
            #   # @param url [String]
            #   # @param type [Symbol, :url_citation]
            #   #
            #   def initialize(end_index:, start_index:, title:, url:, type: :url_citation, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void
          end

          class FilePath < OpenAI::BaseModel
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

            # @!parse
            #   # A path to a file.
            #   #
            #   # @param file_id [String]
            #   # @param index [Integer]
            #   # @param type [Symbol, :file_path]
            #   #
            #   def initialize(file_id:, index:, type: :file_path, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void
          end

          # @!parse
          #   # @return [Array(OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FileCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::URLCitation, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent::Annotation::FilePath)]
          #   def self.variants; end
        end
      end
    end
  end
end
