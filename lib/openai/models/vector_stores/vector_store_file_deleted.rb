# frozen_string_literal: true

module OpenAI
  module Models
    module VectorStores
      class VectorStoreFileDeleted < OpenAI::BaseModel
        # @!attribute id
        #
        #   @return [String]
        required :id, String

        # @!attribute deleted
        #
        #   @return [Boolean]
        required :deleted, OpenAI::BooleanModel

        # @!attribute object
        #
        #   @return [Symbol, :"vector_store.file.deleted"]
        required :object, const: :"vector_store.file.deleted"

        # @!parse
        #   # @param id [String]
        #   # @param deleted [Boolean]
        #   # @param object [Symbol, :"vector_store.file.deleted"]
        #   #
        #   def initialize(id:, deleted:, object: :"vector_store.file.deleted", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end

    VectorStoreFileDeleted = VectorStores::VectorStoreFileDeleted
  end
end
