# typed: strong

module OpenAI
  module Models
    module Evals
      class RunListParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(OpenAI::Evals::RunListParams, OpenAI::Internal::AnyHash)
          end

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
        sig do
          returns(T.nilable(OpenAI::Evals::RunListParams::Order::OrSymbol))
        end
        attr_reader :order

        sig do
          params(order: OpenAI::Evals::RunListParams::Order::OrSymbol).void
        end
        attr_writer :order

        # Filter runs by status. One of `queued` | `in_progress` | `failed` | `completed`
        # | `canceled`.
        sig do
          returns(T.nilable(OpenAI::Evals::RunListParams::Status::OrSymbol))
        end
        attr_reader :status

        sig do
          params(status: OpenAI::Evals::RunListParams::Status::OrSymbol).void
        end
        attr_writer :status

        sig do
          params(
            after: String,
            limit: Integer,
            order: OpenAI::Evals::RunListParams::Order::OrSymbol,
            status: OpenAI::Evals::RunListParams::Status::OrSymbol,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Identifier for the last run from the previous pagination request.
          after: nil,
          # Number of runs to retrieve.
          limit: nil,
          # Sort order for runs by timestamp. Use `asc` for ascending order or `desc` for
          # descending order. Defaults to `asc`.
          order: nil,
          # Filter runs by status. One of `queued` | `in_progress` | `failed` | `completed`
          # | `canceled`.
          status: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              after: String,
              limit: Integer,
              order: OpenAI::Evals::RunListParams::Order::OrSymbol,
              status: OpenAI::Evals::RunListParams::Status::OrSymbol,
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end

        # Sort order for runs by timestamp. Use `asc` for ascending order or `desc` for
        # descending order. Defaults to `asc`.
        module Order
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Evals::RunListParams::Order) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          ASC = T.let(:asc, OpenAI::Evals::RunListParams::Order::TaggedSymbol)
          DESC = T.let(:desc, OpenAI::Evals::RunListParams::Order::TaggedSymbol)

          sig do
            override.returns(
              T::Array[OpenAI::Evals::RunListParams::Order::TaggedSymbol]
            )
          end
          def self.values
          end
        end

        # Filter runs by status. One of `queued` | `in_progress` | `failed` | `completed`
        # | `canceled`.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Evals::RunListParams::Status) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          QUEUED =
            T.let(:queued, OpenAI::Evals::RunListParams::Status::TaggedSymbol)
          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Evals::RunListParams::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Evals::RunListParams::Status::TaggedSymbol
            )
          CANCELED =
            T.let(:canceled, OpenAI::Evals::RunListParams::Status::TaggedSymbol)
          FAILED =
            T.let(:failed, OpenAI::Evals::RunListParams::Status::TaggedSymbol)

          sig do
            override.returns(
              T::Array[OpenAI::Evals::RunListParams::Status::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
