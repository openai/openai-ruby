# typed: strong

module OpenAI
  module Models
    module Responses
      class InputItemListParams < OpenAI::BaseModel
        extend OpenAI::RequestParameters::Converter
        include OpenAI::RequestParameters

        # An item ID to list items after, used in pagination.
        sig { returns(T.nilable(String)) }
        def after
        end

        sig { params(_: String).returns(String) }
        def after=(_)
        end

        # An item ID to list items before, used in pagination.
        sig { returns(T.nilable(String)) }
        def before
        end

        sig { params(_: String).returns(String) }
        def before=(_)
        end

        # A limit on the number of objects to be returned. Limit can range between 1 and
        #   100, and the default is 20.
        sig { returns(T.nilable(Integer)) }
        def limit
        end

        sig { params(_: Integer).returns(Integer) }
        def limit=(_)
        end

        # The order to return the input items in. Default is `asc`.
        #
        #   - `asc`: Return the input items in ascending order.
        #   - `desc`: Return the input items in descending order.
        sig { returns(T.nilable(Symbol)) }
        def order
        end

        sig { params(_: Symbol).returns(Symbol) }
        def order=(_)
        end

        sig do
          params(
            after: String,
            before: String,
            limit: Integer,
            order: Symbol,
            request_options: T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything])
          )
            .returns(T.attached_class)
        end
        def self.new(after: nil, before: nil, limit: nil, order: nil, request_options: {})
        end

        sig do
          override
            .returns(
              {
                after: String,
                before: String,
                limit: Integer,
                order: Symbol,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash
        end

        # The order to return the input items in. Default is `asc`.
        #
        #   - `asc`: Return the input items in ascending order.
        #   - `desc`: Return the input items in descending order.
        class Order < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          ASC = :asc
          DESC = :desc
        end
      end
    end
  end
end
