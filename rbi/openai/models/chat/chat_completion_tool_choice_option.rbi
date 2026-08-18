# typed: strong

module OpenAI
  module Models
    ChatCompletionToolChoiceOption = Chat::ChatCompletionToolChoiceOption

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

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Chat::ChatCompletionToolChoiceOption::Auto::TaggedSymbol,
              OpenAI::Chat::ChatCompletionAllowedToolChoice,
              OpenAI::Chat::ChatCompletionNamedToolChoice,
              OpenAI::Chat::ChatCompletionNamedToolChoiceCustom
            )
          end

        # `none` means the model will not call any tool and instead generates a message.
        # `auto` means the model can pick between generating a message or calling one or
        # more tools. `required` means the model must call one or more tools.
        module Auto
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Chat::ChatCompletionToolChoiceOption::Auto)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          NONE =
            T.let(
              :none,
              OpenAI::Chat::ChatCompletionToolChoiceOption::Auto::TaggedSymbol
            )
          AUTO =
            T.let(
              :auto,
              OpenAI::Chat::ChatCompletionToolChoiceOption::Auto::TaggedSymbol
            )
          REQUIRED =
            T.let(
              :required,
              OpenAI::Chat::ChatCompletionToolChoiceOption::Auto::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Chat::ChatCompletionToolChoiceOption::Auto::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        sig do
          override.returns(
            T::Array[OpenAI::Chat::ChatCompletionToolChoiceOption::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
