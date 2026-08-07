# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module Realtime
      class RealtimeMcpProtocolError < OpenAI::Internal::Type::BaseModel
        # @!attribute code
        #
        #   @return [Integer]
        required :code, Integer

        # @!attribute message
        #
        #   @return [String]
        required :message, String

        # @!attribute type
        #
        #   @return [Symbol, :protocol_error]
        required :type, const: :protocol_error

        # @!method initialize(code:, message:, type: :protocol_error)
        #   @param code [Integer]
        #   @param message [String]
        #   @param type [Symbol, :protocol_error]
      end
    end
  end
end
