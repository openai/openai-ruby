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

            # @!attribute [r] tool_calls
            #   An array of tool calls the run step was involved in. These can be associated
            #   with one of three types of tools: `code_interpreter`, `file_search`, or
            #   `function`.
            #
            #   @return [Array<OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta>, nil]
            optional :tool_calls,
                     -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Models::Beta::Threads::Runs::ToolCallDelta] }

            # @!parse
            #   # @return [Array<OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta>]
            #   attr_writer :tool_calls

            # @!method initialize(tool_calls: nil, type: :tool_calls)
            #   Details of the tool call.
            #
            #   @param tool_calls [Array<OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta>]
            #   @param type [Symbol, :tool_calls]
          end
        end
      end
    end
  end
end
