# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class AssistantToolChoice < OpenAI::BaseModel
        # @!attribute type
        #   The type of the tool. If type is `function`, the function name must be set
        #
        #   @return [Symbol, OpenAI::Models::Beta::AssistantToolChoice::Type]
        required :type, enum: -> { OpenAI::Models::Beta::AssistantToolChoice::Type }

        # @!attribute [r] function
        #
        #   @return [OpenAI::Models::Beta::AssistantToolChoiceFunction, nil]
        optional :function, -> { OpenAI::Models::Beta::AssistantToolChoiceFunction }

        # @!parse
        #   # @return [OpenAI::Models::Beta::AssistantToolChoiceFunction]
        #   attr_writer :function

        # @!parse
        #   # Specifies a tool the model should use. Use to force the model to call a specific
        #   #   tool.
        #   #
        #   # @param type [Symbol, OpenAI::Models::Beta::AssistantToolChoice::Type]
        #   # @param function [OpenAI::Models::Beta::AssistantToolChoiceFunction]
        #   #
        #   def initialize(type:, function: nil, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # The type of the tool. If type is `function`, the function name must be set
        module Type
          extend OpenAI::Enum

          FUNCTION = :function
          CODE_INTERPRETER = :code_interpreter
          FILE_SEARCH = :file_search

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end
      end
    end
  end
end
