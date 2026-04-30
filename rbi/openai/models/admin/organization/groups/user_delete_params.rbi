# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          class UserDeleteParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Groups::UserDeleteParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :group_id

            sig { returns(String) }
            attr_accessor :user_id

            sig do
              params(
                group_id: String,
                user_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(group_id:, user_id:, request_options: {})
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
