# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AssistantToolChoice < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the tool. If type is `function`, the function name must be set
        #
        #   @return [Symbol, OpenAI::Models::Beta::AssistantToolChoice::Type]
        required :type, enum: -> { OpenAI::Beta::AssistantToolChoice::Type }

        # @!attribute function
        #
        #   @return [OpenAI::Models::Beta::AssistantToolChoiceFunction, nil]
        optional :function, -> { OpenAI::Beta::AssistantToolChoiceFunction }

        # @!method initialize(type:, function: nil)
        #   Specifies a tool the model should use. Use to force the model to call a specific
        #   tool.
        #
        #   @param type [Symbol, OpenAI::Models::Beta::AssistantToolChoice::Type] The type of the tool. If type is `function`, the function name must be set
        #
        #   @param function [OpenAI::Models::Beta::AssistantToolChoiceFunction]

        # The type of the tool. If type is `function`, the function name must be set
        #
        # @see OpenAI::Models::Beta::AssistantToolChoice#type
        module Type
          extend OpenAI::Internal::Type::Enum

          FUNCTION = :function
          CODE_INTERPRETER = :code_interpreter
          FILE_SEARCH = :file_search

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
