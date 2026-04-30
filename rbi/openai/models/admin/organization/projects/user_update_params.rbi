# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class UserUpdateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::UserUpdateParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

            sig { returns(String) }
            attr_accessor :user_id

            # `owner` or `member`
            sig do
              returns(
                OpenAI::Admin::Organization::Projects::UserUpdateParams::Role::OrSymbol
              )
            end
            attr_accessor :role

            sig do
              params(
                project_id: String,
                user_id: String,
                role:
                  OpenAI::Admin::Organization::Projects::UserUpdateParams::Role::OrSymbol,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
              user_id:,
              # `owner` or `member`
              role:,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  user_id: String,
                  role:
                    OpenAI::Admin::Organization::Projects::UserUpdateParams::Role::OrSymbol,
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
                    OpenAI::Admin::Organization::Projects::UserUpdateParams::Role
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              OWNER =
                T.let(
                  :owner,
                  OpenAI::Admin::Organization::Projects::UserUpdateParams::Role::TaggedSymbol
                )
              MEMBER =
                T.let(
                  :member,
                  OpenAI::Admin::Organization::Projects::UserUpdateParams::Role::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Admin::Organization::Projects::UserUpdateParams::Role::TaggedSymbol
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
