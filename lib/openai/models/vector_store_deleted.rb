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
      required :deleted, OpenAI::Internal::Type::BooleanModel

      # @!attribute object
      #
      #   @return [Symbol, :"vector_store.deleted"]
      required :object, const: :"vector_store.deleted"

      # @!parse
      #   # @param id [String]
      #   # @param deleted [Boolean]
      #   # @param object [Symbol, :"vector_store.deleted"]
      #   #
      #   def initialize(id:, deleted:, object: :"vector_store.deleted", **) = super

      # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
    end
  end
end
