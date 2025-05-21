# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseReasoningDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the reasoning content part within the output item.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The unique identifier of the item for which reasoning is finalized.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response's output array.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The finalized reasoning text.
        sig { returns(String) }
        attr_accessor :text

        # The type of the event. Always 'response.reasoning.done'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the reasoning content is finalized for an item.
        sig do
          params(
            content_index: Integer,
            item_id: String,
            output_index: Integer,
            text: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the reasoning content part within the output item.
          content_index:,
          # The unique identifier of the item for which reasoning is finalized.
          item_id:,
          # The index of the output item in the response's output array.
          output_index:,
          # The finalized reasoning text.
          text:,
          # The type of the event. Always 'response.reasoning.done'.
          type: :"response.reasoning.done"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              item_id: String,
              output_index: Integer,
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
