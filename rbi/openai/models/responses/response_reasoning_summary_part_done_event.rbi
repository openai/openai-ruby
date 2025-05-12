# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningSummaryPartDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseReasoningSummaryPartDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the item this summary part is associated with.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item this summary part is associated with.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The completed summary part.
        sig do
          returns(
            OpenAI::Responses::ResponseReasoningSummaryPartDoneEvent::Part
          )
        end
        attr_reader :part

        sig do
          params(
            part:
              OpenAI::Responses::ResponseReasoningSummaryPartDoneEvent::Part::OrHash
          ).void
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
            part:
              OpenAI::Responses::ResponseReasoningSummaryPartDoneEvent::Part::OrHash,
            summary_index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The ID of the item this summary part is associated with.
          item_id:,
          # The index of the output item this summary part is associated with.
          output_index:,
          # The completed summary part.
          part:,
          # The index of the summary part within the reasoning summary.
          summary_index:,
          # The type of the event. Always `response.reasoning_summary_part.done`.
          type: :"response.reasoning_summary_part.done"
        )
        end

        sig do
          override.returns(
            {
              item_id: String,
              output_index: Integer,
              part:
                OpenAI::Responses::ResponseReasoningSummaryPartDoneEvent::Part,
              summary_index: Integer,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Part < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseReasoningSummaryPartDoneEvent::Part,
                OpenAI::Internal::AnyHash
              )
            end

          # The text of the summary part.
          sig { returns(String) }
          attr_accessor :text

          # The type of the summary part. Always `summary_text`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The completed summary part.
          sig { params(text: String, type: Symbol).returns(T.attached_class) }
          def self.new(
            # The text of the summary part.
            text:,
            # The type of the summary part. Always `summary_text`.
            type: :summary_text
          )
          end

          sig { override.returns({ text: String, type: Symbol }) }
          def to_hash
          end
        end
      end
    end
  end
end
