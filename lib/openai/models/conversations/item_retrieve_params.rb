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

        # @!attribute include
        #   Additional fields to include in the response. See the `include` parameter for
        #   [listing Conversation items above](https://platform.openai.com/docs/api-reference/conversations/list-items#conversations_list_items-include)
        #   for more information.
        #
        #   @return [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>, nil]
        optional :include, -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Responses::ResponseIncludable] }

        # @!method initialize(conversation_id:, include: nil, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Conversations::ItemRetrieveParams} for more details.
        #
        #   @param conversation_id [String]
        #
        #   @param include [Array<Symbol, OpenAI::Models::Responses::ResponseIncludable>] Additional fields to include in the response. See the `include`
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
