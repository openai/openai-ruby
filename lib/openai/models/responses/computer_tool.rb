# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ComputerTool < OpenAI::Internal::Type::BaseModel
        # @!attribute display_height
        #   The height of the computer display.
        #
        #   @return [Float]
        required :display_height, Float

        # @!attribute display_width
        #   The width of the computer display.
        #
        #   @return [Float]
        required :display_width, Float

        # @!attribute environment
        #   The type of computer environment to control.
        #
        #   @return [Symbol, OpenAI::Models::Responses::ComputerTool::Environment]
        required :environment, enum: -> { OpenAI::Models::Responses::ComputerTool::Environment }

        # @!attribute type
        #   The type of the computer use tool. Always `computer_use_preview`.
        #
        #   @return [Symbol, :computer_use_preview]
        required :type, const: :computer_use_preview

        # @!method initialize(display_height:, display_width:, environment:, type: :computer_use_preview)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ComputerTool} for more details.
        #
        #   A tool that controls a virtual computer. Learn more about the
        #   [computer tool](https://platform.openai.com/docs/guides/tools-computer-use).
        #
        #   @param display_height [Float] The height of the computer display. ...
        #
        #   @param display_width [Float] The width of the computer display. ...
        #
        #   @param environment [Symbol, OpenAI::Models::Responses::ComputerTool::Environment] The type of computer environment to control. ...
        #
        #   @param type [Symbol, :computer_use_preview] The type of the computer use tool. Always `computer_use_preview`. ...

        # The type of computer environment to control.
        #
        # @see OpenAI::Models::Responses::ComputerTool#environment
        module Environment
          extend OpenAI::Internal::Type::Enum

          MAC = :mac
          WINDOWS = :windows
          UBUNTU = :ubuntu
          BROWSER = :browser

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
