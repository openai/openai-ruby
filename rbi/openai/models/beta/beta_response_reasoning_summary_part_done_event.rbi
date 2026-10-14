# typed: strong

module OpenAI
  module Models
    BetaResponseReasoningSummaryPartDoneEvent =
      Beta::BetaResponseReasoningSummaryPartDoneEvent

    module Beta
      class BetaResponseReasoningSummaryPartDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent,
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
          returns(OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Part)
        end
        attr_reader :part

        sig do
          params(
            part:
              OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Part::OrHash
          ).void
        end
        attr_writer :part

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The index of the summary part within the reasoning summary.
        sig { returns(Integer) }
        attr_accessor :summary_index

        # The type of the event. Always `response.reasoning_summary_part.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # The completion status of the summary part. Omitted when the part completed
        # normally and set to `incomplete` when generation was interrupted.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Status::TaggedSymbol
            )
          )
        end
        attr_reader :status

        sig do
          params(
            status:
              OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Status::OrSymbol
          ).void
        end
        attr_writer :status

        # Emitted when a reasoning summary part is completed.
        sig do
          params(
            item_id: String,
            output_index: Integer,
            part:
              OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Part::OrHash,
            sequence_number: Integer,
            summary_index: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Agent::OrHash
              ),
            status:
              OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Status::OrSymbol,
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
          # The sequence number of this event.
          sequence_number:,
          # The index of the summary part within the reasoning summary.
          summary_index:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The completion status of the summary part. Omitted when the part completed
          # normally and set to `incomplete` when generation was interrupted.
          status: nil,
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
                OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Part,
              sequence_number: Integer,
              summary_index: Integer,
              type: Symbol,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Agent
                ),
              status:
                OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Status::TaggedSymbol
            }
          )
        end
        def to_hash
        end

        class Part < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Part,
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

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Agent,
                OpenAI::Internal::AnyHash
              )
            end

          # The canonical name of the agent that produced this item.
          sig { returns(String) }
          attr_accessor :agent_name

          # The agent that owns this multi-agent streaming event.
          sig { params(agent_name: String).returns(T.attached_class) }
          def self.new(
            # The canonical name of the agent that produced this item.
            agent_name:
          )
          end

          sig { override.returns({ agent_name: String }) }
          def to_hash
          end
        end

        # The completion status of the summary part. Omitted when the part completed
        # normally and set to `incomplete` when generation was interrupted.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(
                Symbol,
                OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Status
              )
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Status::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
