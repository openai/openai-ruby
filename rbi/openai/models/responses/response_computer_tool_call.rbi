# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseComputerToolCall < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The unique ID of the computer call.
        sig { returns(String) }
        attr_accessor :id

        # A click action.
        sig do
          returns(
            T.any(
              OpenAI::Responses::ResponseComputerToolCall::Action::Click,
              OpenAI::Responses::ResponseComputerToolCall::Action::DoubleClick,
              OpenAI::Responses::ResponseComputerToolCall::Action::Drag,
              OpenAI::Responses::ResponseComputerToolCall::Action::Keypress,
              OpenAI::Responses::ResponseComputerToolCall::Action::Move,
              OpenAI::Responses::ResponseComputerToolCall::Action::Screenshot,
              OpenAI::Responses::ResponseComputerToolCall::Action::Scroll,
              OpenAI::Responses::ResponseComputerToolCall::Action::Type,
              OpenAI::Responses::ResponseComputerToolCall::Action::Wait
            )
          )
        end
        attr_accessor :action

        # An identifier used when responding to the tool call with output.
        sig { returns(String) }
        attr_accessor :call_id

        # The pending safety checks for the computer call.
        sig do
          returns(
            T::Array[
              OpenAI::Responses::ResponseComputerToolCall::PendingSafetyCheck
            ]
          )
        end
        attr_accessor :pending_safety_checks

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        sig do
          returns(OpenAI::Responses::ResponseComputerToolCall::Status::OrSymbol)
        end
        attr_accessor :status

        # The type of the computer call. Always `computer_call`.
        sig do
          returns(OpenAI::Responses::ResponseComputerToolCall::Type::OrSymbol)
        end
        attr_accessor :type

        # A tool call to a computer use tool. See the
        # [computer use guide](https://platform.openai.com/docs/guides/tools-computer-use)
        # for more information.
        sig do
          params(
            id: String,
            action:
              T.any(
                OpenAI::Responses::ResponseComputerToolCall::Action::Click::OrHash,
                OpenAI::Responses::ResponseComputerToolCall::Action::DoubleClick::OrHash,
                OpenAI::Responses::ResponseComputerToolCall::Action::Drag::OrHash,
                OpenAI::Responses::ResponseComputerToolCall::Action::Keypress::OrHash,
                OpenAI::Responses::ResponseComputerToolCall::Action::Move::OrHash,
                OpenAI::Responses::ResponseComputerToolCall::Action::Screenshot::OrHash,
                OpenAI::Responses::ResponseComputerToolCall::Action::Scroll::OrHash,
                OpenAI::Responses::ResponseComputerToolCall::Action::Type::OrHash,
                OpenAI::Responses::ResponseComputerToolCall::Action::Wait::OrHash
              ),
            call_id: String,
            pending_safety_checks:
              T::Array[
                OpenAI::Responses::ResponseComputerToolCall::PendingSafetyCheck::OrHash
              ],
            status:
              OpenAI::Responses::ResponseComputerToolCall::Status::OrSymbol,
            type: OpenAI::Responses::ResponseComputerToolCall::Type::OrSymbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the computer call.
          id:,
          # A click action.
          action:,
          # An identifier used when responding to the tool call with output.
          call_id:,
          # The pending safety checks for the computer call.
          pending_safety_checks:,
          # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
          # Populated when items are returned via API.
          status:,
          # The type of the computer call. Always `computer_call`.
          type:
        )
        end

        sig do
          override.returns(
            {
              id: String,
              action:
                T.any(
                  OpenAI::Responses::ResponseComputerToolCall::Action::Click,
                  OpenAI::Responses::ResponseComputerToolCall::Action::DoubleClick,
                  OpenAI::Responses::ResponseComputerToolCall::Action::Drag,
                  OpenAI::Responses::ResponseComputerToolCall::Action::Keypress,
                  OpenAI::Responses::ResponseComputerToolCall::Action::Move,
                  OpenAI::Responses::ResponseComputerToolCall::Action::Screenshot,
                  OpenAI::Responses::ResponseComputerToolCall::Action::Scroll,
                  OpenAI::Responses::ResponseComputerToolCall::Action::Type,
                  OpenAI::Responses::ResponseComputerToolCall::Action::Wait
                ),
              call_id: String,
              pending_safety_checks:
                T::Array[
                  OpenAI::Responses::ResponseComputerToolCall::PendingSafetyCheck
                ],
              status:
                OpenAI::Responses::ResponseComputerToolCall::Status::OrSymbol,
              type: OpenAI::Responses::ResponseComputerToolCall::Type::OrSymbol
            }
          )
        end
        def to_hash
        end

        # A click action.
        module Action
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponseComputerToolCall::Action::Click,
                OpenAI::Responses::ResponseComputerToolCall::Action::DoubleClick,
                OpenAI::Responses::ResponseComputerToolCall::Action::Drag,
                OpenAI::Responses::ResponseComputerToolCall::Action::Keypress,
                OpenAI::Responses::ResponseComputerToolCall::Action::Move,
                OpenAI::Responses::ResponseComputerToolCall::Action::Screenshot,
                OpenAI::Responses::ResponseComputerToolCall::Action::Scroll,
                OpenAI::Responses::ResponseComputerToolCall::Action::Type,
                OpenAI::Responses::ResponseComputerToolCall::Action::Wait
              )
            end

          class Click < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

            # Indicates which mouse button was pressed during the click. One of `left`,
            # `right`, `wheel`, `back`, or `forward`.
            sig do
              returns(
                OpenAI::Responses::ResponseComputerToolCall::Action::Click::Button::OrSymbol
              )
            end
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
                button:
                  OpenAI::Responses::ResponseComputerToolCall::Action::Click::Button::OrSymbol,
                x: Integer,
                y_: Integer,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # Indicates which mouse button was pressed during the click. One of `left`,
              # `right`, `wheel`, `back`, or `forward`.
              button:,
              # The x-coordinate where the click occurred.
              x:,
              # The y-coordinate where the click occurred.
              y_:,
              # Specifies the event type. For a click action, this property is always set to
              # `click`.
              type: :click
            )
            end

            sig do
              override.returns(
                {
                  button:
                    OpenAI::Responses::ResponseComputerToolCall::Action::Click::Button::OrSymbol,
                  type: Symbol,
                  x: Integer,
                  y_: Integer
                }
              )
            end
            def to_hash
            end

            # Indicates which mouse button was pressed during the click. One of `left`,
            # `right`, `wheel`, `back`, or `forward`.
            module Button
              extend OpenAI::Internal::Type::Enum

              TaggedSymbol =
                T.type_alias do
                  T.all(
                    Symbol,
                    OpenAI::Responses::ResponseComputerToolCall::Action::Click::Button
                  )
                end
              OrSymbol = T.type_alias { T.any(Symbol, String) }

              LEFT =
                T.let(
                  :left,
                  OpenAI::Responses::ResponseComputerToolCall::Action::Click::Button::TaggedSymbol
                )
              RIGHT =
                T.let(
                  :right,
                  OpenAI::Responses::ResponseComputerToolCall::Action::Click::Button::TaggedSymbol
                )
              WHEEL =
                T.let(
                  :wheel,
                  OpenAI::Responses::ResponseComputerToolCall::Action::Click::Button::TaggedSymbol
                )
              BACK =
                T.let(
                  :back,
                  OpenAI::Responses::ResponseComputerToolCall::Action::Click::Button::TaggedSymbol
                )
              FORWARD =
                T.let(
                  :forward,
                  OpenAI::Responses::ResponseComputerToolCall::Action::Click::Button::TaggedSymbol
                )

              sig do
                override.returns(
                  T::Array[
                    OpenAI::Responses::ResponseComputerToolCall::Action::Click::Button::TaggedSymbol
                  ]
                )
              end
              def self.values
              end
            end
          end

          class DoubleClick < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
            sig do
              params(x: Integer, y_: Integer, type: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # The x-coordinate where the double click occurred.
              x:,
              # The y-coordinate where the double click occurred.
              y_:,
              # Specifies the event type. For a double click action, this property is always set
              # to `double_click`.
              type: :double_click
            )
            end

            sig { override.returns({ type: Symbol, x: Integer, y_: Integer }) }
            def to_hash
            end
          end

          class Drag < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

            # An array of coordinates representing the path of the drag action. Coordinates
            # will appear as an array of objects, eg
            #
            # ```
            # [
            #   { x: 100, y: 200 },
            #   { x: 200, y: 300 }
            # ]
            # ```
            sig do
              returns(
                T::Array[
                  OpenAI::Responses::ResponseComputerToolCall::Action::Drag::Path
                ]
              )
            end
            attr_accessor :path

            # Specifies the event type. For a drag action, this property is always set to
            # `drag`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A drag action.
            sig do
              params(
                path:
                  T::Array[
                    OpenAI::Responses::ResponseComputerToolCall::Action::Drag::Path::OrHash
                  ],
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # An array of coordinates representing the path of the drag action. Coordinates
              # will appear as an array of objects, eg
              #
              # ```
              # [
              #   { x: 100, y: 200 },
              #   { x: 200, y: 300 }
              # ]
              # ```
              path:,
              # Specifies the event type. For a drag action, this property is always set to
              # `drag`.
              type: :drag
            )
            end

            sig do
              override.returns(
                {
                  path:
                    T::Array[
                      OpenAI::Responses::ResponseComputerToolCall::Action::Drag::Path
                    ],
                  type: Symbol
                }
              )
            end
            def to_hash
            end

            class Path < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

              # The x-coordinate.
              sig { returns(Integer) }
              attr_accessor :x

              # The y-coordinate.
              sig { returns(Integer) }
              attr_accessor :y_

              # A series of x/y coordinate pairs in the drag path.
              sig { params(x: Integer, y_: Integer).returns(T.attached_class) }
              def self.new(
                # The x-coordinate.
                x:,
                # The y-coordinate.
                y_:
              )
              end

              sig { override.returns({ x: Integer, y_: Integer }) }
              def to_hash
              end
            end
          end

          class Keypress < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

            # The combination of keys the model is requesting to be pressed. This is an array
            # of strings, each representing a key.
            sig { returns(T::Array[String]) }
            attr_accessor :keys

            # Specifies the event type. For a keypress action, this property is always set to
            # `keypress`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A collection of keypresses the model would like to perform.
            sig do
              params(keys: T::Array[String], type: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # The combination of keys the model is requesting to be pressed. This is an array
              # of strings, each representing a key.
              keys:,
              # Specifies the event type. For a keypress action, this property is always set to
              # `keypress`.
              type: :keypress
            )
            end

            sig { override.returns({ keys: T::Array[String], type: Symbol }) }
            def to_hash
            end
          end

          class Move < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
            sig do
              params(x: Integer, y_: Integer, type: Symbol).returns(
                T.attached_class
              )
            end
            def self.new(
              # The x-coordinate to move to.
              x:,
              # The y-coordinate to move to.
              y_:,
              # Specifies the event type. For a move action, this property is always set to
              # `move`.
              type: :move
            )
            end

            sig { override.returns({ type: Symbol, x: Integer, y_: Integer }) }
            def to_hash
            end
          end

          class Screenshot < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

            # Specifies the event type. For a screenshot action, this property is always set
            # to `screenshot`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A screenshot action.
            sig { params(type: Symbol).returns(T.attached_class) }
            def self.new(
              # Specifies the event type. For a screenshot action, this property is always set
              # to `screenshot`.
              type: :screenshot
            )
            end

            sig { override.returns({ type: Symbol }) }
            def to_hash
            end
          end

          class Scroll < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
              params(
                scroll_x: Integer,
                scroll_y: Integer,
                x: Integer,
                y_: Integer,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The horizontal scroll distance.
              scroll_x:,
              # The vertical scroll distance.
              scroll_y:,
              # The x-coordinate where the scroll occurred.
              x:,
              # The y-coordinate where the scroll occurred.
              y_:,
              # Specifies the event type. For a scroll action, this property is always set to
              # `scroll`.
              type: :scroll
            )
            end

            sig do
              override.returns(
                {
                  scroll_x: Integer,
                  scroll_y: Integer,
                  type: Symbol,
                  x: Integer,
                  y_: Integer
                }
              )
            end
            def to_hash
            end
          end

          class Type < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

            # The text to type.
            sig { returns(String) }
            attr_accessor :text

            # Specifies the event type. For a type action, this property is always set to
            # `type`.
            sig { returns(Symbol) }
            attr_accessor :type

            # An action to type in text.
            sig { params(text: String, type: Symbol).returns(T.attached_class) }
            def self.new(
              # The text to type.
              text:,
              # Specifies the event type. For a type action, this property is always set to
              # `type`.
              type: :type
            )
            end

            sig { override.returns({ text: String, type: Symbol }) }
            def to_hash
            end
          end

          class Wait < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

            # Specifies the event type. For a wait action, this property is always set to
            # `wait`.
            sig { returns(Symbol) }
            attr_accessor :type

            # A wait action.
            sig { params(type: Symbol).returns(T.attached_class) }
            def self.new(
              # Specifies the event type. For a wait action, this property is always set to
              # `wait`.
              type: :wait
            )
            end

            sig { override.returns({ type: Symbol }) }
            def to_hash
            end
          end

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseComputerToolCall::Action::Variants
              ]
            )
          end
          def self.variants
          end
        end

        class PendingSafetyCheck < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

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
          sig do
            params(id: String, code: String, message: String).returns(
              T.attached_class
            )
          end
          def self.new(
            # The ID of the pending safety check.
            id:,
            # The type of the pending safety check.
            code:,
            # Details about the pending safety check.
            message:
          )
          end

          sig do
            override.returns({ id: String, code: String, message: String })
          end
          def to_hash
          end
        end

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        module Status
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ResponseComputerToolCall::Status)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          IN_PROGRESS =
            T.let(
              :in_progress,
              OpenAI::Responses::ResponseComputerToolCall::Status::TaggedSymbol
            )
          COMPLETED =
            T.let(
              :completed,
              OpenAI::Responses::ResponseComputerToolCall::Status::TaggedSymbol
            )
          INCOMPLETE =
            T.let(
              :incomplete,
              OpenAI::Responses::ResponseComputerToolCall::Status::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseComputerToolCall::Status::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        # The type of the computer call. Always `computer_call`.
        module Type
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Responses::ResponseComputerToolCall::Type)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          COMPUTER_CALL =
            T.let(
              :computer_call,
              OpenAI::Responses::ResponseComputerToolCall::Type::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Responses::ResponseComputerToolCall::Type::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
