# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class GroupUpdateResponse < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Models::Admin::Organization::GroupUpdateResponse,
                OpenAI::Internal::AnyHash
              )
            end

          # Identifier for the group.
          sig { returns(String) }
          attr_accessor :id

          # Unix timestamp (in seconds) when the group was created.
          sig { returns(Integer) }
          attr_accessor :created_at

          # Whether the group is managed through SCIM and controlled by your identity
          # provider.
          sig { returns(T::Boolean) }
          attr_accessor :is_scim_managed

          # Updated display name for the group.
          sig { returns(String) }
          attr_accessor :name

          # Response returned after updating a group.
          sig do
            params(
              id: String,
              created_at: Integer,
              is_scim_managed: T::Boolean,
              name: String
            ).returns(T.attached_class)
          end
          def self.new(
            # Identifier for the group.
            id:,
            # Unix timestamp (in seconds) when the group was created.
            created_at:,
            # Whether the group is managed through SCIM and controlled by your identity
            # provider.
            is_scim_managed:,
            # Updated display name for the group.
            name:
          )
          end

          sig do
            override.returns(
              {
                id: String,
                created_at: Integer,
                is_scim_managed: T::Boolean,
                name: String
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
