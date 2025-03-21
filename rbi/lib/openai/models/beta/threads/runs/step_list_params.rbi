# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class StepListParams < OpenAI::BaseModel
            extend OpenAI::RequestParameters::Converter
            include OpenAI::RequestParameters

            sig { returns(String) }
            def thread_id
            end

            sig { params(_: String).returns(String) }
            def thread_id=(_)
            end

            # A cursor for use in pagination. `after` is an object ID that defines your place
            #   in the list. For instance, if you make a list request and receive 100 objects,
            #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
            #   fetch the next page of the list.
            sig { returns(T.nilable(String)) }
            def after
            end

            sig { params(_: String).returns(String) }
            def after=(_)
            end

            # A cursor for use in pagination. `before` is an object ID that defines your place
            #   in the list. For instance, if you make a list request and receive 100 objects,
            #   starting with obj_foo, your subsequent call can include before=obj_foo in order
            #   to fetch the previous page of the list.
            sig { returns(T.nilable(String)) }
            def before
            end

            sig { params(_: String).returns(String) }
            def before=(_)
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

            # A limit on the number of objects to be returned. Limit can range between 1 and
            #   100, and the default is 20.
            sig { returns(T.nilable(Integer)) }
            def limit
            end

            sig { params(_: Integer).returns(Integer) }
            def limit=(_)
            end

            # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
            #   order and `desc` for descending order.
            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::StepListParams::Order::OrSymbol)) }
            def order
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Runs::StepListParams::Order::OrSymbol)
                .returns(OpenAI::Models::Beta::Threads::Runs::StepListParams::Order::OrSymbol)
            end
            def order=(_)
            end

            sig do
              params(
                thread_id: String,
                after: String,
                before: String,
                include: T::Array[OpenAI::Models::Beta::Threads::Runs::RunStepInclude::OrSymbol],
                limit: Integer,
                order: OpenAI::Models::Beta::Threads::Runs::StepListParams::Order::OrSymbol,
                request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
              )
                .returns(T.attached_class)
            end
            def self.new(thread_id:, after: nil, before: nil, include: nil, limit: nil, order: nil, request_options: {})
            end

            sig do
              override
                .returns(
                  {
                    thread_id: String,
                    after: String,
                    before: String,
                    include: T::Array[OpenAI::Models::Beta::Threads::Runs::RunStepInclude::OrSymbol],
                    limit: Integer,
                    order: OpenAI::Models::Beta::Threads::Runs::StepListParams::Order::OrSymbol,
                    request_options: OpenAI::RequestOptions
                  }
                )
            end
            def to_hash
            end

            # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
            #   order and `desc` for descending order.
            module Order
              extend OpenAI::Enum

              TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Runs::StepListParams::Order) }
              OrSymbol =
                T.type_alias { T.any(Symbol, OpenAI::Models::Beta::Threads::Runs::StepListParams::Order::TaggedSymbol) }

              ASC = T.let(:asc, OpenAI::Models::Beta::Threads::Runs::StepListParams::Order::TaggedSymbol)
              DESC = T.let(:desc, OpenAI::Models::Beta::Threads::Runs::StepListParams::Order::TaggedSymbol)

              class << self
                sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::Runs::StepListParams::Order::TaggedSymbol]) }
                def values
                end
              end
            end
          end
        end
      end
    end
  end
end
