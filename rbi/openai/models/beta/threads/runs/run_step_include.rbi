# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        RunStepInclude = Runs::RunStepInclude

        module Runs
          module RunStepInclude
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Beta::Threads::Runs::RunStepInclude)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            STEP_DETAILS_TOOL_CALLS_FILE_SEARCH_RESULTS_CONTENT =
              T.let(
                :"step_details.tool_calls[*].file_search.results[*].content",
                OpenAI::Beta::Threads::Runs::RunStepInclude::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::Threads::Runs::RunStepInclude::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
