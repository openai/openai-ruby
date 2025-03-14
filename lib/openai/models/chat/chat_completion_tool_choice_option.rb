# frozen_string_literal: true

module OpenAI
  module Models
    module Chat
      # @abstract
      #
      # Controls which (if any) tool is called by the model. `none` means the model will
      #   not call any tool and instead generates a message. `auto` means the model can
      #   pick between generating a message or calling one or more tools. `required` means
      #   the model must call one or more tools. Specifying a particular tool via
      #   `{"type": "function", "function": {"name": "my_function"}}` forces the model to
      #   call that tool.
      #
      #   `none` is the default when no tools are present. `auto` is the default if tools
      #   are present.
      class ChatCompletionToolChoiceOption < OpenAI::Union
        # `none` means the model will not call any tool and instead generates a message. `auto` means the model can pick between generating a message or calling one or more tools. `required` means the model must call one or more tools.
        variant enum: -> { OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto }

        # Specifies a tool the model should use. Use to force the model to call a specific function.
        variant -> { OpenAI::Models::Chat::ChatCompletionNamedToolChoice }

        # @abstract
        #
        # `none` means the model will not call any tool and instead generates a message.
        #   `auto` means the model can pick between generating a message or calling one or
        #   more tools. `required` means the model must call one or more tools.
        class Auto < OpenAI::Enum
          NONE = :none
          AUTO = :auto
          REQUIRED = :required

          finalize!
        end

        # @!parse
        #   class << self
        #     # @return [Array(Symbol, OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto, OpenAI::Models::Chat::ChatCompletionNamedToolChoice)]
        #     def variants; end
        #   end
      end
    end

    ChatCompletionToolChoiceOption = Chat::ChatCompletionToolChoiceOption
  end
end
