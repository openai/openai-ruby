# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          module RunStepInclude
            extend OpenAI::Enum

            STEP_DETAILS_TOOL_CALLS_FILE_SEARCH_RESULTS_CONTENT =
              :"step_details.tool_calls[*].file_search.results[*].content"

            finalize!

            # @!parse
            #   # @return [Array<Symbol>]
            #   def self.values; end
          end
        end

        RunStepInclude = Runs::RunStepInclude
      end
    end
  end
end
