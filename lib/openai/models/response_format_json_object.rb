# frozen_string_literal: true

module OpenAI
  module Models
    class ResponseFormatJSONObject < OpenAI::Internal::Type::BaseModel
      # @!attribute type
      #   The type of response format being defined. Always `json_object`.
      #
      #   @return [Symbol, :json_object]
      required :type, const: :json_object

      # @!parse
      #   # JSON object response format. An older method of generating JSON responses. Using
      #   # `json_schema` is recommended for models that support it. Note that the model
      #   # will not generate JSON without a system or user message instructing it to do so.
      #   #
      #   # @param type [Symbol, :json_object]
      #   #
      #   def initialize(type: :json_object, **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
    end
  end
end
