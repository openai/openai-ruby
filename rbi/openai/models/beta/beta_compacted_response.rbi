# typed: strong

module OpenAI
  module Models
    BetaCompactedResponse = Beta::BetaCompactedResponse

    module Beta
      class BetaCompactedResponse < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaCompactedResponse,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique identifier for the compacted response.
        sig { returns(String) }
        attr_accessor :id

        # Unix timestamp (in seconds) when the compacted conversation was created.
        sig { returns(Integer) }
        attr_accessor :created_at

        # The object type. Always `response.compaction`.
        sig { returns(Symbol) }
        attr_accessor :object

        # The compacted list of output items. This is a list of all user messages,
        # followed by a single compaction item.
        sig do
          returns(T::Array[OpenAI::Beta::BetaResponseOutputItem::Variants])
        end
        attr_accessor :output

        # Token accounting for the compaction pass, including cached, reasoning, and total
        # tokens.
        sig { returns(OpenAI::Beta::BetaResponseUsage) }
        attr_reader :usage

        sig { params(usage: OpenAI::Beta::BetaResponseUsage::OrHash).void }
        attr_writer :usage

        sig do
          params(
            id: String,
            created_at: Integer,
            output:
              T::Array[
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
                )
              ],
            usage: OpenAI::Beta::BetaResponseUsage::OrHash,
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique identifier for the compacted response.
          id:,
          # Unix timestamp (in seconds) when the compacted conversation was created.
          created_at:,
          # The compacted list of output items. This is a list of all user messages,
          # followed by a single compaction item.
          output:,
          # Token accounting for the compaction pass, including cached, reasoning, and total
          # tokens.
          usage:,
          # The object type. Always `response.compaction`.
          object: :"response.compaction"
        )
        end

        sig do
          override.returns(
            {
              id: String,
              created_at: Integer,
              object: Symbol,
              output: T::Array[OpenAI::Beta::BetaResponseOutputItem::Variants],
              usage: OpenAI::Beta::BetaResponseUsage
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
