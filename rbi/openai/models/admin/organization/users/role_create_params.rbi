# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Users
          class RoleCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Users::RoleCreateParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :user_id

            # Identifier of the role to assign.
            sig { returns(String) }
            attr_accessor :role_id

            sig do
              params(
                user_id: String,
                role_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              user_id:,
              # Identifier of the role to assign.
              role_id:,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  user_id: String,
                  role_id: String,
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
