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
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::UserCreateParams::Role]
            required :role, enum: -> { OpenAI::Admin::Organization::Projects::UserCreateParams::Role }

            # @!attribute user_id
            #   The ID of the user.
            #
            #   @return [String]
            required :user_id, String

            # @!method initialize(project_id:, role:, user_id:, request_options: {})
            #   @param project_id [String]
            #
            #   @param role [Symbol, OpenAI::Models::Admin::Organization::Projects::UserCreateParams::Role] `owner` or `member`
            #
            #   @param user_id [String] The ID of the user.
            #
            #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

            # `owner` or `member`
            module Role
              extend OpenAI::Internal::Type::Enum

              OWNER = :owner
              MEMBER = :member

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end
