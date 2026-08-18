# typed: strong

module OpenAI
  module Models
    module Beta
      ChatKitWidgetItem = ChatKit::ChatKitWidgetItem

      module ChatKit
        class ChatKitWidgetItem < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatKitWidgetItem,
                OpenAI::Internal::AnyHash
              )
            end

          # Identifier of the thread item.
          sig { returns(String) }
          attr_accessor :id

          # Unix timestamp (in seconds) for when the item was created.
          sig { returns(Integer) }
          attr_accessor :created_at

          # Type discriminator that is always `chatkit.thread_item`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Identifier of the parent thread.
          sig { returns(String) }
          attr_accessor :thread_id

          # Type discriminator that is always `chatkit.widget`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Serialized widget payload rendered in the UI.
          sig { returns(String) }
          attr_accessor :widget

          # Thread item that renders a widget payload.
          sig do
            params(
              id: String,
              created_at: Integer,
              thread_id: String,
              widget: String,
              object: Symbol,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Identifier of the thread item.
            id:,
            # Unix timestamp (in seconds) for when the item was created.
            created_at:,
            # Identifier of the parent thread.
            thread_id:,
            # Serialized widget payload rendered in the UI.
            widget:,
            # Type discriminator that is always `chatkit.thread_item`.
            object: :"chatkit.thread_item",
            # Type discriminator that is always `chatkit.widget`.
            type: :"chatkit.widget"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                created_at: Integer,
                object: Symbol,
                thread_id: String,
                type: Symbol,
                widget: String
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
