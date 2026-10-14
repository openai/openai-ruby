# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseReasoningSummaryPartAddedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseReasoningSummaryPartAddedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the item this summary part is associated with.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item this summary part is associated with.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The summary part that was added.
        sig do
          returns(
            OpenAI::Responses::ResponseReasoningSummaryPartAddedEvent::Part
          )
        end
        attr_reader :part

        sig do
          params(
            part:
              OpenAI::Responses::ResponseReasoningSummaryPartAddedEvent::Part::OrHash
          ).void
        end
        attr_writer :part

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The index of the summary part within the reasoning summary.
        sig { returns(Integer) }
        attr_accessor :summary_index

        # The type of the event. Always `response.reasoning_summary_part.added`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a new reasoning summary part is added.
        sig do
          params(
            item_id: String,
            output_index: Integer,
            part:
              OpenAI::Responses::ResponseReasoningSummaryPartAddedEvent::Part::OrHash,
            sequence_number: Integer,
            summary_index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The ID of the item this summary part is associated with.
          item_id:,
          # The index of the output item this summary part is associated with.
          output_index:,
          # The summary part that was added.
          part:,
          # The sequence number of this event.
          sequence_number:,
          # The index of the summary part within the reasoning summary.
          summary_index:,
          # The type of the event. Always `response.reasoning_summary_part.added`.
          type: :"response.reasoning_summary_part.added"
        )
        end

        sig do
          override.returns(
            {
              item_id: String,
              output_index: Integer,
              part:
                OpenAI::Responses::ResponseReasoningSummaryPartAddedEvent::Part,
              sequence_number: Integer,
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
                OpenAI::Responses::ResponseReasoningSummaryPartAddedEvent::Part,
                OpenAI::Internal::AnyHash
              )
            end

          # The text of the summary part.
          sig { returns(String) }
          attr_accessor :text

          # The type of the summary part. Always `summary_text`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The summary part that was added.
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
