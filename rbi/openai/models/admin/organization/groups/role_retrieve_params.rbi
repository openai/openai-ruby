# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          class RoleRetrieveParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Groups::RoleRetrieveParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :group_id

            sig { returns(String) }
            attr_accessor :role_id

            sig do
              params(
                group_id: String,
                role_id: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(group_id:, role_id:, request_options: {})
            end

            sig do
              override.returns(
                {
                  group_id: String,
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
