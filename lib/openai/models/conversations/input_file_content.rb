# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class InputFileContent < OpenAI::Internal::Type::BaseModel
        # @!attribute file_id
        #   The ID of the file to be sent to the model.
        #
        #   @return [String, nil]
        required :file_id, String, nil?: true

        # @!attribute type
        #   The type of the input item. Always `input_file`.
        #
        #   @return [Symbol, :input_file]
        required :type, const: :input_file

        # @!attribute file_url
        #   The URL of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :file_url, String

        # @!attribute filename
        #   The name of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :filename, String

        # @!method initialize(file_id:, file_url: nil, filename: nil, type: :input_file)
        #   @param file_id [String, nil] The ID of the file to be sent to the model.
        #
        #   @param file_url [String] The URL of the file to be sent to the model.
        #
        #   @param filename [String] The name of the file to be sent to the model.
        #
        #   @param type [Symbol, :input_file] The type of the input item. Always `input_file`.
      end
    end
  end
end
