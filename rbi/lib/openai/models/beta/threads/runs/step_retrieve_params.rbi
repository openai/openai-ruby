# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class StepRetrieveParams < OpenAI::BaseModel
            extend OpenAI::RequestParameters::Converter
            include OpenAI::RequestParameters

            sig { returns(String) }
            def thread_id
            end

            sig { params(_: String).returns(String) }
            def thread_id=(_)
            end

            sig { returns(String) }
            def run_id
            end

            sig { params(_: String).returns(String) }
            def run_id=(_)
            end

            # A list of additional fields to include in the response. Currently the only
            #   supported value is `step_details.tool_calls[*].file_search.results[*].content`
            #   to fetch the file search result content.
            #
            #   See the
            #   [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
            #   for more information.
            sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::Threads::Runs::RunStepInclude::OrSymbol])) }
            def include
            end

            sig do
              params(_: T::Array[OpenAI::Models::Beta::Threads::Runs::RunStepInclude::OrSymbol])
                .returns(T::Array[OpenAI::Models::Beta::Threads::Runs::RunStepInclude::OrSymbol])
            end
            def include=(_)
            end

            sig do
              params(
                thread_id: String,
                run_id: String,
                include: T::Array[OpenAI::Models::Beta::Threads::Runs::RunStepInclude::OrSymbol],
                request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
              )
                .returns(T.attached_class)
            end
            def self.new(thread_id:, run_id:, include: nil, request_options: {})
            end

            sig do
              override
                .returns(
                  {
                    thread_id: String,
                    run_id: String,
                    include: T::Array[OpenAI::Models::Beta::Threads::Runs::RunStepInclude::OrSymbol],
                    request_options: OpenAI::RequestOptions
                  }
                )
            end
            def to_hash
            end
          end
        end
      end
    end
  end
end
