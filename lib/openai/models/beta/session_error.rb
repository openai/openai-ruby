# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class SessionError < OpenAI::Internal::Type::BaseModel
        # @!attribute code
        #   The machine-readable error code, if any.
        #
        #   @return [String, nil]
        required :code, String, nil?: true

        # @!attribute message
        #   A customer-safe explanation of the error.
        #
        #   @return [String]
        required :message, String

        # @!attribute param
        #   The request parameter associated with the error, if any.
        #
        #   @return [String, nil]
        required :param, String, nil?: true

        # @!attribute type
        #   The error type.
        #
        #   @return [String]
        required :type, String

        # @!method initialize(code:, message:, param:, type:)
        #   An error payload with the same public fields as Responses API streaming errors.
        #
        #   @param code [String, nil]
        #     The machine-readable error code, if any.
        #
        #   @param message [String]
        #     A customer-safe explanation of the error.
        #
        #   @param param [String, nil]
        #     The request parameter associated with the error, if any.
        #
        #   @param type [String]
        #     The error type.
      end
    end
  end
end
