# typed: strong

module OpenAI
  module Models
    module Evals
      class RunListParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # Identifier for the last run from the previous pagination request.
        sig { returns(T.nilable(String)) }
        attr_reader :after

        sig { params(after: String).void }
        attr_writer :after

        # Number of runs to retrieve.
        sig { returns(T.nilable(Integer)) }
        attr_reader :limit

        sig { params(limit: Integer).void }
        attr_writer :limit

        # Sort order for runs by timestamp. Use `asc` for ascending order or `desc` for
        # descending order. Defaults to `asc`.
        sig { returns(T.nilable(OpenAI::Models::Evals::RunListParams::Order::OrSymbol)) }
        attr_reader :order

        sig { params(order: OpenAI::Models::Evals::RunListParams::Order::OrSymbol).void }
        attr_writer :order

        # Filter runs by status. One of `queued` | `in_progress` | `failed` | `completed`
        # | `canceled`.
        sig { returns(T.nilable(OpenAI::Models::Evals::RunListParams::Status::OrSymbol)) }
        attr_reader :status

        sig { params(status: OpenAI::Models::Evals::RunListParams::Status::OrSymbol).void }
        attr_writer :status

        sig do
          params(
            after: String,
            limit: Integer,
            order: OpenAI::Models::Evals::RunListParams::Order::OrSymbol,
            status: OpenAI::Models::Evals::RunListParams::Status::OrSymbol,
            request_options: T.any(OpenAI::RequestOptions, OpenAI::Internal::AnyHash)
          )
            .returns(T.attached_class)
        end
        def self.new(after: nil, limit: nil, order: nil, status: nil, request_options: {}); end

        sig do
          override
            .returns(
              {
                after: String,
                limit: Integer,
                order: OpenAI::Models::Evals::RunListParams::Order::OrSymbol,
                status: OpenAI::Models::Evals::RunListParams::Status::OrSymbol,
                request_options: OpenAI::RequestOptions
              }
            )
        end
        def to_hash; end

        # Sort order for runs by timestamp. Use `asc` for ascending order or `desc` for
        # descending order. Defaults to `asc`.
        module Order
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Evals::RunListParams::Order) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ASC = T.let(:asc, OpenAI::Models::Evals::RunListParams::Order::TaggedSymbol)
          DESC = T.let(:desc, OpenAI::Models::Evals::RunListParams::Order::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Evals::RunListParams::Order::TaggedSymbol]) }
          def self.values; end
        end

        # Filter runs by status. One of `queued` | `in_progress` | `failed` | `completed`
        # | `canceled`.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Evals::RunListParams::Status) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          QUEUED = T.let(:queued, OpenAI::Models::Evals::RunListParams::Status::TaggedSymbol)
          IN_PROGRESS = T.let(:in_progress, OpenAI::Models::Evals::RunListParams::Status::TaggedSymbol)
          COMPLETED = T.let(:completed, OpenAI::Models::Evals::RunListParams::Status::TaggedSymbol)
          CANCELED = T.let(:canceled, OpenAI::Models::Evals::RunListParams::Status::TaggedSymbol)
          FAILED = T.let(:failed, OpenAI::Models::Evals::RunListParams::Status::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Evals::RunListParams::Status::TaggedSymbol]) }
          def self.values; end
        end
      end
    end
  end
end
