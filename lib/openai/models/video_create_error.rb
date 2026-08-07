# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    class VideoCreateError < OpenAI::Internal::Type::BaseModel
      # @!attribute code
      #   A machine-readable error code that was returned.
      #
      #   @return [String]
      required :code, String

      # @!attribute message
      #   A human-readable description of the error that was returned.
      #
      #   @return [String]
      required :message, String

      # @!method initialize(code:, message:)
      #   An error that occurred while generating the response.
      #
      #   @param code [String] A machine-readable error code that was returned.
      #
      #   @param message [String] A human-readable description of the error that was returned.
    end
  end
end
