# typed: strong

module OpenAI
  module Models
    module Beta
      # Controls which (if any) tool is called by the model. `none` means the model will
      # not call any tools and instead generates a message. `auto` is the default value
      # and means the model can pick between generating a message or calling one or more
      # tools. `required` means the model must call one or more tools before responding
      # to the user. Specifying a particular tool like `{"type": "file_search"}` or
      # `{"type": "function", "function": {"name": "my_function"}}` forces the model to
      # call that tool.
      module AssistantToolChoiceOption
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Beta::AssistantToolChoiceOption::Auto::TaggedSymbol,
              OpenAI::Beta::AssistantToolChoice
            )
          end

        # `none` means the model will not call any tools and instead generates a message.
        # `auto` means the model can pick between generating a message or calling one or
        # more tools. `required` means the model must call one or more tools before
        # responding to the user.
        module Auto
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias do
              T.all(Symbol, OpenAI::Beta::AssistantToolChoiceOption::Auto)
            end
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          NONE =
            T.let(
              :none,
              OpenAI::Beta::AssistantToolChoiceOption::Auto::TaggedSymbol
            )
          AUTO =
            T.let(
              :auto,
              OpenAI::Beta::AssistantToolChoiceOption::Auto::TaggedSymbol
            )
          REQUIRED =
            T.let(
              :required,
              OpenAI::Beta::AssistantToolChoiceOption::Auto::TaggedSymbol
            )

          sig do
            override.returns(
              T::Array[
                OpenAI::Beta::AssistantToolChoiceOption::Auto::TaggedSymbol
              ]
            )
          end
          def self.values
          end
        end

        sig do
          override.returns(
            T::Array[OpenAI::Beta::AssistantToolChoiceOption::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
