# frozen_string_literal: true

module OpenAI
  module Models
    # @see OpenAI::Resources::VectorStores#delete
    class VectorStoreDeleted < OpenAI::Internal::Type::BaseModel
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
      #   @return [Symbol, :"vector_store.deleted"]
      required :object, const: :"vector_store.deleted"

      # @!method initialize(id:, deleted:, object: :"vector_store.deleted")
      #   @param id [String]
      #   @param deleted [Boolean]
      #   @param object [Symbol, :"vector_store.deleted"]
    end
  end
end
