# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class ServiceAccountUpdateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::ServiceAccountUpdateParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

            sig { returns(String) }
            attr_accessor :service_account_id

            # The updated service account name.
            sig { returns(T.nilable(String)) }
            attr_reader :name

            sig { params(name: String).void }
            attr_writer :name

            # The updated service account role.
            sig do
              returns(
                T.nilable(
                  OpenAI::Admin::Organization::Projects::ServiceAccountUpdateParams::Role::OrSymbol
                )
              )
            end
            attr_reader :role

            sig do
              params(
                role:
                  OpenAI::Admin::Organization::Projects::ServiceAccountUpdateParams::Role::OrSymbol
              ).void
            end
            attr_writer :role

            sig do
              params(
                project_id: String,
                service_account_id: String,
                name: String,
                role:
                  OpenAI::Admin::Organization::Projects::ServiceAccountUpdateParams::Role::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
              service_account_id:,
              # The updated service account name.
              name: nil,
              # The updated service account role.
              role: nil,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  service_account_id: String,
                  name: String,
                  role:
                    OpenAI::Admin::Organization::Projects::ServiceAccountUpdateParams::Role::OrSymbol,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # The updated service account role.
            module Role
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::ServiceAccountUpdateParams::Role
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              MEMBER =
                T.let(
                  :member,
                  OpenAI::Admin::Organization::Projects::ServiceAccountUpdateParams::Role::TaggedSymbol
                )
              OWNER =
                T.let(
                  :owner,
                  OpenAI::Admin::Organization::Projects::ServiceAccountUpdateParams::Role::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::ServiceAccountUpdateParams::Role::TaggedSymbol
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
