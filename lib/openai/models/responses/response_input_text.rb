# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseInputText < OpenAI::BaseModel
        # @!attribute text
        #   The text input to the model.
        #
        #   @return [String]
        required :text, String

        # @!attribute type
        #   The type of the input item. Always `input_text`.
        #
        #   @return [Symbol, :input_text]
        required :type, const: :input_text

        # @!parse
        #   # A text input to the model.
        #   #
        #   # @param text [String]
        #   # @param type [Symbol, :input_text]
        #   #
        #   def initialize(text:, type: :input_text, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
