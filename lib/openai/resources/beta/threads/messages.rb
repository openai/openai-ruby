# frozen_string_literal: true

module OpenAI
  module Resources
    class Beta
      class Threads
        class Messages
          # Create a message.
          #
          # @overload create(thread_id, content:, role:, attachments: nil, metadata: nil, request_options: {})
          #
          # @param thread_id [String]
          # @param content [String, Array<OpenAI::Models::Beta::Threads::ImageFileContentBlock, OpenAI::Models::Beta::Threads::ImageURLContentBlock, OpenAI::Models::Beta::Threads::TextContentBlockParam>]
          # @param role [Symbol, OpenAI::Models::Beta::Threads::MessageCreateParams::Role]
          # @param attachments [Array<OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment>, nil]
          # @param metadata [Hash{Symbol=>String}, nil]
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

          # Retrieve a message.
          #
          # @overload retrieve(message_id, thread_id:, request_options: {})
          #
          # @param message_id [String]
          # @param thread_id [String]
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

          # Modifies a message.
          #
          # @overload update(message_id, thread_id:, metadata: nil, request_options: {})
          #
          # @param message_id [String]
          # @param thread_id [String]
          # @param metadata [Hash{Symbol=>String}, nil]
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

          # Returns a list of messages for a given thread.
          #
          # @overload list(thread_id, after: nil, before: nil, limit: nil, order: nil, run_id: nil, request_options: {})
          #
          # @param thread_id [String]
          # @param after [String]
          # @param before [String]
          # @param limit [Integer]
          # @param order [Symbol, OpenAI::Models::Beta::Threads::MessageListParams::Order]
          # @param run_id [String]
          # @param request_options [OpenAI::RequestOptions, Hash{Symbol=>Object}, nil]
          #
          # @return [OpenAI::CursorPage<OpenAI::Models::Beta::Threads::Message>]
          #
          # @see OpenAI::Models::Beta::Threads::MessageListParams
          def list(thread_id, params = {})
            parsed, options = OpenAI::Models::Beta::Threads::MessageListParams.dump_request(params)
            @client.request(
              method: :get,
              path: ["threads/%1$s/messages", thread_id],
              query: parsed,
              page: OpenAI::CursorPage,
              model: OpenAI::Models::Beta::Threads::Message,
              options: options
            )
          end

          # Deletes a message.
          #
          # @overload delete(message_id, thread_id:, request_options: {})
          #
          # @param message_id [String]
          # @param thread_id [String]
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
