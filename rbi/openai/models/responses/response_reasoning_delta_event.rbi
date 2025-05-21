# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseReasoningDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the reasoning content part within the output item.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The partial update to the reasoning content.
        sig { returns(T.anything) }
        attr_accessor :delta

        # The unique identifier of the item for which reasoning is being updated.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response's output array.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always 'response.reasoning.delta'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when there is a delta (partial update) to the reasoning content.
        sig do
          params(
            content_index: Integer,
            delta: T.anything,
            item_id: String,
            output_index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the reasoning content part within the output item.
          content_index:,
          # The partial update to the reasoning content.
          delta:,
          # The unique identifier of the item for which reasoning is being updated.
          item_id:,
          # The index of the output item in the response's output array.
          output_index:,
          # The type of the event. Always 'response.reasoning.delta'.
          type: :"response.reasoning.delta"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              delta: T.anything,
              item_id: String,
              output_index: Integer,
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
