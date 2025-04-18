# frozen_string_literal: true

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
        #   @param name [String]
      end
    end
  end
end
