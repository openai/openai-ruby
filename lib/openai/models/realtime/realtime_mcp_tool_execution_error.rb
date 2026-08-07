# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeMcpToolExecutionError < OpenAI::Internal::Type::BaseModel
        # @!attribute message
        #
        #   @return [String]
        required :message, String

        # @!attribute type
        #
        #   @return [Symbol, :tool_execution_error]
        required :type, const: :tool_execution_error

        # @!method initialize(message:, type: :tool_execution_error)
        #   @param message [String]
        #   @param type [Symbol, :tool_execution_error]
      end
    end
  end
end
