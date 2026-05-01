# typed: strong

module OpenAI
  module Models
    module Admin
      module Organization
        class AdminAPIKey < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Admin::Organization::AdminAPIKey,
                OpenAI::Internal::AnyHash
              )
            end

          # The identifier, which can be referenced in API endpoints
          sig { returns(String) }
          attr_accessor :id

          # The Unix timestamp (in seconds) of when the API key was created
          sig { returns(Integer) }
          attr_accessor :created_at

          # The object type, which is always `organization.admin_api_key`
          sig { returns(Symbol) }
          attr_accessor :object

          sig { returns(OpenAI::Admin::Organization::AdminAPIKey::Owner) }
          attr_reader :owner

          sig do
            params(
              owner: OpenAI::Admin::Organization::AdminAPIKey::Owner::OrHash
            ).void
          end
          attr_writer :owner

          # The redacted value of the API key
          sig { returns(String) }
          attr_accessor :redacted_value

          # The Unix timestamp (in seconds) of when the API key was last used
          sig { returns(T.nilable(Integer)) }
          attr_accessor :last_used_at

          # The name of the API key
          sig { returns(T.nilable(String)) }
          attr_accessor :name

          # Represents an individual Admin API key in an org.
          sig do
            params(
              id: String,
              created_at: Integer,
              owner: OpenAI::Admin::Organization::AdminAPIKey::Owner::OrHash,
              redacted_value: String,
              last_used_at: T.nilable(Integer),
              name: T.nilable(String),
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The identifier, which can be referenced in API endpoints
            id:,
            # The Unix timestamp (in seconds) of when the API key was created
            created_at:,
            owner:,
            # The redacted value of the API key
            redacted_value:,
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
                object: Symbol,
                owner: OpenAI::Admin::Organization::AdminAPIKey::Owner,
                redacted_value: String,
                last_used_at: T.nilable(Integer),
                name: T.nilable(String)
              }
            )
          end
          def to_hash
          end

          class Owner < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Admin::Organization::AdminAPIKey::Owner,
                  OpenAI::Internal::AnyHash
                )
              end

            # The identifier, which can be referenced in API endpoints
            sig { returns(T.nilable(String)) }
            attr_reader :id

            sig { params(id: String).void }
            attr_writer :id

            # The Unix timestamp (in seconds) of when the user was created
            sig { returns(T.nilable(Integer)) }
            attr_reader :created_at

            sig { params(created_at: Integer).void }
            attr_writer :created_at

            # The name of the user
            sig { returns(T.nilable(String)) }
            attr_reader :name

            sig { params(name: String).void }
            attr_writer :name

            # The object type, which is always organization.user
            sig { returns(T.nilable(String)) }
            attr_reader :object

            sig { params(object: String).void }
            attr_writer :object

            # Always `owner`
            sig { returns(T.nilable(String)) }
            attr_reader :role

            sig { params(role: String).void }
            attr_writer :role

            # Always `user`
            sig { returns(T.nilable(String)) }
            attr_reader :type

            sig { params(type: String).void }
            attr_writer :type

            sig do
              params(
                id: String,
                created_at: Integer,
                name: String,
                object: String,
                role: String,
                type: String
              ).returns(T.attached_class)
            end
            def self.new(
              # The identifier, which can be referenced in API endpoints
              id: nil,
              # The Unix timestamp (in seconds) of when the user was created
              created_at: nil,
              # The name of the user
              name: nil,
              # The object type, which is always organization.user
              object: nil,
              # Always `owner`
              role: nil,
              # Always `user`
              type: nil
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  created_at: Integer,
                  name: String,
                  object: String,
                  role: String,
                  type: String
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
