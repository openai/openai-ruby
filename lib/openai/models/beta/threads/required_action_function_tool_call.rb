# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        class RequiredActionFunctionToolCall < OpenAI::BaseModel
          # @!attribute id
          #   The ID of the tool call. This ID must be referenced when you submit the tool
          #     outputs in using the
          #     [Submit tool outputs to run](https://platform.openai.com/docs/api-reference/runs/submitToolOutputs)
          #     endpoint.
          #
          #   @return [String]
          required :id, String

          # @!attribute function
          #   The function definition.
          #
          #   @return [OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall::Function]
          required :function, -> { OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall::Function }

          # @!attribute type
          #   The type of tool call the output is required for. For now, this is always
          #     `function`.
          #
          #   @return [Symbol, :function]
          required :type, const: :function

          # @!parse
          #   # Tool call objects
          #   #
          #   # @param id [String]
          #   # @param function [OpenAI::Models::Beta::Threads::RequiredActionFunctionToolCall::Function]
          #   # @param type [Symbol, :function]
          #   #
          #   def initialize(id:, function:, type: :function, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void

          class Function < OpenAI::BaseModel
            # @!attribute arguments
            #   The arguments that the model expects you to pass to the function.
            #
            #   @return [String]
            required :arguments, String

            # @!attribute name
            #   The name of the function.
            #
            #   @return [String]
            required :name, String

            # @!parse
            #   # The function definition.
            #   #
            #   # @param arguments [String]
            #   # @param name [String]
            #   #
            #   def initialize(arguments:, name:, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void
          end
        end
      end
    end
  end
end
