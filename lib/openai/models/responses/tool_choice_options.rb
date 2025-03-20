# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # @abstract
      #
      # Controls which (if any) tool is called by the model.
      #
      #   `none` means the model will not call any tool and instead generates a message.
      #
      #   `auto` means the model can pick between generating a message or calling one or
      #   more tools.
      #
      #   `required` means the model must call one or more tools.
      class ToolChoiceOptions < OpenAI::Enum
        NONE = :none
        AUTO = :auto
        REQUIRED = :required

        finalize!
      end
    end
  end
end
