# typed: strong

module OpenAI
  module Models
    ResponseItemList = T.type_alias { Responses::ResponseItemList }

    module Responses
      class ResponseItemList < OpenAI::BaseModel
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

        sig { returns(String) }
        def first_id
        end

        sig { params(_: String).returns(String) }
        def first_id=(_)
        end

        sig { returns(T::Boolean) }
        def has_more
        end

        sig { params(_: T::Boolean).returns(T::Boolean) }
        def has_more=(_)
        end

        sig { returns(String) }
        def last_id
        end

        sig { params(_: String).returns(String) }
        def last_id=(_)
        end

        sig { returns(Symbol) }
        def object
        end

        sig { params(_: Symbol).returns(Symbol) }
        def object=(_)
        end

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

        class Data < OpenAI::Union
          abstract!

          class Message < OpenAI::BaseModel
            sig { returns(String) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            sig { returns(OpenAI::Models::Responses::ResponseInputMessageContentList) }
            def content
            end

            sig do
              params(_: OpenAI::Models::Responses::ResponseInputMessageContentList)
                .returns(OpenAI::Models::Responses::ResponseInputMessageContentList)
            end
            def content=(_)
            end

            sig { returns(Symbol) }
            def role
            end

            sig { params(_: Symbol).returns(Symbol) }
            def role=(_)
            end

            sig { returns(T.nilable(Symbol)) }
            def status
            end

            sig { params(_: Symbol).returns(Symbol) }
            def status=(_)
            end

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
            sig { returns(String) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            sig { returns(String) }
            def call_id
            end

            sig { params(_: String).returns(String) }
            def call_id=(_)
            end

            sig { returns(OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Output) }
            def output
            end

            sig do
              params(_: OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Output)
                .returns(OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput::Output)
            end
            def output=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

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
              sig { returns(Symbol) }
              def type
              end

              sig { params(_: Symbol).returns(Symbol) }
              def type=(_)
              end

              sig { returns(T.nilable(String)) }
              def file_id
              end

              sig { params(_: String).returns(String) }
              def file_id=(_)
              end

              sig { returns(T.nilable(String)) }
              def image_url
              end

              sig { params(_: String).returns(String) }
              def image_url=(_)
              end

              sig { params(file_id: String, image_url: String, type: Symbol).returns(T.attached_class) }
              def self.new(file_id: nil, image_url: nil, type: :computer_screenshot)
              end

              sig { override.returns({type: Symbol, file_id: String, image_url: String}) }
              def to_hash
              end
            end

            class AcknowledgedSafetyCheck < OpenAI::BaseModel
              sig { returns(String) }
              def id
              end

              sig { params(_: String).returns(String) }
              def id=(_)
              end

              sig { returns(String) }
              def code
              end

              sig { params(_: String).returns(String) }
              def code=(_)
              end

              sig { returns(String) }
              def message
              end

              sig { params(_: String).returns(String) }
              def message=(_)
              end

              sig { params(id: String, code: String, message: String).returns(T.attached_class) }
              def self.new(id:, code:, message:)
              end

              sig { override.returns({id: String, code: String, message: String}) }
              def to_hash
              end
            end

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
            sig { returns(String) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            sig { returns(String) }
            def call_id
            end

            sig { params(_: String).returns(String) }
            def call_id=(_)
            end

            sig { returns(String) }
            def output
            end

            sig { params(_: String).returns(String) }
            def output=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

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

          class << self
            sig do
              override
                .returns(
                  [[Symbol, OpenAI::Models::Responses::ResponseItemList::Data::Message], [Symbol, OpenAI::Models::Responses::ResponseOutputMessage], [Symbol, OpenAI::Models::Responses::ResponseFileSearchToolCall], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall], [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::ComputerCallOutput], [Symbol, OpenAI::Models::Responses::ResponseFunctionWebSearch], [Symbol, OpenAI::Models::Responses::ResponseFunctionToolCall], [Symbol, OpenAI::Models::Responses::ResponseItemList::Data::FunctionCallOutput]]
                )
            end
            private def variants
            end
          end
        end
      end
    end
  end
end
