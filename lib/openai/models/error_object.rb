# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    class ErrorObject < OpenAI::Internal::Type::BaseModel
      # @!attribute code
      #
      #   @return [String, nil]
      required :code, String, nil?: true

      # @!attribute message
      #
      #   @return [String]
      required :message, String

      # @!attribute param
      #
      #   @return [String, nil]
      required :param, String, nil?: true

      # @!attribute type
      #
      #   @return [String]
      required :type, String

      # @!method initialize(code:, message:, param:, type:)
      #   @param code [String, nil]
      #   @param message [String]
      #   @param param [String, nil]
      #   @param type [String]
    end
  end
end
