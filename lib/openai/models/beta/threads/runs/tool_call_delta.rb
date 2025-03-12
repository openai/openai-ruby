# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          # @abstract
          #
          # Details of the Code Interpreter tool call the run step was involved in.
          class ToolCallDelta < OpenAI::Union
            discriminator :type

            # Details of the Code Interpreter tool call the run step was involved in.
            variant :code_interpreter, -> { OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta }

            variant :file_search, -> { OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta }

            variant :function, -> { OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta }
          end
        end
      end
    end
  end
end
