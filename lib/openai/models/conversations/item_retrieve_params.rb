# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      # @see OpenAI::Resources::Conversations::Items#retrieve
      class ItemRetrieveParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute conversation_id
        #
        #   @return [String]
        required :conversation_id, String

        # @!attribute item_id
        #
        #   @return [String]
        required :item_id, String

        # @!attribute include
        #   Additional fields to include in the response. See the `include` parameter for
        #   [listing Conversation items above](https://developers.openai.com/api/reference/resources/conversations/subresources/items/methods/list#%28resource%29%20conversations.items%20%3E%20%28method%29%20list%20%3E%20%28params%29%20default%20%3E%20%28param%29%20include%20%3E%20%28schema%29)
        #   for more information.
        #
        #   @return [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil]
        optional :include, -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Responses::ResponseIncludable] }

        # @!method initialize(conversation_id:, item_id:, include: nil, request_options: {})
        #   @param conversation_id [String]
        #
        #   @param item_id [String]
        #
        #   @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>]
        #     Additional fields to include in the response. See the `include` parameter for
        #     [listing Conversation items above](https://developers.openai.com/api/reference/resources/conversations/subresources/items/methods/list#%28resource%29%20conversations.items%20%3E%20%28method%29%20list%20%3E%20%28params%29%20default%20%3E%20%28param%29%20include%20%3E%20%28schema%29)
        #     for more information.
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
