# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          # Details of the Code Interpreter tool call the run step was involved in.
          module ToolCallDelta
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # Details of the Code Interpreter tool call the run step was involved in.
            variant :code_interpreter, -> { OpenAI::Beta::Threads::Runs::CodeInterpreterToolCallDelta }

            variant :file_search, -> { OpenAI::Beta::Threads::Runs::FileSearchToolCallDelta }

            variant :function, -> { OpenAI::Beta::Threads::Runs::FunctionToolCallDelta }

            # @!method self.variants
            #   @return [Array(OpenAI::Beta::Threads::Runs::CodeInterpreterToolCallDelta, OpenAI::Beta::Threads::Runs::FileSearchToolCallDelta, OpenAI::Beta::Threads::Runs::FunctionToolCallDelta)]
          end
        end
      end
    end
  end
end
