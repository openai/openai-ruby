# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class StepRetrieveParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::Runs::StepRetrieveParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :thread_id

            sig { returns(String) }
            attr_accessor :run_id

            # A list of additional fields to include in the response. Currently the only
            # supported value is `step_details.tool_calls[*].file_search.results[*].content`
            # to fetch the file search result content.
            #
            # See the
            # [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
            # for more information.
            sig do
              returns(
                T.nilable(
                  T::Array[
                    OpenAI::Beta::Threads::Runs::RunStepInclude::OrSymbol
                  ]
                )
              )
            end
            attr_reader :include

            sig do
              params(
                include:
                  T::Array[
                    OpenAI::Beta::Threads::Runs::RunStepInclude::OrSymbol
                  ]
              ).void
            end
            attr_writer :include

            sig do
              params(
                thread_id: String,
                run_id: String,
                include:
                  T::Array[
                    OpenAI::Beta::Threads::Runs::RunStepInclude::OrSymbol
                  ],
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              thread_id:,
              run_id:,
              # A list of additional fields to include in the response. Currently the only
              # supported value is `step_details.tool_calls[*].file_search.results[*].content`
              # to fetch the file search result content.
              #
              # See the
              # [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
              # for more information.
              include: nil,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  thread_id: String,
                  run_id: String,
                  include:
                    T::Array[
                      OpenAI::Beta::Threads::Runs::RunStepInclude::OrSymbol
                    ],
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
