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
            #   @return [OpenAI::Beta::Threads::Runs::FunctionToolCall::Function]
            required :function, -> { OpenAI::Beta::Threads::Runs::FunctionToolCall::Function }

            # @!attribute type
            #   The type of tool call. This is always going to be `function` for this type of
            #   tool call.
            #
            #   @return [Symbol, :function]
            required :type, const: :function

            # @!method initialize(id:, function:, type: :function)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Beta::Threads::Runs::FunctionToolCall} for more details.
            #
            #   @param id [String] The ID of the tool call object.
            #
            #   @param function [OpenAI::Beta::Threads::Runs::FunctionToolCall::Function] The definition of the function that was called.
            #
            #   @param type [Symbol, :function] The type of tool call. This is always going to be `function` for this type of to

            # @see OpenAI::Beta::Threads::Runs::FunctionToolCall#function
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
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Beta::Threads::Runs::FunctionToolCall::Function} for more details.
              #
              #   The definition of the function that was called.
              #
              #   @param arguments [String] The arguments passed to the function.
              #
              #   @param name [String] The name of the function.
              #
              #   @param output [String, nil] The output of the function. This will be `null` if the outputs have not been [su
            end
          end
        end
      end
    end
  end
end
