# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          # Details of the Code Interpreter tool call the run step was involved in.
          module ToolCall
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Details of the Code Interpreter tool call the run step was involved in.
            variant :code_interpreter, -> { OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall }

            variant :file_search, -> { OpenAI::Beta::Threads::Runs::FileSearchToolCall }

            variant :function, -> { OpenAI::Beta::Threads::Runs::FunctionToolCall }

            # @!method self.variants
            #   @return [Array(OpenAI::Beta::Threads::Runs::CodeInterpreterToolCall, OpenAI::Beta::Threads::Runs::FileSearchToolCall, OpenAI::Beta::Threads::Runs::FunctionToolCall)]
          end
        end
      end
    end
  end
end
