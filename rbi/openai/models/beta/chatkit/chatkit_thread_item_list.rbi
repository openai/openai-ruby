# typed: strong

module OpenAI
  module Models
    module Beta
      ChatKitThreadItemList = ChatKit::ChatKitThreadItemList

      module ChatKit
        class ChatKitThreadItemList < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::ChatKit::ChatKitThreadItemList,
                OpenAI::Internal::AnyHash
              )
            end

          # A list of items
          sig do
            returns(
              T::Array[
                OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::Variants
              ]
            )
          end
          attr_accessor :data

          # The ID of the first item in the list.
          sig { returns(T.nilable(String)) }
          attr_accessor :first_id

          # Whether there are more items available.
          sig { returns(T::Boolean) }
          attr_accessor :has_more

          # The ID of the last item in the list.
          sig { returns(T.nilable(String)) }
          attr_accessor :last_id

          # The type of object returned, must be `list`.
          sig { returns(Symbol) }
          attr_accessor :object

          # A paginated list of thread items rendered for the ChatKit API.
          sig do
            params(
              data:
                T::Array[
                  T.any(
                    OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem::OrHash,
                    OpenAI::Beta::ChatKit::ChatKitThreadAssistantMessageItem::OrHash,
                    OpenAI::Beta::ChatKit::ChatKitWidgetItem::OrHash,
                    OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall::OrHash,
                    OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask::OrHash,
                    OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::OrHash
                  )
                ],
              first_id: T.nilable(String),
              has_more: T::Boolean,
              last_id: T.nilable(String),
              object: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # A list of items
            data:,
            # The ID of the first item in the list.
            first_id:,
            # Whether there are more items available.
            has_more:,
            # The ID of the last item in the list.
            last_id:,
            # The type of object returned, must be `list`.
            object: :list
          )
          end

          sig do
            override.returns(
              {
                data:
                  T::Array[
                    OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::Variants
                  ],
                first_id: T.nilable(String),
                has_more: T::Boolean,
                last_id: T.nilable(String),
                object: Symbol
              }
            )
          end
          def to_hash
          end

          # User-authored messages within a thread.
          module Data
            extend OpenAI::Internal::Type::Union

            Variants =
              T.type_alias do
                T.any(
                  OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem,
                  OpenAI::Beta::ChatKit::ChatKitThreadAssistantMessageItem,
                  OpenAI::Beta::ChatKit::ChatKitWidgetItem,
                  OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall,
                  OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask,
                  OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup
                )
              end

            class ChatKitClientToolCall < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Identifier of the thread item.
              sig { returns(String) }
              attr_accessor :id

              # JSON-encoded arguments that were sent to the tool.
              sig { returns(String) }
              attr_accessor :arguments

              # Identifier for the client tool call.
              sig { returns(String) }
              attr_accessor :call_id

              # Unix timestamp (in seconds) for when the item was created.
              sig { returns(Integer) }
              attr_accessor :created_at

              # Tool name that was invoked.
              sig { returns(String) }
              attr_accessor :name

              # Type discriminator that is always `chatkit.thread_item`.
              sig { returns(Symbol) }
              attr_accessor :object

              # JSON-encoded output captured from the tool. Defaults to null while execution is
              # in progress.
              sig { returns(T.nilable(String)) }
              attr_accessor :output

              # Execution status for the tool call.
              sig do
                returns(
                  OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall::Status::TaggedSymbol
                )
              end
              attr_accessor :status

              # Identifier of the parent thread.
              sig { returns(String) }
              attr_accessor :thread_id

              # Type discriminator that is always `chatkit.client_tool_call`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Record of a client side tool invocation initiated by the assistant.
              sig do
                params(
                  id: String,
                  arguments: String,
                  call_id: String,
                  created_at: Integer,
                  name: String,
                  output: T.nilable(String),
                  status:
                    OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall::Status::OrSymbol,
                  thread_id: String,
                  object: Symbol,
                  type: Symbol
                ).returns(T.attached_class)
              end
              def self.new(
                # Identifier of the thread item.
                id:,
                # JSON-encoded arguments that were sent to the tool.
                arguments:,
                # Identifier for the client tool call.
                call_id:,
                # Unix timestamp (in seconds) for when the item was created.
                created_at:,
                # Tool name that was invoked.
                name:,
                # JSON-encoded output captured from the tool. Defaults to null while execution is
                # in progress.
                output:,
                # Execution status for the tool call.
                status:,
                # Identifier of the parent thread.
                thread_id:,
                # Type discriminator that is always `chatkit.thread_item`.
                object: :"chatkit.thread_item",
                # Type discriminator that is always `chatkit.client_tool_call`.
                type: :"chatkit.client_tool_call"
              )
              end

              sig do
                override.returns(
                  {
                    id: String,
                    arguments: String,
                    call_id: String,
                    created_at: Integer,
                    name: String,
                    object: Symbol,
                    output: T.nilable(String),
                    status:
                      OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall::Status::TaggedSymbol,
                    thread_id: String,
                    type: Symbol
                  }
                )
              end
              def to_hash
              end

              # Execution status for the tool call.
              module Status
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias do
                    T.all(
                      Symbol,
                      OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall::Status
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                IN_PROGRESS =
                  T.let(
                    :in_progress,
                    OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall::Status::TaggedSymbol
                  )
                COMPLETED =
                  T.let(
                    :completed,
                    OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall::Status::TaggedSymbol
                  )

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall::Status::TaggedSymbol
                    ]
                  )
                end
                def self.values
                end
              end
            end

            class ChatKitTask < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Identifier of the thread item.
              sig { returns(String) }
              attr_accessor :id

              # Unix timestamp (in seconds) for when the item was created.
              sig { returns(Integer) }
              attr_accessor :created_at

              # Optional heading for the task. Defaults to null when not provided.
              sig { returns(T.nilable(String)) }
              attr_accessor :heading

              # Type discriminator that is always `chatkit.thread_item`.
              sig { returns(Symbol) }
              attr_accessor :object

              # Optional summary that describes the task. Defaults to null when omitted.
              sig { returns(T.nilable(String)) }
              attr_accessor :summary

              # Subtype for the task.
              sig do
                returns(
                  OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask::TaskType::TaggedSymbol
                )
              end
              attr_accessor :task_type

              # Identifier of the parent thread.
              sig { returns(String) }
              attr_accessor :thread_id

              # Type discriminator that is always `chatkit.task`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Task emitted by the workflow to show progress and status updates.
              sig do
                params(
                  id: String,
                  created_at: Integer,
                  heading: T.nilable(String),
                  summary: T.nilable(String),
                  task_type:
                    OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask::TaskType::OrSymbol,
                  thread_id: String,
                  object: Symbol,
                  type: Symbol
                ).returns(T.attached_class)
              end
              def self.new(
                # Identifier of the thread item.
                id:,
                # Unix timestamp (in seconds) for when the item was created.
                created_at:,
                # Optional heading for the task. Defaults to null when not provided.
                heading:,
                # Optional summary that describes the task. Defaults to null when omitted.
                summary:,
                # Subtype for the task.
                task_type:,
                # Identifier of the parent thread.
                thread_id:,
                # Type discriminator that is always `chatkit.thread_item`.
                object: :"chatkit.thread_item",
                # Type discriminator that is always `chatkit.task`.
                type: :"chatkit.task"
              )
              end

              sig do
                override.returns(
                  {
                    id: String,
                    created_at: Integer,
                    heading: T.nilable(String),
                    object: Symbol,
                    summary: T.nilable(String),
                    task_type:
                      OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask::TaskType::TaggedSymbol,
                    thread_id: String,
                    type: Symbol
                  }
                )
              end
              def to_hash
              end

              # Subtype for the task.
              module TaskType
                extend OpenAI::Internal::Type::Enum

                TaggedSymbol =
                  T.type_alias do
                    T.all(
                      Symbol,
                      OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask::TaskType
                    )
                  end
                OrSymbol = T.type_alias { T.any(Symbol, String) }

                CUSTOM =
                  T.let(
                    :custom,
                    OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask::TaskType::TaggedSymbol
                  )
                THOUGHT =
                  T.let(
                    :thought,
                    OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask::TaskType::TaggedSymbol
                  )

                sig do
                  override.returns(
                    T::Array[
                      OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask::TaskType::TaggedSymbol
                    ]
                  )
                end
                def self.values
                end
              end
            end

            class ChatKitTaskGroup < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup,
                    OpenAI::Internal::AnyHash
                  )
                end

              # Identifier of the thread item.
              sig { returns(String) }
              attr_accessor :id

              # Unix timestamp (in seconds) for when the item was created.
              sig { returns(Integer) }
              attr_accessor :created_at

              # Type discriminator that is always `chatkit.thread_item`.
              sig { returns(Symbol) }
              attr_accessor :object

              # Tasks included in the group.
              sig do
                returns(
                  T::Array[
                    OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task
                  ]
                )
              end
              attr_accessor :tasks

              # Identifier of the parent thread.
              sig { returns(String) }
              attr_accessor :thread_id

              # Type discriminator that is always `chatkit.task_group`.
              sig { returns(Symbol) }
              attr_accessor :type

              # Collection of workflow tasks grouped together in the thread.
              sig do
                params(
                  id: String,
                  created_at: Integer,
                  tasks:
                    T::Array[
                      OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task::OrHash
                    ],
                  thread_id: String,
                  object: Symbol,
                  type: Symbol
                ).returns(T.attached_class)
              end
              def self.new(
                # Identifier of the thread item.
                id:,
                # Unix timestamp (in seconds) for when the item was created.
                created_at:,
                # Tasks included in the group.
                tasks:,
                # Identifier of the parent thread.
                thread_id:,
                # Type discriminator that is always `chatkit.thread_item`.
                object: :"chatkit.thread_item",
                # Type discriminator that is always `chatkit.task_group`.
                type: :"chatkit.task_group"
              )
              end

              sig do
                override.returns(
                  {
                    id: String,
                    created_at: Integer,
                    object: Symbol,
                    tasks:
                      T::Array[
                        OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task
                      ],
                    thread_id: String,
                    type: Symbol
                  }
                )
              end
              def to_hash
              end

              class Task < OpenAI::Internal::Type::BaseModel
                OrHash =
                  T.type_alias do
                    T.any(
                      OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task,
                      OpenAI::Internal::AnyHash
                    )
                  end

                # Optional heading for the grouped task. Defaults to null when not provided.
                sig { returns(T.nilable(String)) }
                attr_accessor :heading

                # Optional summary that describes the grouped task. Defaults to null when omitted.
                sig { returns(T.nilable(String)) }
                attr_accessor :summary

                # Subtype for the grouped task.
                sig do
                  returns(
                    OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task::Type::TaggedSymbol
                  )
                end
                attr_accessor :type

                # Task entry that appears within a TaskGroup.
                sig do
                  params(
                    heading: T.nilable(String),
                    summary: T.nilable(String),
                    type:
                      OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task::Type::OrSymbol
                  ).returns(T.attached_class)
                end
                def self.new(
                  # Optional heading for the grouped task. Defaults to null when not provided.
                  heading:,
                  # Optional summary that describes the grouped task. Defaults to null when omitted.
                  summary:,
                  # Subtype for the grouped task.
                  type:
                )
                end

                sig do
                  override.returns(
                    {
                      heading: T.nilable(String),
                      summary: T.nilable(String),
                      type:
                        OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task::Type::TaggedSymbol
                    }
                  )
                end
                def to_hash
                end

                # Subtype for the grouped task.
                module Type
                  extend OpenAI::Internal::Type::Enum

                  TaggedSymbol =
                    T.type_alias do
                      T.all(
                        Symbol,
                        OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task::Type
                      )
                    end
                  OrSymbol = T.type_alias { T.any(Symbol, String) }

                  CUSTOM =
                    T.let(
                      :custom,
                      OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task::Type::TaggedSymbol
                    )
                  THOUGHT =
                    T.let(
                      :thought,
                      OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task::Type::TaggedSymbol
                    )

                  sig do
                    override.returns(
                      T::Array[
                        OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task::Type::TaggedSymbol
                      ]
                    )
                  end
                  def self.values
                  end
                end
              end
            end

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::Variants
                ]
              )
            end
            def self.variants
            end
          end
        end
      end
    end
  end
end
