# frozen_string_literal: true

module OpenAI
  module Models
    module ResponsesModel
      extend OpenAI::Internal::Type::Union

      variant String

      variant enum: -> { OpenAI::Models::ChatModel }

      variant enum: -> { OpenAI::Models::ResponsesModel::ResponsesOnlyModel }

      module ResponsesOnlyModel
        extend OpenAI::Internal::Type::Enum

        O1_PRO = :"o1-pro"
        O1_PRO_2025_03_19 = :"o1-pro-2025-03-19"
        COMPUTER_USE_PREVIEW = :"computer-use-preview"
        COMPUTER_USE_PREVIEW_2025_03_11 = :"computer-use-preview-2025-03-11"

        finalize!

        # @!parse
        #   # @return [Array<Symbol>]
        #   def self.values; end
      end

      # @!parse
      #   # @return [Array(String, Symbol, OpenAI::Models::ChatModel, Symbol, OpenAI::Models::ResponsesModel::ResponsesOnlyModel)]
      #   def self.variants; end
    end
  end
end
