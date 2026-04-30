# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Invites#create
        class InviteCreateParams < OpenAI::Internal::Type::BaseModel
          extend OpenAI::Internal::Type::RequestParameters::Converter
          include OpenAI::Internal::Type::RequestParameters

          # @!attribute email
          #   Send an email to this address
          #
          #   @return [String]
          required :email, String

          # @!attribute role
          #   `owner` or `reader`
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::InviteCreateParams::Role]
          required :role, enum: -> { OpenAI::Admin::Organization::InviteCreateParams::Role }

          # @!attribute projects
          #   An array of projects to which membership is granted at the same time the org
          #   invite is accepted. If omitted, the user will be invited to the default project
          #   for compatibility with legacy behavior.
          #
          #   @return [Array<OpenAI::Models::Admin::Organization::InviteCreateParams::Project>, nil]
          optional :projects,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Admin::Organization::InviteCreateParams::Project] }

          # @!method initialize(email:, role:, projects: nil, request_options: {})
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Admin::Organization::InviteCreateParams} for more details.
          #
          #   @param email [String] Send an email to this address
          #
          #   @param role [Symbol, OpenAI::Models::Admin::Organization::InviteCreateParams::Role] `owner` or `reader`
          #
          #   @param projects [Array<OpenAI::Models::Admin::Organization::InviteCreateParams::Project>] An array of projects to which membership is granted at the same time the org inv
          #
          #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]

          # `owner` or `reader`
          module Role
            extend OpenAI::Internal::Type::Enum

            READER = :reader
            OWNER = :owner

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          class Project < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   Project's public ID
            #
            #   @return [String]
            required :id, String

            # @!attribute role
            #   Project membership role
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::InviteCreateParams::Project::Role]
            required :role, enum: -> { OpenAI::Admin::Organization::InviteCreateParams::Project::Role }

            # @!method initialize(id:, role:)
            #   @param id [String] Project's public ID
            #
            #   @param role [Symbol, OpenAI::Models::Admin::Organization::InviteCreateParams::Project::Role] Project membership role

            # Project membership role
            #
            # @see OpenAI::Models::Admin::Organization::InviteCreateParams::Project#role
            module Role
              extend OpenAI::Internal::Type::Enum

              MEMBER = :member
              OWNER = :owner

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end
        end
      end
    end
  end
end
