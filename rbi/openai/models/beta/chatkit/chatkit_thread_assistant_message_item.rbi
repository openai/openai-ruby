# typed: strong

module OpenAI
  module Models
    module Beta
      ChatKitThreadAssistantMessageItem =
        ChatKit::ChatKitThreadAssistantMessageItem

      module ChatKit
        class ChatKitThreadAssistantMessageItem < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatKitThreadAssistantMessageItem,
                OpenAI::Internal::AnyHash
              )
            end

          # Identifier of the thread item.
          sig { returns(String) }
          attr_accessor :id

          # Ordered assistant response segments.
          sig do
            returns(T::Array[OpenAI::Beta::ChatKit::ChatKitResponseOutputText])
          end
          attr_accessor :content

          # Unix timestamp (in seconds) for when the item was created.
          sig { returns(Integer) }
          attr_accessor :created_at

          # Type discriminator that is always `chatkit.thread_item`.
          sig { returns(Symbol) }
          attr_accessor :object

          # Identifier of the parent thread.
          sig { returns(String) }
          attr_accessor :thread_id

          # Type discriminator that is always `chatkit.assistant_message`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Assistant-authored message within a thread.
          sig do
            params(
              id: String,
              content:
                T::Array[
                  OpenAI::Beta::ChatKit::ChatKitResponseOutputText::OrHash
                ],
              created_at: Integer,
              thread_id: String,
              object: Symbol,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Identifier of the thread item.
            id:,
            # Ordered assistant response segments.
            content:,
            # Unix timestamp (in seconds) for when the item was created.
            created_at:,
            # Identifier of the parent thread.
            thread_id:,
            # Type discriminator that is always `chatkit.thread_item`.
            object: :"chatkit.thread_item",
            # Type discriminator that is always `chatkit.assistant_message`.
            type: :"chatkit.assistant_message"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                content:
                  T::Array[OpenAI::Beta::ChatKit::ChatKitResponseOutputText],
                created_at: Integer,
                object: Symbol,
                thread_id: String,
                type: Symbol
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
