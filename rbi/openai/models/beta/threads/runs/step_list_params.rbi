# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class StepListParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::Runs::StepListParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :thread_id

            # A cursor for use in pagination. `after` is an object ID that defines your place
            # in the list. For instance, if you make a list request and receive 100 objects,
            # ending with obj_foo, your subsequent call can include after=obj_foo in order to
            # fetch the next page of the list.
            sig { returns(T.nilable(String)) }
            attr_reader :after

            sig { params(after: String).void }
            attr_writer :after

            # A cursor for use in pagination. `before` is an object ID that defines your place
            # in the list. For instance, if you make a list request and receive 100 objects,
            # starting with obj_foo, your subsequent call can include before=obj_foo in order
            # to fetch the previous page of the list.
            sig { returns(T.nilable(String)) }
            attr_reader :before

            sig { params(before: String).void }
            attr_writer :before

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

            # A limit on the number of objects to be returned. Limit can range between 1 and
            # 100, and the default is 20.
            sig { returns(T.nilable(Integer)) }
            attr_reader :limit

            sig { params(limit: Integer).void }
            attr_writer :limit

            # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
            # order and `desc` for descending order.
            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::Threads::Runs::StepListParams::Order::OrSymbol
                )
              )
            end
            attr_reader :order

            sig do
              params(
                order:
                  OpenAI::Beta::Threads::Runs::StepListParams::Order::OrSymbol
              ).void
            end
            attr_writer :order

            sig do
              params(
                thread_id: String,
                after: String,
                before: String,
                include:
                  T::Array[
                    OpenAI::Beta::Threads::Runs::RunStepInclude::OrSymbol
                  ],
                limit: Integer,
                order:
                  OpenAI::Beta::Threads::Runs::StepListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              thread_id:,
              # A cursor for use in pagination. `after` is an object ID that defines your place
              # in the list. For instance, if you make a list request and receive 100 objects,
              # ending with obj_foo, your subsequent call can include after=obj_foo in order to
              # fetch the next page of the list.
              after: nil,
              # A cursor for use in pagination. `before` is an object ID that defines your place
              # in the list. For instance, if you make a list request and receive 100 objects,
              # starting with obj_foo, your subsequent call can include before=obj_foo in order
              # to fetch the previous page of the list.
              before: nil,
              # A list of additional fields to include in the response. Currently the only
              # supported value is `step_details.tool_calls[*].file_search.results[*].content`
              # to fetch the file search result content.
              #
              # See the
              # [file search tool documentation](https://platform.openai.com/docs/assistants/tools/file-search#customizing-file-search-settings)
              # for more information.
              include: nil,
              # A limit on the number of objects to be returned. Limit can range between 1 and
              # 100, and the default is 20.
              limit: nil,
              # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
              # order and `desc` for descending order.
              order: nil,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  thread_id: String,
                  after: String,
                  before: String,
                  include:
                    T::Array[
                      OpenAI::Beta::Threads::Runs::RunStepInclude::OrSymbol
                    ],
                  limit: Integer,
                  order:
                    OpenAI::Beta::Threads::Runs::StepListParams::Order::OrSymbol,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
            # order and `desc` for descending order.
            module Order
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Beta::Threads::Runs::StepListParams::Order
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              ASC =
                T.let(
                  :asc,
                  OpenAI::Beta::Threads::Runs::StepListParams::Order::TaggedSymbol
                )
              DESC =
                T.let(
                  :desc,
                  OpenAI::Beta::Threads::Runs::StepListParams::Order::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::Threads::Runs::StepListParams::Order::TaggedSymbol
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
end
