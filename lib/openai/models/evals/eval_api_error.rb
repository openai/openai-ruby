# frozen_string_literal: true

module OpenAI
  module Models
    module Evals
      class EvalAPIError < OpenAI::Internal::Type::BaseModel
        # @!attribute code
        #   The error code.
        #
        #   @return [String]
        required :code, String

        # @!attribute message
        #   The error message.
        #
        #   @return [String]
        required :message, String

        # @!method initialize(code:, message:)
        #   An object representing an error response from the Eval API.
        #
        #   @param code [String] The error code.
        #
        #   @param message [String] The error message.
      end
    end

    EvalAPIError = Evals::EvalAPIError
  end
end
