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

            # Service accounts can only have one role of type `member`
            sig { returns(Symbol) }
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
                object: Symbol,
                role: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              id:,
              api_key:,
              created_at:,
              name:,
              object: :"organization.project.service_account",
              # Service accounts can only have one role of type `member`
              role: :member
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
                  role: Symbol
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
          end
        end
      end
    end
  end
end
