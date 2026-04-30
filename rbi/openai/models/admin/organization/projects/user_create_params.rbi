# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class UserCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::UserCreateParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

            # `owner` or `member`
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::UserCreateParams::Role::OrSymbol
              )
            end
            attr_accessor :role

            # The ID of the user.
            sig { returns(String) }
            attr_accessor :user_id

            sig do
              params(
                project_id: String,
                role:
                  OpenAI::Admin::Organization::Projects::UserCreateParams::Role::OrSymbol,
                user_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
              # `owner` or `member`
              role:,
              # The ID of the user.
              user_id:,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  role:
                    OpenAI::Admin::Organization::Projects::UserCreateParams::Role::OrSymbol,
                  user_id: String,
                  request_options: OpenAI::RequestOptions
                }
              )
            end
            def to_hash
            end

            # `owner` or `member`
            module Role
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Admin::Organization::Projects::UserCreateParams::Role
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              OWNER =
                T.let(
                  :owner,
                  OpenAI::Admin::Organization::Projects::UserCreateParams::Role::TaggedSymbol
                )
              MEMBER =
                T.let(
                  :member,
                  OpenAI::Admin::Organization::Projects::UserCreateParams::Role::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::UserCreateParams::Role::TaggedSymbol
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
