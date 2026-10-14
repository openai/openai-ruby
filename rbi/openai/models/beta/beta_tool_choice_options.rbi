# typed: strong

module OpenAI
  module Models
    BetaToolChoiceOptions = Beta::BetaToolChoiceOptions

    module Beta
      # Controls which (if any) tool is called by the model.
      #
      # `none` means the model will not call any tool and instead generates a message.
      #
      # `auto` means the model can pick between generating a message or calling one or
      # more tools.
      #
      # `required` means the model must call one or more tools.
      module BetaToolChoiceOptions
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Beta::BetaToolChoiceOptions) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        NONE = T.let(:none, OpenAI::Beta::BetaToolChoiceOptions::TaggedSymbol)
        AUTO = T.let(:auto, OpenAI::Beta::BetaToolChoiceOptions::TaggedSymbol)
        REQUIRED =
          T.let(:required, OpenAI::Beta::BetaToolChoiceOptions::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::Beta::BetaToolChoiceOptions::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end
