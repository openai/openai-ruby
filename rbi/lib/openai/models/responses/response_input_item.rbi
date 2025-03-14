# typed: strong

module OpenAI
  module Models
    module Responses
      # A message input to the model with a role indicating instruction following
      #   hierarchy. Instructions given with the `developer` or `system` role take
      #   precedence over instructions given with the `user` role. Messages with the
      #   `assistant` role are presumed to have been generated by the model in previous
      #   interactions.
      class ResponseInputItem < OpenAI::Union
        abstract!

        class Message < OpenAI::BaseModel
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

          # A message input to the model with a role indicating instruction following
          #   hierarchy. Instructions given with the `developer` or `system` role take
          #   precedence over instructions given with the `user` role.
          sig do
            params(
              content: OpenAI::Models::Responses::ResponseInputMessageContentList,
              role: Symbol,
              status: Symbol,
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(content:, role:, status: nil, type: nil)
          end

          sig do
            override
              .returns(
                {content: OpenAI::Models::Responses::ResponseInputMessageContentList, role: Symbol, status: Symbol, type: Symbol}
              )
          end
          def to_hash
          end

          # The role of the message input. One of `user`, `system`, or `developer`.
          class Role < OpenAI::Enum
            abstract!

            USER = :user
            SYSTEM = :system
            DEVELOPER = :developer

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end

          # The status of item. One of `in_progress`, `completed`, or `incomplete`.
          #   Populated when items are returned via API.
          class Status < OpenAI::Enum
            abstract!

            IN_PROGRESS = :in_progress
            COMPLETED = :completed
            INCOMPLETE = :incomplete

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end

          # The type of the message input. Always set to `message`.
          class Type < OpenAI::Enum
            abstract!

            MESSAGE = :message

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end
        end

        class ComputerCallOutput < OpenAI::BaseModel
          # The ID of the computer tool call that produced the output.
          sig { returns(String) }
          def call_id
          end

          sig { params(_: String).returns(String) }
          def call_id=(_)
          end

          # A computer screenshot image used with the computer use tool.
          sig { returns(OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Output) }
          def output
          end

          sig do
            params(_: OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Output)
              .returns(OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Output)
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

          # The ID of the computer tool call output.
          sig { returns(T.nilable(String)) }
          def id
          end

          sig { params(_: String).returns(String) }
          def id=(_)
          end

          # The safety checks reported by the API that have been acknowledged by the
          #   developer.
          sig do
            returns(
              T.nilable(
                T::Array[OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::AcknowledgedSafetyCheck]
              )
            )
          end
          def acknowledged_safety_checks
          end

          sig do
            params(
              _: T::Array[OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::AcknowledgedSafetyCheck]
            )
              .returns(
                T::Array[OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::AcknowledgedSafetyCheck]
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

          # The output of a computer tool call.
          sig do
            params(
              call_id: String,
              output: OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Output,
              id: String,
              acknowledged_safety_checks: T::Array[OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::AcknowledgedSafetyCheck],
              status: Symbol,
              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(call_id:, output:, id: nil, acknowledged_safety_checks: nil, status: nil, type: :computer_call_output)
          end

          sig do
            override
              .returns(
                {
                  call_id: String,
                  output: OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::Output,
                  type: Symbol,
                  id: String,
                  acknowledged_safety_checks: T::Array[OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput::AcknowledgedSafetyCheck],
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

            IN_PROGRESS = :in_progress
            COMPLETED = :completed
            INCOMPLETE = :incomplete

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end
        end

        class FunctionCallOutput < OpenAI::BaseModel
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

          # The unique ID of the function tool call output. Populated when this item is
          #   returned via API.
          sig { returns(T.nilable(String)) }
          def id
          end

          sig { params(_: String).returns(String) }
          def id=(_)
          end

          # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          #   Populated when items are returned via API.
          sig { returns(T.nilable(Symbol)) }
          def status
          end

          sig { params(_: Symbol).returns(Symbol) }
          def status=(_)
          end

          # The output of a function tool call.
          sig do
            params(
              call_id: String,
              output: String,
              id: String,
              status: Symbol,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(call_id:, output:, id: nil, status: nil, type: :function_call_output)
          end

          sig do
            override.returns({call_id: String, output: String, type: Symbol, id: String, status: Symbol})
          end
          def to_hash
          end

          # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          #   Populated when items are returned via API.
          class Status < OpenAI::Enum
            abstract!

            IN_PROGRESS = :in_progress
            COMPLETED = :completed
            INCOMPLETE = :incomplete

            class << self
              sig { override.returns(T::Array[Symbol]) }
              def values
              end
            end
          end
        end

        class ItemReference < OpenAI::BaseModel
          # The ID of the item to reference.
          sig { returns(String) }
          def id
          end

          sig { params(_: String).returns(String) }
          def id=(_)
          end

          # The type of item to reference. Always `item_reference`.
          sig { returns(Symbol) }
          def type
          end

          sig { params(_: Symbol).returns(Symbol) }
          def type=(_)
          end

          # An internal identifier for an item to reference.
          sig { params(id: String, type: Symbol).returns(T.attached_class) }
          def self.new(id:, type: :item_reference)
          end

          sig { override.returns({id: String, type: Symbol}) }
          def to_hash
          end
        end

        class << self
          sig do
            override
              .returns(
                [OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseInputItem::ItemReference]
              )
          end
          def variants
          end
        end
      end
    end
  end
end
