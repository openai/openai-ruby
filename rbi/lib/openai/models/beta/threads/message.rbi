# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class Message < OpenAI::BaseModel
          # The identifier, which can be referenced in API endpoints.
          sig { returns(String) }
          def id
          end

          sig { params(_: String).returns(String) }
          def id=(_)
          end

          # If applicable, the ID of the
          #   [assistant](https://platform.openai.com/docs/api-reference/assistants) that
          #   authored this message.
          sig { returns(T.nilable(String)) }
          def assistant_id
          end

          sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
          def assistant_id=(_)
          end

          # A list of files attached to the message, and the tools they were added to.
          sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::Threads::Message::Attachment])) }
          def attachments
          end

          sig do
            params(_: T.nilable(T::Array[OpenAI::Models::Beta::Threads::Message::Attachment]))
              .returns(T.nilable(T::Array[OpenAI::Models::Beta::Threads::Message::Attachment]))
          end
          def attachments=(_)
          end

          # The Unix timestamp (in seconds) for when the message was completed.
          sig { returns(T.nilable(Integer)) }
          def completed_at
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def completed_at=(_)
          end

          # The content of the message in array of text and/or images.
          sig do
            returns(
              T::Array[
              T.any(
                OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                OpenAI::Models::Beta::Threads::TextContentBlock,
                OpenAI::Models::Beta::Threads::RefusalContentBlock
              )
              ]
            )
          end
          def content
          end

          sig do
            params(
              _: T::Array[
              T.any(
                OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                OpenAI::Models::Beta::Threads::TextContentBlock,
                OpenAI::Models::Beta::Threads::RefusalContentBlock
              )
              ]
            )
              .returns(
                T::Array[
                T.any(
                  OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                  OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                  OpenAI::Models::Beta::Threads::TextContentBlock,
                  OpenAI::Models::Beta::Threads::RefusalContentBlock
                )
                ]
              )
          end
          def content=(_)
          end

          # The Unix timestamp (in seconds) for when the message was created.
          sig { returns(Integer) }
          def created_at
          end

          sig { params(_: Integer).returns(Integer) }
          def created_at=(_)
          end

          # The Unix timestamp (in seconds) for when the message was marked as incomplete.
          sig { returns(T.nilable(Integer)) }
          def incomplete_at
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def incomplete_at=(_)
          end

          # On an incomplete message, details about why the message is incomplete.
          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Message::IncompleteDetails)) }
          def incomplete_details
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::Threads::Message::IncompleteDetails))
              .returns(T.nilable(OpenAI::Models::Beta::Threads::Message::IncompleteDetails))
          end
          def incomplete_details=(_)
          end

          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          sig { returns(T.nilable(OpenAI::Models::Metadata)) }
          def metadata
          end

          sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
          def metadata=(_)
          end

          # The object type, which is always `thread.message`.
          sig { returns(Symbol) }
          def object
          end

          sig { params(_: Symbol).returns(Symbol) }
          def object=(_)
          end

          # The entity that produced the message. One of `user` or `assistant`.
          sig { returns(Symbol) }
          def role
          end

          sig { params(_: Symbol).returns(Symbol) }
          def role=(_)
          end

          # The ID of the [run](https://platform.openai.com/docs/api-reference/runs)
          #   associated with the creation of this message. Value is `null` when messages are
          #   created manually using the create message or create thread endpoints.
          sig { returns(T.nilable(String)) }
          def run_id
          end

          sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
          def run_id=(_)
          end

          # The status of the message, which can be either `in_progress`, `incomplete`, or
          #   `completed`.
          sig { returns(Symbol) }
          def status
          end

          sig { params(_: Symbol).returns(Symbol) }
          def status=(_)
          end

          # The [thread](https://platform.openai.com/docs/api-reference/threads) ID that
          #   this message belongs to.
          sig { returns(String) }
          def thread_id
          end

          sig { params(_: String).returns(String) }
          def thread_id=(_)
          end

          # Represents a message within a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          sig do
            params(
              id: String,
              assistant_id: T.nilable(String),
              attachments: T.nilable(T::Array[OpenAI::Models::Beta::Threads::Message::Attachment]),
              completed_at: T.nilable(Integer),
              content: T::Array[
              T.any(
                OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                OpenAI::Models::Beta::Threads::TextContentBlock,
                OpenAI::Models::Beta::Threads::RefusalContentBlock
              )
              ],
              created_at: Integer,
              incomplete_at: T.nilable(Integer),
              incomplete_details: T.nilable(OpenAI::Models::Beta::Threads::Message::IncompleteDetails),
              metadata: T.nilable(OpenAI::Models::Metadata),
              role: Symbol,
              run_id: T.nilable(String),
              status: Symbol,
              thread_id: String,
              object: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(
            id:,
            assistant_id:,
            attachments:,
            completed_at:,
            content:,
            created_at:,
            incomplete_at:,
            incomplete_details:,
            metadata:,
            role:,
            run_id:,
            status:,
            thread_id:,
            object: :"thread.message"
          )
          end

          sig do
            override
              .returns(
                {
                  id: String,
                  assistant_id: T.nilable(String),
                  attachments: T.nilable(T::Array[OpenAI::Models::Beta::Threads::Message::Attachment]),
                  completed_at: T.nilable(Integer),
                  content: T::Array[
                  T.any(
                    OpenAI::Models::Beta::Threads::ImageFileContentBlock,
                    OpenAI::Models::Beta::Threads::ImageURLContentBlock,
                    OpenAI::Models::Beta::Threads::TextContentBlock,
                    OpenAI::Models::Beta::Threads::RefusalContentBlock
                  )
                  ],
                  created_at: Integer,
                  incomplete_at: T.nilable(Integer),
                  incomplete_details: T.nilable(OpenAI::Models::Beta::Threads::Message::IncompleteDetails),
                  metadata: T.nilable(OpenAI::Models::Metadata),
                  object: Symbol,
                  role: Symbol,
                  run_id: T.nilable(String),
                  status: Symbol,
                  thread_id: String
                }
              )
          end
          def to_hash
          end

          class Attachment < OpenAI::BaseModel
            # The ID of the file to attach to the message.
            sig { returns(T.nilable(String)) }
            def file_id
            end

            sig { params(_: String).returns(String) }
            def file_id=(_)
            end

            # The tools to add this file to.
            sig do
              returns(
                T.nilable(
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::CodeInterpreterTool,
                    OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly
                  )
                  ]
                )
              )
            end
            def tools
            end

            sig do
              params(
                _: T::Array[
                T.any(
                  OpenAI::Models::Beta::CodeInterpreterTool,
                  OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly
                )
                ]
              )
                .returns(
                  T::Array[
                  T.any(
                    OpenAI::Models::Beta::CodeInterpreterTool,
                    OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly
                  )
                  ]
                )
            end
            def tools=(_)
            end

            sig do
              params(
                file_id: String,
                tools: T::Array[
                T.any(
                  OpenAI::Models::Beta::CodeInterpreterTool,
                  OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly
                )
                ]
              )
                .returns(T.attached_class)
            end
            def self.new(file_id: nil, tools: nil)
            end

            sig do
              override
                .returns(
                  {
                    file_id: String,
                    tools: T::Array[
                    T.any(
                      OpenAI::Models::Beta::CodeInterpreterTool,
                      OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly
                    )
                    ]
                  }
                )
            end
            def to_hash
            end

            class Tool < OpenAI::Union
              abstract!

              class AssistantToolsFileSearchTypeOnly < OpenAI::BaseModel
                # The type of tool being defined: `file_search`
                sig { returns(Symbol) }
                def type
                end

                sig { params(_: Symbol).returns(Symbol) }
                def type=(_)
                end

                sig { params(type: Symbol).returns(T.attached_class) }
                def self.new(type: :file_search)
                end

                sig { override.returns({type: Symbol}) }
                def to_hash
                end
              end

              class << self
                # @api private
                sig do
                  override
                    .returns(
                      [[NilClass, OpenAI::Models::Beta::CodeInterpreterTool], [NilClass, OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly]]
                    )
                end
                private def variants
                end
              end
            end
          end

          class IncompleteDetails < OpenAI::BaseModel
            # The reason the message is incomplete.
            sig { returns(Symbol) }
            def reason
            end

            sig { params(_: Symbol).returns(Symbol) }
            def reason=(_)
            end

            # On an incomplete message, details about why the message is incomplete.
            sig { params(reason: Symbol).returns(T.attached_class) }
            def self.new(reason:)
            end

            sig { override.returns({reason: Symbol}) }
            def to_hash
            end

            # The reason the message is incomplete.
            class Reason < OpenAI::Enum
              abstract!

              CONTENT_FILTER = :content_filter
              MAX_TOKENS = :max_tokens
              RUN_CANCELLED = :run_cancelled
              RUN_EXPIRED = :run_expired
              RUN_FAILED = :run_failed

              class << self
                sig { override.returns(T::Array[Symbol]) }
                def values
                end
              end
            end
          end

          # The entity that produced the message. One of `user` or `assistant`.
          class Role < OpenAI::Enum
            abstract!

            USER = :user
            ASSISTANT = :assistant

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end

          # The status of the message, which can be either `in_progress`, `incomplete`, or
          #   `completed`.
          class Status < OpenAI::Enum
            abstract!

            IN_PROGRESS = :in_progress
            INCOMPLETE = :incomplete
            COMPLETED = :completed

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end
        end
      end
    end
  end
end
