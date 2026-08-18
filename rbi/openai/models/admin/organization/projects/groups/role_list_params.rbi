# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          module Groups
            class RoleListParams < OpenAI::Internal::Type::BaseModel
              extend OpenAI::Internal::Type::RequestParameters::Converter
              include OpenAI::Internal::Type::RequestParameters

              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::Projects::Groups::RoleListParams,
                    OpenAI::Internal::AnyHash
                  )
                end

              sig { returns(String) }
              attr_accessor :project_id

              sig { returns(String) }
              attr_accessor :group_id

              # Cursor for pagination. Provide the value from the previous response's `next`
              # field to continue listing project roles.
              sig { returns(T.nilable(String)) }
              attr_reader :after

              sig { params(after: String).void }
              attr_writer :after

              # A limit on the number of project role assignments to return.
              sig { returns(T.nilable(Integer)) }
              attr_reader :limit

              sig { params(limit: Integer).void }
              attr_writer :limit

              # Sort order for the returned project roles.
              sig do
                returns(
                  T.nilable(
                    OpenAI::Admin::Organization::Projects::Groups::RoleListParams::Order::OrSymbol
                  )
                )
              end
              attr_reader :order

              sig do
                params(
                  order:
                    OpenAI::Admin::Organization::Projects::Groups::RoleListParams::Order::OrSymbol
                ).void
              end
              attr_writer :order

              sig do
                params(
                  project_id: String,
                  group_id: String,
                  after: String,
                  limit: Integer,
                  order:
                    OpenAI::Admin::Organization::Projects::Groups::RoleListParams::Order::OrSymbol,
                  request_options: OpenAI::RequestOptions::OrHash
                ).returns(T.attached_class)
              end
              def self.new(
                project_id:,
                group_id:,
                # Cursor for pagination. Provide the value from the previous response's `next`
                # field to continue listing project roles.
                after: nil,
                # A limit on the number of project role assignments to return.
                limit: nil,
                # Sort order for the returned project roles.
                order: nil,
                request_options: {}
              )
              end

              sig do
                override.returns(
                  {
                    project_id: String,
                    group_id: String,
                    after: String,
                    limit: Integer,
                    order:
                      OpenAI::Admin::Organization::Projects::Groups::RoleListParams::Order::OrSymbol,
                    request_options: OpenAI::RequestOptions
                  }
                )
              end
              def to_hash
              end

              # Sort order for the returned project roles.
              module Order
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias do
                    T.all(
                      Symbol,
                      OpenAI::Admin::Organization::Projects::Groups::RoleListParams::Order
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                ASC =
                  T.let(
                    :asc,
                    OpenAI::Admin::Organization::Projects::Groups::RoleListParams::Order::TaggedSymbol
                  )
                DESC =
                  T.let(
                    :desc,
                    OpenAI::Admin::Organization::Projects::Groups::RoleListParams::Order::TaggedSymbol
                  )

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Admin::Organization::Projects::Groups::RoleListParams::Order::TaggedSymbol
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
end
