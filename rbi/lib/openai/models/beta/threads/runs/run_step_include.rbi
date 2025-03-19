# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class RunStepInclude < OpenAI::Enum
            abstract!

            Value = type_template(:out) { {fixed: Symbol} }

            STEP_DETAILS_TOOL_CALLS_FILE_SEARCH_RESULTS_CONTENT =
              :"step_details.tool_calls[*].file_search.results[*].content"
          end
        end

        RunStepInclude = Runs::RunStepInclude
      end
    end
  end
end
