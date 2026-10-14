# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class ServiceAccountCreateResponse < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :id

            sig do
              returns(
                T.nilable(
                  OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::APIKey
                )
              )
            end
            attr_reader :api_key

            sig do
              params(
                api_key:
                  T.nilable(
                    OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::APIKey::OrHash
                  )
              ).void
            end
            attr_writer :api_key

            sig { returns(Integer) }
            attr_accessor :created_at

            sig { returns(String) }
            attr_accessor :name

            sig { returns(Symbol) }
            attr_accessor :object

            # Service accounts created with default project membership have role `member`.
            # Accounts created with `create_service_account_only` have role `none`.
            sig do
              returns(
                OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::Role::TaggedSymbol
              )
            end
            attr_accessor :role

            sig do
              params(
                id: String,
                api_key:
                  T.nilable(
                    OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::APIKey::OrHash
                  ),
                created_at: Integer,
                name: String,
                role:
                  OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::Role::OrSymbol,
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              id:,
              api_key:,
              created_at:,
              name:,
              # Service accounts created with default project membership have role `member`.
              # Accounts created with `create_service_account_only` have role `none`.
              role:,
              object: :"organization.project.service_account"
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  api_key:
                    T.nilable(
                      OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::APIKey
                    ),
                  created_at: Integer,
                  name: String,
                  object: Symbol,
                  role:
                    OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::Role::TaggedSymbol
                }
              )
            end
            def to_hash
            end

            class APIKey < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::APIKey,
                    OpenAI::Internal::AnyHash
                  )
                end

              sig { returns(String) }
              attr_accessor :id

              sig { returns(Integer) }
              attr_accessor :created_at

              sig { returns(String) }
              attr_accessor :name

              # The object type, which is always `organization.project.service_account.api_key`
              sig { returns(Symbol) }
              attr_accessor :object

              sig { returns(String) }
              attr_accessor :value

              sig do
                params(
                  id: String,
                  created_at: Integer,
                  name: String,
                  value: String,
                  object: Symbol
                ).returns(T.attached_class)
              end
              def self.new(
                id:,
                created_at:,
                name:,
                value:,
                # The object type, which is always `organization.project.service_account.api_key`
                object: :"organization.project.service_account.api_key"
              )
              end

              sig do
                override.returns(
                  {
                    id: String,
                    created_at: Integer,
                    name: String,
                    object: Symbol,
                    value: String
                  }
                )
              end
              def to_hash
              end
            end

            # Service accounts created with default project membership have role `member`.
            # Accounts created with `create_service_account_only` have role `none`.
            module Role
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::Role
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              MEMBER =
                T.let(
                  :member,
                  OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::Role::TaggedSymbol
                )
              NONE =
                T.let(
                  :none,
                  OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::Role::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Models::Admin::Organization::Projects::ServiceAccountCreateResponse::Role::TaggedSymbol
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
