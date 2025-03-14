# frozen_string_literal: true

module OpenAI
  module Models
    class ResponseFormatJSONObject < OpenAI::BaseModel
      # @!attribute type
      #   The type of response format being defined: `json_object`
      #
      #   @return [Symbol, :json_object]
      required :type, const: :json_object

      # @!parse
      #   # @param type [Symbol, :json_object]
      #   #
      #   def initialize(type: :json_object, **) = super

      # def initialize: (Hash | OpenAI::BaseModel) -> void
    end
  end
end
