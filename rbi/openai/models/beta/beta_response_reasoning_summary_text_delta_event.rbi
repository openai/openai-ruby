# typed: strong

module OpenAI
  module Models
    BetaResponseReasoningSummaryTextDeltaEvent =
      Beta::BetaResponseReasoningSummaryTextDeltaEvent

    module Beta
      class BetaResponseReasoningSummaryTextDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseReasoningSummaryTextDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The text delta that was added to the summary.
        sig { returns(String) }
        attr_accessor :delta

        # The ID of the item this summary text delta is associated with.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item this summary text delta is associated with.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The index of the summary part within the reasoning summary.
        sig { returns(Integer) }
        attr_accessor :summary_index

        # The type of the event. Always `response.reasoning_summary_text.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseReasoningSummaryTextDeltaEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseReasoningSummaryTextDeltaEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when a delta is added to a reasoning summary text.
        sig do
          params(
            delta: String,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            summary_index: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseReasoningSummaryTextDeltaEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The text delta that was added to the summary.
          delta:,
          # The ID of the item this summary text delta is associated with.
          item_id:,
          # The index of the output item this summary text delta is associated with.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The index of the summary part within the reasoning summary.
          summary_index:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.reasoning_summary_text.delta`.
          type: :"response.reasoning_summary_text.delta"
        )
        end

        sig do
          override.returns(
            {
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              summary_index: Integer,
              type: Symbol,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseReasoningSummaryTextDeltaEvent::Agent
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
                OpenAI::Beta::BetaResponseReasoningSummaryTextDeltaEvent::Agent,
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
