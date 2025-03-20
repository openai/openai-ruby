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
            sig { returns(T.nilable(T::Array[Symbol])) }
            def include
            end

            sig { params(_: T::Array[Symbol]).returns(T::Array[Symbol]) }
            def include=(_)
            end

            sig do
              params(
                thread_id: String,
                run_id: String,
                include: T::Array[Symbol],
                request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
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
                    include: T::Array[Symbol],
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
