# typed: strong

module OpenAI
  module Models
    BetaResponseReasoningSummaryTextDoneEvent =
      Beta::BetaResponseReasoningSummaryTextDoneEvent

    module Beta
      class BetaResponseReasoningSummaryTextDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseReasoningSummaryTextDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the item this summary text is associated with.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item this summary text is associated with.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The index of the summary part within the reasoning summary.
        sig { returns(Integer) }
        attr_accessor :summary_index

        # The full text of the completed reasoning summary.
        sig { returns(String) }
        attr_accessor :text

        # The type of the event. Always `response.reasoning_summary_text.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseReasoningSummaryTextDoneEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseReasoningSummaryTextDoneEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when a reasoning summary text is completed.
        sig do
          params(
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            summary_index: Integer,
            text: String,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseReasoningSummaryTextDoneEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The ID of the item this summary text is associated with.
          item_id:,
          # The index of the output item this summary text is associated with.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The index of the summary part within the reasoning summary.
          summary_index:,
          # The full text of the completed reasoning summary.
          text:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.reasoning_summary_text.done`.
          type: :"response.reasoning_summary_text.done"
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
              type: Symbol,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseReasoningSummaryTextDoneEvent::Agent
                )
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseReasoningSummaryTextDoneEvent::Agent,
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
      end
    end
  end
end
