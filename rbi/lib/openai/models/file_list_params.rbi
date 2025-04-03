# typed: strong

module OpenAI
  module Models
    class FileListParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      # A cursor for use in pagination. `after` is an object ID that defines your place
      #   in the list. For instance, if you make a list request and receive 100 objects,
      #   ending with obj_foo, your subsequent call can include after=obj_foo in order to
      #   fetch the next page of the list.
      sig { returns(T.nilable(String)) }
      attr_reader :after

      sig { params(after: String).void }
      attr_writer :after

      # A limit on the number of objects to be returned. Limit can range between 1 and
      #   10,000, and the default is 10,000.
      sig { returns(T.nilable(Integer)) }
      attr_reader :limit

      sig { params(limit: Integer).void }
      attr_writer :limit

      # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
      #   order and `desc` for descending order.
      sig { returns(T.nilable(OpenAI::Models::FileListParams::Order::OrSymbol)) }
      attr_reader :order

      sig { params(order: OpenAI::Models::FileListParams::Order::OrSymbol).void }
      attr_writer :order

      # Only return files with the given purpose.
      sig { returns(T.nilable(String)) }
      attr_reader :purpose

      sig { params(purpose: String).void }
      attr_writer :purpose

      sig do
        params(
          after: String,
          limit: Integer,
          order: OpenAI::Models::FileListParams::Order::OrSymbol,
          purpose: String,
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
        )
          .returns(T.attached_class)
      end
      def self.new(after: nil, limit: nil, order: nil, purpose: nil, request_options: {})
      end

      sig do
        override
          .returns(
            {
              after: String,
              limit: Integer,
              order: OpenAI::Models::FileListParams::Order::OrSymbol,
              purpose: String,
              request_options: OpenAI::RequestOptions
            }
          )
      end
      def to_hash
      end

      # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
      #   order and `desc` for descending order.
      module Order
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::FileListParams::Order) }
        OrSymbol = T.type_alias { T.any(Symbol, String, OpenAI::Models::FileListParams::Order::TaggedSymbol) }

        ASC = T.let(:asc, OpenAI::Models::FileListParams::Order::TaggedSymbol)
        DESC = T.let(:desc, OpenAI::Models::FileListParams::Order::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::FileListParams::Order::TaggedSymbol]) }
        def self.values
        end
      end
    end
  end
end
