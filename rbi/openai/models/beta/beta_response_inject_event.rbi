# typed: strong

module OpenAI
  module Models
    BetaResponseInjectEvent = Beta::BetaResponseInjectEvent

    module Beta
      class BetaResponseInjectEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseInjectEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Input items to inject into the active response.
        sig do
          returns(
            T::Array[
              T.any(
                OpenAI::Beta::BetaEasyInputMessage,
                OpenAI::Beta::BetaResponseInputItem::Message,
                OpenAI::Beta::BetaResponseOutputMessage,
                OpenAI::Beta::BetaResponseFileSearchToolCall,
                OpenAI::Beta::BetaResponseComputerToolCall,
                OpenAI::Beta::BetaResponseInputItem::ComputerCallOutput,
                OpenAI::Beta::BetaResponseFunctionWebSearch,
                OpenAI::Beta::BetaResponseFunctionToolCall,
                OpenAI::Beta::BetaResponseInputItem::FunctionCallOutput,
                OpenAI::Beta::BetaResponseInputItem::AgentMessage,
                OpenAI::Beta::BetaResponseInputItem::MultiAgentCall,
                OpenAI::Beta::BetaResponseInputItem::MultiAgentCallOutput,
                OpenAI::Beta::BetaResponseInputItem::ToolSearchCall,
                OpenAI::Beta::BetaResponseToolSearchOutputItemParam,
                OpenAI::Beta::BetaResponseInputItem::AdditionalTools,
                OpenAI::Beta::BetaResponseReasoningItem,
                OpenAI::Beta::BetaResponseCompactionItemParam,
                OpenAI::Beta::BetaResponseInputItem::ImageGenerationCall,
                OpenAI::Beta::BetaResponseCodeInterpreterToolCall,
                OpenAI::Beta::BetaResponseInputItem::LocalShellCall,
                OpenAI::Beta::BetaResponseInputItem::LocalShellCallOutput,
                OpenAI::Beta::BetaResponseInputItem::ShellCall,
                OpenAI::Beta::BetaResponseInputItem::ShellCallOutput,
                OpenAI::Beta::BetaResponseInputItem::ApplyPatchCall,
                OpenAI::Beta::BetaResponseInputItem::ApplyPatchCallOutput,
                OpenAI::Beta::BetaResponseInputItem::McpListTools,
                OpenAI::Beta::BetaResponseInputItem::McpApprovalRequest,
                OpenAI::Beta::BetaResponseInputItem::McpApprovalResponse,
                OpenAI::Beta::BetaResponseInputItem::McpCall,
                OpenAI::Beta::BetaResponseCustomToolCallOutput,
                OpenAI::Beta::BetaResponseCustomToolCall,
                OpenAI::Beta::BetaResponseInputItem::CompactionTrigger,
                OpenAI::Beta::BetaResponseInputItem::ItemReference,
                OpenAI::Beta::BetaResponseInputItem::Program,
                OpenAI::Beta::BetaResponseInputItem::ProgramOutput
              )
            ]
          )
        end
        attr_accessor :input

        # The ID of the active response that should receive the input.
        sig { returns(String) }
        attr_accessor :response_id

        # The event discriminator. Always `response.inject`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Injects input items into an active response over a WebSocket connection. The
        # items are validated and committed atomically. Currently, the server accepts
        # client-owned tool outputs that resume a waiting agent.
        sig do
          params(
            input:
              T::Array[
                T.any(
                  OpenAI::Beta::BetaEasyInputMessage::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::Message::OrHash,
                  OpenAI::Beta::BetaResponseOutputMessage::OrHash,
                  OpenAI::Beta::BetaResponseFileSearchToolCall::OrHash,
                  OpenAI::Beta::BetaResponseComputerToolCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ComputerCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseFunctionWebSearch::OrHash,
                  OpenAI::Beta::BetaResponseFunctionToolCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::FunctionCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::AgentMessage::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::MultiAgentCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::MultiAgentCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ToolSearchCall::OrHash,
                  OpenAI::Beta::BetaResponseToolSearchOutputItemParam::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::AdditionalTools::OrHash,
                  OpenAI::Beta::BetaResponseReasoningItem::OrHash,
                  OpenAI::Beta::BetaResponseCompactionItemParam::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ImageGenerationCall::OrHash,
                  OpenAI::Beta::BetaResponseCodeInterpreterToolCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::LocalShellCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::LocalShellCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ShellCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ShellCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ApplyPatchCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ApplyPatchCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::McpListTools::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::McpApprovalRequest::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::McpApprovalResponse::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::McpCall::OrHash,
                  OpenAI::Beta::BetaResponseCustomToolCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseCustomToolCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::CompactionTrigger::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ItemReference::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::Program::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ProgramOutput::OrHash
                )
              ],
            response_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Input items to inject into the active response.
          input:,
          # The ID of the active response that should receive the input.
          response_id:,
          # The event discriminator. Always `response.inject`.
          type: :"response.inject"
        )
        end

        sig do
          override.returns(
            {
              input:
                T::Array[
                  T.any(
                    OpenAI::Beta::BetaEasyInputMessage,
                    OpenAI::Beta::BetaResponseInputItem::Message,
                    OpenAI::Beta::BetaResponseOutputMessage,
                    OpenAI::Beta::BetaResponseFileSearchToolCall,
                    OpenAI::Beta::BetaResponseComputerToolCall,
                    OpenAI::Beta::BetaResponseInputItem::ComputerCallOutput,
                    OpenAI::Beta::BetaResponseFunctionWebSearch,
                    OpenAI::Beta::BetaResponseFunctionToolCall,
                    OpenAI::Beta::BetaResponseInputItem::FunctionCallOutput,
                    OpenAI::Beta::BetaResponseInputItem::AgentMessage,
                    OpenAI::Beta::BetaResponseInputItem::MultiAgentCall,
                    OpenAI::Beta::BetaResponseInputItem::MultiAgentCallOutput,
                    OpenAI::Beta::BetaResponseInputItem::ToolSearchCall,
                    OpenAI::Beta::BetaResponseToolSearchOutputItemParam,
                    OpenAI::Beta::BetaResponseInputItem::AdditionalTools,
                    OpenAI::Beta::BetaResponseReasoningItem,
                    OpenAI::Beta::BetaResponseCompactionItemParam,
                    OpenAI::Beta::BetaResponseInputItem::ImageGenerationCall,
                    OpenAI::Beta::BetaResponseCodeInterpreterToolCall,
                    OpenAI::Beta::BetaResponseInputItem::LocalShellCall,
                    OpenAI::Beta::BetaResponseInputItem::LocalShellCallOutput,
                    OpenAI::Beta::BetaResponseInputItem::ShellCall,
                    OpenAI::Beta::BetaResponseInputItem::ShellCallOutput,
                    OpenAI::Beta::BetaResponseInputItem::ApplyPatchCall,
                    OpenAI::Beta::BetaResponseInputItem::ApplyPatchCallOutput,
                    OpenAI::Beta::BetaResponseInputItem::McpListTools,
                    OpenAI::Beta::BetaResponseInputItem::McpApprovalRequest,
                    OpenAI::Beta::BetaResponseInputItem::McpApprovalResponse,
                    OpenAI::Beta::BetaResponseInputItem::McpCall,
                    OpenAI::Beta::BetaResponseCustomToolCallOutput,
                    OpenAI::Beta::BetaResponseCustomToolCall,
                    OpenAI::Beta::BetaResponseInputItem::CompactionTrigger,
                    OpenAI::Beta::BetaResponseInputItem::ItemReference,
                    OpenAI::Beta::BetaResponseInputItem::Program,
                    OpenAI::Beta::BetaResponseInputItem::ProgramOutput
                  )
                ],
              response_id: String,
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
