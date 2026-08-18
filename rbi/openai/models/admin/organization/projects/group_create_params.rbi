# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          class GroupCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::Projects::GroupCreateParams,
                  OpenAI::Internal::AnyHash
                )
              end

            sig { returns(String) }
            attr_accessor :project_id

            # Identifier of the group to add to the project.
            sig { returns(String) }
            attr_accessor :group_id

            # Identifier of the project role to grant to the group.
            sig { returns(String) }
            attr_accessor :role

            sig do
              params(
                project_id: String,
                group_id: String,
                role: String,
                request_options: OpenAI::RequestOptions::OrHash
              ).returns(T.attached_class)
            end
            def self.new(
              project_id:,
              # Identifier of the group to add to the project.
              group_id:,
              # Identifier of the project role to grant to the group.
              role:,
              request_options: {}
            )
            end

            sig do
              override.returns(
                {
                  project_id: String,
                  group_id: String,
                  role: String,
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
