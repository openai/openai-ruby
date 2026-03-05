# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # A click action.
      module ComputerAction
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A click action.
        variant :click, -> { OpenAI::Responses::ComputerAction::Click }

        # A double click action.
        variant :double_click, -> { OpenAI::Responses::ComputerAction::DoubleClick }

        # A drag action.
        variant :drag, -> { OpenAI::Responses::ComputerAction::Drag }

        # A collection of keypresses the model would like to perform.
        variant :keypress, -> { OpenAI::Responses::ComputerAction::Keypress }

        # A mouse move action.
        variant :move, -> { OpenAI::Responses::ComputerAction::Move }

        # A screenshot action.
        variant :screenshot, -> { OpenAI::Responses::ComputerAction::Screenshot }

        # A scroll action.
        variant :scroll, -> { OpenAI::Responses::ComputerAction::Scroll }

        # An action to type in text.
        variant :type, -> { OpenAI::Responses::ComputerAction::Type }

        # A wait action.
        variant :wait, -> { OpenAI::Responses::ComputerAction::Wait }

        class Click < OpenAI::Internal::Type::BaseModel
          # @!attribute button
          #   Indicates which mouse button was pressed during the click. One of `left`,
          #   `right`, `wheel`, `back`, or `forward`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::ComputerAction::Click::Button]
          required :button, enum: -> { OpenAI::Responses::ComputerAction::Click::Button }

          # @!attribute type
          #   Specifies the event type. For a click action, this property is always `click`.
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
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ComputerAction::Click} for more details.
          #
          #   A click action.
          #
          #   @param button [Symbol, OpenAI::Models::Responses::ComputerAction::Click::Button] Indicates which mouse button was pressed during the click. One of `left`, `right
          #
          #   @param x [Integer] The x-coordinate where the click occurred.
          #
          #   @param y_ [Integer] The y-coordinate where the click occurred.
          #
          #   @param type [Symbol, :click] Specifies the event type. For a click action, this property is always `click`.

          # Indicates which mouse button was pressed during the click. One of `left`,
          # `right`, `wheel`, `back`, or `forward`.
          #
          # @see OpenAI::Models::Responses::ComputerAction::Click#button
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
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ComputerAction::DoubleClick} for more details.
          #
          #   A double click action.
          #
          #   @param x [Integer] The x-coordinate where the double click occurred.
          #
          #   @param y_ [Integer] The y-coordinate where the double click occurred.
          #
          #   @param type [Symbol, :double_click] Specifies the event type. For a double click action, this property is always set
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
          #   @return [Array<OpenAI::Models::Responses::ComputerAction::Drag::Path>]
          required :path, -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Responses::ComputerAction::Drag::Path] }

          # @!attribute type
          #   Specifies the event type. For a drag action, this property is always set to
          #   `drag`.
          #
          #   @return [Symbol, :drag]
          required :type, const: :drag

          # @!method initialize(path:, type: :drag)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ComputerAction::Drag} for more details.
          #
          #   A drag action.
          #
          #   @param path [Array<OpenAI::Models::Responses::ComputerAction::Drag::Path>] An array of coordinates representing the path of the drag action. Coordinates wi
          #
          #   @param type [Symbol, :drag] Specifies the event type. For a drag action, this property is always set to `dra

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
            #   An x/y coordinate pair, e.g. `{ x: 100, y: 200 }`.
            #
            #   @param x [Integer] The x-coordinate.
            #
            #   @param y_ [Integer] The y-coordinate.
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
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ComputerAction::Keypress} for more details.
          #
          #   A collection of keypresses the model would like to perform.
          #
          #   @param keys [Array<String>] The combination of keys the model is requesting to be pressed. This is an array
          #
          #   @param type [Symbol, :keypress] Specifies the event type. For a keypress action, this property is always set to
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
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ComputerAction::Move} for more details.
          #
          #   A mouse move action.
          #
          #   @param x [Integer] The x-coordinate to move to.
          #
          #   @param y_ [Integer] The y-coordinate to move to.
          #
          #   @param type [Symbol, :move] Specifies the event type. For a move action, this property is always set to `mov
        end

        class Screenshot < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   Specifies the event type. For a screenshot action, this property is always set
          #   to `screenshot`.
          #
          #   @return [Symbol, :screenshot]
          required :type, const: :screenshot

          # @!method initialize(type: :screenshot)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ComputerAction::Screenshot} for more details.
          #
          #   A screenshot action.
          #
          #   @param type [Symbol, :screenshot] Specifies the event type. For a screenshot action, this property is always set t
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
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ComputerAction::Scroll} for more details.
          #
          #   A scroll action.
          #
          #   @param scroll_x [Integer] The horizontal scroll distance.
          #
          #   @param scroll_y [Integer] The vertical scroll distance.
          #
          #   @param x [Integer] The x-coordinate where the scroll occurred.
          #
          #   @param y_ [Integer] The y-coordinate where the scroll occurred.
          #
          #   @param type [Symbol, :scroll] Specifies the event type. For a scroll action, this property is always set to `s
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
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ComputerAction::Type} for more details.
          #
          #   An action to type in text.
          #
          #   @param text [String] The text to type.
          #
          #   @param type [Symbol, :type] Specifies the event type. For a type action, this property is always set to `typ
        end

        class Wait < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   Specifies the event type. For a wait action, this property is always set to
          #   `wait`.
          #
          #   @return [Symbol, :wait]
          required :type, const: :wait

          # @!method initialize(type: :wait)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::ComputerAction::Wait} for more details.
          #
          #   A wait action.
          #
          #   @param type [Symbol, :wait] Specifies the event type. For a wait action, this property is always set to `wai
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Responses::ComputerAction::Click, OpenAI::Models::Responses::ComputerAction::DoubleClick, OpenAI::Models::Responses::ComputerAction::Drag, OpenAI::Models::Responses::ComputerAction::Keypress, OpenAI::Models::Responses::ComputerAction::Move, OpenAI::Models::Responses::ComputerAction::Screenshot, OpenAI::Models::Responses::ComputerAction::Scroll, OpenAI::Models::Responses::ComputerAction::Type, OpenAI::Models::Responses::ComputerAction::Wait)]
      end
    end
  end
end
