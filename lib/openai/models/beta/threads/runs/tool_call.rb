# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          # @abstract
          #
          # Details of the Code Interpreter tool call the run step was involved in.
          class ToolCall < OpenAI::Union
            discriminator :type

            # Details of the Code Interpreter tool call the run step was involved in.
            variant :code_interpreter, -> { OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCall }

            variant :file_search, -> { OpenAI::Models::Beta::Threads::Runs::FileSearchToolCall }

            variant :function, -> { OpenAI::Models::Beta::Threads::Runs::FunctionToolCall }
          end
        end
      end
    end
  end
end
