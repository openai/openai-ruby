# typed: strong

module OpenAI
  module Models
    class VideoListParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::VideoListParams, OpenAI::Internal::AnyHash)
        end

      # Identifier for the last item from the previous pagination request
      sig { returns(T.nilable(String)) }
      attr_reader :after

      sig { params(after: String).void }
      attr_writer :after

      # Number of items to retrieve
      sig { returns(T.nilable(Integer)) }
      attr_reader :limit

      sig { params(limit: Integer).void }
      attr_writer :limit

      # Sort order of results by timestamp. Use `asc` for ascending order or `desc` for
      # descending order.
      sig { returns(T.nilable(OpenAI::VideoListParams::Order::OrSymbol)) }
      attr_reader :order

      sig { params(order: OpenAI::VideoListParams::Order::OrSymbol).void }
      attr_writer :order

      sig do
        params(
          after: String,
          limit: Integer,
          order: OpenAI::VideoListParams::Order::OrSymbol,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # Identifier for the last item from the previous pagination request
        after: nil,
        # Number of items to retrieve
        limit: nil,
        # Sort order of results by timestamp. Use `asc` for ascending order or `desc` for
        # descending order.
        order: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            after: String,
            limit: Integer,
            order: OpenAI::VideoListParams::Order::OrSymbol,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # Sort order of results by timestamp. Use `asc` for ascending order or `desc` for
      # descending order.
      module Order
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::VideoListParams::Order) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        ASC = T.let(:asc, OpenAI::VideoListParams::Order::TaggedSymbol)
        DESC = T.let(:desc, OpenAI::VideoListParams::Order::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::VideoListParams::Order::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end
