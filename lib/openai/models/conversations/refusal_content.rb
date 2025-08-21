# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class RefusalContent < OpenAI::Internal::Type::BaseModel
        # @!attribute refusal
        #   The refusal explanation from the model.
        #
        #   @return [String]
        required :refusal, String

        # @!attribute type
        #   The type of the refusal. Always `refusal`.
        #
        #   @return [Symbol, :refusal]
        required :type, const: :refusal

        # @!method initialize(refusal:, type: :refusal)
        #   @param refusal [String] The refusal explanation from the model.
        #
        #   @param type [Symbol, :refusal] The type of the refusal. Always `refusal`.
      end
    end
  end
end
