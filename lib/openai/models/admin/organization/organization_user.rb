# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Users#retrieve
        class OrganizationUser < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The identifier, which can be referenced in API endpoints
          #
          #   @return [String]
          required :id, String

          # @!attribute added_at
          #   The Unix timestamp (in seconds) of when the user was added.
          #
          #   @return [Integer]
          required :added_at, Integer

          # @!attribute object
          #   The object type, which is always `organization.user`
          #
          #   @return [Symbol, :"organization.user"]
          required :object, const: :"organization.user"

          # @!attribute api_key_last_used_at
          #   The Unix timestamp (in seconds) of the user's last API key usage.
          #
          #   @return [Integer, nil]
          optional :api_key_last_used_at, Integer, nil?: true

          # @!attribute created
          #   The Unix timestamp (in seconds) of when the user was created.
          #
          #   @return [Integer, nil]
          optional :created, Integer

          # @!attribute developer_persona
          #   The developer persona metadata for the user.
          #
          #   @return [String, nil]
          optional :developer_persona, String, nil?: true

          # @!attribute email
          #   The email address of the user
          #
          #   @return [String, nil]
          optional :email, String, nil?: true

          # @!attribute is_default
          #   Whether this is the organization's default user.
          #
          #   @return [Boolean, nil]
          optional :is_default, OpenAI::Internal::Type::Boolean

          # @!attribute is_scale_tier_authorized_purchaser
          #   Whether the user is an authorized purchaser for Scale Tier.
          #
          #   @return [Boolean, nil]
          optional :is_scale_tier_authorized_purchaser, OpenAI::Internal::Type::Boolean, nil?: true

          # @!attribute is_scim_managed
          #   Whether the user is managed through SCIM.
          #
          #   @return [Boolean, nil]
          optional :is_scim_managed, OpenAI::Internal::Type::Boolean

          # @!attribute is_service_account
          #   Whether the user is a service account.
          #
          #   @return [Boolean, nil]
          optional :is_service_account, OpenAI::Internal::Type::Boolean

          # @!attribute name
          #   The name of the user
          #
          #   @return [String, nil]
          optional :name, String, nil?: true

          # @!attribute projects
          #   Projects associated with the user, if included.
          #
          #   @return [OpenAI::Models::Admin::Organization::OrganizationUser::Projects, nil]
          optional :projects, -> { OpenAI::Admin::Organization::OrganizationUser::Projects }, nil?: true

          # @!attribute role
          #   `owner` or `reader`
          #
          #   @return [String, nil]
          optional :role, String, nil?: true

          # @!attribute technical_level
          #   The technical level metadata for the user.
          #
          #   @return [String, nil]
          optional :technical_level, String, nil?: true

          # @!attribute user
          #   Nested user details.
          #
          #   @return [OpenAI::Models::Admin::Organization::OrganizationUser::User, nil]
          optional :user, -> { OpenAI::Admin::Organization::OrganizationUser::User }

          # @!method initialize(id:, added_at:, api_key_last_used_at: nil, created: nil, developer_persona: nil, email: nil, is_default: nil, is_scale_tier_authorized_purchaser: nil, is_scim_managed: nil, is_service_account: nil, name: nil, projects: nil, role: nil, technical_level: nil, user: nil, object: :"organization.user")
          #   Represents an individual `user` within an organization.
          #
          #   @param id [String] The identifier, which can be referenced in API endpoints
          #
          #   @param added_at [Integer] The Unix timestamp (in seconds) of when the user was added.
          #
          #   @param api_key_last_used_at [Integer, nil] The Unix timestamp (in seconds) of the user's last API key usage.
          #
          #   @param created [Integer] The Unix timestamp (in seconds) of when the user was created.
          #
          #   @param developer_persona [String, nil] The developer persona metadata for the user.
          #
          #   @param email [String, nil] The email address of the user
          #
          #   @param is_default [Boolean] Whether this is the organization's default user.
          #
          #   @param is_scale_tier_authorized_purchaser [Boolean, nil] Whether the user is an authorized purchaser for Scale Tier.
          #
          #   @param is_scim_managed [Boolean] Whether the user is managed through SCIM.
          #
          #   @param is_service_account [Boolean] Whether the user is a service account.
          #
          #   @param name [String, nil] The name of the user
          #
          #   @param projects [OpenAI::Models::Admin::Organization::OrganizationUser::Projects, nil] Projects associated with the user, if included.
          #
          #   @param role [String, nil] `owner` or `reader`
          #
          #   @param technical_level [String, nil] The technical level metadata for the user.
          #
          #   @param user [OpenAI::Models::Admin::Organization::OrganizationUser::User] Nested user details.
          #
          #   @param object [Symbol, :"organization.user"] The object type, which is always `organization.user`

          # @see OpenAI::Models::Admin::Organization::OrganizationUser#projects
          class Projects < OpenAI::Internal::Type::BaseModel
            # @!attribute data
            #
            #   @return [Array<OpenAI::Models::Admin::Organization::OrganizationUser::Projects::Data>]
            required :data,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Admin::Organization::OrganizationUser::Projects::Data] }

            # @!attribute object
            #
            #   @return [Symbol, :list]
            required :object, const: :list

            # @!method initialize(data:, object: :list)
            #   Projects associated with the user, if included.
            #
            #   @param data [Array<OpenAI::Models::Admin::Organization::OrganizationUser::Projects::Data>]
            #   @param object [Symbol, :list]

            class Data < OpenAI::Internal::Type::BaseModel
              # @!attribute id
              #
              #   @return [String, nil]
              optional :id, String, nil?: true

              # @!attribute name
              #
              #   @return [String, nil]
              optional :name, String, nil?: true

              # @!attribute role
              #
              #   @return [String, nil]
              optional :role, String, nil?: true

              # @!method initialize(id: nil, name: nil, role: nil)
              #   @param id [String, nil]
              #   @param name [String, nil]
              #   @param role [String, nil]
            end
          end

          # @see OpenAI::Models::Admin::Organization::OrganizationUser#user
          class User < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #
            #   @return [String]
            required :id, String

            # @!attribute object
            #
            #   @return [Symbol, :user]
            required :object, const: :user

            # @!attribute banned
            #
            #   @return [Boolean, nil]
            optional :banned, OpenAI::Internal::Type::Boolean, nil?: true

            # @!attribute banned_at
            #
            #   @return [Integer, nil]
            optional :banned_at, Integer, nil?: true

            # @!attribute email
            #
            #   @return [String, nil]
            optional :email, String, nil?: true

            # @!attribute enabled
            #
            #   @return [Boolean, nil]
            optional :enabled, OpenAI::Internal::Type::Boolean, nil?: true

            # @!attribute name
            #
            #   @return [String, nil]
            optional :name, String, nil?: true

            # @!attribute picture
            #
            #   @return [String, nil]
            optional :picture, String, nil?: true

            # @!method initialize(id:, banned: nil, banned_at: nil, email: nil, enabled: nil, name: nil, picture: nil, object: :user)
            #   Nested user details.
            #
            #   @param id [String]
            #   @param banned [Boolean, nil]
            #   @param banned_at [Integer, nil]
            #   @param email [String, nil]
            #   @param enabled [Boolean, nil]
            #   @param name [String, nil]
            #   @param picture [String, nil]
            #   @param object [Symbol, :user]
          end
        end
      end

      OrganizationUser = Organization::OrganizationUser
    end
  end
end
