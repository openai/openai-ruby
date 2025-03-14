# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseComputerToolCall < OpenAI::BaseModel
        # The unique ID of the computer call.
        sig { returns(String) }
        def id
        end

        sig { params(_: String).returns(String) }
        def id=(_)
        end

        # A click action.
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

        # An identifier used when responding to the tool call with output.
        sig { returns(String) }
        def call_id
        end

        sig { params(_: String).returns(String) }
        def call_id=(_)
        end

        # The pending safety checks for the computer call.
        sig { returns(T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::PendingSafetyCheck]) }
        def pending_safety_checks
        end

        sig do
          params(_: T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::PendingSafetyCheck])
            .returns(T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::PendingSafetyCheck])
        end
        def pending_safety_checks=(_)
        end

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        sig { returns(Symbol) }
        def status
        end

        sig { params(_: Symbol).returns(Symbol) }
        def status=(_)
        end

        # The type of the computer call. Always `computer_call`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # A tool call to a computer use tool. See the
        #   [computer use guide](https://platform.openai.com/docs/guides/tools-computer-use)
        #   for more information.
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

        # A click action.
        class Action < OpenAI::Union
          abstract!

          class Click < OpenAI::BaseModel
            # Indicates which mouse button was pressed during the click. One of `left`,
            #   `right`, `wheel`, `back`, or `forward`.
            sig { returns(Symbol) }
            def button
            end

            sig { params(_: Symbol).returns(Symbol) }
            def button=(_)
            end

            # Specifies the event type. For a click action, this property is always set to
            #   `click`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # The x-coordinate where the click occurred.
            sig { returns(Integer) }
            def x
            end

            sig { params(_: Integer).returns(Integer) }
            def x=(_)
            end

            # The y-coordinate where the click occurred.
            sig { returns(Integer) }
            def y_
            end

            sig { params(_: Integer).returns(Integer) }
            def y_=(_)
            end

            # A click action.
            sig { params(button: Symbol, x: Integer, y_: Integer, type: Symbol).returns(T.attached_class) }
            def self.new(button:, x:, y_:, type: :click)
            end

            sig { override.returns({button: Symbol, type: Symbol, x: Integer, y_: Integer}) }
            def to_hash
            end

            # Indicates which mouse button was pressed during the click. One of `left`,
            #   `right`, `wheel`, `back`, or `forward`.
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
            # Specifies the event type. For a double click action, this property is always set
            #   to `double_click`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # The x-coordinate where the double click occurred.
            sig { returns(Integer) }
            def x
            end

            sig { params(_: Integer).returns(Integer) }
            def x=(_)
            end

            # The y-coordinate where the double click occurred.
            sig { returns(Integer) }
            def y_
            end

            sig { params(_: Integer).returns(Integer) }
            def y_=(_)
            end

            # A double click action.
            sig { params(x: Integer, y_: Integer, type: Symbol).returns(T.attached_class) }
            def self.new(x:, y_:, type: :double_click)
            end

            sig { override.returns({type: Symbol, x: Integer, y_: Integer}) }
            def to_hash
            end
          end

          class Drag < OpenAI::BaseModel
            # An array of coordinates representing the path of the drag action. Coordinates
            #   will appear as an array of objects, eg
            #
            #   ```
            #   [
            #     { x: 100, y: 200 },
            #     { x: 200, y: 300 }
            #   ]
            #   ```
            sig { returns(T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag::Path]) }
            def path
            end

            sig do
              params(_: T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag::Path])
                .returns(T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag::Path])
            end
            def path=(_)
            end

            # Specifies the event type. For a drag action, this property is always set to
            #   `drag`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # A drag action.
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
              # The x-coordinate.
              sig { returns(Integer) }
              def x
              end

              sig { params(_: Integer).returns(Integer) }
              def x=(_)
              end

              # The y-coordinate.
              sig { returns(Integer) }
              def y_
              end

              sig { params(_: Integer).returns(Integer) }
              def y_=(_)
              end

              # A series of x/y coordinate pairs in the drag path.
              sig { params(x: Integer, y_: Integer).returns(T.attached_class) }
              def self.new(x:, y_:)
              end

              sig { override.returns({x: Integer, y_: Integer}) }
              def to_hash
              end
            end
          end

          class Keypress < OpenAI::BaseModel
            # The combination of keys the model is requesting to be pressed. This is an array
            #   of strings, each representing a key.
            sig { returns(T::Array[String]) }
            def keys
            end

            sig { params(_: T::Array[String]).returns(T::Array[String]) }
            def keys=(_)
            end

            # Specifies the event type. For a keypress action, this property is always set to
            #   `keypress`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # A collection of keypresses the model would like to perform.
            sig { params(keys: T::Array[String], type: Symbol).returns(T.attached_class) }
            def self.new(keys:, type: :keypress)
            end

            sig { override.returns({keys: T::Array[String], type: Symbol}) }
            def to_hash
            end
          end

          class Move < OpenAI::BaseModel
            # Specifies the event type. For a move action, this property is always set to
            #   `move`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # The x-coordinate to move to.
            sig { returns(Integer) }
            def x
            end

            sig { params(_: Integer).returns(Integer) }
            def x=(_)
            end

            # The y-coordinate to move to.
            sig { returns(Integer) }
            def y_
            end

            sig { params(_: Integer).returns(Integer) }
            def y_=(_)
            end

            # A mouse move action.
            sig { params(x: Integer, y_: Integer, type: Symbol).returns(T.attached_class) }
            def self.new(x:, y_:, type: :move)
            end

            sig { override.returns({type: Symbol, x: Integer, y_: Integer}) }
            def to_hash
            end
          end

          class Screenshot < OpenAI::BaseModel
            # Specifies the event type. For a screenshot action, this property is always set
            #   to `screenshot`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # A screenshot action.
            sig { params(type: Symbol).returns(T.attached_class) }
            def self.new(type: :screenshot)
            end

            sig { override.returns({type: Symbol}) }
            def to_hash
            end
          end

          class Scroll < OpenAI::BaseModel
            # The horizontal scroll distance.
            sig { returns(Integer) }
            def scroll_x
            end

            sig { params(_: Integer).returns(Integer) }
            def scroll_x=(_)
            end

            # The vertical scroll distance.
            sig { returns(Integer) }
            def scroll_y
            end

            sig { params(_: Integer).returns(Integer) }
            def scroll_y=(_)
            end

            # Specifies the event type. For a scroll action, this property is always set to
            #   `scroll`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # The x-coordinate where the scroll occurred.
            sig { returns(Integer) }
            def x
            end

            sig { params(_: Integer).returns(Integer) }
            def x=(_)
            end

            # The y-coordinate where the scroll occurred.
            sig { returns(Integer) }
            def y_
            end

            sig { params(_: Integer).returns(Integer) }
            def y_=(_)
            end

            # A scroll action.
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
            # The text to type.
            sig { returns(String) }
            def text
            end

            sig { params(_: String).returns(String) }
            def text=(_)
            end

            # Specifies the event type. For a type action, this property is always set to
            #   `type`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # An action to type in text.
            sig { params(text: String, type: Symbol).returns(T.attached_class) }
            def self.new(text:, type: :type)
            end

            sig { override.returns({text: String, type: Symbol}) }
            def to_hash
            end
          end

          class Wait < OpenAI::BaseModel
            # Specifies the event type. For a wait action, this property is always set to
            #   `wait`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # A wait action.
            sig { params(type: Symbol).returns(T.attached_class) }
            def self.new(type: :wait)
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
                  [[Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::DoubleClick], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Keypress], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Move], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Screenshot], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Scroll], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Type], [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Wait]]
                )
            end
            private def variants
            end
          end
        end

        class PendingSafetyCheck < OpenAI::BaseModel
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

        # The type of the computer call. Always `computer_call`.
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
