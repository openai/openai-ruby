# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseComputerToolCall < OpenAI::BaseModel
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        sig do
          returns(
            T.any(
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::DoubleClick,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Keypress,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Move,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Screenshot,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Scroll,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Type,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Wait
            )
          )
        end
        def action
        end

        sig do
          params(
            _: T.any(
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::DoubleClick,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Keypress,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Move,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Screenshot,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Scroll,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Type,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Wait
            )
          )
            .returns(
              T.any(
                OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click,
                OpenAI::Models::Responses::ResponseComputerToolCall::Action::DoubleClick,
                OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag,
                OpenAI::Models::Responses::ResponseComputerToolCall::Action::Keypress,
                OpenAI::Models::Responses::ResponseComputerToolCall::Action::Move,
                OpenAI::Models::Responses::ResponseComputerToolCall::Action::Screenshot,
                OpenAI::Models::Responses::ResponseComputerToolCall::Action::Scroll,
                OpenAI::Models::Responses::ResponseComputerToolCall::Action::Type,
                OpenAI::Models::Responses::ResponseComputerToolCall::Action::Wait
              )
            )
        end
        def action=(_)
        end

        sig { returns(String) }
        def call_id
        end

        sig { params(_: String).returns(String) }
        def call_id=(_)
        end

        sig { returns(T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::PendingSafetyCheck]) }
        def pending_safety_checks
        end

        sig do
          params(_: T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::PendingSafetyCheck])
            .returns(T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::PendingSafetyCheck])
        end
        def pending_safety_checks=(_)
        end

        sig { returns(Symbol) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig do
          params(
            id: String,
            action: T.any(
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::DoubleClick,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Keypress,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Move,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Screenshot,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Scroll,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Type,
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Wait
            ),
            call_id: String,
            pending_safety_checks: T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::PendingSafetyCheck],
            status: Symbol,
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, action:, call_id:, pending_safety_checks:, status:, type:)
        end

        sig do
          override
            .returns(
              {
                id: String,
                action: T.any(
                  OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click,
                  OpenAI::Models::Responses::ResponseComputerToolCall::Action::DoubleClick,
                  OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag,
                  OpenAI::Models::Responses::ResponseComputerToolCall::Action::Keypress,
                  OpenAI::Models::Responses::ResponseComputerToolCall::Action::Move,
                  OpenAI::Models::Responses::ResponseComputerToolCall::Action::Screenshot,
                  OpenAI::Models::Responses::ResponseComputerToolCall::Action::Scroll,
                  OpenAI::Models::Responses::ResponseComputerToolCall::Action::Type,
                  OpenAI::Models::Responses::ResponseComputerToolCall::Action::Wait
                ),
                call_id: String,
                pending_safety_checks: T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::PendingSafetyCheck],
                status: Symbol,
                type: Symbol
              }
            )
        end
        def to_hash
        end

        class Action < OpenAI::Union
          abstract!

          class Click < OpenAI::BaseModel
            sig { returns(Symbol) }
            def button
            end

            sig { params(_: Symbol).returns(Symbol) }
            def button=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { returns(Integer) }
            def x
            end

            sig { params(_: Integer).returns(Integer) }
            def x=(_)
            end

            sig { returns(Integer) }
            def y_
            end

            sig { params(_: Integer).returns(Integer) }
            def y_=(_)
            end

            sig { params(button: Symbol, x: Integer, y_: Integer, type: Symbol).returns(T.attached_class) }
            def self.new(button:, x:, y_:, type: :click)
            end

            sig { override.returns({button: Symbol, type: Symbol, x: Integer, y_: Integer}) }
            def to_hash
            end

            class Button < OpenAI::Enum
              abstract!

              LEFT = :left
              RIGHT = :right
              WHEEL = :wheel
              BACK = :back
              FORWARD = :forward

              class << self
                sig { override.returns(T::Array[Symbol]) }
                def values
                end
              end
            end
          end

          class DoubleClick < OpenAI::BaseModel
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { returns(Integer) }
            def x
            end

            sig { params(_: Integer).returns(Integer) }
            def x=(_)
            end

            sig { returns(Integer) }
            def y_
            end

            sig { params(_: Integer).returns(Integer) }
            def y_=(_)
            end

            sig { params(x: Integer, y_: Integer, type: Symbol).returns(T.attached_class) }
            def self.new(x:, y_:, type: :double_click)
            end

            sig { override.returns({type: Symbol, x: Integer, y_: Integer}) }
            def to_hash
            end
          end

          class Drag < OpenAI::BaseModel
            sig { returns(T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag::Path]) }
            def path
            end

            sig do
              params(_: T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag::Path])
                .returns(T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag::Path])
            end
            def path=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig do
              params(
                path: T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag::Path],
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(path:, type: :drag)
            end

            sig do
              override
                .returns(
                  {path: T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag::Path], type: Symbol}
                )
            end
            def to_hash
            end

            class Path < OpenAI::BaseModel
              sig { returns(Integer) }
              def x
              end

              sig { params(_: Integer).returns(Integer) }
              def x=(_)
              end

              sig { returns(Integer) }
              def y_
              end

              sig { params(_: Integer).returns(Integer) }
              def y_=(_)
              end

              sig { params(x: Integer, y_: Integer).returns(T.attached_class) }
              def self.new(x:, y_:)
              end

              sig { override.returns({x: Integer, y_: Integer}) }
              def to_hash
              end
            end
          end

          class Keypress < OpenAI::BaseModel
            sig { returns(T::Array[String]) }
            def keys
            end

            sig { params(_: T::Array[String]).returns(T::Array[String]) }
            def keys=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { params(keys: T::Array[String], type: Symbol).returns(T.attached_class) }
            def self.new(keys:, type: :keypress)
            end

            sig { override.returns({keys: T::Array[String], type: Symbol}) }
            def to_hash
            end
          end

          class Move < OpenAI::BaseModel
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { returns(Integer) }
            def x
            end

            sig { params(_: Integer).returns(Integer) }
            def x=(_)
            end

            sig { returns(Integer) }
            def y_
            end

            sig { params(_: Integer).returns(Integer) }
            def y_=(_)
            end

            sig { params(x: Integer, y_: Integer, type: Symbol).returns(T.attached_class) }
            def self.new(x:, y_:, type: :move)
            end

            sig { override.returns({type: Symbol, x: Integer, y_: Integer}) }
            def to_hash
            end
          end

          class Screenshot < OpenAI::BaseModel
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { params(type: Symbol).returns(T.attached_class) }
            def self.new(type: :screenshot)
            end

            sig { override.returns({type: Symbol}) }
            def to_hash
            end
          end

          class Scroll < OpenAI::BaseModel
            sig { returns(Integer) }
            def scroll_x
            end

            sig { params(_: Integer).returns(Integer) }
            def scroll_x=(_)
            end

            sig { returns(Integer) }
            def scroll_y
            end

            sig { params(_: Integer).returns(Integer) }
            def scroll_y=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { returns(Integer) }
            def x
            end

            sig { params(_: Integer).returns(Integer) }
            def x=(_)
            end

            sig { returns(Integer) }
            def y_
            end

            sig { params(_: Integer).returns(Integer) }
            def y_=(_)
            end

            sig do
              params(scroll_x: Integer, scroll_y: Integer, x: Integer, y_: Integer, type: Symbol)
                .returns(T.attached_class)
            end
            def self.new(scroll_x:, scroll_y:, x:, y_:, type: :scroll)
            end

            sig do
              override.returns({scroll_x: Integer, scroll_y: Integer, type: Symbol, x: Integer, y_: Integer})
            end
            def to_hash
            end
          end

          class Type < OpenAI::BaseModel
            sig { returns(String) }
            def text
            end

            sig { params(_: String).returns(String) }
            def text=(_)
            end

            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { params(text: String, type: Symbol).returns(T.attached_class) }
            def self.new(text:, type: :type)
            end

            sig { override.returns({text: String, type: Symbol}) }
            def to_hash
            end
          end

          class Wait < OpenAI::BaseModel
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { params(type: Symbol).returns(T.attached_class) }
            def self.new(type: :wait)
            end

            sig { override.returns({type: Symbol}) }
            def to_hash
            end
          end

          class << self
            sig do
              override
                .returns(
                  [[Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::DoubleClick], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Keypress], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Move], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Screenshot], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Scroll], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Type], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Wait]]
                )
            end
            private def variants
            end
          end
        end

        class PendingSafetyCheck < OpenAI::BaseModel
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

        class Type < OpenAI::Enum
          abstract!

          COMPUTER_CALL = :computer_call

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
