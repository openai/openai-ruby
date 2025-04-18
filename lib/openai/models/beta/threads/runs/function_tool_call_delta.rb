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

            # @!attribute [r] id
            #   The ID of the tool call object.
            #
            #   @return [String, nil]
            optional :id, String

            # @!parse
            #   # @return [String]
            #   attr_writer :id

            # @!attribute [r] function
            #   The definition of the function that was called.
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function, nil]
            optional :function, -> { OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function }

            # @!parse
            #   # @return [OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function]
            #   attr_writer :function

            # @!method initialize(index:, id: nil, function: nil, type: :function)
            #   @param index [Integer]
            #   @param id [String]
            #   @param function [OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta::Function]
            #   @param type [Symbol, :function]

            # @see OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta#function
            class Function < OpenAI::Internal::Type::BaseModel
              # @!attribute [r] arguments
              #   The arguments passed to the function.
              #
              #   @return [String, nil]
              optional :arguments, String

              # @!parse
              #   # @return [String]
              #   attr_writer :arguments

              # @!attribute [r] name
              #   The name of the function.
              #
              #   @return [String, nil]
              optional :name, String

              # @!parse
              #   # @return [String]
              #   attr_writer :name

              # @!attribute output
              #   The output of the function. This will be `null` if the outputs have not been
              #   [submitted](https://platform.openai.com/docs/api-reference/runs/submitToolOutputs)
              #   yet.
              #
              #   @return [String, nil]
              optional :output, String, nil?: true

              # @!method initialize(arguments: nil, name: nil, output: nil)
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
