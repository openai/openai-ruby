# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseInputFile < OpenAI::BaseModel
        # @!attribute type
        #   The type of the input item. Always `input_file`.
        #
        #   @return [Symbol, :input_file]
        required :type, const: :input_file

        # @!attribute [r] file_data
        #   The content of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :file_data, String

        # @!parse
        #   # @return [String]
        #   attr_writer :file_data

        # @!attribute [r] file_id
        #   The ID of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :file_id, String

        # @!parse
        #   # @return [String]
        #   attr_writer :file_id

        # @!attribute [r] filename
        #   The name of the file to be sent to the model.
        #
        #   @return [String, nil]
        optional :filename, String

        # @!parse
        #   # @return [String]
        #   attr_writer :filename

        # @!parse
        #   # A file input to the model.
        #   #
        #   # @param file_data [String]
        #   # @param file_id [String]
        #   # @param filename [String]
        #   # @param type [Symbol, :input_file]
        #   #
        #   def initialize(file_data: nil, file_id: nil, filename: nil, type: :input_file, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
