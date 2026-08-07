# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          # @see OpenAI::Resources::Admin::Organization::Groups::Users#retrieve
          class UserRetrieveResponse < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   Identifier for the user.
            #
            #   @return [String]
            required :id, String

            # @!attribute email
            #   Email address of the user, or `null` for users without an email.
            #
            #   @return [String, nil]
            required :email, String, nil?: true

            # @!attribute is_service_account
            #   Whether the user is a service account.
            #
            #   @return [Boolean, nil]
            required :is_service_account, OpenAI::Internal::Type::Boolean, nil?: true

            # @!attribute name
            #   Display name of the user.
            #
            #   @return [String]
            required :name, String

            # @!attribute picture
            #   URL of the user's profile picture, if available.
            #
            #   @return [String, nil]
            required :picture, String, nil?: true

            # @!attribute user_type
            #   The type of user.
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse::UserType]
            required :user_type,
                     enum: -> { OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse::UserType }

            # @!method initialize(id:, email:, is_service_account:, name:, picture:, user_type:)
            #   Details about a user returned from an organization group membership lookup.
            #
            #   @param id [String] Identifier for the user.
            #
            #   @param email [String, nil] Email address of the user, or `null` for users without an email.
            #
            #   @param is_service_account [Boolean, nil] Whether the user is a service account.
            #
            #   @param name [String] Display name of the user.
            #
            #   @param picture [String, nil] URL of the user's profile picture, if available.
            #
            #   @param user_type [Symbol, OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse::UserType] The type of user.

            # The type of user.
            #
            # @see OpenAI::Models::Admin::Organization::Groups::UserRetrieveResponse#user_type
            module UserType
              extend OpenAI::Internal::Type::Enum

              USER = :user
              TENANT_USER = :tenant_user

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end
