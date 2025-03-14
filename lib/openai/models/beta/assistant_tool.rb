# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @abstract
      class AssistantTool < OpenAI::Union
        discriminator :type

        variant :code_interpreter, -> { OpenAI::Models::Beta::CodeInterpreterTool }

        variant :file_search, -> { OpenAI::Models::Beta::FileSearchTool }

        variant :function, -> { OpenAI::Models::Beta::FunctionTool }

        # @!parse
        #   class << self
        #     # @return [Array(OpenAI::Models::Beta::CodeInterpreterTool, OpenAI::Models::Beta::FileSearchTool, OpenAI::Models::Beta::FunctionTool)]
        #     def variants; end
        #   end
      end
    end
  end
end
