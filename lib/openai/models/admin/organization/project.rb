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

          # @!attribute object
          #   The object type, which is always `organization.project`
          #
          #   @return [Symbol, :"organization.project"]
          required :object, const: :"organization.project"

          # @!attribute archived_at
          #   The Unix timestamp (in seconds) of when the project was archived or `null`.
          #
          #   @return [Integer, nil]
          optional :archived_at, Integer, nil?: true

          # @!attribute external_key_id
          #   The external key associated with the project.
          #
          #   @return [String, nil]
          optional :external_key_id, String, nil?: true

          # @!attribute name
          #   The name of the project. This appears in reporting.
          #
          #   @return [String, nil]
          optional :name, String, nil?: true

          # @!attribute status
          #   `active` or `archived`
          #
          #   @return [String, nil]
          optional :status, String, nil?: true

          # @!method initialize(id:, created_at:, archived_at: nil, external_key_id: nil, name: nil, status: nil, object: :"organization.project")
          #   Represents an individual project.
          #
          #   @param id [String] The identifier, which can be referenced in API endpoints
          #
          #   @param created_at [Integer] The Unix timestamp (in seconds) of when the project was created.
          #
          #   @param archived_at [Integer, nil] The Unix timestamp (in seconds) of when the project was archived or `null`.
          #
          #   @param external_key_id [String, nil] The external key associated with the project.
          #
          #   @param name [String, nil] The name of the project. This appears in reporting.
          #
          #   @param status [String, nil] `active` or `archived`
          #
          #   @param object [Symbol, :"organization.project"] The object type, which is always `organization.project`
        end
      end
    end
  end
end
