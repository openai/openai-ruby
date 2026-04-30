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

          # The email address of the user
          sig { returns(String) }
          attr_accessor :email

          # The name of the user
          sig { returns(String) }
          attr_accessor :name

          # The object type, which is always `organization.user`
          sig { returns(Symbol) }
          attr_accessor :object

          # `owner` or `reader`
          sig do
            returns(
              OpenAI::Admin::Organization::OrganizationUser::Role::TaggedSymbol
            )
          end
          attr_accessor :role

          # Represents an individual `user` within an organization.
          sig do
            params(
              id: String,
              added_at: Integer,
              email: String,
              name: String,
              role:
                OpenAI::Admin::Organization::OrganizationUser::Role::OrSymbol,
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The identifier, which can be referenced in API endpoints
            id:,
            # The Unix timestamp (in seconds) of when the user was added.
            added_at:,
            # The email address of the user
            email:,
            # The name of the user
            name:,
            # `owner` or `reader`
            role:,
            # The object type, which is always `organization.user`
            object: :"organization.user"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                added_at: Integer,
                email: String,
                name: String,
                object: Symbol,
                role:
                  OpenAI::Admin::Organization::OrganizationUser::Role::TaggedSymbol
              }
            )
          end
          def to_hash
          end

          # `owner` or `reader`
          module Role
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Admin::Organization::OrganizationUser::Role
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            OWNER =
              T.let(
                :owner,
                OpenAI::Admin::Organization::OrganizationUser::Role::TaggedSymbol
              )
            READER =
              T.let(
                :reader,
                OpenAI::Admin::Organization::OrganizationUser::Role::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Admin::Organization::OrganizationUser::Role::TaggedSymbol
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
