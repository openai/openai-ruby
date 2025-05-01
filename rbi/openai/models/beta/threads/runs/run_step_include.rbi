# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        RunStepInclude = Runs::RunStepInclude

        module Runs
          module RunStepInclude
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Runs::RunStepInclude) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            STEP_DETAILS_TOOL_CALLS_FILE_SEARCH_RESULTS_CONTENT =
              T.let(
                :"step_details.tool_calls[*].file_search.results[*].content",
                OpenAI::Models::Beta::Threads::Runs::RunStepInclude::TaggedSymbol
              )

            sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::Runs::RunStepInclude::TaggedSymbol]) }
            def self.values; end
          end
        end
      end
    end
  end
end
