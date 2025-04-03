# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module AssistantTool
        extend OpenAI::Internal::Type::Union

        discriminator :type

        variant :code_interpreter, -> { OpenAI::Models::Beta::CodeInterpreterTool }

        variant :file_search, -> { OpenAI::Models::Beta::FileSearchTool }

        variant :function, -> { OpenAI::Models::Beta::FunctionTool }

        # @!parse
        #   # @return [Array(OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool)]
        #   def self.variants; end
      end
    end
  end
end
