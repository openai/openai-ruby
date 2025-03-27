# frozen_string_literal: true

module OpenAI
  module Models
    module AllModels
      extend OpenAI::Union

      variant String

      variant enum: -> { OpenAI::Models::ChatModel }

      variant const: -> { OpenAI::Models::AllModels::O1_PRO }

      variant const: -> { OpenAI::Models::AllModels::O1_PRO_2025_03_19 }

      variant const: -> { OpenAI::Models::AllModels::COMPUTER_USE_PREVIEW }

      variant const: -> { OpenAI::Models::AllModels::COMPUTER_USE_PREVIEW_2025_03_11 }

      # @!parse
      #   # @return [Array(String, Symbol, OpenAI::Models::ChatModel, Symbol)]
      #   def self.variants; end

      # @!group

      O1_PRO = :"o1-pro"
      O1_PRO_2025_03_19 = :"o1-pro-2025-03-19"
      COMPUTER_USE_PREVIEW = :"computer-use-preview"
      COMPUTER_USE_PREVIEW_2025_03_11 = :"computer-use-preview-2025-03-11"

      # @!endgroup
    end
  end
end
