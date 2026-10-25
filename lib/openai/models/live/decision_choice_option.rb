# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionChoiceOption < OpenAI::Internal::Type::BaseModel
        # @!attribute value
        #
        #   @return [String, Boolean]
        required :value, union: -> { OpenAI::Live::DecisionChoiceOption::Value }

        # @!attribute description
        #
        #   @return [String, nil]
        optional :description, String

        # @!method initialize(value:, description: nil)
        #   @param value [String, Boolean]
        #   @param description [String]

        # @see OpenAI::Models::Live::DecisionChoiceOption#value
        module Value
          extend OpenAI::Internal::Type::Union

          variant String

          variant OpenAI::Internal::Type::Boolean

          # @!method self.variants
          #   @return [Array(String, Boolean)]
        end
      end
    end
  end
end
