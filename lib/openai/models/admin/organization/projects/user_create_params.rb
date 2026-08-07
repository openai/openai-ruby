# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::Users#create
          class UserCreateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute role
            #   `owner` or `member`
            #
            #   @return [String]
            required :role, String

            # @!attribute email
            #   Email of the user to add.
            #
            #   @return [String, nil]
            optional :email, String, nil?: true

            # @!attribute user_id
            #   The ID of the user.
            #
            #   @return [String, nil]
            optional :user_id, String, nil?: true

            # @!method initialize(project_id:, role:, email: nil, user_id: nil, request_options: {})
            #   @param project_id [String]
            #
            #   @param role [String] `owner` or `member`
            #
            #   @param email [String, nil] Email of the user to add.
            #
            #   @param user_id [String, nil] The ID of the user.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
          end
        end
      end
    end
  end
end
