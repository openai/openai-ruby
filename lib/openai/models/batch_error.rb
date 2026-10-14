# frozen_string_literal: true

module OpenAI
  module Models
    class BatchError < OpenAI::Internal::Type::BaseModel
      # @!attribute code
      #   An error code identifying the error type.
      #
      #   @return [String, nil]
      optional :code, String

      # @!attribute line
      #   The line number of the input file where the error occurred, if applicable.
      #
      #   @return [Integer, nil]
      optional :line, Integer, nil?: true

      # @!attribute message
      #   A human-readable message providing more details about the error.
      #
      #   @return [String, nil]
      optional :message, String

      # @!attribute param
      #   The name of the parameter that caused the error, if applicable.
      #
      #   @return [String, nil]
      optional :param, String, nil?: true

      # @!method initialize(code: nil, line: nil, message: nil, param: nil)
      #   @param code [String] An error code identifying the error type.
      #
      #   @param line [Integer, nil] The line number of the input file where the error occurred, if applicable.
      #
      #   @param message [String] A human-readable message providing more details about the error.
      #
      #   @param param [String, nil] The name of the parameter that caused the error, if applicable.
    end
  end
end
