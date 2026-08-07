# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    class ResponseFormatText < OpenAI::Internal::Type::BaseModel
      # @!attribute type
      #   The type of response format being defined. Always `text`.
      #
      #   @return [Symbol, :text]
      required :type, const: :text

      # @!method initialize(type: :text)
      #   Default response format. Used to generate text responses.
      #
      #   @param type [Symbol, :text] The type of response format being defined. Always `text`.
    end
  end
end
