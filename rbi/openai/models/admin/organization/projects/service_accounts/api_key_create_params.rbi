# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          module ServiceAccounts
            class APIKeyCreateParams < OpenAI::Internal::Type::BaseModel
              extend OpenAI::Internal::Type::RequestParameters::Converter
              include OpenAI::Internal::Type::RequestParameters

              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::Projects::ServiceAccounts::APIKeyCreateParams,
                    OpenAI::Internal::AnyHash
                  )
                end

              sig { returns(String) }
              attr_accessor :project_id

              sig { returns(String) }
              attr_accessor :service_account_id

              # API key name.
              sig { returns(T.nilable(String)) }
              attr_reader :name

              sig { params(name: String).void }
              attr_writer :name

              # API key scopes.
              sig { returns(T.nilable(T::Array[String])) }
              attr_reader :scopes

              sig { params(scopes: T::Array[String]).void }
              attr_writer :scopes

              sig do
                params(
                  project_id: String,
                  service_account_id: String,
                  name: String,
                  scopes: T::Array[String],
                  request_options: OpenAI::RequestOptions::OrHash
                ).returns(T.attached_class)
              end
              def self.new(
                project_id:,
                service_account_id:,
                # API key name.
                name: nil,
                # API key scopes.
                scopes: nil,
                request_options: {}
              )
              end

              sig do
                override.returns(
                  {
                    project_id: String,
                    service_account_id: String,
                    name: String,
                    scopes: T::Array[String],
                    request_options: OpenAI::RequestOptions
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
