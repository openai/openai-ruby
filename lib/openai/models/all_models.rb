# frozen_string_literal: true

module OpenAI
  module Models
    # @abstract
    class AllModels < OpenAI::Union
      variant String

      variant enum: -> { OpenAI::Models::ChatModel }

      variant enum: -> { OpenAI::Models::AllModels::UnionMember2 }

      # @abstract
      class UnionMember2 < OpenAI::Enum
        O1_PRO = :"o1-pro"
        O1_PRO_2025_03_19 = :"o1-pro-2025-03-19"
        COMPUTER_USE_PREVIEW = :"computer-use-preview"
        COMPUTER_USE_PREVIEW_2025_03_11 = :"computer-use-preview-2025-03-11"

        finalize!
      end

      # @!parse
      #   class << self
      #     # @return [Array(String, Symbol, OpenAI::Models::ChatModel, Symbol, OpenAI::Models::AllModels::UnionMember2)]
      #     def variants; end
      #   end
    end
  end
end
