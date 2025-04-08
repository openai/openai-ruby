# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        # @see OpenAI::Resources::FineTuning::Checkpoints::Permissions#retrieve
        class PermissionRetrieveResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #
          #   @return [Array<OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveResponse::Data>]
          required :data,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveResponse::Data] }

          # @!attribute has_more
          #
          #   @return [Boolean]
          required :has_more, OpenAI::Internal::Type::Boolean

          # @!attribute object
          #
          #   @return [Symbol, :list]
          required :object, const: :list

          # @!attribute first_id
          #
          #   @return [String, nil]
          optional :first_id, String, nil?: true

          # @!attribute last_id
          #
          #   @return [String, nil]
          optional :last_id, String, nil?: true

          # @!parse
          #   # @param data [Array<OpenAI::Models::FineTuning::Checkpoints::PermissionRetrieveResponse::Data>]
          #   # @param has_more [Boolean]
          #   # @param first_id [String, nil]
          #   # @param last_id [String, nil]
          #   # @param object [Symbol, :list]
          #   #
          #   def initialize(data:, has_more:, first_id: nil, last_id: nil, object: :list, **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void

          class Data < OpenAI::Internal::Type::BaseModel
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
end
