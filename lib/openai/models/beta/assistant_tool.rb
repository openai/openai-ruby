# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module AssistantTool
        extend OpenAI::Internal::Type::Union

        discriminator :type

        variant :code_interpreter, -> { OpenAI::Beta::CodeInterpreterTool }

        variant :file_search, -> { OpenAI::Beta::FileSearchTool }

        variant :function, -> { OpenAI::Beta::FunctionTool }

        # @!method self.variants
        #   @return [Array(OpenAI::Beta::CodeInterpreterTool, OpenAI::Beta::FileSearchTool, OpenAI::Beta::FunctionTool)]

        define_sorbet_constant!(:Variants) do
          T.type_alias do
            T.any(OpenAI::Beta::CodeInterpreterTool, OpenAI::Beta::FileSearchTool, OpenAI::Beta::FunctionTool)
          end
        end
      end
    end
  end
end
