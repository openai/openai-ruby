# typed: strong

module OpenAI
  module Models
    module Beta
      module Responses
        class BetaResponseItemList < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::Responses::BetaResponseItemList,
                OpenAI::Internal::AnyHash
              )
            end

          # A list of items used to generate this response.
          sig { returns(T::Array[OpenAI::Beta::BetaResponseItem::Variants]) }
          attr_accessor :data

          # The ID of the first item in the list.
          sig { returns(String) }
          attr_accessor :first_id

          # Whether there are more items available.
          sig { returns(T::Boolean) }
          attr_accessor :has_more

          # The ID of the last item in the list.
          sig { returns(String) }
          attr_accessor :last_id

          # The type of object returned, must be `list`.
          sig { returns(Symbol) }
          attr_accessor :object

          # A list of Response items.
          sig do
            params(
              data:
                T::Array[
                  T.any(
                    OpenAI::Beta::BetaResponseInputMessageItem::OrHash,
                    OpenAI::Beta::BetaResponseOutputMessage::OrHash,
                    OpenAI::Beta::BetaResponseFileSearchToolCall::OrHash,
                    OpenAI::Beta::BetaResponseComputerToolCall::OrHash,
                    OpenAI::Beta::BetaResponseComputerToolCallOutputItem::OrHash,
                    OpenAI::Beta::BetaResponseFunctionWebSearch::OrHash,
                    OpenAI::Beta::BetaResponseFunctionToolCallItem::OrHash,
                    OpenAI::Beta::BetaResponseFunctionToolCallOutputItem::OrHash,
                    OpenAI::Beta::BetaResponseItem::AgentMessage::OrHash,
                    OpenAI::Beta::BetaResponseItem::MultiAgentCall::OrHash,
                    OpenAI::Beta::BetaResponseItem::MultiAgentCallOutput::OrHash,
                    OpenAI::Beta::BetaResponseToolSearchCall::OrHash,
                    OpenAI::Beta::BetaResponseToolSearchOutputItem::OrHash,
                    OpenAI::Beta::BetaResponseItem::AdditionalTools::OrHash,
                    OpenAI::Beta::BetaResponseReasoningItem::OrHash,
                    OpenAI::Beta::BetaResponseItem::Program::OrHash,
                    OpenAI::Beta::BetaResponseItem::ProgramOutput::OrHash,
                    OpenAI::Beta::BetaResponseCompactionItem::OrHash,
                    OpenAI::Beta::BetaResponseItem::ImageGenerationCall::OrHash,
                    OpenAI::Beta::BetaResponseCodeInterpreterToolCall::OrHash,
                    OpenAI::Beta::BetaResponseItem::LocalShellCall::OrHash,
                    OpenAI::Beta::BetaResponseItem::LocalShellCallOutput::OrHash,
                    OpenAI::Beta::BetaResponseFunctionShellToolCall::OrHash,
                    OpenAI::Beta::BetaResponseFunctionShellToolCallOutput::OrHash,
                    OpenAI::Beta::BetaResponseApplyPatchToolCall::OrHash,
                    OpenAI::Beta::BetaResponseApplyPatchToolCallOutput::OrHash,
                    OpenAI::Beta::BetaResponseItem::McpListTools::OrHash,
                    OpenAI::Beta::BetaResponseItem::McpApprovalRequest::OrHash,
                    OpenAI::Beta::BetaResponseItem::McpApprovalResponse::OrHash,
                    OpenAI::Beta::BetaResponseItem::McpCall::OrHash,
                    OpenAI::Beta::BetaResponseCustomToolCallItem::OrHash,
                    OpenAI::Beta::BetaResponseCustomToolCallOutputItem::OrHash
                  )
                ],
              first_id: String,
              has_more: T::Boolean,
              last_id: String,
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # A list of items used to generate this response.
            data:,
            # The ID of the first item in the list.
            first_id:,
            # Whether there are more items available.
            has_more:,
            # The ID of the last item in the list.
            last_id:,
            # The type of object returned, must be `list`.
            object: :list
          )
          end

          sig do
            override.returns(
              {
                data: T::Array[OpenAI::Beta::BetaResponseItem::Variants],
                first_id: String,
                has_more: T::Boolean,
                last_id: String,
                object: Symbol
              }
            )
          end
          def to_hash
          end
        end
      end
    end
  end
end
