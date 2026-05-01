# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          # @see OpenAI::Resources::Admin::Organization::Groups::Users#list
          class OrganizationGroupUser < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The identifier, which can be referenced in API endpoints
            #
            #   @return [String]
            required :id, String

            # @!attribute email
            #   The email address of the user.
            #
            #   @return [String, nil]
            required :email, String, nil?: true

            # @!attribute name
            #   The name of the user.
            #
            #   @return [String]
            required :name, String

            # @!method initialize(id:, email:, name:)
            #   Represents an individual user returned when inspecting group membership.
            #
            #   @param id [String] The identifier, which can be referenced in API endpoints
            #
            #   @param email [String, nil] The email address of the user.
            #
            #   @param name [String] The name of the user.
          end
        end
      end
    end
  end
end
