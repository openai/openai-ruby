# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          module Users
            class RoleListResponse < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Models::Admin::Organization::Projects::Users::RoleListResponse,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Identifier for the role.
              sig { returns(String) }
              attr_accessor :id

              # Principals from which the role assignment is inherited, when available.
              sig do
                returns(
                  T.nilable(
                    T::Array[
                      OpenAI::Models::Admin::Organization::Projects::Users::RoleListResponse::AssignmentSource
                    ]
                  )
                )
              end
              attr_accessor :assignment_sources

              # When the role was created.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :created_at

              # Identifier of the actor who created the role.
              sig { returns(T.nilable(String)) }
              attr_accessor :created_by

              # User details for the actor that created the role, when available.
              sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
              attr_accessor :created_by_user_obj

              # Description of the role.
              sig { returns(T.nilable(String)) }
              attr_accessor :description

              # Arbitrary metadata stored on the role.
              sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
              attr_accessor :metadata

              # Name of the role.
              sig { returns(String) }
              attr_accessor :name

              # Permissions associated with the role.
              sig { returns(T::Array[String]) }
              attr_accessor :permissions

              # Whether the role is predefined by OpenAI.
              sig { returns(T::Boolean) }
              attr_accessor :predefined_role

              # Resource type the role applies to.
              sig { returns(String) }
              attr_accessor :resource_type

              # When the role was last updated.
              sig { returns(T.nilable(Integer)) }
              attr_accessor :updated_at

              # Detailed information about a role assignment entry returned when listing
              # assignments.
              sig do
                params(
                  id: String,
                  assignment_sources:
                    T.nilable(
                      T::Array[
                        OpenAI::Models::Admin::Organization::Projects::Users::RoleListResponse::AssignmentSource::OrHash
                      ]
                    ),
                  created_at: T.nilable(Integer),
                  created_by: T.nilable(String),
                  created_by_user_obj: T.nilable(T::Hash[Symbol, T.anything]),
                  description: T.nilable(String),
                  metadata: T.nilable(T::Hash[Symbol, T.anything]),
                  name: String,
                  permissions: T::Array[String],
                  predefined_role: T::Boolean,
                  resource_type: String,
                  updated_at: T.nilable(Integer)
                ).returns(T.attached_class)
              end
              def self.new(
                # Identifier for the role.
                id:,
                # Principals from which the role assignment is inherited, when available.
                assignment_sources:,
                # When the role was created.
                created_at:,
                # Identifier of the actor who created the role.
                created_by:,
                # User details for the actor that created the role, when available.
                created_by_user_obj:,
                # Description of the role.
                description:,
                # Arbitrary metadata stored on the role.
                metadata:,
                # Name of the role.
                name:,
                # Permissions associated with the role.
                permissions:,
                # Whether the role is predefined by OpenAI.
                predefined_role:,
                # Resource type the role applies to.
                resource_type:,
                # When the role was last updated.
                updated_at:
              )
              end

              sig do
                override.returns(
                  {
                    id: String,
                    assignment_sources:
                      T.nilable(
                        T::Array[
                          OpenAI::Models::Admin::Organization::Projects::Users::RoleListResponse::AssignmentSource
                        ]
                      ),
                    created_at: T.nilable(Integer),
                    created_by: T.nilable(String),
                    created_by_user_obj: T.nilable(T::Hash[Symbol, T.anything]),
                    description: T.nilable(String),
                    metadata: T.nilable(T::Hash[Symbol, T.anything]),
                    name: String,
                    permissions: T::Array[String],
                    predefined_role: T::Boolean,
                    resource_type: String,
                    updated_at: T.nilable(Integer)
                  }
                )
              end
              def to_hash
              end

              class AssignmentSource < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Models::Admin::Organization::Projects::Users::RoleListResponse::AssignmentSource,
                      OpenAI::Internal::AnyHash
                    )
                  end

                sig { returns(String) }
                attr_accessor :principal_id

                sig { returns(String) }
                attr_accessor :principal_type

                sig do
                  params(principal_id: String, principal_type: String).returns(
                    T.attached_class
                  )
                end
                def self.new(principal_id:, principal_type:)
                end

                sig do
                  override.returns(
                    { principal_id: String, principal_type: String }
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
  end
end
