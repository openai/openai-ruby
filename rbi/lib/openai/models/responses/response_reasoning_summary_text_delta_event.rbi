# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningSummaryTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        # The text delta that was added to the summary.
        sig { returns(String) }
        attr_accessor :delta

        # The ID of the item this summary text delta is associated with.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item this summary text delta is associated with.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The index of the summary part within the reasoning summary.
        sig { returns(Integer) }
        attr_accessor :summary_index

        # The type of the event. Always `response.reasoning_summary_text.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a delta is added to a reasoning summary text.
        sig do
          params(delta: String, item_id: String, output_index: Integer, summary_index: Integer, type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(
          # The text delta that was added to the summary.
          delta:,
          # The ID of the item this summary text delta is associated with.
          item_id:,
          # The index of the output item this summary text delta is associated with.
          output_index:,
          # The index of the summary part within the reasoning summary.
          summary_index:,
          # The type of the event. Always `response.reasoning_summary_text.delta`.
          type: :"response.reasoning_summary_text.delta"
        ); end
        sig do
          override
            .returns({
                       delta: String,
                       item_id: String,
                       output_index: Integer,
                       summary_index: Integer,
                       type: Symbol
                     })
        end
        def to_hash; end
      end
    end
  end
end
