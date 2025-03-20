# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ToolChoiceTypes < OpenAI::BaseModel
        # @!attribute type
        #   The type of hosted tool the model should to use. Learn more about
        #     [built-in tools](https://platform.openai.com/docs/guides/tools).
        #
        #     Allowed values are:
        #
        #     - `file_search`
        #     - `web_search_preview`
        #     - `computer_use_preview`
        #
        #   @return [Symbol, OpenAI::Models::Responses::ToolChoiceTypes::Type]
        required :type, enum: -> { OpenAI::Models::Responses::ToolChoiceTypes::Type }

        # @!parse
        #   # Indicates that the model should use a built-in tool to generate a response.
        #   #   [Learn more about built-in tools](https://platform.openai.com/docs/guides/tools).
        #   #
        #   # @param type [Symbol, OpenAI::Models::Responses::ToolChoiceTypes::Type]
        #   #
        #   def initialize(type:, **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # The type of hosted tool the model should to use. Learn more about
        #   [built-in tools](https://platform.openai.com/docs/guides/tools).
        #
        #   Allowed values are:
        #
        #   - `file_search`
        #   - `web_search_preview`
        #   - `computer_use_preview`
        module Type
          extend OpenAI::Enum

          FILE_SEARCH = :file_search
          WEB_SEARCH_PREVIEW = :web_search_preview
          COMPUTER_USE_PREVIEW = :computer_use_preview
          WEB_SEARCH_PREVIEW_2025_03_11 = :web_search_preview_2025_03_11

          finalize!

          class << self
            # @!parse
            #   # @return [Array<Symbol>]
            #   def values; end
          end
        end
      end
    end
  end
end
