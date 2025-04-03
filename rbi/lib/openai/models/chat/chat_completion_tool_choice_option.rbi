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
      module ChatCompletionToolChoiceOption
        extend OpenAI::Internal::Type::Union

        # `none` means the model will not call any tool and instead generates a message.
        #   `auto` means the model can pick between generating a message or calling one or
        #   more tools. `required` means the model must call one or more tools.
        module Auto
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto::TaggedSymbol) }

          NONE = T.let(:none, OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto::TaggedSymbol)
          AUTO = T.let(:auto, OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto::TaggedSymbol)
          REQUIRED = T.let(:required, OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto::TaggedSymbol]) }
          def self.values
          end
        end

        sig do
          override
            .returns(
              [OpenAI::Models::Chat::ChatCompletionToolChoiceOption::Auto::OrSymbol, OpenAI::Models::Chat::ChatCompletionNamedToolChoice]
            )
        end
        def self.variants
        end
      end
    end

    ChatCompletionToolChoiceOption = Chat::ChatCompletionToolChoiceOption
  end
end
