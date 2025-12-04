# typed: strong

module OpenAI
  module Models
    module Conversations
      class ItemCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::ItemCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

        # The items to add to the conversation. You may add up to 20 items at a time.
        sig do
          returns(
            T::Array[
              T.any(
                OpenAI::Responses::EasyInputMessage,
                OpenAI::Responses::ResponseInputItem::Message,
                OpenAI::Responses::ResponseOutputMessage,
                OpenAI::Responses::ResponseFileSearchToolCall,
                OpenAI::Responses::ResponseComputerToolCall,
                OpenAI::Responses::ResponseInputItem::ComputerCallOutput,
                OpenAI::Responses::ResponseFunctionWebSearch,
                OpenAI::Responses::ResponseFunctionToolCall,
                OpenAI::Responses::ResponseInputItem::FunctionCallOutput,
                OpenAI::Responses::ResponseReasoningItem,
                OpenAI::Responses::ResponseCompactionItemParam,
                OpenAI::Responses::ResponseInputItem::ImageGenerationCall,
                OpenAI::Responses::ResponseCodeInterpreterToolCall,
                OpenAI::Responses::ResponseInputItem::LocalShellCall,
                OpenAI::Responses::ResponseInputItem::LocalShellCallOutput,
                OpenAI::Responses::ResponseInputItem::ShellCall,
                OpenAI::Responses::ResponseInputItem::ShellCallOutput,
                OpenAI::Responses::ResponseInputItem::ApplyPatchCall,
                OpenAI::Responses::ResponseInputItem::ApplyPatchCallOutput,
                OpenAI::Responses::ResponseInputItem::McpListTools,
                OpenAI::Responses::ResponseInputItem::McpApprovalRequest,
                OpenAI::Responses::ResponseInputItem::McpApprovalResponse,
                OpenAI::Responses::ResponseInputItem::McpCall,
                OpenAI::Responses::ResponseCustomToolCallOutput,
                OpenAI::Responses::ResponseCustomToolCall,
                OpenAI::Responses::ResponseInputItem::ItemReference
              )
            ]
          )
        end
        attr_accessor :items

        # Additional fields to include in the response. See the `include` parameter for
        # [listing Conversation items above](https://platform.openai.com/docs/api-reference/conversations/list-items#conversations_list_items-include)
        # for more information.
        sig do
          returns(
            T.nilable(T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol])
          )
        end
        attr_reader :include

        sig do
          params(
            include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol]
          ).void
        end
        attr_writer :include

        sig do
          params(
            items:
              T::Array[
                T.any(
                  OpenAI::Responses::EasyInputMessage::OrHash,
                  OpenAI::Responses::ResponseInputItem::Message::OrHash,
                  OpenAI::Responses::ResponseOutputMessage::OrHash,
                  OpenAI::Responses::ResponseFileSearchToolCall::OrHash,
                  OpenAI::Responses::ResponseComputerToolCall::OrHash,
                  OpenAI::Responses::ResponseInputItem::ComputerCallOutput::OrHash,
                  OpenAI::Responses::ResponseFunctionWebSearch::OrHash,
                  OpenAI::Responses::ResponseFunctionToolCall::OrHash,
                  OpenAI::Responses::ResponseInputItem::FunctionCallOutput::OrHash,
                  OpenAI::Responses::ResponseReasoningItem::OrHash,
                  OpenAI::Responses::ResponseCompactionItemParam::OrHash,
                  OpenAI::Responses::ResponseInputItem::ImageGenerationCall::OrHash,
                  OpenAI::Responses::ResponseCodeInterpreterToolCall::OrHash,
                  OpenAI::Responses::ResponseInputItem::LocalShellCall::OrHash,
                  OpenAI::Responses::ResponseInputItem::LocalShellCallOutput::OrHash,
                  OpenAI::Responses::ResponseInputItem::ShellCall::OrHash,
                  OpenAI::Responses::ResponseInputItem::ShellCallOutput::OrHash,
                  OpenAI::Responses::ResponseInputItem::ApplyPatchCall::OrHash,
                  OpenAI::Responses::ResponseInputItem::ApplyPatchCallOutput::OrHash,
                  OpenAI::Responses::ResponseInputItem::McpListTools::OrHash,
                  OpenAI::Responses::ResponseInputItem::McpApprovalRequest::OrHash,
                  OpenAI::Responses::ResponseInputItem::McpApprovalResponse::OrHash,
                  OpenAI::Responses::ResponseInputItem::McpCall::OrHash,
                  OpenAI::Responses::ResponseCustomToolCallOutput::OrHash,
                  OpenAI::Responses::ResponseCustomToolCall::OrHash,
                  OpenAI::Responses::ResponseInputItem::ItemReference::OrHash
                )
              ],
            include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # The items to add to the conversation. You may add up to 20 items at a time.
          items:,
          # Additional fields to include in the response. See the `include` parameter for
          # [listing Conversation items above](https://platform.openai.com/docs/api-reference/conversations/list-items#conversations_list_items-include)
          # for more information.
          include: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              items:
                T::Array[
                  T.any(
                    OpenAI::Responses::EasyInputMessage,
                    OpenAI::Responses::ResponseInputItem::Message,
                    OpenAI::Responses::ResponseOutputMessage,
                    OpenAI::Responses::ResponseFileSearchToolCall,
                    OpenAI::Responses::ResponseComputerToolCall,
                    OpenAI::Responses::ResponseInputItem::ComputerCallOutput,
                    OpenAI::Responses::ResponseFunctionWebSearch,
                    OpenAI::Responses::ResponseFunctionToolCall,
                    OpenAI::Responses::ResponseInputItem::FunctionCallOutput,
                    OpenAI::Responses::ResponseReasoningItem,
                    OpenAI::Responses::ResponseCompactionItemParam,
                    OpenAI::Responses::ResponseInputItem::ImageGenerationCall,
                    OpenAI::Responses::ResponseCodeInterpreterToolCall,
                    OpenAI::Responses::ResponseInputItem::LocalShellCall,
                    OpenAI::Responses::ResponseInputItem::LocalShellCallOutput,
                    OpenAI::Responses::ResponseInputItem::ShellCall,
                    OpenAI::Responses::ResponseInputItem::ShellCallOutput,
                    OpenAI::Responses::ResponseInputItem::ApplyPatchCall,
                    OpenAI::Responses::ResponseInputItem::ApplyPatchCallOutput,
                    OpenAI::Responses::ResponseInputItem::McpListTools,
                    OpenAI::Responses::ResponseInputItem::McpApprovalRequest,
                    OpenAI::Responses::ResponseInputItem::McpApprovalResponse,
                    OpenAI::Responses::ResponseInputItem::McpCall,
                    OpenAI::Responses::ResponseCustomToolCallOutput,
                    OpenAI::Responses::ResponseCustomToolCall,
                    OpenAI::Responses::ResponseInputItem::ItemReference
                  )
                ],
              include:
                T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
              request_options: OpenAI::RequestOptions
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
