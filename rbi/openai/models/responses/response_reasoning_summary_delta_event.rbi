# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningSummaryDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseReasoningSummaryDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The partial update to the reasoning summary content.
        sig { returns(T.anything) }
        attr_accessor :delta

        # The unique identifier of the item for which the reasoning summary is being
        # updated.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response's output array.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The index of the summary part within the output item.
        sig { returns(Integer) }
        attr_accessor :summary_index

        # The type of the event. Always 'response.reasoning_summary.delta'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when there is a delta (partial update) to the reasoning summary content.
        sig do
          params(
            delta: T.anything,
            item_id: String,
            output_index: Integer,
            summary_index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The partial update to the reasoning summary content.
          delta:,
          # The unique identifier of the item for which the reasoning summary is being
          # updated.
          item_id:,
          # The index of the output item in the response's output array.
          output_index:,
          # The index of the summary part within the output item.
          summary_index:,
          # The type of the event. Always 'response.reasoning_summary.delta'.
          type: :"response.reasoning_summary.delta"
        )
        end

        sig do
          override.returns(
            {
              delta: T.anything,
              item_id: String,
              output_index: Integer,
              summary_index: Integer,
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
