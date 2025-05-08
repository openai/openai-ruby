# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class ToolCallDeltaObject < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   Always `tool_calls`.
            #
            #   @return [Symbol, :tool_calls]
            required :type, const: :tool_calls

            # @!attribute tool_calls
            #   An array of tool calls the run step was involved in. These can be associated
            #   with one of three types of tools: `code_interpreter`, `file_search`, or
            #   `function`.
            #
            #   @return [Array<OpenAI::Beta::Threads::Runs::CodeInterpreterToolCallDelta, OpenAI::Beta::Threads::Runs::FileSearchToolCallDelta, OpenAI::Beta::Threads::Runs::FunctionToolCallDelta>, nil]
            optional :tool_calls,
                     -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::Threads::Runs::ToolCallDelta] }

            # @!method initialize(tool_calls: nil, type: :tool_calls)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Beta::Threads::Runs::ToolCallDeltaObject} for more details.
            #
            #   Details of the tool call.
            #
            #   @param tool_calls [Array<OpenAI::Beta::Threads::Runs::CodeInterpreterToolCallDelta, OpenAI::Beta::Threads::Runs::FileSearchToolCallDelta, OpenAI::Beta::Threads::Runs::FunctionToolCallDelta>] An array of tool calls the run step was involved in. These can be associated wit
            #
            #   @param type [Symbol, :tool_calls] Always `tool_calls`.
          end
        end
      end
    end
  end
end
