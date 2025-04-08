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

        # @!parse
        #   # An object representing an error response from the Eval API.
        #   #
        #   # @param code [String]
        #   # @param message [String]
        #   #
        #   def initialize(code:, message:, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end

    EvalAPIError = Evals::EvalAPIError
  end
end
