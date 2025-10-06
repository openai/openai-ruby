# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class ChatKit
        class Threads
          # Retrieve a ChatKit thread
          #
          # @overload retrieve(thread_id, request_options: {})
          #
          # @param thread_id [String] Identifier of the ChatKit thread to retrieve.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::ChatKit::ChatKitThread]
          #
          # @see OpenAI::Models::Beta::ChatKit::ThreadRetrieveParams
          def retrieve(thread_id, params = {})
            @client.request(
              method: :get,
              path: ["chatkit/threads/%1$s", thread_id],
              model: OpenAI::Beta::ChatKit::ChatKitThread,
              options: {extra_headers: {"OpenAI-Beta" => "chatkit_beta=v1"}, **params[:request_options].to_h}
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::ChatKit::ThreadListParams} for more details.
          #
          # List ChatKit threads
          #
          # @overload list(after: nil, before: nil, limit: nil, order: nil, user: nil, request_options: {})
          #
          # @param after [String] List items created after this thread item ID. Defaults to null for the first pag
          #
          # @param before [String] List items created before this thread item ID. Defaults to null for the newest r
          #
          # @param limit [Integer] Maximum number of thread items to return. Defaults to 20.
          #
          # @param order [Symbol, OpenAI::Models::Beta::ChatKit::ThreadListParams::Order] Sort order for results by creation time. Defaults to `desc`.
          #
          # @param user [String] Filter threads that belong to this user identifier. Defaults to null to return a
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Beta::ChatKit::ChatKitThread>]
          #
          # @see OpenAI::Models::Beta::ChatKit::ThreadListParams
          def list(params = {})
            parsed, options = OpenAI::Beta::ChatKit::ThreadListParams.dump_request(params)
            @client.request(
              method: :get,
              path: "chatkit/threads",
              query: parsed,
              page: OpenAI::Internal::ConversationCursorPage,
              model: OpenAI::Beta::ChatKit::ChatKitThread,
              options: {extra_headers: {"OpenAI-Beta" => "chatkit_beta=v1"}, **options}
            )
          end

          # Delete a ChatKit thread
          #
          # @overload delete(thread_id, request_options: {})
          #
          # @param thread_id [String] Identifier of the ChatKit thread to delete.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::ChatKit::ThreadDeleteResponse]
          #
          # @see OpenAI::Models::Beta::ChatKit::ThreadDeleteParams
          def delete(thread_id, params = {})
            @client.request(
              method: :delete,
              path: ["chatkit/threads/%1$s", thread_id],
              model: OpenAI::Models::Beta::ChatKit::ThreadDeleteResponse,
              options: {extra_headers: {"OpenAI-Beta" => "chatkit_beta=v1"}, **params[:request_options].to_h}
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::ChatKit::ThreadListItemsParams} for more details.
          #
          # List ChatKit thread items
          #
          # @overload list_items(thread_id, after: nil, before: nil, limit: nil, order: nil, request_options: {})
          #
          # @param thread_id [String] Identifier of the ChatKit thread whose items are requested.
          #
          # @param after [String] List items created after this thread item ID. Defaults to null for the first pag
          #
          # @param before [String] List items created before this thread item ID. Defaults to null for the newest r
          #
          # @param limit [Integer] Maximum number of thread items to return. Defaults to 20.
          #
          # @param order [Symbol, OpenAI::Models::Beta::ChatKit::ThreadListItemsParams::Order] Sort order for results by creation time. Defaults to `desc`.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::ConversationCursorPage<OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem, OpenAI::Models::Beta::ChatKit::ChatKitThreadAssistantMessageItem, OpenAI::Models::Beta::ChatKit::ChatKitWidgetItem, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup>]
          #
          # @see OpenAI::Models::Beta::ChatKit::ThreadListItemsParams
          def list_items(thread_id, params = {})
            parsed, options = OpenAI::Beta::ChatKit::ThreadListItemsParams.dump_request(params)
            @client.request(
              method: :get,
              path: ["chatkit/threads/%1$s/items", thread_id],
              query: parsed,
              page: OpenAI::Internal::ConversationCursorPage,
              model: OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data,
              options: {extra_headers: {"OpenAI-Beta" => "chatkit_beta=v1"}, **options}
            )
          end

          # @api private
          #
          # @param client [OpenAI::Client]
          def initialize(client:)
            @client = client
          end
        end
      end
    end
  end
end
