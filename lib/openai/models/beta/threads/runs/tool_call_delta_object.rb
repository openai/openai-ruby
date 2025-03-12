# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class ToolCallDeltaObject < OpenAI::BaseModel
            # @!attribute type
            #   Always `tool_calls`.
            #
            #   @return [Symbol, :tool_calls]
            required :type, const: :tool_calls

            # @!attribute [r] tool_calls
            #   An array of tool calls the run step was involved in. These can be associated
            #     with one of three types of tools: `code_interpreter`, `file_search`, or
            #     `function`.
            #
            #   @return [Array<OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta>, nil]
            optional :tool_calls, -> { OpenAI::ArrayOf[union: OpenAI::Models::Beta::Threads::Runs::ToolCallDelta] }

            # @!parse
            #   # @return [Array<OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta>]
            #   attr_writer :tool_calls

            # @!parse
            #   # Details of the tool call.
            #   #
            #   # @param tool_calls [Array<OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta>]
            #   # @param type [Symbol, :tool_calls]
            #   #
            #   def initialize(tool_calls: nil, type: :tool_calls, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void
          end
        end
      end
    end
  end
end
