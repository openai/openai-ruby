# typed: strong

module OpenAI
  module Models
    module Admin
      OrganizationUser = Organization::OrganizationUser

      module Organization
        class OrganizationUser < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::OrganizationUser,
                OpenAI::Internal::AnyHash
              )
            end

          # The identifier, which can be referenced in API endpoints
          sig { returns(String) }
          attr_accessor :id

          # The Unix timestamp (in seconds) of when the user was added.
          sig { returns(Integer) }
          attr_accessor :added_at

          # The object type, which is always `organization.user`
          sig { returns(Symbol) }
          attr_accessor :object

          # The Unix timestamp (in seconds) of the user's last API key usage.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :api_key_last_used_at

          # The Unix timestamp (in seconds) of when the user was created.
          sig { returns(T.nilable(Integer)) }
          attr_reader :created

          sig { params(created: Integer).void }
          attr_writer :created

          # The developer persona metadata for the user.
          sig { returns(T.nilable(String)) }
          attr_accessor :developer_persona

          # The email address of the user
          sig { returns(T.nilable(String)) }
          attr_accessor :email

          # Whether this is the organization's default user.
          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :is_default

          sig { params(is_default: T::Boolean).void }
          attr_writer :is_default

          # Whether the user is an authorized purchaser for Scale Tier.
          sig { returns(T.nilable(T::Boolean)) }
          attr_accessor :is_scale_tier_authorized_purchaser

          # Whether the user is managed through SCIM.
          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :is_scim_managed

          sig { params(is_scim_managed: T::Boolean).void }
          attr_writer :is_scim_managed

          # Whether the user is a service account.
          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :is_service_account

          sig { params(is_service_account: T::Boolean).void }
          attr_writer :is_service_account

          # The name of the user
          sig { returns(T.nilable(String)) }
          attr_accessor :name

          # Projects associated with the user, if included.
          sig do
            returns(
              T.nilable(OpenAI::Admin::Organization::OrganizationUser::Projects)
            )
          end
          attr_reader :projects

          sig do
            params(
              projects:
                T.nilable(
                  OpenAI::Admin::Organization::OrganizationUser::Projects::OrHash
                )
            ).void
          end
          attr_writer :projects

          # `owner` or `reader`
          sig { returns(T.nilable(String)) }
          attr_accessor :role

          # The technical level metadata for the user.
          sig { returns(T.nilable(String)) }
          attr_accessor :technical_level

          # Nested user details.
          sig do
            returns(
              T.nilable(OpenAI::Admin::Organization::OrganizationUser::User)
            )
          end
          attr_reader :user

          sig do
            params(
              user: OpenAI::Admin::Organization::OrganizationUser::User::OrHash
            ).void
          end
          attr_writer :user

          # Represents an individual `user` within an organization.
          sig do
            params(
              id: String,
              added_at: Integer,
              api_key_last_used_at: T.nilable(Integer),
              created: Integer,
              developer_persona: T.nilable(String),
              email: T.nilable(String),
              is_default: T::Boolean,
              is_scale_tier_authorized_purchaser: T.nilable(T::Boolean),
              is_scim_managed: T::Boolean,
              is_service_account: T::Boolean,
              name: T.nilable(String),
              projects:
                T.nilable(
                  OpenAI::Admin::Organization::OrganizationUser::Projects::OrHash
                ),
              role: T.nilable(String),
              technical_level: T.nilable(String),
              user: OpenAI::Admin::Organization::OrganizationUser::User::OrHash,
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The identifier, which can be referenced in API endpoints
            id:,
            # The Unix timestamp (in seconds) of when the user was added.
            added_at:,
            # The Unix timestamp (in seconds) of the user's last API key usage.
            api_key_last_used_at: nil,
            # The Unix timestamp (in seconds) of when the user was created.
            created: nil,
            # The developer persona metadata for the user.
            developer_persona: nil,
            # The email address of the user
            email: nil,
            # Whether this is the organization's default user.
            is_default: nil,
            # Whether the user is an authorized purchaser for Scale Tier.
            is_scale_tier_authorized_purchaser: nil,
            # Whether the user is managed through SCIM.
            is_scim_managed: nil,
            # Whether the user is a service account.
            is_service_account: nil,
            # The name of the user
            name: nil,
            # Projects associated with the user, if included.
            projects: nil,
            # `owner` or `reader`
            role: nil,
            # The technical level metadata for the user.
            technical_level: nil,
            # Nested user details.
            user: nil,
            # The object type, which is always `organization.user`
            object: :"organization.user"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                added_at: Integer,
                object: Symbol,
                api_key_last_used_at: T.nilable(Integer),
                created: Integer,
                developer_persona: T.nilable(String),
                email: T.nilable(String),
                is_default: T::Boolean,
                is_scale_tier_authorized_purchaser: T.nilable(T::Boolean),
                is_scim_managed: T::Boolean,
                is_service_account: T::Boolean,
                name: T.nilable(String),
                projects:
                  T.nilable(
                    OpenAI::Admin::Organization::OrganizationUser::Projects
                  ),
                role: T.nilable(String),
                technical_level: T.nilable(String),
                user: OpenAI::Admin::Organization::OrganizationUser::User
              }
            )
          end
          def to_hash
          end

          class Projects < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::OrganizationUser::Projects,
                  OpenAI::Internal::AnyHash
                )
              end

            sig do
              returns(
                T::Array[
                  OpenAI::Admin::Organization::OrganizationUser::Projects::Data
                ]
              )
            end
            attr_accessor :data

            sig { returns(Symbol) }
            attr_accessor :object

            # Projects associated with the user, if included.
            sig do
              params(
                data:
                  T::Array[
                    OpenAI::Admin::Organization::OrganizationUser::Projects::Data::OrHash
                  ],
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(data:, object: :list)
            end

            sig do
              override.returns(
                {
                  data:
                    T::Array[
                      OpenAI::Admin::Organization::OrganizationUser::Projects::Data
                    ],
                  object: Symbol
                }
              )
            end
            def to_hash
            end

            class Data < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Admin::Organization::OrganizationUser::Projects::Data,
                    OpenAI::Internal::AnyHash
                  )
                end

              sig { returns(T.nilable(String)) }
              attr_accessor :id

              sig { returns(T.nilable(String)) }
              attr_accessor :name

              sig { returns(T.nilable(String)) }
              attr_accessor :role

              sig do
                params(
                  id: T.nilable(String),
                  name: T.nilable(String),
                  role: T.nilable(String)
                ).returns(T.attached_class)
              end
              def self.new(id: nil, name: nil, role: nil)
              end

              sig do
                override.returns(
                  {
                    id: T.nilable(String),
                    name: T.nilable(String),
                    role: T.nilable(String)
                  }
                )
              end
              def to_hash
              end
            end
          end

          class User < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::OrganizationUser::User,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :id

            sig { returns(Symbol) }
            attr_accessor :object

            sig { returns(T.nilable(T::Boolean)) }
            attr_accessor :banned

            sig { returns(T.nilable(Integer)) }
            attr_accessor :banned_at

            sig { returns(T.nilable(String)) }
            attr_accessor :email

            sig { returns(T.nilable(T::Boolean)) }
            attr_accessor :enabled

            sig { returns(T.nilable(String)) }
            attr_accessor :name

            sig { returns(T.nilable(String)) }
            attr_accessor :picture

            # Nested user details.
            sig do
              params(
                id: String,
                banned: T.nilable(T::Boolean),
                banned_at: T.nilable(Integer),
                email: T.nilable(String),
                enabled: T.nilable(T::Boolean),
                name: T.nilable(String),
                picture: T.nilable(String),
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              id:,
              banned: nil,
              banned_at: nil,
              email: nil,
              enabled: nil,
              name: nil,
              picture: nil,
              object: :user
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  object: Symbol,
                  banned: T.nilable(T::Boolean),
                  banned_at: T.nilable(Integer),
                  email: T.nilable(String),
                  enabled: T.nilable(T::Boolean),
                  name: T.nilable(String),
                  picture: T.nilable(String)
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
