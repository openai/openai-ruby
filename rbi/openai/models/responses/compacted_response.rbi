# typed: strong

module OpenAI
  module Models
    module Responses
      class CompactedResponse < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::CompactedResponse,
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
          returns(T::Array[OpenAI::Responses::ResponseOutputItem::Variants])
        end
        attr_accessor :output

        # Token accounting for the compaction pass, including cached, reasoning, and total
        # tokens.
        sig { returns(OpenAI::Responses::ResponseUsage) }
        attr_reader :usage

        sig { params(usage: OpenAI::Responses::ResponseUsage::OrHash).void }
        attr_writer :usage

        sig do
          params(
            id: String,
            created_at: Integer,
            output:
              T::Array[
                T.any(
                  OpenAI::Responses::ResponseOutputMessage::OrHash,
                  OpenAI::Responses::ResponseFileSearchToolCall::OrHash,
                  OpenAI::Responses::ResponseFunctionToolCall::OrHash,
                  OpenAI::Responses::ResponseFunctionWebSearch::OrHash,
                  OpenAI::Responses::ResponseComputerToolCall::OrHash,
                  OpenAI::Responses::ResponseReasoningItem::OrHash,
                  OpenAI::Responses::ResponseCompactionItem::OrHash,
                  OpenAI::Responses::ResponseOutputItem::ImageGenerationCall::OrHash,
                  OpenAI::Responses::ResponseCodeInterpreterToolCall::OrHash,
                  OpenAI::Responses::ResponseOutputItem::LocalShellCall::OrHash,
                  OpenAI::Responses::ResponseFunctionShellToolCall::OrHash,
                  OpenAI::Responses::ResponseFunctionShellToolCallOutput::OrHash,
                  OpenAI::Responses::ResponseApplyPatchToolCall::OrHash,
                  OpenAI::Responses::ResponseApplyPatchToolCallOutput::OrHash,
                  OpenAI::Responses::ResponseOutputItem::McpCall::OrHash,
                  OpenAI::Responses::ResponseOutputItem::McpListTools::OrHash,
                  OpenAI::Responses::ResponseOutputItem::McpApprovalRequest::OrHash,
                  OpenAI::Responses::ResponseCustomToolCall::OrHash
                )
              ],
            usage: OpenAI::Responses::ResponseUsage::OrHash,
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
              output: T::Array[OpenAI::Responses::ResponseOutputItem::Variants],
              usage: OpenAI::Responses::ResponseUsage
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
