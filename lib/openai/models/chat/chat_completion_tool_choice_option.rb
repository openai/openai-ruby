# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # Controls which (if any) tool is called by the model. `none` means the model will
      # not call any tool and instead generates a message. `auto` means the model can
      # pick between generating a message or calling one or more tools. `required` means
      # the model must call one or more tools. Specifying a particular tool via
      # `{"type": "function", "function": {"name": "my_function"}}` forces the model to
      # call that tool.
      #
      # `none` is the default when no tools are present. `auto` is the default if tools
      # are present.
      module ChatCompletionToolChoiceOption
        extend OpenAI::Internal::Type::Union

        # `none` means the model will not call any tool and instead generates a message. `auto` means the model can pick between generating a message or calling one or more tools. `required` means the model must call one or more tools.
        variant enum: -> { OpenAI::Chat::ChatCompletionToolChoiceOption::Auto }

        # Specifies a tool the model should use. Use to force the model to call a specific function.
        variant -> { OpenAI::Chat::ChatCompletionNamedToolChoice }

        # `none` means the model will not call any tool and instead generates a message.
        # `auto` means the model can pick between generating a message or calling one or
        # more tools. `required` means the model must call one or more tools.
        module Auto
          extend OpenAI::Internal::Type::Enum

          NONE = :none
          AUTO = :auto
          REQUIRED = :required

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # @!method self.variants
        #   @return [Array(Symbol, OpenAI::Chat::ChatCompletionToolChoiceOption::Auto, OpenAI::Chat::ChatCompletionNamedToolChoice)]
      end
    end

    ChatCompletionToolChoiceOption = Chat::ChatCompletionToolChoiceOption
  end
end
