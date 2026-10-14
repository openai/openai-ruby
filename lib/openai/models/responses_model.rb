# frozen_string_literal: true

module OpenAI
  module Models
    module ResponsesModel
      extend OpenAI::Internal::Type::Union

      variant String

      variant enum: -> { OpenAI::ChatModel }

      variant enum: -> { OpenAI::ResponsesModel::ResponsesOnlyModel }

      module ResponsesOnlyModel
        extend OpenAI::Internal::Type::Enum

        # @deprecated Announced shutdown date: 2026-10-23. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        O1_PRO = :"o1-pro"
        # @deprecated Announced shutdown date: 2026-10-23. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        O1_PRO_2025_03_19 = :"o1-pro-2025-03-19"
        # @deprecated Announced shutdown date: 2026-12-11. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        O3_PRO = :"o3-pro"
        # @deprecated Announced shutdown date: 2026-12-11. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        O3_PRO_2025_06_10 = :"o3-pro-2025-06-10"
        # @deprecated Announced shutdown date: 2026-07-23. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        O3_DEEP_RESEARCH = :"o3-deep-research"
        # @deprecated Announced shutdown date: 2026-07-23. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        O3_DEEP_RESEARCH_2025_06_26 = :"o3-deep-research-2025-06-26"
        # @deprecated Announced shutdown date: 2026-07-23. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        O4_MINI_DEEP_RESEARCH = :"o4-mini-deep-research"
        # @deprecated Announced shutdown date: 2026-07-23. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        O4_MINI_DEEP_RESEARCH_2025_06_26 = :"o4-mini-deep-research-2025-06-26"
        # @deprecated Announced shutdown date: 2026-07-23. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        COMPUTER_USE_PREVIEW = :"computer-use-preview"
        # @deprecated Announced shutdown date: 2026-07-23. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        COMPUTER_USE_PREVIEW_2025_03_11 = :"computer-use-preview-2025-03-11"
        GPT_5_5_PRO = :"gpt-5.5-pro"
        GPT_5_5_PRO_2026_04_23 = :"gpt-5.5-pro-2026-04-23"
        # @deprecated Announced shutdown date: 2026-07-23. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        GPT_5_CODEX = :"gpt-5-codex"
        # @deprecated Announced shutdown date: 2026-12-11. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        GPT_5_PRO = :"gpt-5-pro"
        # @deprecated Announced shutdown date: 2026-12-11. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        GPT_5_PRO_2025_10_06 = :"gpt-5-pro-2025-10-06"
        # @deprecated Announced shutdown date: 2026-07-23. See
        # https://developers.openai.com/api/docs/deprecations for details and recommended
        # replacements.
        GPT_5_1_CODEX_MAX = :"gpt-5.1-codex-max"
        GPT_DAYBREAK_BLUE_LATEST = :"gpt-daybreak-blue-latest"
        GPT_DAYBREAK_RED_LATEST = :"gpt-daybreak-red-latest"
        GPT_5_6_CYBER = :"gpt-5.6-cyber"
        GPT_ROSALIND_RESEARCH = :"gpt-rosalind-research"

        # @!method self.values
        #   @return [Array<Symbol>]
      end

      # @!method self.variants
      #   @return [Array(String, Symbol, OpenAI::Models::ChatModel, Symbol, OpenAI::Models::ResponsesModel::ResponsesOnlyModel)]
    end
  end
end
