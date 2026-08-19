# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::Models#delete
    class ModelDeleted < OpenAI::Internal::Type::BaseModel
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
      #   @return [String]
      required :object, String

      # @!method initialize(id:, deleted:, object:)
      #   @param id [String]
      #   @param deleted [Boolean]
      #   @param object [String]
    end
  end
end
