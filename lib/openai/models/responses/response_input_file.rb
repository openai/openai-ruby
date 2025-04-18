# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseInputFile < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the input item. Always `input_file`.
        #
        #   @return [Symbol, :input_file]
        required :type, const: :input_file

        # @!attribute file_data
        #   The content of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :file_data, String

        # @!attribute file_id
        #   The ID of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :file_id, String

        # @!attribute filename
        #   The name of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :filename, String

        # @!method initialize(file_data: nil, file_id: nil, filename: nil, type: :input_file)
        #   A file input to the model.
        #
        #   @param file_data [String]
        #   @param file_id [String]
        #   @param filename [String]
        #   @param type [Symbol, :input_file]
      end
    end
  end
end
