# typed: strong

module OpenAI
  module Models
    class FileListParams < OpenAI::BaseModel
      extend OpenAI::RequestParameters::Converter
      include OpenAI::RequestParameters

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

      # A limit on the number of objects to be returned. Limit can range between 1 and
      #   10,000, and the default is 10,000.
      sig { returns(T.nilable(Integer)) }
      def limit
      end

      sig { params(_: Integer).returns(Integer) }
      def limit=(_)
      end

      # Sort order by the `created_at` timestamp of the objects. `asc` for ascending
      #   order and `desc` for descending order.
      sig { returns(T.nilable(OpenAI::Models::FileListParams::Order::OrSymbol)) }
      def order
      end

      sig do
        params(_: OpenAI::Models::FileListParams::Order::OrSymbol)
          .returns(OpenAI::Models::FileListParams::Order::OrSymbol)
      end
      def order=(_)
      end

      # Only return files with the given purpose.
      sig { returns(T.nilable(String)) }
      def purpose
      end

      sig { params(_: String).returns(String) }
      def purpose=(_)
      end

      sig do
        params(
          after: String,
          limit: Integer,
          order: OpenAI::Models::FileListParams::Order::OrSymbol,
          purpose: String,
          request_options: T.any(OpenAI::RequestOptions, OpenAI::Util::AnyHash)
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
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::FileListParams::Order) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::FileListParams::Order::TaggedSymbol) }

        ASC = T.let(:asc, OpenAI::Models::FileListParams::Order::TaggedSymbol)
        DESC = T.let(:desc, OpenAI::Models::FileListParams::Order::TaggedSymbol)

        class << self
          sig { override.returns(T::Array[OpenAI::Models::FileListParams::Order::TaggedSymbol]) }
          def values
          end
        end
      end
    end
  end
end
