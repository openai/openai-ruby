# typed: strong

module OpenAI
  module Models
    module Evals
      module Runs
        class OutputItemListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          sig { returns(String) }
          attr_accessor :eval_id

          # Identifier for the last output item from the previous pagination request.
          sig { returns(T.nilable(String)) }
          attr_reader :after

          sig { params(after: String).void }
          attr_writer :after

          # Number of output items to retrieve.
          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          # Sort order for output items by timestamp. Use `asc` for ascending order or
          # `desc` for descending order. Defaults to `asc`.
          sig { returns(T.nilable(OpenAI::Models::Evals::Runs::OutputItemListParams::Order::OrSymbol)) }
          attr_reader :order

          sig { params(order: OpenAI::Models::Evals::Runs::OutputItemListParams::Order::OrSymbol).void }
          attr_writer :order

          # Filter output items by status. Use `failed` to filter by failed output items or
          # `pass` to filter by passed output items.
          sig { returns(T.nilable(OpenAI::Models::Evals::Runs::OutputItemListParams::Status::OrSymbol)) }
          attr_reader :status

          sig { params(status: OpenAI::Models::Evals::Runs::OutputItemListParams::Status::OrSymbol).void }
          attr_writer :status

          sig do
            params(
              eval_id: String,
              after: String,
              limit: Integer,
              order: OpenAI::Models::Evals::Runs::OutputItemListParams::Order::OrSymbol,
              status: OpenAI::Models::Evals::Runs::OutputItemListParams::Status::OrSymbol,
              request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
            )
              .returns(T.attached_class)
          end
          def self.new(
            eval_id:,
            # Identifier for the last output item from the previous pagination request.
            after: nil,
            # Number of output items to retrieve.
            limit: nil,
            # Sort order for output items by timestamp. Use `asc` for ascending order or
            # `desc` for descending order. Defaults to `asc`.
            order: nil,
            # Filter output items by status. Use `failed` to filter by failed output items or
            # `pass` to filter by passed output items.
            status: nil,
            request_options: {}
          ); end
          sig do
            override
              .returns(
                {
                  eval_id: String,
                  after: String,
                  limit: Integer,
                  order: OpenAI::Models::Evals::Runs::OutputItemListParams::Order::OrSymbol,
                  status: OpenAI::Models::Evals::Runs::OutputItemListParams::Status::OrSymbol,
                  request_options: OpenAI::RequestOptions
                }
              )
          end
          def to_hash; end

          # Sort order for output items by timestamp. Use `asc` for ascending order or
          # `desc` for descending order. Defaults to `asc`.
          module Order
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Evals::Runs::OutputItemListParams::Order) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ASC = T.let(:asc, OpenAI::Models::Evals::Runs::OutputItemListParams::Order::TaggedSymbol)
            DESC = T.let(:desc, OpenAI::Models::Evals::Runs::OutputItemListParams::Order::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::Evals::Runs::OutputItemListParams::Order::TaggedSymbol]) }
            def self.values; end
          end

          # Filter output items by status. Use `failed` to filter by failed output items or
          # `pass` to filter by passed output items.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Evals::Runs::OutputItemListParams::Status) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            FAIL = T.let(:fail, OpenAI::Models::Evals::Runs::OutputItemListParams::Status::TaggedSymbol)
            PASS = T.let(:pass, OpenAI::Models::Evals::Runs::OutputItemListParams::Status::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Models::Evals::Runs::OutputItemListParams::Status::TaggedSymbol]) }
            def self.values; end
          end
        end
      end
    end
  end
end
