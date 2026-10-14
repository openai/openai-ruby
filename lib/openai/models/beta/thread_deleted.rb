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

        # @!method initialize(id:, deleted:, object: :"thread.deleted")
        #   @param id [String]
        #   @param deleted [Boolean]
        #   @param object [Symbol, :"thread.deleted"]
      end
    end
  end
end
