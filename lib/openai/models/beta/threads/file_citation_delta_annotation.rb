# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class FileCitationDeltaAnnotation < OpenAI::Internal::Type::BaseModel
          # @!attribute index
          #   The index of the annotation in the text content part.
          #
          #   @return [Integer]
          required :index, Integer

          # @!attribute type
          #   Always `file_citation`.
          #
          #   @return [Symbol, :file_citation]
          required :type, const: :file_citation

          # @!attribute [r] end_index
          #
          #   @return [Integer, nil]
          optional :end_index, Integer

          # @!parse
          #   # @return [Integer]
          #   attr_writer :end_index

          # @!attribute [r] file_citation
          #
          #   @return [OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation::FileCitation, nil]
          optional :file_citation, -> { OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation::FileCitation }

          # @!parse
          #   # @return [OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation::FileCitation]
          #   attr_writer :file_citation

          # @!attribute [r] start_index
          #
          #   @return [Integer, nil]
          optional :start_index, Integer

          # @!parse
          #   # @return [Integer]
          #   attr_writer :start_index

          # @!attribute [r] text
          #   The text in the message content that needs to be replaced.
          #
          #   @return [String, nil]
          optional :text, String

          # @!parse
          #   # @return [String]
          #   attr_writer :text

          # @!method initialize(index:, end_index: nil, file_citation: nil, start_index: nil, text: nil, type: :file_citation)
          #   A citation within the message that points to a specific quote from a specific
          #   File associated with the assistant or the message. Generated when the assistant
          #   uses the "file_search" tool to search files.
          #
          #   @param index [Integer]
          #   @param end_index [Integer]
          #   @param file_citation [OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation::FileCitation]
          #   @param start_index [Integer]
          #   @param text [String]
          #   @param type [Symbol, :file_citation]

          # @see OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation#file_citation
          class FileCitation < OpenAI::Internal::Type::BaseModel
            # @!attribute [r] file_id
            #   The ID of the specific File the citation is from.
            #
            #   @return [String, nil]
            optional :file_id, String

            # @!parse
            #   # @return [String]
            #   attr_writer :file_id

            # @!attribute [r] quote
            #   The specific quote in the file.
            #
            #   @return [String, nil]
            optional :quote, String

            # @!parse
            #   # @return [String]
            #   attr_writer :quote

            # @!method initialize(file_id: nil, quote: nil)
            #   @param file_id [String]
            #   @param quote [String]
          end
        end
      end
    end
  end
end
