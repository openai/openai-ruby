# typed: strong

module OpenAI
  module Models
    module Realtime
      class ResponseTextDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ResponseTextDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the content part in the item's content array.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The ID of the response.
        sig { returns(String) }
        attr_accessor :response_id

        # The final text content.
        sig { returns(String) }
        attr_accessor :text

        # The event type, must be `response.output_text.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when the text value of an "output_text" content part is done streaming.
        # Also emitted when a Response is interrupted, incomplete, or cancelled.
        sig do
          params(
            content_index: Integer,
            event_id: String,
            item_id: String,
            output_index: Integer,
            response_id: String,
            text: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the content part in the item's content array.
          content_index:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the item.
          item_id:,
          # The index of the output item in the response.
          output_index:,
          # The ID of the response.
          response_id:,
          # The final text content.
          text:,
          # The event type, must be `response.output_text.done`.
          type: :"response.output_text.done"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              event_id: String,
              item_id: String,
              output_index: Integer,
              response_id: String,
              text: String,
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
