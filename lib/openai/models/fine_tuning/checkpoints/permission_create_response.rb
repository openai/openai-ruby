# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        # @see OpenAI::Resources::FineTuning::Checkpoints::Permissions#create
        class PermissionCreateResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The permission identifier, which can be referenced in the API endpoints.
          #
          #   @return [String]
          required :id, String

          # @!attribute created_at
          #   The Unix timestamp (in seconds) for when the permission was created.
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute object
          #   The object type, which is always "checkpoint.permission".
          #
          #   @return [Symbol, :"checkpoint.permission"]
          required :object, const: :"checkpoint.permission"

          # @!attribute project_id
          #   The project identifier that the permission is for.
          #
          #   @return [String]
          required :project_id, String

          # @!parse
          #   # The `checkpoint.permission` object represents a permission for a fine-tuned
          #   # model checkpoint.
          #   #
          #   # @param id [String]
          #   # @param created_at [Integer]
          #   # @param project_id [String]
          #   # @param object [Symbol, :"checkpoint.permission"]
          #   #
          #   def initialize(id:, created_at:, project_id:, object: :"checkpoint.permission", **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
        end
      end
    end
  end
end
