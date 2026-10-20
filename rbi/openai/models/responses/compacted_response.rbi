# typed: strong

module OpenAI
  module Models

    module Responses

      class CompactedResponse < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
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
        sig { returns(T::Array[OpenAI::Responses::ResponseItem::Variants]) }
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

            output: T::Array[
              T.any(
                OpenAI::Responses::ResponseInputMessageItem::OrHash,
                OpenAI::Responses::ResponseOutputMessage::OrHash,
                OpenAI::Responses::ResponseFileSearchToolCall::OrHash,
                OpenAI::Responses::ResponseComputerToolCall::OrHash,
                OpenAI::Responses::ResponseComputerToolCallOutputItem::OrHash,
                OpenAI::Responses::ResponseFunctionWebSearch::OrHash,
                OpenAI::Responses::ResponseFunctionToolCallItem::OrHash,
                OpenAI::Responses::ResponseFunctionToolCallOutputItem::OrHash,
                OpenAI::Responses::ResponseToolSearchCall::OrHash,
                OpenAI::Responses::ResponseToolSearchOutputItem::OrHash,
                OpenAI::Responses::ResponseItem::AdditionalTools::OrHash,
                OpenAI::Responses::ResponseConfigurationUpdateItem::OrHash,
                OpenAI::Responses::ResponseReasoningItem::OrHash,
                OpenAI::Responses::ResponseItem::Program::OrHash,
                OpenAI::Responses::ResponseItem::ProgramOutput::OrHash,
                OpenAI::Responses::ResponseCompactionItem::OrHash,
                OpenAI::Responses::ResponseItem::ImageGenerationCall::OrHash,
                OpenAI::Responses::ResponseCodeInterpreterToolCall::OrHash,
                OpenAI::Responses::ResponseItem::LocalShellCall::OrHash,
                OpenAI::Responses::ResponseItem::LocalShellCallOutput::OrHash,
                OpenAI::Responses::ResponseFunctionShellToolCall::OrHash,
                OpenAI::Responses::ResponseFunctionShellToolCallOutput::OrHash,
                OpenAI::Responses::ResponseApplyPatchToolCall::OrHash,
                OpenAI::Responses::ResponseApplyPatchToolCallOutput::OrHash,
                OpenAI::Responses::ResponseItem::McpListTools::OrHash,
                OpenAI::Responses::ResponseItem::McpApprovalRequest::OrHash,
                OpenAI::Responses::ResponseItem::McpApprovalResponse::OrHash,
                OpenAI::Responses::ResponseItem::McpCall::OrHash,
                OpenAI::Responses::ResponseCustomToolCallItem::OrHash,
                OpenAI::Responses::ResponseCustomToolCallOutputItem::OrHash
              )
            ],

            usage: OpenAI::Responses::ResponseUsage::OrHash,

            object: Symbol
          )
            .returns(T.attached_class)
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
              output: T::Array[OpenAI::Responses::ResponseItem::Variants],
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
