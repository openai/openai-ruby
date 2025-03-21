# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          # Details of the Code Interpreter tool call the run step was involved in.
          module ToolCallDelta
            extend OpenAI::Union

            discriminator :type

            # Details of the Code Interpreter tool call the run step was involved in.
            variant :code_interpreter, -> { OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta }

            variant :file_search, -> { OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta }

            variant :function, -> { OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta }

            # @!parse
            #   # @return [Array(OpenAI::Models::Beta::Threads::Runs::CodeInterpreterToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FileSearchToolCallDelta, OpenAI::Models::Beta::Threads::Runs::FunctionToolCallDelta)]
            #   def self.variants; end
          end
        end
      end
    end
  end
end
