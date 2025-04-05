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

        # `none` means the model will not call any tools and instead generates a message.
        # `auto` means the model can pick between generating a message or calling one or
        # more tools. `required` means the model must call one or more tools before
        # responding to the user.
        module Auto
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto) }
          OrSymbol =
            T.type_alias { T.any(Symbol, String, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto::TaggedSymbol) }

          NONE = T.let(:none, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto::TaggedSymbol)
          AUTO = T.let(:auto, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto::TaggedSymbol)
          REQUIRED = T.let(:required, OpenAI::Models::Beta::AssistantToolChoiceOption::Auto::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Models::Beta::AssistantToolChoiceOption::Auto::TaggedSymbol]) }
          def self.values; end
        end

        sig do
          override
            .returns(
              [OpenAI::Models::Beta::AssistantToolChoiceOption::Auto::OrSymbol, OpenAI::Models::Beta::AssistantToolChoice]
            )
        end
        def self.variants; end
      end
    end
  end
end
