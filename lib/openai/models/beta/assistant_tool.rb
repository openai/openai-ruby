# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @abstract
      #
      class AssistantTool < OpenAI::Union
        discriminator :type

        variant :code_interpreter, -> { OpenAI::Models::Beta::CodeInterpreterTool }

        variant :file_search, -> { OpenAI::Models::Beta::FileSearchTool }

        variant :function, -> { OpenAI::Models::Beta::FunctionTool }
      end
    end
  end
end
