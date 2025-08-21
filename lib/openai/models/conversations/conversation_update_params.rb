# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      # @see OpenAI::Resources::Conversations#update
      class ConversationUpdateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        # @!attribute metadata
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard. Keys are strings with a maximum
        #   length of 64 characters. Values are strings with a maximum length of 512
        #   characters.
        #
        #   @return [Hash{Symbol=>String}]
        required :metadata, OpenAI::Internal::Type::HashOf[String]

        # @!method initialize(metadata:, request_options: {})
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Conversations::ConversationUpdateParams} for more details.
        #
        #   @param metadata [Hash{Symbol=>String}] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        #   @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}]
      end
    end
  end
end
