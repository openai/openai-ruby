# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # Controls which (if any) tool is called by the model. `none` means the model will
      #   not call any tool and instead generates a message. `auto` means the model can
      #   pick between generating a message or calling one or more tools. `required` means
      #   the model must call one or more tools. Specifying a particular tool via
      #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
      #   call that tool.
      #
      #   `none` is the default when no tools are present. `auto` is the default if tools
      #   are present.
      module ChatCompletionToolChoiceOption
        extend OpenAI::Union

        # `none` means the model will not call any tool and instead generates a message. `auto` means the model can pick between generating a message or calling one or more tools. `required` means the model must call one or more tools.
        variant enum: -> { OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto }

        # Specifies a tool the model should use. Use to force the model to call a specific function.
        variant -> { OpenAI::Models::Chat::ChatCompletionNamedToolChoice }

        # `none` means the model will not call any tool and instead generates a message.
        #   `auto` means the model can pick between generating a message or calling one or
        #   more tools. `required` means the model must call one or more tools.
        module Auto
          extend OpenAI::Enum

          NONE = :none
          AUTO = :auto
          REQUIRED = :required

          finalize!

          # @!parse
          #   # @return [Array<Symbol>]
          #   def self.values; end
        end

        # @!parse
        #   # @return [Array(Symbol, OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto, OpenAI::Models::Chat::ChatCompletionNamedToolChoice)]
        #   def self.variants; end
      end
    end

    ChatCompletionToolChoiceOption = Chat::ChatCompletionToolChoiceOption
  end
end
