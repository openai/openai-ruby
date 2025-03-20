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
            params(
              _: T.nilable(T.any(OpenAI::Models::Beta::Threads::Message::IncompleteDetails, OpenAI::Util::AnyHash))
            )
              .returns(
                T.nilable(T.any(OpenAI::Models::Beta::Threads::Message::IncompleteDetails, OpenAI::Util::AnyHash))
              )
          end
          def incomplete_details=(_)
          end

          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          #   for storing additional information about the object in a structured format, and
          #   querying for objects via API or the dashboard.
          #
          #   Keys are strings with a maximum length of 64 characters. Values are strings with
          #   a maximum length of 512 characters.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          def metadata
          end

          sig { params(_: T.nilable(T::Hash[Symbol, String])).returns(T.nilable(T::Hash[Symbol, String])) }
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
          sig { returns(OpenAI::Models::Beta::Threads::Message::Role::TaggedSymbol) }
          def role
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::Message::Role::TaggedSymbol)
              .returns(OpenAI::Models::Beta::Threads::Message::Role::TaggedSymbol)
          end
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
          sig { returns(OpenAI::Models::Beta::Threads::Message::Status::TaggedSymbol) }
          def status
          end

          sig do
            params(_: OpenAI::Models::Beta::Threads::Message::Status::TaggedSymbol)
              .returns(OpenAI::Models::Beta::Threads::Message::Status::TaggedSymbol)
          end
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
              metadata: T.nilable(T::Hash[Symbol, String]),
              role: OpenAI::Models::Beta::Threads::Message::Role::TaggedSymbol,
              run_id: T.nilable(String),
              status: OpenAI::Models::Beta::Threads::Message::Status::TaggedSymbol,
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
                  metadata: T.nilable(T::Hash[Symbol, String]),
                  object: Symbol,
                  role: OpenAI::Models::Beta::Threads::Message::Role::TaggedSymbol,
                  run_id: T.nilable(String),
                  status: OpenAI::Models::Beta::Threads::Message::Status::TaggedSymbol,
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

            module Tool
              extend OpenAI::Union

              Variants =
                type_template(:out) do
                  {
                    fixed: T.any(
                      OpenAI::Models::Beta::CodeInterpreterTool,
                      OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly
                    )
                  }
                end

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
                sig do
                  override
                    .returns(
                      [OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly]
                    )
                end
                def variants
                end
              end
            end
          end

          class IncompleteDetails < OpenAI::BaseModel
            # The reason the message is incomplete.
            sig { returns(OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol) }
            def reason
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol)
                .returns(OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol)
            end
            def reason=(_)
            end

            # On an incomplete message, details about why the message is incomplete.
            sig do
              params(reason: OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol)
                .returns(T.attached_class)
            end
            def self.new(reason:)
            end

            sig do
              override.returns({reason: OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol})
            end
            def to_hash
            end

            # The reason the message is incomplete.
            module Reason
              extend OpenAI::Enum

              TaggedSymbol =
                T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason) }
              OrSymbol =
                T.type_alias { T.any(Symbol, OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol) }

              CONTENT_FILTER =
                T.let(:content_filter, OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol)
              MAX_TOKENS =
                T.let(:max_tokens, OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol)
              RUN_CANCELLED =
                T.let(:run_cancelled, OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol)
              RUN_EXPIRED =
                T.let(:run_expired, OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol)
              RUN_FAILED =
                T.let(:run_failed, OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol)

              class << self
                sig do
                  override.returns(T::Array[OpenAI::Models::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol])
                end
                def values
                end
              end
            end
          end

          # The entity that produced the message. One of `user` or `assistant`.
          module Role
            extend OpenAI::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Message::Role) }
            OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::Beta::Threads::Message::Role::TaggedSymbol) }

            USER = T.let(:user, OpenAI::Models::Beta::Threads::Message::Role::TaggedSymbol)
            ASSISTANT = T.let(:assistant, OpenAI::Models::Beta::Threads::Message::Role::TaggedSymbol)

            class << self
              sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::Message::Role::TaggedSymbol]) }
              def values
              end
            end
          end

          # The status of the message, which can be either `in_progress`, `incomplete`, or
          #   `completed`.
          module Status
            extend OpenAI::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::Threads::Message::Status) }
            OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::Beta::Threads::Message::Status::TaggedSymbol) }

            IN_PROGRESS = T.let(:in_progress, OpenAI::Models::Beta::Threads::Message::Status::TaggedSymbol)
            INCOMPLETE = T.let(:incomplete, OpenAI::Models::Beta::Threads::Message::Status::TaggedSymbol)
            COMPLETED = T.let(:completed, OpenAI::Models::Beta::Threads::Message::Status::TaggedSymbol)

            class << self
              sig { override.returns(T::Array[OpenAI::Models::Beta::Threads::Message::Status::TaggedSymbol]) }
              def values
              end
            end
          end
        end
      end
    end
  end
end
