# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class ToolCallsStepDetails < OpenAI::Internal::Type::BaseModel
            # @!attribute tool_calls
            #   An array of tool calls the run step was involved in. These can be associated
            #   with one of three types of tools: `code_interpreter`, `file_search`, or
            #   `function`.
            #
            #   @return [Array<OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall, OpenAI::Models::Beta::Threads::Runs::FunctionToolCall>]
            required :tool_calls, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::Threads::Runs::ToolCall] }

            # @!attribute type
            #   Always `tool_calls`.
            #
            #   @return [Symbol, :tool_calls]
            required :type, const: :tool_calls

            # @!method initialize(tool_calls:, type: :tool_calls)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Beta::Threads::Runs::ToolCallsStepDetails} for more details.
            #
            #   Details of the tool call.
            #
            #   @param tool_calls [Array<OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall, OpenAI::Models::Beta::Threads::Runs::FunctionToolCall>] An array of tool calls the run step was involved in. These can be associated wit
            #
            #   @param type [Symbol, :tool_calls] Always `tool_calls`.
          end
        end
      end
    end
  end
end
