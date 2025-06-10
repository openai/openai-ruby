# frozen_string_literal: true

module OpenAI
  module Models
    module AllModels
      extend OpenAI::Internal::Type::Union

      variant String

      variant enum: -> { OpenAI::ChatModel }

      variant enum: -> { OpenAI::AllModels::ResponsesOnlyModel }

      module ResponsesOnlyModel
        extend OpenAI::Internal::Type::Enum

        O1_PRO = :"o1-pro"
        O1_PRO_2025_03_19 = :"o1-pro-2025-03-19"
        O3_PRO = :"o3-pro"
        O3_PRO_2025_06_10 = :"o3-pro-2025-06-10"
        COMPUTER_USE_PREVIEW = :"computer-use-preview"
        COMPUTER_USE_PREVIEW_2025_03_11 = :"computer-use-preview-2025-03-11"

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # @!method self.variants
      #   @return [Array(String, Symbol, OpenAI::Models::ChatModel, Symbol, OpenAI::Models::AllModels::ResponsesOnlyModel)]
    end
  end
end
