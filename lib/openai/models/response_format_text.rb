# frozen_string_literal: true

module OpenAI
  module Models
    class ResponseFormatText < OpenAI::Internal::Type::BaseModel
      # @!attribute type
      #   The type of response format being defined. Always `text`.
      #
      #   @return [Symbol, :text]
      required :type, const: :text

      # @!parse
      #   # Default response format. Used to generate text responses.
      #   #
      #   # @param type [Symbol, :text]
      #   #
      #   def initialize(type: :text, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
    end
  end
end
