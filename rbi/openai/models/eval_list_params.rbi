# typed: strong

module OpenAI
  module Models
    class EvalListParams < OpenAI::Internal::Type::BaseModel
      extend OpenAI::Internal::Type::RequestParameters::Converter
      include OpenAI::Internal::Type::RequestParameters

      OrHash =
        T.type_alias do
          T.any(OpenAI::EvalListParams, OpenAI::Internal::AnyHash)
        end

      # Identifier for the last eval from the previous pagination request.
      sig { returns(T.nilable(String)) }
      attr_reader :after

      sig { params(after: String).void }
      attr_writer :after

      # Number of evals to retrieve.
      sig { returns(T.nilable(Integer)) }
      attr_reader :limit

      sig { params(limit: Integer).void }
      attr_writer :limit

      # Sort order for evals by timestamp. Use `asc` for ascending order or `desc` for
      # descending order.
      sig { returns(T.nilable(OpenAI::EvalListParams::Order::OrSymbol)) }
      attr_reader :order

      sig { params(order: OpenAI::EvalListParams::Order::OrSymbol).void }
      attr_writer :order

      # Evals can be ordered by creation time or last updated time. Use `created_at` for
      # creation time or `updated_at` for last updated time.
      sig { returns(T.nilable(OpenAI::EvalListParams::OrderBy::OrSymbol)) }
      attr_reader :order_by

      sig { params(order_by: OpenAI::EvalListParams::OrderBy::OrSymbol).void }
      attr_writer :order_by

      sig do
        params(
          after: String,
          limit: Integer,
          order: OpenAI::EvalListParams::Order::OrSymbol,
          order_by: OpenAI::EvalListParams::OrderBy::OrSymbol,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(T.attached_class)
      end
      def self.new(
        # Identifier for the last eval from the previous pagination request.
        after: nil,
        # Number of evals to retrieve.
        limit: nil,
        # Sort order for evals by timestamp. Use `asc` for ascending order or `desc` for
        # descending order.
        order: nil,
        # Evals can be ordered by creation time or last updated time. Use `created_at` for
        # creation time or `updated_at` for last updated time.
        order_by: nil,
        request_options: {}
      )
      end

      sig do
        override.returns(
          {
            after: String,
            limit: Integer,
            order: OpenAI::EvalListParams::Order::OrSymbol,
            order_by: OpenAI::EvalListParams::OrderBy::OrSymbol,
            request_options: OpenAI::RequestOptions
          }
        )
      end
      def to_hash
      end

      # Sort order for evals by timestamp. Use `asc` for ascending order or `desc` for
      # descending order.
      module Order
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::EvalListParams::Order) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        ASC = T.let(:asc, OpenAI::EvalListParams::Order::TaggedSymbol)
        DESC = T.let(:desc, OpenAI::EvalListParams::Order::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::EvalListParams::Order::TaggedSymbol]
          )
        end
        def self.values
        end
      end

      # Evals can be ordered by creation time or last updated time. Use `created_at` for
      # creation time or `updated_at` for last updated time.
      module OrderBy
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::EvalListParams::OrderBy) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        CREATED_AT =
          T.let(:created_at, OpenAI::EvalListParams::OrderBy::TaggedSymbol)
        UPDATED_AT =
          T.let(:updated_at, OpenAI::EvalListParams::OrderBy::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::EvalListParams::OrderBy::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end
