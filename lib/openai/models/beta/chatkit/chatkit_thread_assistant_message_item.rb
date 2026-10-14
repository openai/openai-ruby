# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatKitThreadAssistantMessageItem < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   Identifier of the thread item.
          #
          #   @return [String]
          required :id, String

          # @!attribute content
          #   Ordered assistant response segments.
          #
          #   @return [Array<OpenAI::Models::Beta::ChatKit::ChatKitResponseOutputText>]
          required :content,
                   -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::ChatKit::ChatKitResponseOutputText] }

          # @!attribute created_at
          #   Unix timestamp (in seconds) for when the item was created.
          #
          #   @return [Integer]
          required :created_at, Integer

          # @!attribute object
          #   Type discriminator that is always `chatkit.thread_item`.
          #
          #   @return [Symbol, :"chatkit.thread_item"]
          required :object, const: :"chatkit.thread_item"

          # @!attribute thread_id
          #   Identifier of the parent thread.
          #
          #   @return [String]
          required :thread_id, String

          # @!attribute type
          #   Type discriminator that is always `chatkit.assistant_message`.
          #
          #   @return [Symbol, :"chatkit.assistant_message"]
          required :type, const: :"chatkit.assistant_message"

          # @!method initialize(id:, content:, created_at:, thread_id:, object: :"chatkit.thread_item", type: :"chatkit.assistant_message")
          #   Assistant-authored message within a thread.
          #
          #   @param id [String] Identifier of the thread item.
          #
          #   @param content [Array<OpenAI::Models::Beta::ChatKit::ChatKitResponseOutputText>] Ordered assistant response segments.
          #
          #   @param created_at [Integer] Unix timestamp (in seconds) for when the item was created.
          #
          #   @param thread_id [String] Identifier of the parent thread.
          #
          #   @param object [Symbol, :"chatkit.thread_item"] Type discriminator that is always `chatkit.thread_item`.
          #
          #   @param type [Symbol, :"chatkit.assistant_message"] Type discriminator that is always `chatkit.assistant_message`.
        end
      end

      ChatKitThreadAssistantMessageItem = ChatKit::ChatKitThreadAssistantMessageItem
    end
  end
end
