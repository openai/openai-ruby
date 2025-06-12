# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningSummaryTextDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseReasoningSummaryTextDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the item this summary text is associated with.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item this summary text is associated with.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The index of the summary part within the reasoning summary.
        sig { returns(Integer) }
        attr_accessor :summary_index

        # The full text of the completed reasoning summary.
        sig { returns(String) }
        attr_accessor :text

        # The type of the event. Always `response.reasoning_summary_text.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a reasoning summary text is completed.
        sig do
          params(
            item_id: String,
            output_index: Integer,
            summary_index: Integer,
            text: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The ID of the item this summary text is associated with.
          item_id:,
          # The index of the output item this summary text is associated with.
          output_index:,
          # The index of the summary part within the reasoning summary.
          summary_index:,
          # The full text of the completed reasoning summary.
          text:,
          # The type of the event. Always `response.reasoning_summary_text.done`.
          type: :"response.reasoning_summary_text.done"
        )
        end

        sig do
          override.returns(
            {
              item_id: String,
              output_index: Integer,
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
