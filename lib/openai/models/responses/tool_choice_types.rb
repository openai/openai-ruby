# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ToolChoiceTypes < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #   The type of hosted tool the model should to use. Learn more about
        #   [built-in tools](https://platform.openai.com/docs/guides/tools).
        #
        #   Allowed values are:
        #
        #   - `file_search`
        #   - `web_search_preview`
        #   - `computer_use_preview`
        #   - `code_interpreter`
        #   - `mcp`
        #   - `image_generation`
        #
        #   @return [Symbol, OpenAI::Responses::ToolChoiceTypes::Type]
        required :type, enum: -> { OpenAI::Responses::ToolChoiceTypes::Type }

        # @!method initialize(type:)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Responses::ToolChoiceTypes} for more details.
        #
        #   Indicates that the model should use a built-in tool to generate a response.
        #   [Learn more about built-in tools](https://platform.openai.com/docs/guides/tools).
        #
        #   @param type [Symbol, OpenAI::Responses::ToolChoiceTypes::Type] The type of hosted tool the model should to use. Learn more about

        # The type of hosted tool the model should to use. Learn more about
        # [built-in tools](https://platform.openai.com/docs/guides/tools).
        #
        # Allowed values are:
        #
        # - `file_search`
        # - `web_search_preview`
        # - `computer_use_preview`
        # - `code_interpreter`
        # - `mcp`
        # - `image_generation`
        #
        # @see OpenAI::Responses::ToolChoiceTypes#type
        module Type
          extend OpenAI::Internal::Type::Enum

          FILE_SEARCH = :file_search
          WEB_SEARCH_PREVIEW = :web_search_preview
          COMPUTER_USE_PREVIEW = :computer_use_preview
          WEB_SEARCH_PREVIEW_2025_03_11 = :web_search_preview_2025_03_11
          IMAGE_GENERATION = :image_generation
          CODE_INTERPRETER = :code_interpreter
          MCP = :mcp

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end
  end
end
