# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    module Beta
      class AssistantToolChoiceFunction < OpenAI::Internal::Type::BaseModel
        # @!attribute name
        #   The name of the function to call.
        #
        #   @return [String]
        required :name, String

        # @!method initialize(name:)
        #   @param name [String] The name of the function to call.
      end
    end
  end
end
