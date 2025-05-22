# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningSummaryDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseReasoningSummaryDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique identifier of the item for which the reasoning summary is finalized.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response's output array.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The index of the summary part within the output item.
        sig { returns(Integer) }
        attr_accessor :summary_index

        # The finalized reasoning summary text.
        sig { returns(String) }
        attr_accessor :text

        # The type of the event. Always 'response.reasoning_summary.done'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the reasoning summary content is finalized for an item.
        sig do
          params(
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            summary_index: Integer,
            text: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique identifier of the item for which the reasoning summary is finalized.
          item_id:,
          # The index of the output item in the response's output array.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The index of the summary part within the output item.
          summary_index:,
          # The finalized reasoning summary text.
          text:,
          # The type of the event. Always 'response.reasoning_summary.done'.
          type: :"response.reasoning_summary.done"
        )
        end

        sig do
          override.returns(
            {
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              summary_index: Integer,
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
