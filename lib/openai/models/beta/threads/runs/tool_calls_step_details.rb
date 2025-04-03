# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class ToolCallsStepDetails < OpenAI::Internal::Type::BaseModel
            # @!attribute tool_calls
            #   An array of tool calls the run step was involved in. These can be associated
            #     with one of three types of tools: `code_interpreter`, `file_search`, or
            #     `function`.
            #
            #   @return [Array<OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall, OpenAI::Models::Beta::Threads::Runs::FunctionToolCall>]
            required :tool_calls,
                     -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Beta::Threads::Runs::ToolCall] }

            # @!attribute type
            #   Always `tool_calls`.
            #
            #   @return [Symbol, :tool_calls]
            required :type, const: :tool_calls

            # @!parse
            #   # Details of the tool call.
            #   #
            #   # @param tool_calls [Array<OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall, OpenAI::Models::Beta::Threads::Runs::FunctionToolCall>]
            #   # @param type [Symbol, :tool_calls]
            #   #
            #   def initialize(tool_calls:, type: :tool_calls, **) = super

            # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
          end
        end
      end
    end
  end
end
