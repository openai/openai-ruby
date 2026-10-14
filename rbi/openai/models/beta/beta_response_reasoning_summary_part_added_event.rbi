# typed: strong

module OpenAI
  module Models
    BetaResponseReasoningSummaryPartAddedEvent =
      Beta::BetaResponseReasoningSummaryPartAddedEvent

    module Beta
      class BetaResponseReasoningSummaryPartAddedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent,
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
            OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Part
          )
        end
        attr_reader :part

        sig do
          params(
            part:
              OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Part::OrHash
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

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when a new reasoning summary part is added.
        sig do
          params(
            item_id: String,
            output_index: Integer,
            part:
              OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Part::OrHash,
            sequence_number: Integer,
            summary_index: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Agent::OrHash
              ),
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
          # The agent that owns this multi-agent streaming event.
          agent: nil,
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
                OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Part,
              sequence_number: Integer,
              summary_index: Integer,
              type: Symbol,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Agent
                )
            }
          )
        end
        def to_hash
        end

        class Part < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Part,
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

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Agent,
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
