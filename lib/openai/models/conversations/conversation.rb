# frozen_string_literal: true

module OpenAI
  module Models
    module Conversations
      # @see OpenAI::Resources::Conversations#create
      class Conversation < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the conversation.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The time at which the conversation was created, measured in seconds since the
        #   Unix epoch.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute metadata
        #   Set of 16 key-value pairs that can be attached to an object. This can be useful
        #   for storing additional information about the object in a structured format, and
        #   querying for objects via API or the dashboard. Keys are strings with a maximum
        #   length of 64 characters. Values are strings with a maximum length of 512
        #   characters.
        #
        #   @return [Object]
        required :metadata, OpenAI::Internal::Type::Unknown

        # @!attribute object
        #   The object type, which is always `conversation`.
        #
        #   @return [Symbol, :conversation]
        required :object, const: :conversation

        # @!method initialize(id:, created_at:, metadata:, object: :conversation)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Conversations::Conversation} for more details.
        #
        #   @param id [String] The unique ID of the conversation.
        #
        #   @param created_at [Integer] The time at which the conversation was created, measured in seconds since the Un
        #
        #   @param metadata [Object] Set of 16 key-value pairs that can be attached to an object. This can be
        #
        #   @param object [Symbol, :conversation] The object type, which is always `conversation`.
      end
    end
  end
end
