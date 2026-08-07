# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Groups
          # @see OpenAI::Resources::Admin::Organization::Groups::Users#retrieve
          class UserRetrieveParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute group_id
            #
            #   @return [String]
            required :group_id, String

            # @!attribute user_id
            #
            #   @return [String]
            required :user_id, String

            # @!method initialize(group_id:, user_id:, request_options: {})
            #   @param group_id [String]
            #   @param user_id [String]
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
