# typed: strong

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
      class ChatCompletionToolChoiceOption < OpenAI::Union
        abstract!

        Variants =
          type_template(:out) { {fixed: T.any(Symbol, OpenAI::Models::Chat::ChatCompletionNamedToolChoice)} }

        # `none` means the model will not call any tool and instead generates a message.
        #   `auto` means the model can pick between generating a message or calling one or
        #   more tools. `required` means the model must call one or more tools.
        class Auto < OpenAI::Enum
          abstract!

          Value = type_template(:out) { {fixed: Symbol} }

          NONE = :none
          AUTO = :auto
          REQUIRED = :required
        end
      end
    end

    ChatCompletionToolChoiceOption = Chat::ChatCompletionToolChoiceOption
  end
end
