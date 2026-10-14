# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseReasoningTextDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the reasoning content part this delta is associated with.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The text delta that was added to the reasoning content.
        sig { returns(String) }
        attr_accessor :delta

        # The ID of the item this reasoning text delta is associated with.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item this reasoning text delta is associated with.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.reasoning_text.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a delta is added to a reasoning text.
        sig do
          params(
            content_index: Integer,
            delta: String,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the reasoning content part this delta is associated with.
          content_index:,
          # The text delta that was added to the reasoning content.
          delta:,
          # The ID of the item this reasoning text delta is associated with.
          item_id:,
          # The index of the output item this reasoning text delta is associated with.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The type of the event. Always `response.reasoning_text.delta`.
          type: :"response.reasoning_text.delta"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
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
