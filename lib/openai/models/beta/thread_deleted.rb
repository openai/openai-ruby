# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @see OpenAI::Resources::Beta::Threads#delete
      class ThreadDeleted < OpenAI::Internal::Type::BaseModel
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
        #   @return [Symbol, :"thread.deleted"]
        required :object, const: :"thread.deleted"

        # @!parse
        #   # @param id [String]
        #   # @param deleted [Boolean]
        #   # @param object [Symbol, :"thread.deleted"]
        #   #
        #   def initialize(id:, deleted:, object: :"thread.deleted", **) = super

        # def initialize: (Hash | OpenAI::Internal::Type::BaseModel) -> void
      end
    end
  end
end
