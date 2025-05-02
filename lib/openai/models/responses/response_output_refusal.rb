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

        # @!method initialize(refusal:, type: :refusal)
        #   A refusal from the model.
        #
        #   @param refusal [String] The refusal explanationfrom the model.
        #
        #   @param type [Symbol, :refusal] The type of the refusal. Always `refusal`.
      end
    end
  end
end
