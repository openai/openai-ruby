# typed: strong

module OpenAI
  module Resources
    class Conversations
      sig { returns(OpenAI::Resources::Conversations::Items) }
      attr_reader :items

      # Create a conversation.
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
              ]
            ),
          metadata: T.nilable(T::Hash[Symbol, String]),
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Conversations::Conversation)
      end
      def create(
        # Initial items to include in the conversation context. You may add up to 20 items
        # at a time.
        items: nil,
        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        metadata: nil,
        request_options: {}
      )
      end

      # Get a conversation
      sig do
        params(
          conversation_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Conversations::Conversation)
      end
      def retrieve(
        # The ID of the conversation to retrieve.
        conversation_id,
        request_options: {}
      )
      end

      # Update a conversation
      sig do
        params(
          conversation_id: String,
          metadata: T.nilable(T::Hash[Symbol, String]),
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Conversations::Conversation)
      end
      def update(
        # The ID of the conversation to update.
        conversation_id,
        # Set of 16 key-value pairs that can be attached to an object. This can be useful
        # for storing additional information about the object in a structured format, and
        # querying for objects via API or the dashboard.
        #
        # Keys are strings with a maximum length of 64 characters. Values are strings with
        # a maximum length of 512 characters.
        metadata:,
        request_options: {}
      )
      end

      # Delete a conversation. Items in the conversation will not be deleted.
      sig do
        params(
          conversation_id: String,
          request_options: OpenAI::RequestOptions::OrHash
        ).returns(OpenAI::Conversations::ConversationDeletedResource)
      end
      def delete(
        # The ID of the conversation to delete.
        conversation_id,
        request_options: {}
      )
      end

      # @api private
      sig { params(client: OpenAI::Client).returns(T.attached_class) }
      def self.new(client:)
      end
    end
  end
end
