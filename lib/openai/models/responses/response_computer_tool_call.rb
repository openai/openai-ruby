# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ResponseComputerToolCall < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the computer call.
        #
        #   @return [String]
        required :id, String

        # @!attribute action
        #   A click action.
        #
        #   @return [OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click, OpenAI::Models::Responses::ResponseComputerToolCall::Action::DoubleClick, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Keypress, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Move, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Screenshot, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Scroll, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Type, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Wait]
        required :action, union: -> { OpenAI::Models::Responses::ResponseComputerToolCall::Action }

        # @!attribute call_id
        #   An identifier used when responding to the tool call with output.
        #
        #   @return [String]
        required :call_id, String

        # @!attribute pending_safety_checks
        #   The pending safety checks for the computer call.
        #
        #   @return [Array<OpenAI::Models::Responses::ResponseComputerToolCall::PendingSafetyCheck>]
        required :pending_safety_checks,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Responses::ResponseComputerToolCall::PendingSafetyCheck] }

        # @!attribute status
        #   The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        #   Populated when items are returned via API.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Status]
        required :status, enum: -> { OpenAI::Models::Responses::ResponseComputerToolCall::Status }

        # @!attribute type
        #   The type of the computer call. Always `computer_call`.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Type]
        required :type, enum: -> { OpenAI::Models::Responses::ResponseComputerToolCall::Type }

        # @!method initialize(id:, action:, call_id:, pending_safety_checks:, status:, type:)
        #   A tool call to a computer use tool. See the
        #   [computer use guide](https://platform.openai.com/docs/guides/tools-computer-use)
        #   for more information.
        #
        #   @param id [String]
        #   @param action [OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click, OpenAI::Models::Responses::ResponseComputerToolCall::Action::DoubleClick, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Keypress, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Move, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Screenshot, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Scroll, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Type, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Wait]
        #   @param call_id [String]
        #   @param pending_safety_checks [Array<OpenAI::Models::Responses::ResponseComputerToolCall::PendingSafetyCheck>]
        #   @param status [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Status]
        #   @param type [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Type]

        # A click action.
        #
        # @see OpenAI::Models::Responses::ResponseComputerToolCall#action
        module Action
          extend OpenAI::Internal::Type::Union

          discriminator :type

          # A click action.
          variant :click, -> { OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click }

          # A double click action.
          variant :double_click, -> { OpenAI::Models::Responses::ResponseComputerToolCall::Action::DoubleClick }

          # A drag action.
          variant :drag, -> { OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag }

          # A collection of keypresses the model would like to perform.
          variant :keypress, -> { OpenAI::Models::Responses::ResponseComputerToolCall::Action::Keypress }

          # A mouse move action.
          variant :move, -> { OpenAI::Models::Responses::ResponseComputerToolCall::Action::Move }

          # A screenshot action.
          variant :screenshot, -> { OpenAI::Models::Responses::ResponseComputerToolCall::Action::Screenshot }

          # A scroll action.
          variant :scroll, -> { OpenAI::Models::Responses::ResponseComputerToolCall::Action::Scroll }

          # An action to type in text.
          variant :type, -> { OpenAI::Models::Responses::ResponseComputerToolCall::Action::Type }

          # A wait action.
          variant :wait, -> { OpenAI::Models::Responses::ResponseComputerToolCall::Action::Wait }

          class Click < OpenAI::Internal::Type::BaseModel
            # @!attribute button
            #   Indicates which mouse button was pressed during the click. One of `left`,
            #   `right`, `wheel`, `back`, or `forward`.
            #
            #   @return [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click::Button]
            required :button, enum: -> { OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click::Button }

            # @!attribute type
            #   Specifies the event type. For a click action, this property is always set to
            #   `click`.
            #
            #   @return [Symbol, :click]
            required :type, const: :click

            # @!attribute x
            #   The x-coordinate where the click occurred.
            #
            #   @return [Integer]
            required :x, Integer

            # @!attribute y_
            #   The y-coordinate where the click occurred.
            #
            #   @return [Integer]
            required :y_, Integer, api_name: :y

            # @!method initialize(button:, x:, y_:, type: :click)
            #   A click action.
            #
            #   @param button [Symbol, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click::Button]
            #   @param x [Integer]
            #   @param y_ [Integer]
            #   @param type [Symbol, :click]

            # Indicates which mouse button was pressed during the click. One of `left`,
            # `right`, `wheel`, `back`, or `forward`.
            #
            # @see OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click#button
            module Button
              extend OpenAI::Internal::Type::Enum

              LEFT = :left
              RIGHT = :right
              WHEEL = :wheel
              BACK = :back
              FORWARD = :forward

              # @!method self.values
              #   @return [Array<Symbol>]
            end
          end

          class DoubleClick < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   Specifies the event type. For a double click action, this property is always set
            #   to `double_click`.
            #
            #   @return [Symbol, :double_click]
            required :type, const: :double_click

            # @!attribute x
            #   The x-coordinate where the double click occurred.
            #
            #   @return [Integer]
            required :x, Integer

            # @!attribute y_
            #   The y-coordinate where the double click occurred.
            #
            #   @return [Integer]
            required :y_, Integer, api_name: :y

            # @!method initialize(x:, y_:, type: :double_click)
            #   A double click action.
            #
            #   @param x [Integer]
            #   @param y_ [Integer]
            #   @param type [Symbol, :double_click]
          end

          class Drag < OpenAI::Internal::Type::BaseModel
            # @!attribute path
            #   An array of coordinates representing the path of the drag action. Coordinates
            #   will appear as an array of objects, eg
            #
            #   ```
            #   [
            #     { x: 100, y: 200 },
            #     { x: 200, y: 300 }
            #   ]
            #   ```
            #
            #   @return [Array<OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag::Path>]
            required :path,
                     -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag::Path] }

            # @!attribute type
            #   Specifies the event type. For a drag action, this property is always set to
            #   `drag`.
            #
            #   @return [Symbol, :drag]
            required :type, const: :drag

            # @!method initialize(path:, type: :drag)
            #   A drag action.
            #
            #   @param path [Array<OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag::Path>]
            #   @param type [Symbol, :drag]

            class Path < OpenAI::Internal::Type::BaseModel
              # @!attribute x
              #   The x-coordinate.
              #
              #   @return [Integer]
              required :x, Integer

              # @!attribute y_
              #   The y-coordinate.
              #
              #   @return [Integer]
              required :y_, Integer, api_name: :y

              # @!method initialize(x:, y_:)
              #   A series of x/y coordinate pairs in the drag path.
              #
              #   @param x [Integer]
              #   @param y_ [Integer]
            end
          end

          class Keypress < OpenAI::Internal::Type::BaseModel
            # @!attribute keys
            #   The combination of keys the model is requesting to be pressed. This is an array
            #   of strings, each representing a key.
            #
            #   @return [Array<String>]
            required :keys, OpenAI::Internal::Type::ArrayOf[String]

            # @!attribute type
            #   Specifies the event type. For a keypress action, this property is always set to
            #   `keypress`.
            #
            #   @return [Symbol, :keypress]
            required :type, const: :keypress

            # @!method initialize(keys:, type: :keypress)
            #   A collection of keypresses the model would like to perform.
            #
            #   @param keys [Array<String>]
            #   @param type [Symbol, :keypress]
          end

          class Move < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   Specifies the event type. For a move action, this property is always set to
            #   `move`.
            #
            #   @return [Symbol, :move]
            required :type, const: :move

            # @!attribute x
            #   The x-coordinate to move to.
            #
            #   @return [Integer]
            required :x, Integer

            # @!attribute y_
            #   The y-coordinate to move to.
            #
            #   @return [Integer]
            required :y_, Integer, api_name: :y

            # @!method initialize(x:, y_:, type: :move)
            #   A mouse move action.
            #
            #   @param x [Integer]
            #   @param y_ [Integer]
            #   @param type [Symbol, :move]
          end

          class Screenshot < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   Specifies the event type. For a screenshot action, this property is always set
            #   to `screenshot`.
            #
            #   @return [Symbol, :screenshot]
            required :type, const: :screenshot

            # @!method initialize(type: :screenshot)
            #   A screenshot action.
            #
            #   @param type [Symbol, :screenshot]
          end

          class Scroll < OpenAI::Internal::Type::BaseModel
            # @!attribute scroll_x
            #   The horizontal scroll distance.
            #
            #   @return [Integer]
            required :scroll_x, Integer

            # @!attribute scroll_y
            #   The vertical scroll distance.
            #
            #   @return [Integer]
            required :scroll_y, Integer

            # @!attribute type
            #   Specifies the event type. For a scroll action, this property is always set to
            #   `scroll`.
            #
            #   @return [Symbol, :scroll]
            required :type, const: :scroll

            # @!attribute x
            #   The x-coordinate where the scroll occurred.
            #
            #   @return [Integer]
            required :x, Integer

            # @!attribute y_
            #   The y-coordinate where the scroll occurred.
            #
            #   @return [Integer]
            required :y_, Integer, api_name: :y

            # @!method initialize(scroll_x:, scroll_y:, x:, y_:, type: :scroll)
            #   A scroll action.
            #
            #   @param scroll_x [Integer]
            #   @param scroll_y [Integer]
            #   @param x [Integer]
            #   @param y_ [Integer]
            #   @param type [Symbol, :scroll]
          end

          class Type < OpenAI::Internal::Type::BaseModel
            # @!attribute text
            #   The text to type.
            #
            #   @return [String]
            required :text, String

            # @!attribute type
            #   Specifies the event type. For a type action, this property is always set to
            #   `type`.
            #
            #   @return [Symbol, :type]
            required :type, const: :type

            # @!method initialize(text:, type: :type)
            #   An action to type in text.
            #
            #   @param text [String]
            #   @param type [Symbol, :type]
          end

          class Wait < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   Specifies the event type. For a wait action, this property is always set to
            #   `wait`.
            #
            #   @return [Symbol, :wait]
            required :type, const: :wait

            # @!method initialize(type: :wait)
            #   A wait action.
            #
            #   @param type [Symbol, :wait]
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Responses::ResponseComputerToolCall::Action::Click, OpenAI::Models::Responses::ResponseComputerToolCall::Action::DoubleClick, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Drag, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Keypress, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Move, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Screenshot, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Scroll, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Type, OpenAI::Models::Responses::ResponseComputerToolCall::Action::Wait)]
        end

        class PendingSafetyCheck < OpenAI::Internal::Type::BaseModel
          # @!attribute id
          #   The ID of the pending safety check.
          #
          #   @return [String]
          required :id, String

          # @!attribute code
          #   The type of the pending safety check.
          #
          #   @return [String]
          required :code, String

          # @!attribute message
          #   Details about the pending safety check.
          #
          #   @return [String]
          required :message, String

          # @!method initialize(id:, code:, message:)
          #   A pending safety check for the computer call.
          #
          #   @param id [String]
          #   @param code [String]
          #   @param message [String]
        end

        # The status of the item. One of `in_progress`, `completed`, or `incomplete`.
        # Populated when items are returned via API.
        #
        # @see OpenAI::Models::Responses::ResponseComputerToolCall#status
        module Status
          extend OpenAI::Internal::Type::Enum

          IN_PROGRESS = :in_progress
          COMPLETED = :completed
          INCOMPLETE = :incomplete

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The type of the computer call. Always `computer_call`.
        #
        # @see OpenAI::Models::Responses::ResponseComputerToolCall#type
        module Type
          extend OpenAI::Internal::Type::Enum

          COMPUTER_CALL = :computer_call

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
