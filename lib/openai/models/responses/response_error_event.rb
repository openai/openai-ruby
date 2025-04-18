# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseErrorEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute code
        #   The error code.
        #
        #   @return [String, nil]
        required :code, String, nil?: true

        # @!attribute message
        #   The error message.
        #
        #   @return [String]
        required :message, String

        # @!attribute param
        #   The error parameter.
        #
        #   @return [String, nil]
        required :param, String, nil?: true

        # @!attribute type
        #   The type of the event. Always `error`.
        #
        #   @return [Symbol, :error]
        required :type, const: :error

        # @!method initialize(code:, message:, param:, type: :error)
        #   Emitted when an error occurs.
        #
        #   @param code [String, nil]
        #   @param message [String]
        #   @param param [String, nil]
        #   @param type [Symbol, :error]
      end
    end
  end
end
