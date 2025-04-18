# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseComputerToolCall < OpenAI::Internal::Type::BaseModel
        # The unique ID of the computer call.
        sig { returns(String) }
        attr_accessor :id

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
        attr_accessor :action

        # An identifier used when responding to the tool call with output.
        sig { returns(String) }
        attr_accessor :call_id

        # The pending safety checks for the computer call.
        sig { returns(T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::PendingSafetyCheck]) }
        attr_accessor :pending_safety_checks

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        sig { returns(OpenAI::Models::Responses::ResponseComputerToolCall::Status::OrSymbol) }
        attr_accessor :status

        # The type of the computer call. Always `computer_call`.
        sig { returns(OpenAI::Models::Responses::ResponseComputerToolCall::Type::OrSymbol) }
        attr_accessor :type

        # A tool call to a computer use tool. See the
        # [computer use guide](https://platform.openai.com/docs/guides/tools-computer-use)
        # for more information.
        sig do
          params(
            id: String,
            action: T.any(
              OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click,
              OpenAI::Internal::AnyHash,
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
            pending_safety_checks: T::Array[T.any(OpenAI::Models::Responses::ResponseComputerToolCall::PendingSafetyCheck, OpenAI::Internal::AnyHash)],
            status: OpenAI::Models::Responses::ResponseComputerToolCall::Status::OrSymbol,
            type: OpenAI::Models::Responses::ResponseComputerToolCall::Type::OrSymbol
          )
            .returns(T.attached_class)
        end
        def self.new(id:, action:, call_id:, pending_safety_checks:, status:, type:); end

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
                status: OpenAI::Models::Responses::ResponseComputerToolCall::Status::OrSymbol,
                type: OpenAI::Models::Responses::ResponseComputerToolCall::Type::OrSymbol
              }
            )
        end
        def to_hash; end

        # A click action.
        module Action
          extend OpenAI::Internal::Type::Union

          class Click < OpenAI::Internal::Type::BaseModel
            # Indicates which mouse button was pressed during the click. One of `left`,
            # `right`, `wheel`, `back`, or `forward`.
            sig { returns(OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click::Button::OrSymbol) }
            attr_accessor :button

            # Specifies the event type. For a click action, this property is always set to
            # `click`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The x-coordinate where the click occurred.
            sig { returns(Integer) }
            attr_accessor :x

            # The y-coordinate where the click occurred.
            sig { returns(Integer) }
            attr_accessor :y_

            # A click action.
            sig do
              params(
                button: OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click::Button::OrSymbol,
                x: Integer,
                y_: Integer,
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(button:, x:, y_:, type: :click); end

            sig do
              override
                .returns(
                  {
                    button: OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click::Button::OrSymbol,
                    type: Symbol,
                    x: Integer,
                    y_: Integer
                  }
                )
            end
            def to_hash; end

            # Indicates which mouse button was pressed during the click. One of `left`,
            # `right`, `wheel`, `back`, or `forward`.
            module Button
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click::Button) }
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              LEFT =
                T.let(:left, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click::Button::TaggedSymbol)
              RIGHT =
                T.let(:right, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click::Button::TaggedSymbol)
              WHEEL =
                T.let(:wheel, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click::Button::TaggedSymbol)
              BACK =
                T.let(:back, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click::Button::TaggedSymbol)
              FORWARD =
                T.let(:forward, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click::Button::TaggedSymbol)

              sig do
                override
                  .returns(
                    T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click::Button::TaggedSymbol]
                  )
              end
              def self.values; end
            end
          end

          class DoubleClick < OpenAI::Internal::Type::BaseModel
            # Specifies the event type. For a double click action, this property is always set
            # to `double_click`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The x-coordinate where the double click occurred.
            sig { returns(Integer) }
            attr_accessor :x

            # The y-coordinate where the double click occurred.
            sig { returns(Integer) }
            attr_accessor :y_

            # A double click action.
            sig { params(x: Integer, y_: Integer, type: Symbol).returns(T.attached_class) }
            def self.new(x:, y_:, type: :double_click); end

            sig { override.returns({type: Symbol, x: Integer, y_: Integer}) }
            def to_hash; end
          end

          class Drag < OpenAI::Internal::Type::BaseModel
            # An array of coordinates representing the path of the drag action. Coordinates
            # will appear as an array of objects, eg
            #
            # ```
            # [
            #   { x: 100, y: 200 },
            #   { x: 200, y: 300 }
            # ]
            # ```
            sig { returns(T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag::Path]) }
            attr_accessor :path

            # Specifies the event type. For a drag action, this property is always set to
            # `drag`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A drag action.
            sig do
              params(
                path: T::Array[T.any(OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag::Path, OpenAI::Internal::AnyHash)],
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(path:, type: :drag); end

            sig do
              override
                .returns(
                  {path: T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag::Path], type: Symbol}
                )
            end
            def to_hash; end

            class Path < OpenAI::Internal::Type::BaseModel
              # The x-coordinate.
              sig { returns(Integer) }
              attr_accessor :x

              # The y-coordinate.
              sig { returns(Integer) }
              attr_accessor :y_

              # A series of x/y coordinate pairs in the drag path.
              sig { params(x: Integer, y_: Integer).returns(T.attached_class) }
              def self.new(x:, y_:); end

              sig { override.returns({x: Integer, y_: Integer}) }
              def to_hash; end
            end
          end

          class Keypress < OpenAI::Internal::Type::BaseModel
            # The combination of keys the model is requesting to be pressed. This is an array
            # of strings, each representing a key.
            sig { returns(T::Array[String]) }
            attr_accessor :keys

            # Specifies the event type. For a keypress action, this property is always set to
            # `keypress`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A collection of keypresses the model would like to perform.
            sig { params(keys: T::Array[String], type: Symbol).returns(T.attached_class) }
            def self.new(keys:, type: :keypress); end

            sig { override.returns({keys: T::Array[String], type: Symbol}) }
            def to_hash; end
          end

          class Move < OpenAI::Internal::Type::BaseModel
            # Specifies the event type. For a move action, this property is always set to
            # `move`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The x-coordinate to move to.
            sig { returns(Integer) }
            attr_accessor :x

            # The y-coordinate to move to.
            sig { returns(Integer) }
            attr_accessor :y_

            # A mouse move action.
            sig { params(x: Integer, y_: Integer, type: Symbol).returns(T.attached_class) }
            def self.new(x:, y_:, type: :move); end

            sig { override.returns({type: Symbol, x: Integer, y_: Integer}) }
            def to_hash; end
          end

          class Screenshot < OpenAI::Internal::Type::BaseModel
            # Specifies the event type. For a screenshot action, this property is always set
            # to `screenshot`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A screenshot action.
            sig { params(type: Symbol).returns(T.attached_class) }
            def self.new(type: :screenshot); end

            sig { override.returns({type: Symbol}) }
            def to_hash; end
          end

          class Scroll < OpenAI::Internal::Type::BaseModel
            # The horizontal scroll distance.
            sig { returns(Integer) }
            attr_accessor :scroll_x

            # The vertical scroll distance.
            sig { returns(Integer) }
            attr_accessor :scroll_y

            # Specifies the event type. For a scroll action, this property is always set to
            # `scroll`.
            sig { returns(Symbol) }
            attr_accessor :type

            # The x-coordinate where the scroll occurred.
            sig { returns(Integer) }
            attr_accessor :x

            # The y-coordinate where the scroll occurred.
            sig { returns(Integer) }
            attr_accessor :y_

            # A scroll action.
            sig do
              params(scroll_x: Integer, scroll_y: Integer, x: Integer, y_: Integer, type: Symbol)
                .returns(T.attached_class)
            end
            def self.new(scroll_x:, scroll_y:, x:, y_:, type: :scroll); end

            sig do
              override.returns({scroll_x: Integer, scroll_y: Integer, type: Symbol, x: Integer, y_: Integer})
            end
            def to_hash; end
          end

          class Type < OpenAI::Internal::Type::BaseModel
            # The text to type.
            sig { returns(String) }
            attr_accessor :text

            # Specifies the event type. For a type action, this property is always set to
            # `type`.
            sig { returns(Symbol) }
            attr_accessor :type

            # An action to type in text.
            sig { params(text: String, type: Symbol).returns(T.attached_class) }
            def self.new(text:, type: :type); end

            sig { override.returns({text: String, type: Symbol}) }
            def to_hash; end
          end

          class Wait < OpenAI::Internal::Type::BaseModel
            # Specifies the event type. For a wait action, this property is always set to
            # `wait`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A wait action.
            sig { params(type: Symbol).returns(T.attached_class) }
            def self.new(type: :wait); end

            sig { override.returns({type: Symbol}) }
            def to_hash; end
          end

          sig do
            override
              .returns(
                [OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click, OpenAI::Models::Responses::ResponseComputerToolCall::Action::DoubleClick, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Keypress, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Move, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Screenshot, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Scroll, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Type, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Wait]
              )
          end
          def self.variants; end
        end

        class PendingSafetyCheck < OpenAI::Internal::Type::BaseModel
          # The ID of the pending safety check.
          sig { returns(String) }
          attr_accessor :id

          # The type of the pending safety check.
          sig { returns(String) }
          attr_accessor :code

          # Details about the pending safety check.
          sig { returns(String) }
          attr_accessor :message

          # A pending safety check for the computer call.
          sig { params(id: String, code: String, message: String).returns(T.attached_class) }
          def self.new(id:, code:, message:); end

          sig { override.returns({id: String, code: String, message: String}) }
          def to_hash; end
        end

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Status) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(:in_progress, OpenAI::Models::Responses::ResponseComputerToolCall::Status::TaggedSymbol)
          COMPLETED = T.let(:completed, OpenAI::Models::Responses::ResponseComputerToolCall::Status::TaggedSymbol)
          INCOMPLETE =
            T.let(:incomplete, OpenAI::Models::Responses::ResponseComputerToolCall::Status::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::Status::TaggedSymbol]) }
          def self.values; end
        end

        # The type of the computer call. Always `computer_call`.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Type) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMPUTER_CALL =
            T.let(:computer_call, OpenAI::Models::Responses::ResponseComputerToolCall::Type::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseComputerToolCall::Type::TaggedSymbol]) }
          def self.values; end
        end
      end
    end
  end
end
