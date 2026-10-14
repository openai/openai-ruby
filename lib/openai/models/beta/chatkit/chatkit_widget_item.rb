# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatKitWidgetItem < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   Identifier of the thread item.
          #
          #   @return [String]
          required :id, String

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
          #   Type discriminator that is always `chatkit.widget`.
          #
          #   @return [Symbol, :"chatkit.widget"]
          required :type, const: :"chatkit.widget"

          # @!attribute widget
          #   Serialized widget payload rendered in the UI.
          #
          #   @return [String]
          required :widget, String

          # @!method initialize(id:, created_at:, thread_id:, widget:, object: :"chatkit.thread_item", type: :"chatkit.widget")
          #   Thread item that renders a widget payload.
          #
          #   @param id [String] Identifier of the thread item.
          #
          #   @param created_at [Integer] Unix timestamp (in seconds) for when the item was created.
          #
          #   @param thread_id [String] Identifier of the parent thread.
          #
          #   @param widget [String] Serialized widget payload rendered in the UI.
          #
          #   @param object [Symbol, :"chatkit.thread_item"] Type discriminator that is always `chatkit.thread_item`.
          #
          #   @param type [Symbol, :"chatkit.widget"] Type discriminator that is always `chatkit.widget`.
        end
      end

      ChatKitWidgetItem = ChatKit::ChatKitWidgetItem
    end
  end
end
