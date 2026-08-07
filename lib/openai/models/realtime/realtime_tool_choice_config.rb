# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # How the model chooses tools. Provide one of the string modes or force a specific
      # function/MCP tool.
      module RealtimeToolChoiceConfig
        extend OpenAI::Internal::Type::Union

        # Controls which (if any) tool is called by the model.
        #
        # `none` means the model will not call any tool and instead generates a message.
        #
        # `auto` means the model can pick between generating a message or calling one or
        # more tools.
        #
        # `required` means the model must call one or more tools.
        variant enum: -> { OpenAI::Responses::ToolChoiceOptions }

        # Use this option to force the model to call a specific function.
        variant -> { OpenAI::Responses::ToolChoiceFunction }

        # Use this option to force the model to call a specific tool on a remote MCP server.
        variant -> { OpenAI::Responses::ToolChoiceMcp }

        # @!method self.variants
        #   @return [Array(Symbol, OpenAI::Models::Responses::ToolChoiceOptions, OpenAI::Models::Responses::ToolChoiceFunction, OpenAI::Models::Responses::ToolChoiceMcp)]
      end
    end
  end
end
