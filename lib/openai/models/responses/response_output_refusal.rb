# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseOutputRefusal < OpenAI::Internal::Type::BaseModel
        # @!attribute refusal
        #   The refusal explanationfrom the model.
        #
        #   @return [String]
        required :refusal, String

        # @!attribute type
        #   The type of the refusal. Always `refusal`.
        #
        #   @return [Symbol, :refusal]
        required :type, const: :refusal

        # @!parse
        #   # A refusal from the model.
        #   #
        #   # @param refusal [String]
        #   # @param type [Symbol, :refusal]
        #   #
        #   def initialize(refusal:, type: :refusal, **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
