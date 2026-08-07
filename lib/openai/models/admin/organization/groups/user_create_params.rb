# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          # @see OpenAI::Resources::Admin::Organization::Groups::Users#create
          class UserCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute group_id
            #
            #   @return [String]
            required :group_id, String

            # @!attribute user_id
            #   Identifier of the user to add to the group.
            #
            #   @return [String]
            required :user_id, String

            # @!method initialize(group_id:, user_id:, request_options: {})
            #   @param group_id [String]
            #
            #   @param user_id [String] Identifier of the user to add to the group.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
