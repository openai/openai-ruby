# typed: strong

module OpenAI
  module Resources
    class Conversations
      class Items
        # Create items in a conversation with the given ID.
        sig do
          params(
            conversation_id: String,
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
          ).returns(OpenAI::Conversations::ConversationItemList)
        end
        def create(
          # Path param: The ID of the conversation to add the item to.
          conversation_id,
          # Body param: The items to add to the conversation. You may add up to 20 items at
          # a time.
          items:,
          # Query param: Additional fields to include in the response. See the `include`
          # parameter for
          # [listing Conversation items above](https://platform.openai.com/docs/api-reference/conversations/list-items#conversations_list_items-include)
          # for more information.
          include: nil,
          request_options: {}
        )
        end

        # Get a single item from a conversation with the given IDs.
        sig do
          params(
            item_id: String,
            conversation_id: String,
            include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Conversations::ConversationItem::Variants)
        end
        def retrieve(
          # Path param: The ID of the item to retrieve.
          item_id,
          # Path param: The ID of the conversation that contains the item.
          conversation_id:,
          # Query param: Additional fields to include in the response. See the `include`
          # parameter for
          # [listing Conversation items above](https://platform.openai.com/docs/api-reference/conversations/list-items#conversations_list_items-include)
          # for more information.
          include: nil,
          request_options: {}
        )
        end

        # List all items for a conversation with the given ID.
        sig do
          params(
            conversation_id: String,
            after: String,
            include: T::Array[OpenAI::Responses::ResponseIncludable::OrSymbol],
            limit: Integer,
            order: OpenAI::Conversations::ItemListParams::Order::OrSymbol,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(
            OpenAI::Internal::ConversationCursorPage[
              OpenAI::Conversations::ConversationItem::Variants
            ]
          )
        end
        def list(
          # The ID of the conversation to list items for.
          conversation_id,
          # An item ID to list items after, used in pagination.
          after: nil,
          # Specify additional output data to include in the model response. Currently
          # supported values are:
          #
          # - `web_search_call.action.sources`: Include the sources of the web search tool
          #   call.
          # - `code_interpreter_call.outputs`: Includes the outputs of python code execution
          #   in code interpreter tool call items.
          # - `computer_call_output.output.image_url`: Include image urls from the computer
          #   call output.
          # - `file_search_call.results`: Include the search results of the file search tool
          #   call.
          # - `message.input_image.image_url`: Include image urls from the input message.
          # - `message.output_text.logprobs`: Include logprobs with assistant messages.
          # - `reasoning.encrypted_content`: Includes an encrypted version of reasoning
          #   tokens in reasoning item outputs. This enables reasoning items to be used in
          #   multi-turn conversations when using the Responses API statelessly (like when
          #   the `store` parameter is set to `false`, or when an organization is enrolled
          #   in the zero data retention program).
          include: nil,
          # A limit on the number of objects to be returned. Limit can range between 1 and
          # 100, and the default is 20.
          limit: nil,
          # The order to return the input items in. Default is `desc`.
          #
          # - `asc`: Return the input items in ascending order.
          # - `desc`: Return the input items in descending order.
          order: nil,
          request_options: {}
        )
        end

        # Delete an item from a conversation with the given IDs.
        sig do
          params(
            item_id: String,
            conversation_id: String,
            request_options: OpenAI::RequestOptions::OrHash
          ).returns(OpenAI::Conversations::Conversation)
        end
        def delete(
          # The ID of the item to delete.
          item_id,
          # The ID of the conversation that contains the item.
          conversation_id:,
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
end
