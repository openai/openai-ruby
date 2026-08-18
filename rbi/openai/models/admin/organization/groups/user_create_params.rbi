# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          class UserCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Groups::UserCreateParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :group_id

            # Identifier of the user to add to the group.
            sig { returns(String) }
            attr_accessor :user_id

            sig do
              params(
                group_id: String,
                user_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              group_id:,
              # Identifier of the user to add to the group.
              user_id:,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  group_id: String,
                  user_id: String,
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
