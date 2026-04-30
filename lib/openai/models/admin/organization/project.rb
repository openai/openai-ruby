# frozen_string_literal: true

module OpenAI
  module Models
    module Admin
      module Organization
        # @see OpenAI::Resources::Admin::Organization::Projects#create
        class Project < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The identifier, which can be referenced in API endpoints
          #
          #   @return [String]
          required :id, String

          # @!attribute created_at
          #   The Unix timestamp (in seconds) of when the project was created.
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute name
          #   The name of the project. This appears in reporting.
          #
          #   @return [String]
          required :name, String

          # @!attribute object
          #   The object type, which is always `organization.project`
          #
          #   @return [Symbol, :"organization.project"]
          required :object, const: :"organization.project"

          # @!attribute status
          #   `active` or `archived`
          #
          #   @return [Symbol, OpenAI::Models::Admin::Organization::Project::Status]
          required :status, enum: -> { OpenAI::Admin::Organization::Project::Status }

          # @!attribute archived_at
          #   The Unix timestamp (in seconds) of when the project was archived or `null`.
          #
          #   @return [Integer, nil]
          optional :archived_at, Integer, nil?: true

          # @!method initialize(id:, created_at:, name:, status:, archived_at: nil, object: :"organization.project")
          #   Represents an individual project.
          #
          #   @param id [String] The identifier, which can be referenced in API endpoints
          #
          #   @param created_at [Integer] The Unix timestamp (in seconds) of when the project was created.
          #
          #   @param name [String] The name of the project. This appears in reporting.
          #
          #   @param status [Symbol, OpenAI::Models::Admin::Organization::Project::Status] `active` or `archived`
          #
          #   @param archived_at [Integer, nil] The Unix timestamp (in seconds) of when the project was archived or `null`.
          #
          #   @param object [Symbol, :"organization.project"] The object type, which is always `organization.project`

          # `active` or `archived`
          #
          # @see OpenAI::Models::Admin::Organization::Project#status
          module Status
            extend OpenAI::Internal::Type::Enum

            ACTIVE = :active
            ARCHIVED = :archived

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
