# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        class Message < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(OpenAI::Beta::Threads::Message, OpenAI::Internal::AnyHash)
            end

          # The identifier, which can be referenced in API endpoints.
          sig { returns(String) }
          attr_accessor :id

          # If applicable, the ID of the
          # [assistant](https://platform.openai.com/docs/api-reference/assistants) that
          # authored this message.
          sig { returns(T.nilable(String)) }
          attr_accessor :assistant_id

          # A list of files attached to the message, and the tools they were added to.
          sig do
            returns(
              T.nilable(T::Array[OpenAI::Beta::Threads::Message::Attachment])
            )
          end
          attr_accessor :attachments

          # The Unix timestamp (in seconds) for when the message was completed.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :completed_at

          # The content of the message in array of text and/or images.
          sig do
            returns(T::Array[OpenAI::Beta::Threads::MessageContent::Variants])
          end
          attr_accessor :content

          # The Unix timestamp (in seconds) for when the message was created.
          sig { returns(Integer) }
          attr_accessor :created_at

          # The Unix timestamp (in seconds) for when the message was marked as incomplete.
          sig { returns(T.nilable(Integer)) }
          attr_accessor :incomplete_at

          # On an incomplete message, details about why the message is incomplete.
          sig do
            returns(
              T.nilable(OpenAI::Beta::Threads::Message::IncompleteDetails)
            )
          end
          attr_reader :incomplete_details

          sig do
            params(
              incomplete_details:
                T.nilable(
                  OpenAI::Beta::Threads::Message::IncompleteDetails::OrHash
                )
            ).void
          end
          attr_writer :incomplete_details

          # Set of 16 key-value pairs that can be attached to an object. This can be useful
          # for storing additional information about the object in a structured format, and
          # querying for objects via API or the dashboard.
          #
          # Keys are strings with a maximum length of 64 characters. Values are strings with
          # a maximum length of 512 characters.
          sig { returns(T.nilable(T::Hash[Symbol, String])) }
          attr_accessor :metadata

          # The object type, which is always `thread.message`.
          sig { returns(Symbol) }
          attr_accessor :object

          # The entity that produced the message. One of `user` or `assistant`.
          sig { returns(OpenAI::Beta::Threads::Message::Role::TaggedSymbol) }
          attr_accessor :role

          # The ID of the [run](https://platform.openai.com/docs/api-reference/runs)
          # associated with the creation of this message. Value is `null` when messages are
          # created manually using the create message or create thread endpoints.
          sig { returns(T.nilable(String)) }
          attr_accessor :run_id

          # The status of the message, which can be either `in_progress`, `incomplete`, or
          # `completed`.
          sig { returns(OpenAI::Beta::Threads::Message::Status::TaggedSymbol) }
          attr_accessor :status

          # The [thread](https://platform.openai.com/docs/api-reference/threads) ID that
          # this message belongs to.
          sig { returns(String) }
          attr_accessor :thread_id

          # Represents a message within a
          # [thread](https://platform.openai.com/docs/api-reference/threads).
          sig do
            params(
              id: String,
              assistant_id: T.nilable(String),
              attachments:
                T.nilable(
                  T::Array[OpenAI::Beta::Threads::Message::Attachment::OrHash]
                ),
              completed_at: T.nilable(Integer),
              content:
                T::Array[
                  T.any(
                    OpenAI::Beta::Threads::ImageFileContentBlock::OrHash,
                    OpenAI::Beta::Threads::ImageURLContentBlock::OrHash,
                    OpenAI::Beta::Threads::TextContentBlock::OrHash,
                    OpenAI::Beta::Threads::RefusalContentBlock::OrHash
                  )
                ],
              created_at: Integer,
              incomplete_at: T.nilable(Integer),
              incomplete_details:
                T.nilable(
                  OpenAI::Beta::Threads::Message::IncompleteDetails::OrHash
                ),
              metadata: T.nilable(T::Hash[Symbol, String]),
              role: OpenAI::Beta::Threads::Message::Role::OrSymbol,
              run_id: T.nilable(String),
              status: OpenAI::Beta::Threads::Message::Status::OrSymbol,
              thread_id: String,
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The identifier, which can be referenced in API endpoints.
            id:,
            # If applicable, the ID of the
            # [assistant](https://platform.openai.com/docs/api-reference/assistants) that
            # authored this message.
            assistant_id:,
            # A list of files attached to the message, and the tools they were added to.
            attachments:,
            # The Unix timestamp (in seconds) for when the message was completed.
            completed_at:,
            # The content of the message in array of text and/or images.
            content:,
            # The Unix timestamp (in seconds) for when the message was created.
            created_at:,
            # The Unix timestamp (in seconds) for when the message was marked as incomplete.
            incomplete_at:,
            # On an incomplete message, details about why the message is incomplete.
            incomplete_details:,
            # Set of 16 key-value pairs that can be attached to an object. This can be useful
            # for storing additional information about the object in a structured format, and
            # querying for objects via API or the dashboard.
            #
            # Keys are strings with a maximum length of 64 characters. Values are strings with
            # a maximum length of 512 characters.
            metadata:,
            # The entity that produced the message. One of `user` or `assistant`.
            role:,
            # The ID of the [run](https://platform.openai.com/docs/api-reference/runs)
            # associated with the creation of this message. Value is `null` when messages are
            # created manually using the create message or create thread endpoints.
            run_id:,
            # The status of the message, which can be either `in_progress`, `incomplete`, or
            # `completed`.
            status:,
            # The [thread](https://platform.openai.com/docs/api-reference/threads) ID that
            # this message belongs to.
            thread_id:,
            # The object type, which is always `thread.message`.
            object: :"thread.message"
          )
          end

          sig do
            override.returns(
              {
                id: String,
                assistant_id: T.nilable(String),
                attachments:
                  T.nilable(
                    T::Array[OpenAI::Beta::Threads::Message::Attachment]
                  ),
                completed_at: T.nilable(Integer),
                content:
                  T::Array[OpenAI::Beta::Threads::MessageContent::Variants],
                created_at: Integer,
                incomplete_at: T.nilable(Integer),
                incomplete_details:
                  T.nilable(OpenAI::Beta::Threads::Message::IncompleteDetails),
                metadata: T.nilable(T::Hash[Symbol, String]),
                object: Symbol,
                role: OpenAI::Beta::Threads::Message::Role::TaggedSymbol,
                run_id: T.nilable(String),
                status: OpenAI::Beta::Threads::Message::Status::TaggedSymbol,
                thread_id: String
              }
            )
          end
          def to_hash
          end

          class Attachment < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::Message::Attachment,
                  OpenAI::Internal::AnyHash
                )
              end

            # The ID of the file to attach to the message.
            sig { returns(T.nilable(String)) }
            attr_reader :file_id

            sig { params(file_id: String).void }
            attr_writer :file_id

            # The tools to add this file to.
            sig do
              returns(
                T.nilable(
                  T::Array[
                    OpenAI::Beta::Threads::Message::Attachment::Tool::Variants
                  ]
                )
              )
            end
            attr_reader :tools

            sig do
              params(
                tools:
                  T::Array[
                    T.any(
                      OpenAI::Beta::CodeInterpreterTool::OrHash,
                      OpenAI::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly::OrHash
                    )
                  ]
              ).void
            end
            attr_writer :tools

            sig do
              params(
                file_id: String,
                tools:
                  T::Array[
                    T.any(
                      OpenAI::Beta::CodeInterpreterTool::OrHash,
                      OpenAI::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly::OrHash
                    )
                  ]
              ).returns(T.attached_class)
            end
            def self.new(
              # The ID of the file to attach to the message.
              file_id: nil,
              # The tools to add this file to.
              tools: nil
            )
            end

            sig do
              override.returns(
                {
                  file_id: String,
                  tools:
                    T::Array[
                      OpenAI::Beta::Threads::Message::Attachment::Tool::Variants
                    ]
                }
              )
            end
            def to_hash
            end

            module Tool
              extend OpenAI::Internal::Type::Union

              Variants =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::CodeInterpreterTool,
                    OpenAI::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly
                  )
                end

              class AssistantToolsFileSearchTypeOnly < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Beta::Threads::Message::Attachment::Tool::AssistantToolsFileSearchTypeOnly,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # The type of tool being defined: `file_search`
                sig { returns(Symbol) }
                attr_accessor :type

                sig { params(type: Symbol).returns(T.attached_class) }
                def self.new(
                  # The type of tool being defined: `file_search`
                  type: :file_search
                )
                end

                sig { override.returns({ type: Symbol }) }
                def to_hash
                end
              end

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::Threads::Message::Attachment::Tool::Variants
                  ]
                )
              end
              def self.variants
              end
            end
          end

          class IncompleteDetails < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::Message::IncompleteDetails,
                  OpenAI::Internal::AnyHash
                )
              end

            # The reason the message is incomplete.
            sig do
              returns(
                OpenAI::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol
              )
            end
            attr_accessor :reason

            # On an incomplete message, details about why the message is incomplete.
            sig do
              params(
                reason:
                  OpenAI::Beta::Threads::Message::IncompleteDetails::Reason::OrSymbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The reason the message is incomplete.
              reason:
            )
            end

            sig do
              override.returns(
                {
                  reason:
                    OpenAI::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol
                }
              )
            end
            def to_hash
            end

            # The reason the message is incomplete.
            module Reason
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Beta::Threads::Message::IncompleteDetails::Reason
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              CONTENT_FILTER =
                T.let(
                  :content_filter,
                  OpenAI::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol
                )
              MAX_TOKENS =
                T.let(
                  :max_tokens,
                  OpenAI::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol
                )
              RUN_CANCELLED =
                T.let(
                  :run_cancelled,
                  OpenAI::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol
                )
              RUN_EXPIRED =
                T.let(
                  :run_expired,
                  OpenAI::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol
                )
              RUN_FAILED =
                T.let(
                  :run_failed,
                  OpenAI::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Beta::Threads::Message::IncompleteDetails::Reason::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end

          # The entity that produced the message. One of `user` or `assistant`.
          module Role
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Beta::Threads::Message::Role)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            USER =
              T.let(:user, OpenAI::Beta::Threads::Message::Role::TaggedSymbol)
            ASSISTANT =
              T.let(
                :assistant,
                OpenAI::Beta::Threads::Message::Role::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[OpenAI::Beta::Threads::Message::Role::TaggedSymbol]
              )
            end
            def self.values
            end
          end

          # The status of the message, which can be either `in_progress`, `incomplete`, or
          # `completed`.
          module Status
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(Symbol, OpenAI::Beta::Threads::Message::Status)
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            IN_PROGRESS =
              T.let(
                :in_progress,
                OpenAI::Beta::Threads::Message::Status::TaggedSymbol
              )
            INCOMPLETE =
              T.let(
                :incomplete,
                OpenAI::Beta::Threads::Message::Status::TaggedSymbol
              )
            COMPLETED =
              T.let(
                :completed,
                OpenAI::Beta::Threads::Message::Status::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[OpenAI::Beta::Threads::Message::Status::TaggedSymbol]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
