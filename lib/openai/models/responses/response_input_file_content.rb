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

        # @!attribute detail
        #   The detail level of the file to be sent to the model. Use `low` for the default
        #   rendering behavior, or `high` to render the file at higher quality. Defaults to
        #   `low`.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseInputFileContent::Detail, nil]
        optional :detail, enum: -> { OpenAI::Responses::ResponseInputFileContent::Detail }

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

        # @!method initialize(detail: nil, file_data: nil, file_id: nil, file_url: nil, filename: nil, type: :input_file)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ResponseInputFileContent} for more details.
        #
        #   A file input to the model.
        #
        #   @param detail [Symbol, OpenAI::Models::Responses::ResponseInputFileContent::Detail] The detail level of the file to be sent to the model. Use `low` for the default
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

        # The detail level of the file to be sent to the model. Use `low` for the default
        # rendering behavior, or `high` to render the file at higher quality. Defaults to
        # `low`.
        #
        # @see OpenAI::Models::Responses::ResponseInputFileContent#detail
        module Detail
          extend OpenAI::Internal::Type::Enum

          LOW = :low
          HIGH = :high

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
