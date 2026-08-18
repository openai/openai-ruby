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
            sig { returns(T.nilable(String)) }
            attr_accessor :role

            sig do
              params(
                project_id: String,
                user_id: String,
                role: T.nilable(String),
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
              user_id:,
              # `owner` or `member`
              role: nil,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  user_id: String,
                  role: T.nilable(String),
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
