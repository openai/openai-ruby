# typed: strong

module OpenAI
  module Models
    module Responses
      # Controls which (if any) tool is called by the model.
      #
      # `none` means the model will not call any tool and instead generates a message.
      #
      # `auto` means the model can pick between generating a message or calling one or
      # more tools.
      #
      # `required` means the model must call one or more tools.
      module ToolChoiceOptions
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Responses::ToolChoiceOptions) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        NONE = T.let(:none, OpenAI::Responses::ToolChoiceOptions::TaggedSymbol)
        AUTO = T.let(:auto, OpenAI::Responses::ToolChoiceOptions::TaggedSymbol)
        REQUIRED =
          T.let(:required, OpenAI::Responses::ToolChoiceOptions::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::Responses::ToolChoiceOptions::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end
