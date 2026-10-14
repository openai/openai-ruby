# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          module ServiceAccounts
            class APIKeyCreateResponse < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::Projects::ServiceAccounts::APIKeyCreateResponse,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The identifier of the API key.
              sig { returns(String) }
              attr_accessor :id

              # The Unix timestamp (in seconds) when the API key was created.
              sig { returns(Integer) }
              attr_accessor :created_at

              # The name of the API key.
              sig { returns(String) }
              attr_accessor :name

              # The object type, which is always `organization.project.service_account.api_key`
              sig { returns(Symbol) }
              attr_accessor :object

              # The unredacted API key value.
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
                # The identifier of the API key.
                id:,
                # The Unix timestamp (in seconds) when the API key was created.
                created_at:,
                # The name of the API key.
                name:,
                # The unredacted API key value.
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
