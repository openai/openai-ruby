# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class ContainerFileCitationBody < OpenAI::Internal::Type::BaseModel
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
    end
  end
end
