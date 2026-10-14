# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Invites#create
        class Invite < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The identifier, which can be referenced in API endpoints
          #
          #   @return [String]
          required :id, String

          # @!attribute created_at
          #   The Unix timestamp (in seconds) of when the invite was sent.
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute email
          #   The email address of the individual to whom the invite was sent
          #
          #   @return [String]
          required :email, String

          # @!attribute object
          #   The object type, which is always `organization.invite`
          #
          #   @return [Symbol, :"organization.invite"]
          required :object, const: :"organization.invite"

          # @!attribute projects
          #   The projects that were granted membership upon acceptance of the invite.
          #
          #   @return [Array<OpenAI::Models::Admin::Organization::Invite::Project>]
          required :projects, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Admin::Organization::Invite::Project] }

          # @!attribute role
          #   `owner` or `reader`
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::Invite::Role]
          required :role, enum: -> { OpenAI::Admin::Organization::Invite::Role }

          # @!attribute status
          #   `accepted`,`expired`, or `pending`
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::Invite::Status]
          required :status, enum: -> { OpenAI::Admin::Organization::Invite::Status }

          # @!attribute accepted_at
          #   The Unix timestamp (in seconds) of when the invite was accepted.
          #
          #   @return [Integer, nil]
          optional :accepted_at, Integer, nil?: true

          # @!attribute expires_at
          #   The Unix timestamp (in seconds) of when the invite expires.
          #
          #   @return [Integer, nil]
          optional :expires_at, Integer, nil?: true

          # @!method initialize(id:, created_at:, email:, projects:, role:, status:, accepted_at: nil, expires_at: nil, object: :"organization.invite")
          #   Represents an individual `invite` to the organization.
          #
          #   @param id [String] The identifier, which can be referenced in API endpoints
          #
          #   @param created_at [Integer] The Unix timestamp (in seconds) of when the invite was sent.
          #
          #   @param email [String] The email address of the individual to whom the invite was sent
          #
          #   @param projects [Array<OpenAI::Models::Admin::Organization::Invite::Project>] The projects that were granted membership upon acceptance of the invite.
          #
          #   @param role [Symbol, OpenAI::Models::Admin::Organization::Invite::Role] `owner` or `reader`
          #
          #   @param status [Symbol, OpenAI::Models::Admin::Organization::Invite::Status] `accepted`,`expired`, or `pending`
          #
          #   @param accepted_at [Integer, nil] The Unix timestamp (in seconds) of when the invite was accepted.
          #
          #   @param expires_at [Integer, nil] The Unix timestamp (in seconds) of when the invite expires.
          #
          #   @param object [Symbol, :"organization.invite"] The object type, which is always `organization.invite`

          class Project < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   Project's public ID
            #
            #   @return [String]
            required :id, String

            # @!attribute role
            #   Project membership role
            #
            #   @return [Symbol, OpenAI::Models::Admin::Organization::Invite::Project::Role]
            required :role, enum: -> { OpenAI::Admin::Organization::Invite::Project::Role }

            # @!method initialize(id:, role:)
            #   @param id [String] Project's public ID
            #
            #   @param role [Symbol, OpenAI::Models::Admin::Organization::Invite::Project::Role] Project membership role

            # Project membership role
            #
            # @see OpenAI::Models::Admin::Organization::Invite::Project#role
            module Role
              extend OpenAI::Internal::Type::Enum

              MEMBER = :member
              OWNER = :owner

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          # `owner` or `reader`
          #
          # @see OpenAI::Models::Admin::Organization::Invite#role
          module Role
            extend OpenAI::Internal::Type::Enum

            OWNER = :owner
            READER = :reader

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # `accepted`,`expired`, or `pending`
          #
          # @see OpenAI::Models::Admin::Organization::Invite#status
          module Status
            extend OpenAI::Internal::Type::Enum

            ACCEPTED = :accepted
            EXPIRED = :expired
            PENDING = :pending

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
