# typed: strong

module OpenAI
  module Models
    ConversationItemList = Conversations::ConversationItemList

    module Conversations
      class ConversationItemList < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Conversations::ConversationItemList,
              OpenAI::Internal::AnyHash
            )
          end

        # A list of conversation items.
        sig do
          returns(T::Array[OpenAI::Conversations::ConversationItem::Variants])
        end
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

        # A list of Conversation items.
        sig do
          params(
            data:
              T::Array[
                T.any(
                  OpenAI::Conversations::Message::OrHash,
                  OpenAI::Responses::ResponseFunctionToolCallItem::OrHash,
                  OpenAI::Responses::ResponseFunctionToolCallOutputItem::OrHash,
                  OpenAI::Responses::ResponseFileSearchToolCall::OrHash,
                  OpenAI::Responses::ResponseFunctionWebSearch::OrHash,
                  OpenAI::Conversations::ConversationItem::ImageGenerationCall::OrHash,
                  OpenAI::Responses::ResponseComputerToolCall::OrHash,
                  OpenAI::Responses::ResponseComputerToolCallOutputItem::OrHash,
                  OpenAI::Responses::ResponseReasoningItem::OrHash,
                  OpenAI::Responses::ResponseCodeInterpreterToolCall::OrHash,
                  OpenAI::Conversations::ConversationItem::LocalShellCall::OrHash,
                  OpenAI::Conversations::ConversationItem::LocalShellCallOutput::OrHash,
                  OpenAI::Conversations::ConversationItem::McpListTools::OrHash,
                  OpenAI::Conversations::ConversationItem::McpApprovalRequest::OrHash,
                  OpenAI::Conversations::ConversationItem::McpApprovalResponse::OrHash,
                  OpenAI::Conversations::ConversationItem::McpCall::OrHash,
                  OpenAI::Responses::ResponseCustomToolCall::OrHash,
                  OpenAI::Responses::ResponseCustomToolCallOutput::OrHash
                )
              ],
            first_id: String,
            has_more: T::Boolean,
            last_id: String,
            object: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # A list of conversation items.
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
              data: T::Array[OpenAI::Conversations::ConversationItem::Variants],
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
