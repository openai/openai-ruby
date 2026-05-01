# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class Group < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::Group,
                OpenAI::Internal::AnyHash
              )
            end

          # Identifier for the group.
          sig { returns(String) }
          attr_accessor :id

          # Unix timestamp (in seconds) when the group was created.
          sig { returns(Integer) }
          attr_accessor :created_at

          # The type of the group.
          sig { returns(String) }
          attr_accessor :group_type

          # Whether the group is managed through SCIM and controlled by your identity
          # provider.
          sig { returns(T::Boolean) }
          attr_accessor :is_scim_managed

          # Display name of the group.
          sig { returns(String) }
          attr_accessor :name

          # Details about an organization group.
          sig do
            params(
              id: String,
              created_at: Integer,
              group_type: String,
              is_scim_managed: T::Boolean,
              name: String
            ).returns(T.attached_class)
          end
          def self.new(
            # Identifier for the group.
            id:,
            # Unix timestamp (in seconds) when the group was created.
            created_at:,
            # The type of the group.
            group_type:,
            # Whether the group is managed through SCIM and controlled by your identity
            # provider.
            is_scim_managed:,
            # Display name of the group.
            name:
          )
          end

          sig do
            override.returns(
              {
                id: String,
                created_at: Integer,
                group_type: String,
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
