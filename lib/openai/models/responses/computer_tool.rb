# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ComputerTool < OpenAI::BaseModel
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

        # @!parse
        #   # A tool that controls a virtual computer. Learn more about the
        #   #   [computer tool](https://platform.openai.com/docs/guides/tools-computer-use).
        #   #
        #   # @param display_height [Float]
        #   # @param display_width [Float]
        #   # @param environment [Symbol, OpenAI::Models::Responses::ComputerTool::Environment]
        #   # @param type [Symbol, :computer_use_preview]
        #   #
        #   def initialize(display_height:, display_width:, environment:, type: :computer_use_preview, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # @abstract
        #
        # The type of computer environment to control.
        class Environment < OpenAI::Enum
          MAC = :mac
          WINDOWS = :windows
          UBUNTU = :ubuntu
          BROWSER = :browser

          finalize!
        end
      end
    end
  end
end
