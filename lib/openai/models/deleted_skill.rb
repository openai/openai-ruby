# frozen_string_literal: true

# File generated from our OpenAPI spec by Castiron. See CONTRIBUTING.md for details.
module OpenAI
  module Models
    # @see OpenAI::Resources::Skills#delete
    class DeletedSkill < OpenAI::Internal::Type::BaseModel
      # @!attribute id
      #
      #   @return [String]
      required :id, String

      # @!attribute deleted
      #
      #   @return [Boolean]
      required :deleted, OpenAI::Internal::Type::Boolean

      # @!attribute object
      #
      #   @return [Symbol, :"skill.deleted"]
      required :object, const: :"skill.deleted"

      # @!method initialize(id:, deleted:, object: :"skill.deleted")
      #   @param id [String]
      #   @param deleted [Boolean]
      #   @param object [Symbol, :"skill.deleted"]
    end
  end
end
