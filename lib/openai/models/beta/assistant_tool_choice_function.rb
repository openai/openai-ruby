# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AssistantToolChoiceFunction < OpenAI::BaseModel
        # @!attribute name
        #   The name of the function to call.
        #
        #   @return [String]
        required :name, String

        # @!parse
        #   # @param name [String]
        #   #
        #   def initialize(name:, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
