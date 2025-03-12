# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class ThreadDeleted < OpenAI::BaseModel
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
        #   @return [Symbol, :"thread.deleted"]
        required :object, const: :"thread.deleted"

        # @!parse
        #   # @param id [String]
        #   # @param deleted [Boolean]
        #   # @param object [Symbol, :"thread.deleted"]
        #   #
        #   def initialize(id:, deleted:, object: :"thread.deleted", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void
      end
    end
  end
end
