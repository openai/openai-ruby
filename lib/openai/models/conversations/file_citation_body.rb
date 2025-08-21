# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class FileCitationBody < OpenAI::Internal::Type::BaseModel
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
        #   @param file_id [String] The ID of the file.
        #
        #   @param filename [String] The filename of the file cited.
        #
        #   @param index [Integer] The index of the file in the list of files.
        #
        #   @param type [Symbol, :file_citation] The type of the file citation. Always `file_citation`.
      end
    end
  end
end
