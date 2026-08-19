# typed: strong

module OpenAI
  module Models

    module Admin

      module Organization

        class AdminAPIKeyCreateResponse < OpenAI::Models::Admin::Organization::AdminAPIKey

          OrHash = T.type_alias do
            T.any(
              OpenAI::Models::Admin::Organization::AdminAPIKeyCreateResponse,
              OpenAI::Internal::AnyHash
            )
          end

          # The value of the API key. Only shown on create.
          sig { returns(String) }
          attr_accessor :value

          # Represents an individual Admin API key in an org.
          sig do
            params(

              id: String,

              created_at: Integer,

              expires_at: T.nilable(Integer),

              owner: OpenAI::Admin::Organization::AdminAPIKey::Owner::OrHash,

              redacted_value: String,

              value: String,

              last_used_at: T.nilable(Integer),

              name: T.nilable(String),

              object: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The identifier, which can be referenced in API endpoints
            id:,

            # The Unix timestamp (in seconds) of when the API key was created
            created_at:,

            # The Unix timestamp (in seconds) of when the API key expires
            expires_at:,

            owner:,

            # The redacted value of the API key
            redacted_value:,

            # The value of the API key. Only shown on create.
            value:,

            # The Unix timestamp (in seconds) of when the API key was last used
            last_used_at: nil,

            # The name of the API key
            name: nil,

            # The object type, which is always `organization.admin_api_key`

            object: :"organization.admin_api_key"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                created_at: Integer,
                expires_at: T.nilable(Integer),
                owner: OpenAI::Admin::Organization::AdminAPIKey::Owner,
                redacted_value: String,
                value: String,
                object: Symbol,
                last_used_at: T.nilable(Integer),
                name: T.nilable(String)
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
