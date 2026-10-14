# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Users
          # @see OpenAI::Resources::Admin::Organization::Users::Roles#create
          class RoleCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute user_id
            #
            #   @return [String]
            required :user_id, String

            # @!attribute role_id
            #   Identifier of the role to assign.
            #
            #   @return [String]
            required :role_id, String

            # @!method initialize(user_id:, role_id:, request_options: {})
            #   @param user_id [String]
            #
            #   @param role_id [String] Identifier of the role to assign.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
