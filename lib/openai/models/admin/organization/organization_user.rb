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

          # @!attribute email
          #   The email address of the user
          #
          #   @return [String]
          required :email, String

          # @!attribute name
          #   The name of the user
          #
          #   @return [String]
          required :name, String

          # @!attribute object
          #   The object type, which is always `organization.user`
          #
          #   @return [Symbol, :"organization.user"]
          required :object, const: :"organization.user"

          # @!attribute role
          #   `owner` or `reader`
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::OrganizationUser::Role]
          required :role, enum: -> { OpenAI::Admin::Organization::OrganizationUser::Role }

          # @!method initialize(id:, added_at:, email:, name:, role:, object: :"organization.user")
          #   Represents an individual `user` within an organization.
          #
          #   @param id [String] The identifier, which can be referenced in API endpoints
          #
          #   @param added_at [Integer] The Unix timestamp (in seconds) of when the user was added.
          #
          #   @param email [String] The email address of the user
          #
          #   @param name [String] The name of the user
          #
          #   @param role [Symbol, OpenAI::Models::Admin::Organization::OrganizationUser::Role] `owner` or `reader`
          #
          #   @param object [Symbol, :"organization.user"] The object type, which is always `organization.user`

          # `owner` or `reader`
          #
          # @see OpenAI::Models::Admin::Organization::OrganizationUser#role
          module Role
            extend OpenAI::Internal::Type::Enum

            OWNER = :owner
            READER = :reader

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end

      OrganizationUser = Organization::OrganizationUser
    end
  end
end
