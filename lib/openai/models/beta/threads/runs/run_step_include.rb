# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          # @abstract
          class RunStepInclude < OpenAI::Enum
            STEP_DETAILS_TOOL_CALLS_FILE_SEARCH_RESULTS_CONTENT =
              :"step_details.tool_calls[*].file_search.results[*].content"

            finalize!
          end
        end

        RunStepInclude = Runs::RunStepInclude
      end
    end
  end
end
