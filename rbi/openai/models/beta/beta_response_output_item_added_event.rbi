# typed: strong

module OpenAI
  module Models
    BetaResponseOutputItemAddedEvent = Beta::BetaResponseOutputItemAddedEvent

    module Beta
      class BetaResponseOutputItemAddedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseOutputItemAddedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The output item that was added.
        sig { returns(OpenAI::Beta::BetaResponseOutputItem::Variants) }
        attr_accessor :item

        # The index of the output item that was added.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.output_item.added`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(OpenAI::Beta::BetaResponseOutputItemAddedEvent::Agent)
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseOutputItemAddedEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when a new output item is added.
        sig do
          params(
            item:
              T.any(
                OpenAI::Beta::BetaResponseOutputMessage::OrHash,
                OpenAI::Beta::BetaResponseFileSearchToolCall::OrHash,
                OpenAI::Beta::BetaResponseFunctionToolCall::OrHash,
                OpenAI::Beta::BetaResponseFunctionToolCallOutputItem::OrHash,
                OpenAI::Beta::BetaResponseOutputItem::AgentMessage::OrHash,
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::OrHash,
                OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::OrHash,
                OpenAI::Beta::BetaResponseFunctionWebSearch::OrHash,
                OpenAI::Beta::BetaResponseComputerToolCall::OrHash,
                OpenAI::Beta::BetaResponseComputerToolCallOutputItem::OrHash,
                OpenAI::Beta::BetaResponseReasoningItem::OrHash,
                OpenAI::Beta::BetaResponseOutputItem::Program::OrHash,
                OpenAI::Beta::BetaResponseOutputItem::ProgramOutput::OrHash,
                OpenAI::Beta::BetaResponseToolSearchCall::OrHash,
                OpenAI::Beta::BetaResponseToolSearchOutputItem::OrHash,
                OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::OrHash,
                OpenAI::Beta::BetaResponseCompactionItem::OrHash,
                OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::OrHash,
                OpenAI::Beta::BetaResponseCodeInterpreterToolCall::OrHash,
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::OrHash,
                OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::OrHash,
                OpenAI::Beta::BetaResponseFunctionShellToolCall::OrHash,
                OpenAI::Beta::BetaResponseFunctionShellToolCallOutput::OrHash,
                OpenAI::Beta::BetaResponseApplyPatchToolCall::OrHash,
                OpenAI::Beta::BetaResponseApplyPatchToolCallOutput::OrHash,
                OpenAI::Beta::BetaResponseOutputItem::McpCall::OrHash,
                OpenAI::Beta::BetaResponseOutputItem::McpListTools::OrHash,
                OpenAI::Beta::BetaResponseOutputItem::McpApprovalRequest::OrHash,
                OpenAI::Beta::BetaResponseOutputItem::McpApprovalResponse::OrHash,
                OpenAI::Beta::BetaResponseCustomToolCall::OrHash,
                OpenAI::Beta::BetaResponseCustomToolCallOutputItem::OrHash
              ),
            output_index: Integer,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseOutputItemAddedEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The output item that was added.
          item:,
          # The index of the output item that was added.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.output_item.added`.
          type: :"response.output_item.added"
        )
        end

        sig do
          override.returns(
            {
              item: OpenAI::Beta::BetaResponseOutputItem::Variants,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              agent:
                T.nilable(OpenAI::Beta::BetaResponseOutputItemAddedEvent::Agent)
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseOutputItemAddedEvent::Agent,
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
