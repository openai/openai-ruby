# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class AdminAPIKeyListParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::AdminAPIKeyListParams,
                OpenAI::Internal::AnyHash
              )
            end

          # Return keys with IDs that come after this ID in the pagination order.
          sig { returns(T.nilable(String)) }
          attr_accessor :after

          # Maximum number of keys to return.
          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          # Order results by creation time, ascending or descending.
          sig do
            returns(
              T.nilable(
                OpenAI::Admin::Organization::AdminAPIKeyListParams::Order::OrSymbol
              )
            )
          end
          attr_reader :order

          sig do
            params(
              order:
                OpenAI::Admin::Organization::AdminAPIKeyListParams::Order::OrSymbol
            ).void
          end
          attr_writer :order

          sig do
            params(
              after: T.nilable(String),
              limit: Integer,
              order:
                OpenAI::Admin::Organization::AdminAPIKeyListParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(T.attached_class)
          end
          def self.new(
            # Return keys with IDs that come after this ID in the pagination order.
            after: nil,
            # Maximum number of keys to return.
            limit: nil,
            # Order results by creation time, ascending or descending.
            order: nil,
            request_options: {}
          )
          end

          sig do
            override.returns(
              {
                after: T.nilable(String),
                limit: Integer,
                order:
                  OpenAI::Admin::Organization::AdminAPIKeyListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions
              }
            )
          end
          def to_hash
          end

          # Order results by creation time, ascending or descending.
          module Order
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Admin::Organization::AdminAPIKeyListParams::Order
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ASC =
              T.let(
                :asc,
                OpenAI::Admin::Organization::AdminAPIKeyListParams::Order::TaggedSymbol
              )
            DESC =
              T.let(
                :desc,
                OpenAI::Admin::Organization::AdminAPIKeyListParams::Order::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::AdminAPIKeyListParams::Order::TaggedSymbol
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
