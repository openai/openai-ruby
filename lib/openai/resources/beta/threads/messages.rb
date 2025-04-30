# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Threads
        class Messages
          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::Threads::MessageCreateParams} for more details.
          #
          # Create a message.
          #
          # @overload create(thread_id, content:, role:, attachments: nil, metadata: nil, request_options: {})
          #
          # @param thread_id [String] The ID of the [thread](https://platform.openai.com/docs/api-reference/threads) t
          # ...
          #
          # @param content [String, Array<OpenAI::Models::Beta::Threads::ImageFileContentBlock, OpenAI::Models::Beta::Threads::ImageURLContentBlock, OpenAI::Models::Beta::Threads::TextContentBlockParam>] The text contents of the message.
          #
          # @param role [Symbol, OpenAI::Models::Beta::Threads::MessageCreateParams::Role] The role of the entity that is creating the message. Allowed values include: ...
          #
          # @param attachments [Array<OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment>, nil] A list of files attached to the message, and the tools they should be added to.
          #
          # @param metadata [Hash{Symbol=>String}, nil] Set of 16 key-value pairs that can be attached to an object. This can be ...
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Threads::Message]
          #
          # @see OpenAI::Models::Beta::Threads::MessageCreateParams
          def create(thread_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::MessageCreateParams.dump_request(params)
            @client.request(
              method: :post,
              path: ["threads/%1$s/messages", thread_id],
              body: parsed,
              model: OpenAI::Models::Beta::Threads::Message,
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::Threads::MessageRetrieveParams} for more details.
          #
          # Retrieve a message.
          #
          # @overload retrieve(message_id, thread_id:, request_options: {})
          #
          # @param message_id [String] The ID of the message to retrieve.
          #
          # @param thread_id [String] The ID of the [thread](https://platform.openai.com/docs/api-reference/threads) t
          # ...
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Threads::Message]
          #
          # @see OpenAI::Models::Beta::Threads::MessageRetrieveParams
          def retrieve(message_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::MessageRetrieveParams.dump_request(params)
            thread_id =
              parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :get,
              path: ["threads/%1$s/messages/%2$s", thread_id, message_id],
              model: OpenAI::Models::Beta::Threads::Message,
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::Threads::MessageUpdateParams} for more details.
          #
          # Modifies a message.
          #
          # @overload update(message_id, thread_id:, metadata: nil, request_options: {})
          #
          # @param message_id [String] Path param: The ID of the message to modify.
          #
          # @param thread_id [String] Path param: The ID of the thread to which this message belongs.
          #
          # @param metadata [Hash{Symbol=>String}, nil] Body param: Set of 16 key-value pairs that can be attached to an object. This ca
          # ...
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Threads::Message]
          #
          # @see OpenAI::Models::Beta::Threads::MessageUpdateParams
          def update(message_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::MessageUpdateParams.dump_request(params)
            thread_id =
              parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :post,
              path: ["threads/%1$s/messages/%2$s", thread_id, message_id],
              body: parsed,
              model: OpenAI::Models::Beta::Threads::Message,
              options: options
            )
          end

          # Some parameter documentations has been truncated, see
          # {OpenAI::Models::Beta::Threads::MessageListParams} for more details.
          #
          # Returns a list of messages for a given thread.
          #
          # @overload list(thread_id, after: nil, before: nil, limit: nil, order: nil, run_id: nil, request_options: {})
          #
          # @param thread_id [String] The ID of the [thread](https://platform.openai.com/docs/api-reference/threads) t
          # ...
          #
          # @param after [String] A cursor for use in pagination. `after` is an object ID that defines your place
          # ...
          #
          # @param before [String] A cursor for use in pagination. `before` is an object ID that defines your place
          # ...
          #
          # @param limit [Integer] A limit on the number of objects to be returned. Limit can range between 1 and 1
          # ...
          #
          # @param order [Symbol, OpenAI::Models::Beta::Threads::MessageListParams::Order] Sort order by the `created_at` timestamp of the objects. `asc` for ascending ord
          # ...
          #
          # @param run_id [String] Filter messages by the run ID that generated them. ...
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Internal::CursorPage<OpenAI::Models::Beta::Threads::Message>]
          #
          # @see OpenAI::Models::Beta::Threads::MessageListParams
          def list(thread_id, params = {})
            parsed, options = OpenAI::Models::Beta::Threads::MessageListParams.dump_request(params)
            @client.request(
              method: :get,
              path: ["threads/%1$s/messages", thread_id],
              query: parsed,
              page: OpenAI::Internal::CursorPage,
              model: OpenAI::Models::Beta::Threads::Message,
              options: options
            )
          end

          # Deletes a message.
          #
          # @overload delete(message_id, thread_id:, request_options: {})
          #
          # @param message_id [String] The ID of the message to delete.
          #
          # @param thread_id [String] The ID of the thread to which this message belongs.
          #
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::Models::Beta::Threads::MessageDeleted]
          #
          # @see OpenAI::Models::Beta::Threads::MessageDeleteParams
          def delete(message_id, params)
            parsed, options = OpenAI::Models::Beta::Threads::MessageDeleteParams.dump_request(params)
            thread_id =
              parsed.delete(:thread_id) do
                raise ArgumentError.new("missing required path argument #{_1}")
              end
            @client.request(
              method: :delete,
              path: ["threads/%1$s/messages/%2$s", thread_id, message_id],
              model: OpenAI::Models::Beta::Threads::MessageDeleted,
              options: options
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
