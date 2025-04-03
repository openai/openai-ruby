# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class FileCitationAnnotation < OpenAI::Internal::Type::BaseModel
          # @!attribute end_index
          #
          #   @return [Integer]
          required :end_index, Integer

          # @!attribute file_citation
          #
          #   @return [OpenAI::Models::Beta::Threads::FileCitationAnnotation::FileCitation]
          required :file_citation, -> { OpenAI::Models::Beta::Threads::FileCitationAnnotation::FileCitation }

          # @!attribute start_index
          #
          #   @return [Integer]
          required :start_index, Integer

          # @!attribute text
          #   The text in the message content that needs to be replaced.
          #
          #   @return [String]
          required :text, String

          # @!attribute type
          #   Always `file_citation`.
          #
          #   @return [Symbol, :file_citation]
          required :type, const: :file_citation

          # @!parse
          #   # A citation within the message that points to a specific quote from a specific
          #   #   File associated with the assistant or the message. Generated when the assistant
          #   #   uses the "file_search" tool to search files.
          #   #
          #   # @param end_index [Integer]
          #   # @param file_citation [OpenAI::Models::Beta::Threads::FileCitationAnnotation::FileCitation]
          #   # @param start_index [Integer]
          #   # @param text [String]
          #   # @param type [Symbol, :file_citation]
          #   #
          #   def initialize(end_index:, file_citation:, start_index:, text:, type: :file_citation, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          # @see OpenAI::Models::Beta::Threads::FileCitationAnnotation#file_citation
          class FileCitation < OpenAI::Internal::Type::BaseModel
            # @!attribute file_id
            #   The ID of the specific File the citation is from.
            #
            #   @return [String]
            required :file_id, String

            # @!parse
            #   # @param file_id [String]
            #   #
            #   def initialize(file_id:, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
          end
        end
      end
    end
  end
end
