# frozen_string_literal: true

module OpenAI
  module Resources
    class Conversations
      # @return [OpenAI::Resources::Conversations::Items]
      attr_reader :items

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::Conversations::ConversationCreateParams} for more details.
      #
      # Create a conversation.
      #
      # @overload create(items: nil, metadata: nil, request_options: {})
      #
      # @param items [Array<OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::ItemReference>, nil] Initial items to include in the conversation context.
      #
      # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. Useful for
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Conversations::Conversation]
      #
      # @see OpenAI::Models::Conversations::ConversationCreateParams
      def create(params = {})
        parsed, options = OpenAI::Conversations::ConversationCreateParams.dump_request(params)
        @client.request(
          method: :post,
          path: "conversations",
          body: parsed,
          model: OpenAI::Conversations::Conversation,
          options: options
        )
      end

      # Get a conversation with the given ID.
      #
      # @overload retrieve(conversation_id, request_options: {})
      #
      # @param conversation_id [String] The ID of the conversation to retrieve.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Conversations::Conversation]
      #
      # @see OpenAI::Models::Conversations::ConversationRetrieveParams
      def retrieve(conversation_id, params = {})
        @client.request(
          method: :get,
          path: ["conversations/%1$s", conversation_id],
          model: OpenAI::Conversations::Conversation,
          options: params[:request_options]
        )
      end

      # Some parameter documentations has been truncated, see
      # {OpenAI::Models::Conversations::ConversationUpdateParams} for more details.
      #
      # Update a conversation's metadata with the given ID.
      #
      # @overload update(conversation_id, metadata:, request_options: {})
      #
      # @param conversation_id [String] The ID of the conversation to update.
      #
      # @param metadata [Hash{Symbol=>String}] Set of 16 key-value pairs that can be attached to an object. This can be
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Conversations::Conversation]
      #
      # @see OpenAI::Models::Conversations::ConversationUpdateParams
      def update(conversation_id, params)
        parsed, options = OpenAI::Conversations::ConversationUpdateParams.dump_request(params)
        @client.request(
          method: :post,
          path: ["conversations/%1$s", conversation_id],
          body: parsed,
          model: OpenAI::Conversations::Conversation,
          options: options
        )
      end

      # Delete a conversation with the given ID.
      #
      # @overload delete(conversation_id, request_options: {})
      #
      # @param conversation_id [String] The ID of the conversation to delete.
      #
      # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
      #
      # @return [OpenAI::Models::Conversations::ConversationDeletedResource]
      #
      # @see OpenAI::Models::Conversations::ConversationDeleteParams
      def delete(conversation_id, params = {})
        @client.request(
          method: :delete,
          path: ["conversations/%1$s", conversation_id],
          model: OpenAI::Conversations::ConversationDeletedResource,
          options: params[:request_options]
        )
      end

      # @api private
      #
      # @param client [OpenAI::Client]
      def initialize(client:)
        @client = client
        @items = OpenAI::Resources::Conversations::Items.new(client: client)
      end
    end
  end
end
