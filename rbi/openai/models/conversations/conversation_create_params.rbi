# typed: strong

module OpenAI
  module Models
    module Conversations
      class ConversationCreateParams < OpenAI::Internal::Type::BaseModel
        extend OpenAI::Internal::Type::RequestParameters::Converter
        include OpenAI::Internal::Type::RequestParameters

        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::ConversationCreateParams,
              OpenAI::Internal::AnyHash
            )
          end

        # Initial items to include in the conversation context. You may add up to 20 items
        # at a time.
        sig do
          returns(
            T.nilable(
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
                  OpenAI::Responses::ResponseInputItem::ImageGenerationCall,
                  OpenAI::Responses::ResponseCodeInterpreterToolCall,
                  OpenAI::Responses::ResponseInputItem::LocalShellCall,
                  OpenAI::Responses::ResponseInputItem::LocalShellCallOutput,
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
          )
        end
        attr_accessor :items

        # Set of 16 key-value pairs that can be attached to an object. Useful for storing
        # additional information about the object in a structured format.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :metadata

        sig do
          params(
            items:
              T.nilable(
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
                    OpenAI::Responses::ResponseInputItem::ImageGenerationCall::OrHash,
                    OpenAI::Responses::ResponseCodeInterpreterToolCall::OrHash,
                    OpenAI::Responses::ResponseInputItem::LocalShellCall::OrHash,
                    OpenAI::Responses::ResponseInputItem::LocalShellCallOutput::OrHash,
                    OpenAI::Responses::ResponseInputItem::McpListTools::OrHash,
                    OpenAI::Responses::ResponseInputItem::McpApprovalRequest::OrHash,
                    OpenAI::Responses::ResponseInputItem::McpApprovalResponse::OrHash,
                    OpenAI::Responses::ResponseInputItem::McpCall::OrHash,
                    OpenAI::Responses::ResponseCustomToolCallOutput::OrHash,
                    OpenAI::Responses::ResponseCustomToolCall::OrHash,
                    OpenAI::Responses::ResponseInputItem::ItemReference::OrHash
                  )
                ]
              ),
            metadata: T.nilable(T::Hash[Symbol, String]),
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(T.attached_class)
        end
        def self.new(
          # Initial items to include in the conversation context. You may add up to 20 items
          # at a time.
          items: nil,
          # Set of 16 key-value pairs that can be attached to an object. Useful for storing
          # additional information about the object in a structured format.
          metadata: nil,
          request_options: {}
        )
        end

        sig do
          override.returns(
            {
              items:
                T.nilable(
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
                      OpenAI::Responses::ResponseInputItem::ImageGenerationCall,
                      OpenAI::Responses::ResponseCodeInterpreterToolCall,
                      OpenAI::Responses::ResponseInputItem::LocalShellCall,
                      OpenAI::Responses::ResponseInputItem::LocalShellCallOutput,
                      OpenAI::Responses::ResponseInputItem::McpListTools,
                      OpenAI::Responses::ResponseInputItem::McpApprovalRequest,
                      OpenAI::Responses::ResponseInputItem::McpApprovalResponse,
                      OpenAI::Responses::ResponseInputItem::McpCall,
                      OpenAI::Responses::ResponseCustomToolCallOutput,
                      OpenAI::Responses::ResponseCustomToolCall,
                      OpenAI::Responses::ResponseInputItem::ItemReference
                    )
                  ]
                ),
              metadata: T.nilable(T::Hash[Symbol, String]),
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
