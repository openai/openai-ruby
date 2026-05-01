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
            sig { returns(String) }
            attr_accessor :role

            # Email of the user to add.
            sig { returns(T.nilable(String)) }
            attr_accessor :email

            # The ID of the user.
            sig { returns(T.nilable(String)) }
            attr_accessor :user_id

            sig do
              params(
                project_id: String,
                role: String,
                email: T.nilable(String),
                user_id: T.nilable(String),
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
              # `owner` or `member`
              role:,
              # Email of the user to add.
              email: nil,
              # The ID of the user.
              user_id: nil,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  role: String,
                  email: T.nilable(String),
                  user_id: T.nilable(String),
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
