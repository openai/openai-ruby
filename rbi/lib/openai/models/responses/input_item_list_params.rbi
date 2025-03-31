# typed: strong

module OpenAI
  module Models
    module Responses
      class InputItemListParams < OpenAI::BaseModel
        extend OpenAI::Type::RequestParameters::Converter
        include OpenAI::RequestParameters

        # An item ID to list items after, used in pagination.
        sig { returns(T.nilable(String)) }
        attr_reader :after

        sig { params(after: String).void }
        attr_writer :after

        # An item ID to list items before, used in pagination.
        sig { returns(T.nilable(String)) }
        attr_reader :before

        sig { params(before: String).void }
        attr_writer :before

        # Additional fields to include in the response. See the `include` parameter for
        #   Response creation above for more information.
        sig { returns(T.nilable(T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol])) }
        attr_reader :include

        sig { params(include: T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol]).void }
        attr_writer :include

        # A limit on the number of objects to be returned. Limit can range between 1 and
        #   100, and the default is 20.
        sig { returns(T.nilable(Integer)) }
        attr_reader :limit

        sig { params(limit: Integer).void }
        attr_writer :limit

        # The order to return the input items in. Default is `asc`.
        #
        #   - `asc`: Return the input items in ascending order.
        #   - `desc`: Return the input items in descending order.
        sig { returns(T.nilable(OpenAI::Models::Responses::InputItemListParams::Order::OrSymbol)) }
        attr_reader :order

        sig { params(order: OpenAI::Models::Responses::InputItemListParams::Order::OrSymbol).void }
        attr_writer :order

        sig do
          params(
            after: String,
            before: String,
            include: T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol],
            limit: Integer,
            order: OpenAI::Models::Responses::InputItemListParams::Order::OrSymbol,
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(after: nil, before: nil, include: nil, limit: nil, order: nil, request_options: {})
        end

        sig do
          override
            .returns(
              {
                after: String,
                before: String,
                include: T::Array[OpenAI::Models::Responses::ResponseIncludable::OrSymbol],
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

          sig { override.returns(T::Array[OpenAI::Models::Responses::InputItemListParams::Order::TaggedSymbol]) }
          def self.values
          end
        end
      end
    end
  end
end
