# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseInputFileContent < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the input item. Always `input_file`.
        #
        #   @return [Symbol, :input_file]
        required :type, const: :input_file

        # @!attribute file_data
        #   The base64-encoded data of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :file_data, String, nil?: true

        # @!attribute file_id
        #   The ID of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :file_id, String, nil?: true

        # @!attribute file_url
        #   The URL of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :file_url, String, nil?: true

        # @!attribute filename
        #   The name of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :filename, String, nil?: true

        # @!method initialize(file_data: nil, file_id: nil, file_url: nil, filename: nil, type: :input_file)
        #   A file input to the model.
        #
        #   @param file_data [String, nil] The base64-encoded data of the file to be sent to the model.
        #
        #   @param file_id [String, nil] The ID of the file to be sent to the model.
        #
        #   @param file_url [String, nil] The URL of the file to be sent to the model.
        #
        #   @param filename [String, nil] The name of the file to be sent to the model.
        #
        #   @param type [Symbol, :input_file] The type of the input item. Always `input_file`.
      end
    end
  end
end
