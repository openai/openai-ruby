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
        sig { returns(T.nilable(OpenAI::Models::Responses::InputItemListParams::Order::OrSymbol)) }
        def order
        end

        sig do
          params(_: OpenAI::Models::Responses::InputItemListParams::Order::OrSymbol)
            .returns(OpenAI::Models::Responses::InputItemListParams::Order::OrSymbol)
        end
        def order=(_)
        end

        sig do
          params(
            after: String,
            before: String,
            limit: Integer,
            order: OpenAI::Models::Responses::InputItemListParams::Order::OrSymbol,
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
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
                order: OpenAI::Models::Responses::InputItemListParams::Order::OrSymbol,
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
        module Order
          extend OpenAI::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::InputItemListParams::Order) }
          OrSymbol =
            T.type_alias { T.any(Symbol, OpenAI::Models::Responses::InputItemListParams::Order::TaggedSymbol) }

          ASC = T.let(:asc, OpenAI::Models::Responses::InputItemListParams::Order::TaggedSymbol)
          DESC = T.let(:desc, OpenAI::Models::Responses::InputItemListParams::Order::TaggedSymbol)

          class << self
            sig { override.returns(T::Array[OpenAI::Models::Responses::InputItemListParams::Order::TaggedSymbol]) }
            def values
            end
          end
        end
      end
    end
  end
end
