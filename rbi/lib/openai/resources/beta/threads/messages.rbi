# typed: strong

module OpenAI
  module Resources
    class Beta
      class Threads
        class Messages
          # Create a message.
          sig do
            params(
              thread_id: String,
              content: T.any(
                String,
                T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                  OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                  OpenAI::Models::Beta::Threads::TextContentBlockParam
                )
                ]
              ),
              role: Symbol,
              attachments: T.nilable(T::Array[OpenAI::Models::Beta::Threads::MessageCreateParams::Attachment]),
              metadata: T.nilable(OpenAI::Models::Metadata),
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::Models::Beta::Threads::Message)
          end
          def create(thread_id, content:, role:, attachments: nil, metadata: nil, request_options: {})
          end

          # Retrieve a message.
          sig do
            params(
              message_id: String,
              thread_id: String,
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::Models::Beta::Threads::Message)
          end
          def retrieve(message_id, thread_id:, request_options: {})
          end

          # Modifies a message.
          sig do
            params(
              message_id: String,
              thread_id: String,
              metadata: T.nilable(OpenAI::Models::Metadata),
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::Models::Beta::Threads::Message)
          end
          def update(message_id, thread_id:, metadata: nil, request_options: {})
          end

          # Returns a list of messages for a given thread.
          sig do
            params(
              thread_id: String,
              after: String,
              before: String,
              limit: Integer,
              order: Symbol,
              run_id: String,
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::CursorPage[OpenAI::Models::Beta::Threads::Message])
          end
          def list(
            thread_id,
            after: nil,
            before: nil,
            limit: nil,
            order: nil,
            run_id: nil,
            request_options: {}
          )
          end

          # Deletes a message.
          sig do
            params(
              message_id: String,
              thread_id: String,
              request_options: T.nilable(T.any(OpenAI::RequestOptions, T::Hash[Symbol, T.anything]))
            )
              .returns(OpenAI::Models::Beta::Threads::MessageDeleted)
          end
          def delete(message_id, thread_id:, request_options: {})
          end

          sig { params(client: OpenAI::Client).returns(T.attached_class) }
          def self.new(client:)
          end
        end
      end
    end
  end
end
