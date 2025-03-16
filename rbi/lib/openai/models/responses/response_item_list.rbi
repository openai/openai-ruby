# typed: strong

module OpenAI
  module Models
    ResponseItemList = T.type_alias { Responses::ResponseItemList }

    module Responses
      class ResponseItemList < OpenAI::BaseModel
        # A list of items used to generate this response.
        sig do
          returns(
            T::Array[
            T.any(
              OpenAI::Models::Responses::ResponseItemList::Data::Message,
              OpenAI::Models::Responses::ResponseOutputMessage,
              OpenAI::Models::Responses::ResponseFileSearchToolCall,
              OpenAI::Models::Responses::ResponseComputerToolCall,
              OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput,
              OpenAI::Models::Responses::ResponseFunctionWebSearch,
              OpenAI::Models::Responses::ResponseFunctionToolCall,
              OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput
            )
            ]
          )
        end
        def data
        end

        sig do
          params(
            _: T::Array[
            T.any(
              OpenAI::Models::Responses::ResponseItemList::Data::Message,
              OpenAI::Models::Responses::ResponseOutputMessage,
              OpenAI::Models::Responses::ResponseFileSearchToolCall,
              OpenAI::Models::Responses::ResponseComputerToolCall,
              OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput,
              OpenAI::Models::Responses::ResponseFunctionWebSearch,
              OpenAI::Models::Responses::ResponseFunctionToolCall,
              OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput
            )
            ]
          )
            .returns(
              T::Array[
              T.any(
                OpenAI::Models::Responses::ResponseItemList::Data::Message,
                OpenAI::Models::Responses::ResponseOutputMessage,
                OpenAI::Models::Responses::ResponseFileSearchToolCall,
                OpenAI::Models::Responses::ResponseComputerToolCall,
                OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput,
                OpenAI::Models::Responses::ResponseFunctionWebSearch,
                OpenAI::Models::Responses::ResponseFunctionToolCall,
                OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput
              )
              ]
            )
        end
        def data=(_)
        end

        # The ID of the first item in the list.
        sig { returns(String) }
        def first_id
        end

        sig { params(_: String).returns(String) }
        def first_id=(_)
        end

        # Whether there are more items available.
        sig { returns(T::Boolean) }
        def has_more
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def has_more=(_)
        end

        # The ID of the last item in the list.
        sig { returns(String) }
        def last_id
        end

        sig { params(_: String).returns(String) }
        def last_id=(_)
        end

        # The type of object returned, must be `list`.
        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

        # A list of Response items.
        sig do
          params(
            data: T::Array[
            T.any(
              OpenAI::Models::Responses::ResponseItemList::Data::Message,
              OpenAI::Models::Responses::ResponseOutputMessage,
              OpenAI::Models::Responses::ResponseFileSearchToolCall,
              OpenAI::Models::Responses::ResponseComputerToolCall,
              OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput,
              OpenAI::Models::Responses::ResponseFunctionWebSearch,
              OpenAI::Models::Responses::ResponseFunctionToolCall,
              OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput
            )
            ],
            first_id: String,
            has_more: T::Boolean,
            last_id: String,
            object: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(data:, first_id:, has_more:, last_id:, object: :list)
        end

        sig do
          override
            .returns(
              {
                data: T::Array[
                T.any(
                  OpenAI::Models::Responses::ResponseItemList::Data::Message,
                  OpenAI::Models::Responses::ResponseOutputMessage,
                  OpenAI::Models::Responses::ResponseFileSearchToolCall,
                  OpenAI::Models::Responses::ResponseComputerToolCall,
                  OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput,
                  OpenAI::Models::Responses::ResponseFunctionWebSearch,
                  OpenAI::Models::Responses::ResponseFunctionToolCall,
                  OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput
                )
                ],
                first_id: String,
                has_more: T::Boolean,
                last_id: String,
                object: Symbol
              }
            )
        end
        def to_hash
        end

        # Content item used to generate a response.
        class Data < OpenAI::Union
          abstract!

          Variants = type_template(:out) do
            {
              fixed: T.any(
                OpenAI::Models::Responses::ResponseItemList::Data::Message,
                OpenAI::Models::Responses::ResponseOutputMessage,
                OpenAI::Models::Responses::ResponseFileSearchToolCall,
                OpenAI::Models::Responses::ResponseComputerToolCall,
                OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput,
                OpenAI::Models::Responses::ResponseFunctionWebSearch,
                OpenAI::Models::Responses::ResponseFunctionToolCall,
                OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput
              )
            }
          end

          class Message < OpenAI::BaseModel
            # The unique ID of the message input.
            sig { returns(String) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            # A list of one or many input items to the model, containing different content
            #   types.
            sig { returns(OpenAI::Models::Responses::ResponseInputMessageContentList) }
            def content
            end

            sig do
              params(_: OpenAI::Models::Responses::ResponseInputMessageContentList)
                .returns(OpenAI::Models::Responses::ResponseInputMessageContentList)
            end
            def content=(_)
            end

            # The role of the message input. One of `user`, `system`, or `developer`.
            sig { returns(Symbol) }
            def role
            end

            sig { params(_: Symbol).returns(Symbol) }
            def role=(_)
            end

            # The status of item. One of `in_progress`, `completed`, or `incomplete`.
            #   Populated when items are returned via API.
            sig { returns(T.nilable(Symbol)) }
            def status
            end

            sig { params(_: Symbol).returns(Symbol) }
            def status=(_)
            end

            # The type of the message input. Always set to `message`.
            sig { returns(T.nilable(Symbol)) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig do
              params(
                id: String,
                content: OpenAI::Models::Responses::ResponseInputMessageContentList,
                role: Symbol,
                status: Symbol,
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(id:, content:, role:, status: nil, type: nil)
            end

            sig do
              override
                .returns(
                  {
                    id: String,
                    content: OpenAI::Models::Responses::ResponseInputMessageContentList,
                    role: Symbol,
                    status: Symbol,
                    type: Symbol
                  }
                )
            end
            def to_hash
            end

            # The role of the message input. One of `user`, `system`, or `developer`.
            class Role < OpenAI::Enum
              abstract!

              Value = type_template(:out) { {fixed: Symbol} }

              USER = :user
              SYSTEM = :system
              DEVELOPER = :developer
            end

            # The status of item. One of `in_progress`, `completed`, or `incomplete`.
            #   Populated when items are returned via API.
            class Status < OpenAI::Enum
              abstract!

              Value = type_template(:out) { {fixed: Symbol} }

              IN_PROGRESS = :in_progress
              COMPLETED = :completed
              INCOMPLETE = :incomplete
            end

            # The type of the message input. Always set to `message`.
            class Type < OpenAI::Enum
              abstract!

              Value = type_template(:out) { {fixed: Symbol} }

              MESSAGE = :message
            end
          end

          class ComputerCallOutput < OpenAI::BaseModel
            # The unique ID of the computer call tool output.
            sig { returns(String) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            # The ID of the computer tool call that produced the output.
            sig { returns(String) }
            def call_id
            end

            sig { params(_: String).returns(String) }
            def call_id=(_)
            end

            # A computer screenshot image used with the computer use tool.
            sig { returns(OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Output) }
            def output
            end

            sig do
              params(_: OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Output)
                .returns(OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Output)
            end
            def output=(_)
            end

            # The type of the computer tool call output. Always `computer_call_output`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # The safety checks reported by the API that have been acknowledged by the
            #   developer.
            sig do
              returns(
                T.nilable(
                  T::Array[OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::AcknowledgedSafetyCheck]
                )
              )
            end
            def acknowledged_safety_checks
            end

            sig do
              params(
                _: T::Array[OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::AcknowledgedSafetyCheck]
              )
                .returns(
                  T::Array[OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::AcknowledgedSafetyCheck]
                )
            end
            def acknowledged_safety_checks=(_)
            end

            # The status of the message input. One of `in_progress`, `completed`, or
            #   `incomplete`. Populated when input items are returned via API.
            sig { returns(T.nilable(Symbol)) }
            def status
            end

            sig { params(_: Symbol).returns(Symbol) }
            def status=(_)
            end

            sig do
              params(
                id: String,
                call_id: String,
                output: OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Output,
                acknowledged_safety_checks: T::Array[OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::AcknowledgedSafetyCheck],
                status: Symbol,
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(id:, call_id:, output:, acknowledged_safety_checks: nil, status: nil, type: :computer_call_output)
            end

            sig do
              override
                .returns(
                  {
                    id: String,
                    call_id: String,
                    output: OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Output,
                    type: Symbol,
                    acknowledged_safety_checks: T::Array[OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::AcknowledgedSafetyCheck],
                    status: Symbol
                  }
                )
            end
            def to_hash
            end

            class Output < OpenAI::BaseModel
              # Specifies the event type. For a computer screenshot, this property is always set
              #   to `computer_screenshot`.
              sig { returns(Symbol) }
              def type
              end

              sig { params(_: Symbol).returns(Symbol) }
              def type=(_)
              end

              # The identifier of an uploaded file that contains the screenshot.
              sig { returns(T.nilable(String)) }
              def file_id
              end

              sig { params(_: String).returns(String) }
              def file_id=(_)
              end

              # The URL of the screenshot image.
              sig { returns(T.nilable(String)) }
              def image_url
              end

              sig { params(_: String).returns(String) }
              def image_url=(_)
              end

              # A computer screenshot image used with the computer use tool.
              sig { params(file_id: String, image_url: String, type: Symbol).returns(T.attached_class) }
              def self.new(file_id: nil, image_url: nil, type: :computer_screenshot)
              end

              sig { override.returns({type: Symbol, file_id: String, image_url: String}) }
              def to_hash
              end
            end

            class AcknowledgedSafetyCheck < OpenAI::BaseModel
              # The ID of the pending safety check.
              sig { returns(String) }
              def id
              end

              sig { params(_: String).returns(String) }
              def id=(_)
              end

              # The type of the pending safety check.
              sig { returns(String) }
              def code
              end

              sig { params(_: String).returns(String) }
              def code=(_)
              end

              # Details about the pending safety check.
              sig { returns(String) }
              def message
              end

              sig { params(_: String).returns(String) }
              def message=(_)
              end

              # A pending safety check for the computer call.
              sig { params(id: String, code: String, message: String).returns(T.attached_class) }
              def self.new(id:, code:, message:)
              end

              sig { override.returns({id: String, code: String, message: String}) }
              def to_hash
              end
            end

            # The status of the message input. One of `in_progress`, `completed`, or
            #   `incomplete`. Populated when input items are returned via API.
            class Status < OpenAI::Enum
              abstract!

              Value = type_template(:out) { {fixed: Symbol} }

              IN_PROGRESS = :in_progress
              COMPLETED = :completed
              INCOMPLETE = :incomplete
            end
          end

          class FunctionCallOutput < OpenAI::BaseModel
            # The unique ID of the function call tool output.
            sig { returns(String) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            # The unique ID of the function tool call generated by the model.
            sig { returns(String) }
            def call_id
            end

            sig { params(_: String).returns(String) }
            def call_id=(_)
            end

            # A JSON string of the output of the function tool call.
            sig { returns(String) }
            def output
            end

            sig { params(_: String).returns(String) }
            def output=(_)
            end

            # The type of the function tool call output. Always `function_call_output`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
            #   Populated when items are returned via API.
            sig { returns(T.nilable(Symbol)) }
            def status
            end

            sig { params(_: Symbol).returns(Symbol) }
            def status=(_)
            end

            sig do
              params(
                id: String,
                call_id: String,
                output: String,
                status: Symbol,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(id:, call_id:, output:, status: nil, type: :function_call_output)
            end

            sig do
              override.returns({id: String, call_id: String, output: String, type: Symbol, status: Symbol})
            end
            def to_hash
            end

            # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
            #   Populated when items are returned via API.
            class Status < OpenAI::Enum
              abstract!

              Value = type_template(:out) { {fixed: Symbol} }

              IN_PROGRESS = :in_progress
              COMPLETED = :completed
              INCOMPLETE = :incomplete
            end
          end
        end
      end
    end
  end
end
