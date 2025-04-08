# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      module Checkpoints
        # @see OpenAI::Resources::FineTuning::Checkpoints::Permissions#delete
        class PermissionDeleteResponse < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the fine-tuned model checkpoint permission that was deleted.
          #
          #   @return [String]
          required :id, String

          # @!attribute deleted
          #   Whether the fine-tuned model checkpoint permission was successfully deleted.
          #
          #   @return [Boolean]
          required :deleted, OpenAI::Internal::Type::Boolean

          # @!attribute object
          #   The object type, which is always "checkpoint.permission".
          #
          #   @return [Symbol, :"checkpoint.permission"]
          required :object, const: :"checkpoint.permission"

          # @!parse
          #   # @param id [String]
          #   # @param deleted [Boolean]
          #   # @param object [Symbol, :"checkpoint.permission"]
          #   #
          #   def initialize(id:, deleted:, object: :"checkpoint.permission", **) = super

          # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
        end
      end
    end
  end
end
