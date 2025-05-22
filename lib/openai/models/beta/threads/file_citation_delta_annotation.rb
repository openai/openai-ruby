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

          # @!attribute end_index
          #
          #   @return [Integer, nil]
          optional :end_index, Integer

          # @!attribute file_citation
          #
          #   @return [OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation::FileCitation, nil]
          optional :file_citation, -> { OpenAI::Beta::Threads::FileCitationDeltaAnnotation::FileCitation }

          # @!attribute start_index
          #
          #   @return [Integer, nil]
          optional :start_index, Integer

          # @!attribute text
          #   The text in the message content that needs to be replaced.
          #
          #   @return [String, nil]
          optional :text, String

          # @!method initialize(index:, end_index: nil, file_citation: nil, start_index: nil, text: nil, type: :file_citation)
          #   A citation within the message that points to a specific quote from a specific
          #   File associated with the assistant or the message. Generated when the assistant
          #   uses the "file_search" tool to search files.
          #
          #   @param index [Integer] The index of the annotation in the text content part.
          #
          #   @param end_index [Integer]
          #
          #   @param file_citation [OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation::FileCitation]
          #
          #   @param start_index [Integer]
          #
          #   @param text [String] The text in the message content that needs to be replaced.
          #
          #   @param type [Symbol, :file_citation] Always `file_citation`.

          # @see OpenAI::Models::Beta::Threads::FileCitationDeltaAnnotation#file_citation
          class FileCitation < OpenAI::Internal::Type::BaseModel
            # @!attribute file_id
            #   The ID of the specific File the citation is from.
            #
            #   @return [String, nil]
            optional :file_id, String

            # @!attribute quote
            #   The specific quote in the file.
            #
            #   @return [String, nil]
            optional :quote, String

            # @!method initialize(file_id: nil, quote: nil)
            #   @param file_id [String] The ID of the specific File the citation is from.
            #
            #   @param quote [String] The specific quote in the file.
          end
        end
      end
    end
  end
end
