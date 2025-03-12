# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class Message < OpenAI::BaseModel
          sig { returns(String) }
          def id
          end

          sig { params(_: String).returns(String) }
          def id=(_)
          end

          sig { returns(T.nilable(String)) }
          def assistant_id
          end

          sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
          def assistant_id=(_)
          end

          sig { returns(T.nilable(T::Array[OpenAI::Models::Beta::Threads::Message::Attachment])) }
          def attachments
          end

          sig do
            params(_: T.nilable(T::Array[OpenAI::Models::Beta::Threads::Message::Attachment]))
              .returns(T.nilable(T::Array[OpenAI::Models::Beta::Threads::Message::Attachment]))
          end
          def attachments=(_)
          end

          sig { returns(T.nilable(Integer)) }
          def completed_at
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def completed_at=(_)
          end

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

          sig { returns(Integer) }
          def created_at
          end

          sig { params(_: Integer).returns(Integer) }
          def created_at=(_)
          end

          sig { returns(T.nilable(Integer)) }
          def incomplete_at
          end

          sig { params(_: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def incomplete_at=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Message::IncompleteDetails)) }
          def incomplete_details
          end

          sig do
            params(_: T.nilable(OpenAI::Models::Beta::Threads::Message::IncompleteDetails))
              .returns(T.nilable(OpenAI::Models::Beta::Threads::Message::IncompleteDetails))
          end
          def incomplete_details=(_)
          end

          sig { returns(T.nilable(OpenAI::Models::Metadata)) }
          def metadata
          end

          sig { params(_: T.nilable(OpenAI::Models::Metadata)).returns(T.nilable(OpenAI::Models::Metadata)) }
          def metadata=(_)
          end

          sig { returns(Symbol) }
          def object
          end

          sig { params(_: Symbol).returns(Symbol) }
          def object=(_)
          end

          sig { returns(Symbol) }
          def role
          end

          sig { params(_: Symbol).returns(Symbol) }
          def role=(_)
          end

          sig { returns(T.nilable(String)) }
          def run_id
          end

          sig { params(_: T.nilable(String)).returns(T.nilable(String)) }
          def run_id=(_)
          end

          sig { returns(Symbol) }
          def status
          end

          sig { params(_: Symbol).returns(Symbol) }
          def status=(_)
          end

          sig { returns(String) }
          def thread_id
          end

          sig { params(_: String).returns(String) }
          def thread_id=(_)
          end

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
            sig { returns(T.nilable(String)) }
            def file_id
            end

            sig { params(_: String).returns(String) }
            def file_id=(_)
            end

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
            sig { returns(Symbol) }
            def reason
            end

            sig { params(_: Symbol).returns(Symbol) }
            def reason=(_)
            end

            sig { params(reason: Symbol).returns(T.attached_class) }
            def self.new(reason:)
            end

            sig { override.returns({reason: Symbol}) }
            def to_hash
            end

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
