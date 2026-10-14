# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatKitThreadItemList < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   A list of items
          #
          #   @return [Array<OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem, OpenAI::Models::Beta::ChatKit::ChatKitThreadAssistantMessageItem, OpenAI::Models::Beta::ChatKit::ChatKitWidgetItem, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup>]
          required :data,
                   -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data] }

          # @!attribute first_id
          #   The ID of the first item in the list.
          #
          #   @return [String, nil]
          required :first_id, String, nil?: true

          # @!attribute has_more
          #   Whether there are more items available.
          #
          #   @return [Boolean]
          required :has_more, OpenAI::Internal::Type::Boolean

          # @!attribute last_id
          #   The ID of the last item in the list.
          #
          #   @return [String, nil]
          required :last_id, String, nil?: true

          # @!attribute object
          #   The type of object returned, must be `list`.
          #
          #   @return [Symbol, :list]
          required :object, const: :list

          # @!method initialize(data:, first_id:, has_more:, last_id:, object: :list)
          #   A paginated list of thread items rendered for the ChatKit API.
          #
          #   @param data [Array<OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem, OpenAI::Models::Beta::ChatKit::ChatKitThreadAssistantMessageItem, OpenAI::Models::Beta::ChatKit::ChatKitWidgetItem, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup>] A list of items
          #
          #   @param first_id [String, nil] The ID of the first item in the list.
          #
          #   @param has_more [Boolean] Whether there are more items available.
          #
          #   @param last_id [String, nil] The ID of the last item in the list.
          #
          #   @param object [Symbol, :list] The type of object returned, must be `list`.

          # User-authored messages within a thread.
          module Data
            extend OpenAI::Internal::Type::Union

            discriminator :type

            # User-authored messages within a thread.
            variant :"chatkit.user_message", -> { OpenAI::Beta::ChatKit::ChatKitThreadUserMessageItem }

            # Assistant-authored message within a thread.
            variant :"chatkit.assistant_message", -> { OpenAI::Beta::ChatKit::ChatKitThreadAssistantMessageItem }

            # Thread item that renders a widget payload.
            variant :"chatkit.widget", -> { OpenAI::Beta::ChatKit::ChatKitWidgetItem }

            # Record of a client side tool invocation initiated by the assistant.
            variant :"chatkit.client_tool_call",
                    -> { OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall }

            # Task emitted by the workflow to show progress and status updates.
            variant :"chatkit.task", -> { OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask }

            # Collection of workflow tasks grouped together in the thread.
            variant :"chatkit.task_group", -> { OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup }

            class ChatKitClientToolCall < OpenAI::Internal::Type::BaseModel
              # @!attribute id
              #   Identifier of the thread item.
              #
              #   @return [String]
              required :id, String

              # @!attribute arguments
              #   JSON-encoded arguments that were sent to the tool.
              #
              #   @return [String]
              required :arguments, String

              # @!attribute call_id
              #   Identifier for the client tool call.
              #
              #   @return [String]
              required :call_id, String

              # @!attribute created_at
              #   Unix timestamp (in seconds) for when the item was created.
              #
              #   @return [Integer]
              required :created_at, Integer

              # @!attribute name
              #   Tool name that was invoked.
              #
              #   @return [String]
              required :name, String

              # @!attribute object
              #   Type discriminator that is always `chatkit.thread_item`.
              #
              #   @return [Symbol, :"chatkit.thread_item"]
              required :object, const: :"chatkit.thread_item"

              # @!attribute output
              #   JSON-encoded output captured from the tool. Defaults to null while execution is
              #   in progress.
              #
              #   @return [String, nil]
              required :output, String, nil?: true

              # @!attribute status
              #   Execution status for the tool call.
              #
              #   @return [Symbol, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall::Status]
              required :status,
                       enum: -> { OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall::Status }

              # @!attribute thread_id
              #   Identifier of the parent thread.
              #
              #   @return [String]
              required :thread_id, String

              # @!attribute type
              #   Type discriminator that is always `chatkit.client_tool_call`.
              #
              #   @return [Symbol, :"chatkit.client_tool_call"]
              required :type, const: :"chatkit.client_tool_call"

              # @!method initialize(id:, arguments:, call_id:, created_at:, name:, output:, status:, thread_id:, object: :"chatkit.thread_item", type: :"chatkit.client_tool_call")
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall}
              #   for more details.
              #
              #   Record of a client side tool invocation initiated by the assistant.
              #
              #   @param id [String] Identifier of the thread item.
              #
              #   @param arguments [String] JSON-encoded arguments that were sent to the tool.
              #
              #   @param call_id [String] Identifier for the client tool call.
              #
              #   @param created_at [Integer] Unix timestamp (in seconds) for when the item was created.
              #
              #   @param name [String] Tool name that was invoked.
              #
              #   @param output [String, nil] JSON-encoded output captured from the tool. Defaults to null while execution is
              #
              #   @param status [Symbol, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall::Status] Execution status for the tool call.
              #
              #   @param thread_id [String] Identifier of the parent thread.
              #
              #   @param object [Symbol, :"chatkit.thread_item"] Type discriminator that is always `chatkit.thread_item`.
              #
              #   @param type [Symbol, :"chatkit.client_tool_call"] Type discriminator that is always `chatkit.client_tool_call`.

              # Execution status for the tool call.
              #
              # @see OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall#status
              module Status
                extend OpenAI::Internal::Type::Enum

                IN_PROGRESS = :in_progress
                COMPLETED = :completed

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end

            class ChatKitTask < OpenAI::Internal::Type::BaseModel
              # @!attribute id
              #   Identifier of the thread item.
              #
              #   @return [String]
              required :id, String

              # @!attribute created_at
              #   Unix timestamp (in seconds) for when the item was created.
              #
              #   @return [Integer]
              required :created_at, Integer

              # @!attribute heading
              #   Optional heading for the task. Defaults to null when not provided.
              #
              #   @return [String, nil]
              required :heading, String, nil?: true

              # @!attribute object
              #   Type discriminator that is always `chatkit.thread_item`.
              #
              #   @return [Symbol, :"chatkit.thread_item"]
              required :object, const: :"chatkit.thread_item"

              # @!attribute summary
              #   Optional summary that describes the task. Defaults to null when omitted.
              #
              #   @return [String, nil]
              required :summary, String, nil?: true

              # @!attribute task_type
              #   Subtype for the task.
              #
              #   @return [Symbol, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask::TaskType]
              required :task_type,
                       enum: -> { OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask::TaskType }

              # @!attribute thread_id
              #   Identifier of the parent thread.
              #
              #   @return [String]
              required :thread_id, String

              # @!attribute type
              #   Type discriminator that is always `chatkit.task`.
              #
              #   @return [Symbol, :"chatkit.task"]
              required :type, const: :"chatkit.task"

              # @!method initialize(id:, created_at:, heading:, summary:, task_type:, thread_id:, object: :"chatkit.thread_item", type: :"chatkit.task")
              #   Task emitted by the workflow to show progress and status updates.
              #
              #   @param id [String] Identifier of the thread item.
              #
              #   @param created_at [Integer] Unix timestamp (in seconds) for when the item was created.
              #
              #   @param heading [String, nil] Optional heading for the task. Defaults to null when not provided.
              #
              #   @param summary [String, nil] Optional summary that describes the task. Defaults to null when omitted.
              #
              #   @param task_type [Symbol, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask::TaskType] Subtype for the task.
              #
              #   @param thread_id [String] Identifier of the parent thread.
              #
              #   @param object [Symbol, :"chatkit.thread_item"] Type discriminator that is always `chatkit.thread_item`.
              #
              #   @param type [Symbol, :"chatkit.task"] Type discriminator that is always `chatkit.task`.

              # Subtype for the task.
              #
              # @see OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask#task_type
              module TaskType
                extend OpenAI::Internal::Type::Enum

                CUSTOM = :custom
                THOUGHT = :thought

                # @!method self.values
                #   @return [Array<Symbol>]
              end
            end

            class ChatKitTaskGroup < OpenAI::Internal::Type::BaseModel
              # @!attribute id
              #   Identifier of the thread item.
              #
              #   @return [String]
              required :id, String

              # @!attribute created_at
              #   Unix timestamp (in seconds) for when the item was created.
              #
              #   @return [Integer]
              required :created_at, Integer

              # @!attribute object
              #   Type discriminator that is always `chatkit.thread_item`.
              #
              #   @return [Symbol, :"chatkit.thread_item"]
              required :object, const: :"chatkit.thread_item"

              # @!attribute tasks
              #   Tasks included in the group.
              #
              #   @return [Array<OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task>]
              required :tasks,
                       -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task] }

              # @!attribute thread_id
              #   Identifier of the parent thread.
              #
              #   @return [String]
              required :thread_id, String

              # @!attribute type
              #   Type discriminator that is always `chatkit.task_group`.
              #
              #   @return [Symbol, :"chatkit.task_group"]
              required :type, const: :"chatkit.task_group"

              # @!method initialize(id:, created_at:, tasks:, thread_id:, object: :"chatkit.thread_item", type: :"chatkit.task_group")
              #   Collection of workflow tasks grouped together in the thread.
              #
              #   @param id [String] Identifier of the thread item.
              #
              #   @param created_at [Integer] Unix timestamp (in seconds) for when the item was created.
              #
              #   @param tasks [Array<OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task>] Tasks included in the group.
              #
              #   @param thread_id [String] Identifier of the parent thread.
              #
              #   @param object [Symbol, :"chatkit.thread_item"] Type discriminator that is always `chatkit.thread_item`.
              #
              #   @param type [Symbol, :"chatkit.task_group"] Type discriminator that is always `chatkit.task_group`.

              class Task < OpenAI::Internal::Type::BaseModel
                # @!attribute heading
                #   Optional heading for the grouped task. Defaults to null when not provided.
                #
                #   @return [String, nil]
                required :heading, String, nil?: true

                # @!attribute summary
                #   Optional summary that describes the grouped task. Defaults to null when omitted.
                #
                #   @return [String, nil]
                required :summary, String, nil?: true

                # @!attribute type
                #   Subtype for the grouped task.
                #
                #   @return [Symbol, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task::Type]
                required :type,
                         enum: -> { OpenAI::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task::Type }

                # @!method initialize(heading:, summary:, type:)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task}
                #   for more details.
                #
                #   Task entry that appears within a TaskGroup.
                #
                #   @param heading [String, nil] Optional heading for the grouped task. Defaults to null when not provided.
                #
                #   @param summary [String, nil] Optional summary that describes the grouped task. Defaults to null when omitted.
                #
                #   @param type [Symbol, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task::Type] Subtype for the grouped task.

                # Subtype for the grouped task.
                #
                # @see OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup::Task#type
                module Type
                  extend OpenAI::Internal::Type::Enum

                  CUSTOM = :custom
                  THOUGHT = :thought

                  # @!method self.values
                  #   @return [Array<Symbol>]
                end
              end
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Beta::ChatKit::ChatKitThreadUserMessageItem, OpenAI::Models::Beta::ChatKit::ChatKitThreadAssistantMessageItem, OpenAI::Models::Beta::ChatKit::ChatKitWidgetItem, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitClientToolCall, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTask, OpenAI::Models::Beta::ChatKit::ChatKitThreadItemList::Data::ChatKitTaskGroup)]
          end
        end
      end

      ChatKitThreadItemList = ChatKit::ChatKitThreadItemList
    end
  end
end
