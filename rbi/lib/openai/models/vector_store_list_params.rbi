# typed: strong

module OpenAI
  module Models
    class VectorStoreListParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

      # A cursor for use in pagination. `after` is an object ID that defines your place
      #   in the list. For instance, if you make a list request and receive 100 objects,
      #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
      #   fetch the next page of the list.
      sig { returns(T.nilable(String)) }
      attr_reader :after

      sig { params(after: String).void }
      attr_writer :after

      # A cursor for use in pagination. `before` is an object ID that defines your place
      #   in the list. For instance, if you make a list request and receive 100 objects,
      #   starting with obj_foo, your subsequent call can include before=obj_foo in order
      #   to fetch the previous page of the list.
      sig { returns(T.nilable(String)) }
      attr_reader :before

      sig { params(before: String).void }
      attr_writer :before

      # A limit on the number of objects to be returned. Limit can range between 1 and
      #   100, and the default is 20.
      sig { returns(T.nilable(Integer)) }
      attr_reader :limit

      sig { params(limit: Integer).void }
      attr_writer :limit

      # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
      #   order and `desc` for descending order.
      sig { returns(T.nilable(OpenAI::Models::VectorStoreListParams::Order::OrSymbol)) }
      attr_reader :order

      sig { params(order: OpenAI::Models::VectorStoreListParams::Order::OrSymbol).void }
      attr_writer :order

      sig do
        params(
          after: String,
          before: String,
          limit: Integer,
          order: OpenAI::Models::VectorStoreListParams::Order::OrSymbol,
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
              order: OpenAI::Models::VectorStoreListParams::Order::OrSymbol,
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

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::VectorStoreListParams::Order) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::VectorStoreListParams::Order::TaggedSymbol) }

        ASC = T.let(:asc, OpenAI::Models::VectorStoreListParams::Order::TaggedSymbol)
        DESC = T.let(:desc, OpenAI::Models::VectorStoreListParams::Order::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::VectorStoreListParams::Order::TaggedSymbol]) }
        def self.values
        end
      end
    end
  end
end
