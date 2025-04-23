# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningSummaryPartDoneEvent < OpenAI::Internal::Type::BaseModel
        # The ID of the item this summary part is associated with.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item this summary part is associated with.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The completed summary part.
        sig { returns(OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent::Part) }
        attr_reader :part

        sig do
          params(
            part: T.any(OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent::Part, OpenAI::Internal::AnyHash)
          )
            .void
        end
        attr_writer :part

        # The index of the summary part within the reasoning summary.
        sig { returns(Integer) }
        attr_accessor :summary_index

        # The type of the event. Always `response.reasoning_summary_part.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a reasoning summary part is completed.
        sig do
          params(
            item_id: String,
            output_index: Integer,
            part: T.any(OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent::Part, OpenAI::Internal::AnyHash),
            summary_index: Integer,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(
          item_id:,
          output_index:,
          part:,
          summary_index:,
          type: :"response.reasoning_summary_part.done"
        )
        end

        sig do
          override
            .returns(
              {
                item_id: String,
                output_index: Integer,
                part: OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent::Part,
                summary_index: Integer,
                type: Symbol
              }
            )
        end
        def to_hash; end

        class Part < OpenAI::Internal::Type::BaseModel
          # The text of the summary part.
          sig { returns(String) }
          attr_accessor :text

          # The type of the summary part. Always `summary_text`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The completed summary part.
          sig { params(text: String, type: Symbol).returns(T.attached_class) }
          def self.new(text:, type: :summary_text); end

          sig { override.returns({text: String, type: Symbol}) }
          def to_hash; end
        end
      end
    end
  end
end
