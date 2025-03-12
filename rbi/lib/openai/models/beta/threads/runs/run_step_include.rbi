# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        RunStepInclude = T.type_alias { Runs::RunStepInclude }

        module Runs
          class RunStepInclude < OpenAI::Enum
            abstract!

            STEP_DETAILS_TOOL_CALLS_FILE_SEARCH_RESULTS_CONTENT = :"step_details.tool_calls[*].file_search.results[*].content"

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end
        end
      end
    end
  end
end
