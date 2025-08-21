# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseConversationParam < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the conversation.
        #
        #   @return [String]
        required :id, String

        # @!method initialize(id:)
        #   The conversation that this response belongs to.
        #
        #   @param id [String] The unique ID of the conversation.
      end
    end
  end
end
