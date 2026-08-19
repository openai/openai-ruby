# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      class ConversationDeleted < OpenAI::Internal::Type::BaseModel
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
        #   @return [Symbol, :"conversation.deleted"]
        required :object, const: :"conversation.deleted"

        # @!method initialize(id:, deleted:, object: :"conversation.deleted")
        #   @param id [String]
        #   @param deleted [Boolean]
        #   @param object [Symbol, :"conversation.deleted"]
      end
    end
  end
end
