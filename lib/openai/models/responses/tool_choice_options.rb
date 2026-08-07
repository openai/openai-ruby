# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # Controls which (if any) tool is called by the model.
      #
      # `none` means the model will not call any tool and instead generates a message.
      #
      # `auto` means the model can pick between generating a message or calling one or
      # more tools.
      #
      # `required` means the model must call one or more tools.
      module ToolChoiceOptions
        extend OpenAI::Internal::Type::Enum

        NONE = :none
        AUTO = :auto
        REQUIRED = :required

        # @!method self.values
        #   @return [Array<Symbol>]
      end
    end
  end
end
