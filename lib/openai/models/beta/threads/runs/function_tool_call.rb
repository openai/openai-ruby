# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FunctionToolCall < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The ID of the tool call object.
            #
            #   @return [String]
            required :id, String

            # @!attribute function
            #   The definition of the function that was called.
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::FunctionToolCall::Function]
            required :function, -> { OpenAI::Models::Beta::Threads::Runs::FunctionToolCall::Function }

            # @!attribute type
            #   The type of tool call. This is always going to be `function` for this type of
            #   tool call.
            #
            #   @return [Symbol, :function]
            required :type, const: :function

            # @!method initialize(id:, function:, type: :function)
            #   @param id [String]
            #   @param function [OpenAI::Models::Beta::Threads::Runs::FunctionToolCall::Function]
            #   @param type [Symbol, :function]

            # @see OpenAI::Models::Beta::Threads::Runs::FunctionToolCall#function
            class Function < OpenAI::Internal::Type::BaseModel
              # @!attribute arguments
              #   The arguments passed to the function.
              #
              #   @return [String]
              required :arguments, String

              # @!attribute name
              #   The name of the function.
              #
              #   @return [String]
              required :name, String

              # @!attribute output
              #   The output of the function. This will be `null` if the outputs have not been
              #   [submitted](https://platform.openai.com/docs/api-reference/runs/submitToolOutputs)
              #   yet.
              #
              #   @return [String, nil]
              required :output, String, nil?: true

              # @!method initialize(arguments:, name:, output:)
              #   The definition of the function that was called.
              #
              #   @param arguments [String]
              #   @param name [String]
              #   @param output [String, nil]
            end
          end
        end
      end
    end
  end
end
