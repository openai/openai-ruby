# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class FunctionToolCallDelta < OpenAI::Internal::Type::BaseModel
            # @!attribute index
            #   The index of the tool call in the tool calls array.
            #
            #   @return [Integer]
            required :index, Integer

            # @!attribute type
            #   The type of tool call. This is always going to be `function` for this type of
            #   tool call.
            #
            #   @return [Symbol, :function]
            required :type, const: :function

            # @!attribute id
            #   The ID of the tool call object.
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute function
            #   The definition of the function that was called.
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function, nil]
            optional :function, -> { OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function }

            # @!method initialize(index:, id: nil, function: nil, type: :function)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta} for more details.
            #
            #   @param index [Integer] The index of the tool call in the tool calls array.
            #
            #   @param id [String] The ID of the tool call object.
            #
            #   @param function [OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function] The definition of the function that was called.
            #
            #   @param type [Symbol, :function] The type of tool call. This is always going to be `function` for this type of to
            #   ...

            # @see OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta#function
            class Function < OpenAI::Internal::Type::BaseModel
              # @!attribute arguments
              #   The arguments passed to the function.
              #
              #   @return [String, nil]
              optional :arguments, String

              # @!attribute name
              #   The name of the function.
              #
              #   @return [String, nil]
              optional :name, String

              # @!attribute output
              #   The output of the function. This will be `null` if the outputs have not been
              #   [submitted](https://platform.openai.com/docs/api-reference/runs/submitToolOutputs)
              #   yet.
              #
              #   @return [String, nil]
              optional :output, String, nil?: true

              # @!method initialize(arguments: nil, name: nil, output: nil)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function} for more
              #   details.
              #
              #   The definition of the function that was called.
              #
              #   @param arguments [String] The arguments passed to the function.
              #
              #   @param name [String] The name of the function.
              #
              #   @param output [String, nil] The output of the function. This will be `null` if the outputs have not been [su
              #   ...
            end
          end
        end
      end
    end
  end
end
