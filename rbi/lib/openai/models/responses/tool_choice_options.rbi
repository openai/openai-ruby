# typed: strong

module OpenAI
  module Models
    module Responses
      # Controls which (if any) tool is called by the model.
      #
      #   `none` means the model will not call any tool and instead generates a message.
      #
      #   `auto` means the model can pick between generating a message or calling one or
      #   more tools.
      #
      #   `required` means the model must call one or more tools.
      module ToolChoiceOptions
        extend OpenAI::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ToolChoiceOptions) }
        OrSymbol = T.type_alias { T.any(Symbol, OpenAI::Models::Responses::ToolChoiceOptions::TaggedSymbol) }

        NONE = T.let(:none, OpenAI::Models::Responses::ToolChoiceOptions::OrSymbol)
        AUTO = T.let(:auto, OpenAI::Models::Responses::ToolChoiceOptions::OrSymbol)
        REQUIRED = T.let(:required, OpenAI::Models::Responses::ToolChoiceOptions::OrSymbol)
      end
    end
  end
end
