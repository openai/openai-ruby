# typed: strong

module OpenAI
  module Models
    module Responses
      # Controls which (if any) tool is called by the model.
      #
      #   `none` means the model will not call any tool and instead generates a message.
      #
      #   `auto` means the model can pick between generating a message or calling one or
      #   more tools.
      #
      #   `required` means the model must call one or more tools.
      class ToolChoiceOptions < OpenAI::Enum
        abstract!

        Value = type_template(:out) { {fixed: Symbol} }

        NONE = :none
        AUTO = :auto
        REQUIRED = :required
      end
    end
  end
end
