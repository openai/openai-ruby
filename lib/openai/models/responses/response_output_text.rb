# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseOutputText < OpenAI::BaseModel
        # @!attribute annotations
        #   The annotations of the text output.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseOutputText::Annotation::FileCitation, OpenAI::Models::Responses::ResponseOutputText::Annotation::URLCitation, OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath>]
        required :annotations,
                 -> { OpenAI::ArrayOf[union: OpenAI::Models::Responses::ResponseOutputText::Annotation] }

        # @!attribute text
        #   The text output from the model.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the output text. Always `output_text`.
        #
        #   @return [Symbol, :output_text]
        required :type, const: :output_text

        # @!parse
        #   # A text output from the model.
        #   #
        #   # @param annotations [Array<OpenAI::Models::Responses::ResponseOutputText::Annotation::FileCitation, OpenAI::Models::Responses::ResponseOutputText::Annotation::URLCitation, OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath>]
        #   # @param text [String]
        #   # @param type [Symbol, :output_text]
        #   #
        #   def initialize(annotations:, text:, type: :output_text, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # @abstract
        #
        # A citation to a file.
        class Annotation < OpenAI::Union
          discriminator :type

          # A citation to a file.
          variant :file_citation, -> { OpenAI::Models::Responses::ResponseOutputText::Annotation::FileCitation }

          # A citation for a web resource used to generate a model response.
          variant :url_citation, -> { OpenAI::Models::Responses::ResponseOutputText::Annotation::URLCitation }

          # A path to a file.
          variant :file_path, -> { OpenAI::Models::Responses::ResponseOutputText::Annotation::FilePath }

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
        end
      end
    end
  end
end
