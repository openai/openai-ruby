# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningTextDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseReasoningTextDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the reasoning content part.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The ID of the item this reasoning text is associated with.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item this reasoning text is associated with.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The full text of the completed reasoning content.
        sig { returns(String) }
        attr_accessor :text

        # The type of the event. Always `response.reasoning_text.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a reasoning text is completed.
        sig do
          params(
            content_index: Integer,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            text: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the reasoning content part.
          content_index:,
          # The ID of the item this reasoning text is associated with.
          item_id:,
          # The index of the output item this reasoning text is associated with.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The full text of the completed reasoning content.
          text:,
          # The type of the event. Always `response.reasoning_text.done`.
          type: :"response.reasoning_text.done"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
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
