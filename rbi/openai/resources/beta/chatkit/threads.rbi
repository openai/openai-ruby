# typed: strong

module OpenAI
  module Resources
    class Beta
      class ChatKit
        class Threads
          # Retrieve a ChatKit thread
          sig do
            params(
              thread_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Beta::ChatKit::ChatKitThread)
          end
          def retrieve(
            # Identifier of the ChatKit thread to retrieve.
            thread_id,
            request_options: {}
          )
          end

          # List ChatKit threads
          sig do
            params(
              after: String,
              before: String,
              limit: Integer,
              order: OpenAI::Beta::ChatKit::ThreadListParams::Order::OrSymbol,
              user: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::ConversationCursorPage[
                OpenAI::Beta::ChatKit::ChatKitThread
              ]
            )
          end
          def list(
            # List items created after this thread item ID. Defaults to null for the first
            # page.
            after: nil,
            # List items created before this thread item ID. Defaults to null for the newest
            # results.
            before: nil,
            # Maximum number of thread items to return. Defaults to 20.
            limit: nil,
            # Sort order for results by creation time. Defaults to `desc`.
            order: nil,
            # Filter threads that belong to this user identifier. Defaults to null to return
            # all users.
            user: nil,
            request_options: {}
          )
          end

          # Delete a ChatKit thread
          sig do
            params(
              thread_id: String,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(OpenAI::Models::Beta::ChatKit::ThreadDeleteResponse)
          end
          def delete(
            # Identifier of the ChatKit thread to delete.
            thread_id,
            request_options: {}
          )
          end

          # List ChatKit thread items
          sig do
            params(
              thread_id: String,
              after: String,
              before: String,
              limit: Integer,
              order:
                OpenAI::Beta::ChatKit::ThreadListItemsParams::Order::OrSymbol,
              request_options: OpenAI::RequestOptions::OrHash
            ).returns(
              OpenAI::Internal::ConversationCursorPage[
                OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::Variants
              ]
            )
          end
          def list_items(
            # Identifier of the ChatKit thread whose items are requested.
            thread_id,
            # List items created after this thread item ID. Defaults to null for the first
            # page.
            after: nil,
            # List items created before this thread item ID. Defaults to null for the newest
            # results.
            before: nil,
            # Maximum number of thread items to return. Defaults to 20.
            limit: nil,
            # Sort order for results by creation time. Defaults to `desc`.
            order: nil,
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
end
