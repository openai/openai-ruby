# frozen_string_literal: true

module OpenAI
  module Models
    class ResponseFormatText < OpenAI::BaseModel
      # @!attribute type
      #   The type of response format being defined: `text`
      #
      #   @return [Symbol, :text]
      required :type, const: :text

      # @!parse
      #   # @param type [Symbol, :text]
      #   #
      #   def initialize(type: :text, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void
    end
  end
end
