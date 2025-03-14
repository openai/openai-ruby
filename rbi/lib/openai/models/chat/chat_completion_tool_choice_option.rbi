# typed: strong

module OpenAI
  module Models
    ChatCompletionToolChoiceOption = T.type_alias { Chat::ChatCompletionToolChoiceOption }

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

        # `none` means the model will not call any tool and instead generates a message.
        #   `auto` means the model can pick between generating a message or calling one or
        #   more tools. `required` means the model must call one or more tools.
        class Auto < OpenAI::Enum
          abstract!

          NONE = :none
          AUTO = :auto
          REQUIRED = :required

          class << self
            sig { override.returns(T::Array[Symbol]) }
            def values
            end
          end
        end

        class << self
          # @api private
          sig { override.returns([[NilClass, Symbol], [NilClass, OpenAI::Models::Chat::ChatCompletionNamedToolChoice]]) }
          private def variants
          end
        end
      end
    end
  end
end
