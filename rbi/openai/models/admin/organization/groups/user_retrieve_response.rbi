# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          class UserRetrieveResponse < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse,
                  OpenAI::Internal::AnyHash
                )
              end

            # Identifier for the user.
            sig { returns(String) }
            attr_accessor :id

            # Email address of the user, or `null` for users without an email.
            sig { returns(T.nilable(String)) }
            attr_accessor :email

            # Whether the user is a service account.
            sig { returns(T.nilable(T::Boolean)) }
            attr_accessor :is_service_account

            # Display name of the user.
            sig { returns(String) }
            attr_accessor :name

            # URL of the user's profile picture, if available.
            sig { returns(T.nilable(String)) }
            attr_accessor :picture

            # The type of user.
            sig do
              returns(
                OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse::UserType::TaggedSymbol
              )
            end
            attr_accessor :user_type

            # Details about a user returned from an organization group membership lookup.
            sig do
              params(
                id: String,
                email: T.nilable(String),
                is_service_account: T.nilable(T::Boolean),
                name: String,
                picture: T.nilable(String),
                user_type:
                  OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse::UserType::OrSymbol
              ).returns(T.attached_class)
            end
            def self.new(
              # Identifier for the user.
              id:,
              # Email address of the user, or `null` for users without an email.
              email:,
              # Whether the user is a service account.
              is_service_account:,
              # Display name of the user.
              name:,
              # URL of the user's profile picture, if available.
              picture:,
              # The type of user.
              user_type:
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  email: T.nilable(String),
                  is_service_account: T.nilable(T::Boolean),
                  name: String,
                  picture: T.nilable(String),
                  user_type:
                    OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse::UserType::TaggedSymbol
                }
              )
            end
            def to_hash
            end

            # The type of user.
            module UserType
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse::UserType
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              USER =
                T.let(
                  :user,
                  OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse::UserType::TaggedSymbol
                )
              TENANT_USER =
                T.let(
                  :tenant_user,
                  OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse::UserType::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse::UserType::TaggedSymbol
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
