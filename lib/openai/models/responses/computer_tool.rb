# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ComputerTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of the computer tool. Always `computer`.
        #
        #   @return [Symbol, :computer]
        required :type, const: :computer

        # @!method initialize(type: :computer)
        #   A tool that controls a virtual computer. Learn more about the
        #   [computer tool](https://platform.openai.com/docs/guides/tools-computer-use).
        #
        #   @param type [Symbol, :computer] The type of the computer tool. Always `computer`.
      end
    end
  end
end
