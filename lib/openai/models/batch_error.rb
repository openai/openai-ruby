# frozen_string_literal: true

module OpenAI
  module Models
    class BatchError < OpenAI::BaseModel
      # @!attribute [r] code
      #   An error code identifying the error type.
      #
      #   @return [String, nil]
      optional :code, String

      # @!parse
      #   # @return [String]
      #   attr_writer :code

      # @!attribute line
      #   The line number of the input file where the error occurred, if applicable.
      #
      #   @return [Integer, nil]
      optional :line, Integer, nil?: true

      # @!attribute [r] message
      #   A human-readable message providing more details about the error.
      #
      #   @return [String, nil]
      optional :message, String

      # @!parse
      #   # @return [String]
      #   attr_writer :message

      # @!attribute param
      #   The name of the parameter that caused the error, if applicable.
      #
      #   @return [String, nil]
      optional :param, String, nil?: true

      # @!parse
      #   # @param code [String]
      #   # @param line [Integer, nil]
      #   # @param message [String]
      #   # @param param [String, nil]
      #   #
      #   def initialize(code: nil, line: nil, message: nil, param: nil, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void
    end
  end
end
