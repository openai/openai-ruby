# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::AdminAPIKeys#retrieve
        class AdminAPIKey < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The identifier, which can be referenced in API endpoints
          #
          #   @return [String]
          required :id, String

          # @!attribute created_at
          #   The Unix timestamp (in seconds) of when the API key was created
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute last_used_at
          #   The Unix timestamp (in seconds) of when the API key was last used
          #
          #   @return [Integer, nil]
          required :last_used_at, Integer, nil?: true

          # @!attribute name
          #   The name of the API key
          #
          #   @return [String]
          required :name, String

          # @!attribute object
          #   The object type, which is always `organization.admin_api_key`
          #
          #   @return [Symbol, :"organization.admin_api_key"]
          required :object, const: :"organization.admin_api_key"

          # @!attribute owner
          #
          #   @return [OpenAI::Models::Admin::Organization::AdminAPIKey::Owner]
          required :owner, -> { OpenAI::Admin::Organization::AdminAPIKey::Owner }

          # @!attribute redacted_value
          #   The redacted value of the API key
          #
          #   @return [String]
          required :redacted_value, String

          # @!attribute value
          #   The value of the API key. Only shown on create.
          #
          #   @return [String, nil]
          optional :value, String

          # @!method initialize(id:, created_at:, last_used_at:, name:, owner:, redacted_value:, value: nil, object: :"organization.admin_api_key")
          #   Represents an individual Admin API key in an org.
          #
          #   @param id [String] The identifier, which can be referenced in API endpoints
          #
          #   @param created_at [Integer] The Unix timestamp (in seconds) of when the API key was created
          #
          #   @param last_used_at [Integer, nil] The Unix timestamp (in seconds) of when the API key was last used
          #
          #   @param name [String] The name of the API key
          #
          #   @param owner [OpenAI::Models::Admin::Organization::AdminAPIKey::Owner]
          #
          #   @param redacted_value [String] The redacted value of the API key
          #
          #   @param value [String] The value of the API key. Only shown on create.
          #
          #   @param object [Symbol, :"organization.admin_api_key"] The object type, which is always `organization.admin_api_key`

          # @see OpenAI::Models::Admin::Organization::AdminAPIKey#owner
          class Owner < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The identifier, which can be referenced in API endpoints
            #
            #   @return [String, nil]
            optional :id, String

            # @!attribute created_at
            #   The Unix timestamp (in seconds) of when the user was created
            #
            #   @return [Integer, nil]
            optional :created_at, Integer

            # @!attribute name
            #   The name of the user
            #
            #   @return [String, nil]
            optional :name, String

            # @!attribute object
            #   The object type, which is always organization.user
            #
            #   @return [String, nil]
            optional :object, String

            # @!attribute role
            #   Always `owner`
            #
            #   @return [String, nil]
            optional :role, String

            # @!attribute type
            #   Always `user`
            #
            #   @return [String, nil]
            optional :type, String

            # @!method initialize(id: nil, created_at: nil, name: nil, object: nil, role: nil, type: nil)
            #   @param id [String] The identifier, which can be referenced in API endpoints
            #
            #   @param created_at [Integer] The Unix timestamp (in seconds) of when the user was created
            #
            #   @param name [String] The name of the user
            #
            #   @param object [String] The object type, which is always organization.user
            #
            #   @param role [String] Always `owner`
            #
            #   @param type [String] Always `user`
          end
        end
      end
    end
  end
end
