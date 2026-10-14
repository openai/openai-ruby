# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Users
          class RoleListParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Users::RoleListParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :user_id

            # Cursor for pagination. Provide the value from the previous response's `next`
            # field to continue listing organization roles.
            sig { returns(T.nilable(String)) }
            attr_reader :after

            sig { params(after: String).void }
            attr_writer :after

            # A limit on the number of organization role assignments to return.
            sig { returns(T.nilable(Integer)) }
            attr_reader :limit

            sig { params(limit: Integer).void }
            attr_writer :limit

            # Sort order for the returned organization roles.
            sig do
              returns(
                T.nilable(
                  OpenAI::Admin::Organization::Users::RoleListParams::Order::OrSymbol
                )
              )
            end
            attr_reader :order

            sig do
              params(
                order:
                  OpenAI::Admin::Organization::Users::RoleListParams::Order::OrSymbol
              ).void
            end
            attr_writer :order

            sig do
              params(
                user_id: String,
                after: String,
                limit: Integer,
                order:
                  OpenAI::Admin::Organization::Users::RoleListParams::Order::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              user_id:,
              # Cursor for pagination. Provide the value from the previous response's `next`
              # field to continue listing organization roles.
              after: nil,
              # A limit on the number of organization role assignments to return.
              limit: nil,
              # Sort order for the returned organization roles.
              order: nil,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  user_id: String,
                  after: String,
                  limit: Integer,
                  order:
                    OpenAI::Admin::Organization::Users::RoleListParams::Order::OrSymbol,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # Sort order for the returned organization roles.
            module Order
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Users::RoleListParams::Order
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              ASC =
                T.let(
                  :asc,
                  OpenAI::Admin::Organization::Users::RoleListParams::Order::TaggedSymbol
                )
              DESC =
                T.let(
                  :desc,
                  OpenAI::Admin::Organization::Users::RoleListParams::Order::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Users::RoleListParams::Order::TaggedSymbol
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
end
