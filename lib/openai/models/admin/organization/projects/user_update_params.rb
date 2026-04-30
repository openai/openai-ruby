# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        module Projects
          # @see OpenAI::Resources::Admin::Organization::Projects::Users#update
          class UserUpdateParams < OpenAI::Internal::Type::BaseModel
            extend OpenAI::Internal::Type::RequestParameters::Converter
            include OpenAI::Internal::Type::RequestParameters

            # @!attribute project_id
            #
            #   @return [String]
            required :project_id, String

            # @!attribute user_id
            #
            #   @return [String]
            required :user_id, String

            # @!attribute role
            #   `owner` or `member`
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Projects::UserUpdateParams::Role]
            required :role, enum: -> { OpenAI::Admin::Organization::Projects::UserUpdateParams::Role }

            # @!method initialize(project_id:, user_id:, role:, request_options: {})
            #   @param project_id [String]
            #
            #   @param user_id [String]
            #
            #   @param role [Symbol, OpenAI::Models::Admin::Organization::Projects::UserUpdateParams::Role] `owner` or `member`
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
