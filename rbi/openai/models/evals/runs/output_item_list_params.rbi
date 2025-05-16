# typed: strong

module OpenAI
  module Models
    module Evals
      module Runs
        class OutputItemListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Evals::Runs::OutputItemListParams,
                OpenAI::Internal::AnyHash
              )
            end

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
          sig do
            returns(
              T.nilable(
                OpenAI::Evals::Runs::OutputItemListParams::Order::OrSymbol
              )
            )
          end
          attr_reader :order

          sig do
            params(
              order: OpenAI::Evals::Runs::OutputItemListParams::Order::OrSymbol
            ).void
          end
          attr_writer :order

          # Filter output items by status. Use `failed` to filter by failed output items or
          # `pass` to filter by passed output items.
          sig do
            returns(
              T.nilable(
                OpenAI::Evals::Runs::OutputItemListParams::Status::OrSymbol
              )
            )
          end
          attr_reader :status

          sig do
            params(
              status:
                OpenAI::Evals::Runs::OutputItemListParams::Status::OrSymbol
            ).void
          end
          attr_writer :status

          sig do
            params(
              eval_id: String,
              after: String,
              limit: Integer,
              order: OpenAI::Evals::Runs::OutputItemListParams::Order::OrSymbol,
              status:
                OpenAI::Evals::Runs::OutputItemListParams::Status::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
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
          )
          end

          sig do
            override.returns(
              {
                eval_id: String,
                after: String,
                limit: Integer,
                order:
                  OpenAI::Evals::Runs::OutputItemListParams::Order::OrSymbol,
                status:
                  OpenAI::Evals::Runs::OutputItemListParams::Status::OrSymbol,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # Sort order for output items by timestamp. Use `asc` for ascending order or
          # `desc` for descending order. Defaults to `asc`.
          module Order
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Evals::Runs::OutputItemListParams::Order)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ASC =
              T.let(
                :asc,
                OpenAI::Evals::Runs::OutputItemListParams::Order::TaggedSymbol
              )
            DESC =
              T.let(
                :desc,
                OpenAI::Evals::Runs::OutputItemListParams::Order::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Evals::Runs::OutputItemListParams::Order::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end

          # Filter output items by status. Use `failed` to filter by failed output items or
          # `pass` to filter by passed output items.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Evals::Runs::OutputItemListParams::Status)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            FAIL =
              T.let(
                :fail,
                OpenAI::Evals::Runs::OutputItemListParams::Status::TaggedSymbol
              )
            PASS =
              T.let(
                :pass,
                OpenAI::Evals::Runs::OutputItemListParams::Status::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Evals::Runs::OutputItemListParams::Status::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
