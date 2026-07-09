# typed: strong

module OpenAI
  module Models
    BetaResponseReasoningTextDoneEvent =
      Beta::BetaResponseReasoningTextDoneEvent

    module Beta
      class BetaResponseReasoningTextDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseReasoningTextDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the reasoning content part.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The ID of the item this reasoning text is associated with.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item this reasoning text is associated with.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The full text of the completed reasoning content.
        sig { returns(String) }
        attr_accessor :text

        # The type of the event. Always `response.reasoning_text.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(OpenAI::Beta::BetaResponseReasoningTextDoneEvent::Agent)
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseReasoningTextDoneEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when a reasoning text is completed.
        sig do
          params(
            content_index: Integer,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            text: String,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseReasoningTextDoneEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the reasoning content part.
          content_index:,
          # The ID of the item this reasoning text is associated with.
          item_id:,
          # The index of the output item this reasoning text is associated with.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The full text of the completed reasoning content.
          text:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.reasoning_text.done`.
          type: :"response.reasoning_text.done"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              text: String,
              type: Symbol,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseReasoningTextDoneEvent::Agent
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
                OpenAI::Beta::BetaResponseReasoningTextDoneEvent::Agent,
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
