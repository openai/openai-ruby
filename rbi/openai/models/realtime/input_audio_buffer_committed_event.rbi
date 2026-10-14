# typed: strong

module OpenAI
  module Models
    module Realtime
      class InputAudioBufferCommittedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::InputAudioBufferCommittedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the user message item that will be created.
        sig { returns(String) }
        attr_accessor :item_id

        # The event type, must be `input_audio_buffer.committed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The ID of the preceding item after which the new item will be inserted. Can be
        # `null` if the item has no predecessor.
        sig { returns(T.nilable(String)) }
        attr_accessor :previous_item_id

        # Returned when an input audio buffer is committed, either by the client or
        # automatically in server VAD mode. The `item_id` property is the ID of the user
        # message item that will be created, thus a `conversation.item.created` event will
        # also be sent to the client.
        sig do
          params(
            event_id: String,
            item_id: String,
            previous_item_id: T.nilable(String),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # The ID of the user message item that will be created.
          item_id:,
          # The ID of the preceding item after which the new item will be inserted. Can be
          # `null` if the item has no predecessor.
          previous_item_id: nil,
          # The event type, must be `input_audio_buffer.committed`.
          type: :"input_audio_buffer.committed"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              item_id: String,
              type: Symbol,
              previous_item_id: T.nilable(String)
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
