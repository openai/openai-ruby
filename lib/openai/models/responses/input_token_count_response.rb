# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module Responses
      # @see OpenAI::Resources::Responses::InputTokens#count
      class InputTokenCountResponse < OpenAI::Internal::Type::BaseModel
        # @!attribute input_tokens
        #
        #   @return [Integer]
        required :input_tokens, Integer

        # @!attribute object
        #
        #   @return [Symbol, :"response.input_tokens"]
        required :object, const: :"response.input_tokens"

        # @!method initialize(input_tokens:, object: :"response.input_tokens")
        #   @param input_tokens [Integer]
        #   @param object [Symbol, :"response.input_tokens"]
      end
    end
  end
end
