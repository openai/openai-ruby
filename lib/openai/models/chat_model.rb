# frozen_string_literal: true

module OpenAI
  module Models
    module ChatModel
      extend OpenAI::Internal::Type::Enum

      GPT_6_ASTRA = :"gpt-6-astra"
      GPT_6_1_SOL = :"gpt-6.1-sol"
      GPT_6_SOL = :"gpt-6-sol"
      GPT_6_LUNA = :"gpt-6-luna"
      GPT_5_6_SOL = :"gpt-5.6-sol"
      GPT_5_6_TERRA = :"gpt-5.6-terra"
      GPT_5_6_LUNA = :"gpt-5.6-luna"
      GPT_5_5 = :"gpt-5.5"
      GPT_5_5_2026_04_23 = :"gpt-5.5-2026-04-23"
      GPT_5_4 = :"gpt-5.4"
      GPT_5_4_MINI = :"gpt-5.4-mini"
      GPT_5_4_NANO = :"gpt-5.4-nano"
      GPT_5_4_MINI_2026_03_17 = :"gpt-5.4-mini-2026-03-17"
      GPT_5_4_NANO_2026_03_17 = :"gpt-5.4-nano-2026-03-17"
      # @deprecated Announced shutdown date: 2026-08-10. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_5_3_CHAT_LATEST = :"gpt-5.3-chat-latest"
      GPT_5_2 = :"gpt-5.2"
      GPT_5_2_2025_12_11 = :"gpt-5.2-2025-12-11"
      # @deprecated Announced shutdown date: 2026-08-10. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_5_2_CHAT_LATEST = :"gpt-5.2-chat-latest"
      GPT_5_2_PRO = :"gpt-5.2-pro"
      GPT_5_2_PRO_2025_12_11 = :"gpt-5.2-pro-2025-12-11"
      GPT_5_1 = :"gpt-5.1"
      GPT_5_1_2025_11_13 = :"gpt-5.1-2025-11-13"
      # @deprecated Announced shutdown date: 2026-07-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_5_1_CODEX = :"gpt-5.1-codex"
      # @deprecated Not a supported model ID. Retained for SDK compatibility.
      GPT_5_1_MINI = :"gpt-5.1-mini"
      # @deprecated Announced shutdown date: 2026-07-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_5_1_CHAT_LATEST = :"gpt-5.1-chat-latest"
      # @deprecated Announced shutdown date: 2026-12-11. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_5 = :"gpt-5"
      # @deprecated Announced shutdown date: 2026-12-11. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_5_MINI = :"gpt-5-mini"
      # @deprecated Announced shutdown date: 2026-12-11. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_5_NANO = :"gpt-5-nano"
      # @deprecated Announced shutdown date: 2026-12-11. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_5_2025_08_07 = :"gpt-5-2025-08-07"
      # @deprecated Announced shutdown date: 2026-12-11. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_5_MINI_2025_08_07 = :"gpt-5-mini-2025-08-07"
      # @deprecated Announced shutdown date: 2026-12-11. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_5_NANO_2025_08_07 = :"gpt-5-nano-2025-08-07"
      # @deprecated Announced shutdown date: 2026-07-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_5_CHAT_LATEST = :"gpt-5-chat-latest"
      GPT_4_1 = :"gpt-4.1"
      GPT_4_1_MINI = :"gpt-4.1-mini"
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4_1_NANO = :"gpt-4.1-nano"
      GPT_4_1_2025_04_14 = :"gpt-4.1-2025-04-14"
      GPT_4_1_MINI_2025_04_14 = :"gpt-4.1-mini-2025-04-14"
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4_1_NANO_2025_04_14 = :"gpt-4.1-nano-2025-04-14"
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      O4_MINI = :"o4-mini"
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      O4_MINI_2025_04_16 = :"o4-mini-2025-04-16"
      # @deprecated Announced shutdown date: 2026-12-11. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      O3 = :o3
      # @deprecated Announced shutdown date: 2026-12-11. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      O3_2025_04_16 = :"o3-2025-04-16"
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      O3_MINI = :"o3-mini"
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      O3_MINI_2025_01_31 = :"o3-mini-2025-01-31"
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      O1 = :o1
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      O1_2024_12_17 = :"o1-2024-12-17"
      # @deprecated Announced shutdown date: 2025-07-28. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      O1_PREVIEW = :"o1-preview"
      # @deprecated Announced shutdown date: 2025-07-28. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      O1_PREVIEW_2024_09_12 = :"o1-preview-2024-09-12"
      # @deprecated Announced shutdown date: 2025-10-27. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      O1_MINI = :"o1-mini"
      # @deprecated Announced shutdown date: 2025-10-27. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      O1_MINI_2024_09_12 = :"o1-mini-2024-09-12"
      GPT_4O = :"gpt-4o"
      GPT_4O_2024_11_20 = :"gpt-4o-2024-11-20"
      GPT_4O_2024_08_06 = :"gpt-4o-2024-08-06"
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4O_2024_05_13 = :"gpt-4o-2024-05-13"
      # @deprecated Announced shutdown date: 2027-01-20. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_AUDIO_MINI = :"gpt-audio-mini"
      # @deprecated Announced shutdown date: 2027-01-20. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_AUDIO_MINI_2025_12_15 = :"gpt-audio-mini-2025-12-15"
      # @deprecated Announced shutdown date: 2026-05-07. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4O_AUDIO_PREVIEW = :"gpt-4o-audio-preview"
      # @deprecated Announced shutdown date: 2025-10-10. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4O_AUDIO_PREVIEW_2024_10_01 = :"gpt-4o-audio-preview-2024-10-01"
      # @deprecated Announced shutdown date: 2026-05-07. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4O_AUDIO_PREVIEW_2024_12_17 = :"gpt-4o-audio-preview-2024-12-17"
      # @deprecated Announced shutdown date: 2026-05-07. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4O_AUDIO_PREVIEW_2025_06_03 = :"gpt-4o-audio-preview-2025-06-03"
      # @deprecated Announced shutdown date: 2026-05-07. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4O_MINI_AUDIO_PREVIEW = :"gpt-4o-mini-audio-preview"
      # @deprecated Announced shutdown date: 2026-05-07. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4O_MINI_AUDIO_PREVIEW_2024_12_17 = :"gpt-4o-mini-audio-preview-2024-12-17"
      # @deprecated Announced shutdown date: 2026-07-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4O_SEARCH_PREVIEW = :"gpt-4o-search-preview"
      # @deprecated Announced shutdown date: 2026-07-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4O_MINI_SEARCH_PREVIEW = :"gpt-4o-mini-search-preview"
      # @deprecated Announced shutdown date: 2026-07-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4O_SEARCH_PREVIEW_2025_03_11 = :"gpt-4o-search-preview-2025-03-11"
      # @deprecated Announced shutdown date: 2026-07-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4O_MINI_SEARCH_PREVIEW_2025_03_11 = :"gpt-4o-mini-search-preview-2025-03-11"
      # @deprecated Announced shutdown date: 2026-02-17. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      CHATGPT_4O_LATEST = :"chatgpt-4o-latest"
      # @deprecated Announced shutdown date: 2026-02-12. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      CODEX_MINI_LATEST = :"codex-mini-latest"
      GPT_4O_MINI = :"gpt-4o-mini"
      GPT_4O_MINI_2024_07_18 = :"gpt-4o-mini-2024-07-18"
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4_TURBO = :"gpt-4-turbo"
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4_TURBO_2024_04_09 = :"gpt-4-turbo-2024-04-09"
      # @deprecated Announced shutdown date: 2026-03-26. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4_0125_PREVIEW = :"gpt-4-0125-preview"
      # @deprecated Announced shutdown date: 2026-03-26. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4_TURBO_PREVIEW = :"gpt-4-turbo-preview"
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4_1106_PREVIEW = :"gpt-4-1106-preview"
      # @deprecated Announced shutdown date: 2024-12-06. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4_VISION_PREVIEW = :"gpt-4-vision-preview"
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4 = :"gpt-4"
      # @deprecated Announced shutdown date: 2026-03-26. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4_0314 = :"gpt-4-0314"
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4_0613 = :"gpt-4-0613"
      # @deprecated Announced shutdown date: 2025-06-06. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4_32K = :"gpt-4-32k"
      # @deprecated Announced shutdown date: 2025-06-06. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4_32K_0314 = :"gpt-4-32k-0314"
      # @deprecated Announced shutdown date: 2025-06-06. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_4_32K_0613 = :"gpt-4-32k-0613"
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_3_5_TURBO = :"gpt-3.5-turbo"
      # @deprecated Announced shutdown date: 2024-09-13. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_3_5_TURBO_16K = :"gpt-3.5-turbo-16k"
      # @deprecated Announced shutdown date: 2024-09-13. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_3_5_TURBO_0301 = :"gpt-3.5-turbo-0301"
      # @deprecated Announced shutdown date: 2024-09-13. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_3_5_TURBO_0613 = :"gpt-3.5-turbo-0613"
      # @deprecated Announced shutdown date: 2026-09-28. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_3_5_TURBO_1106 = :"gpt-3.5-turbo-1106"
      # @deprecated Announced shutdown date: 2026-10-23. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_3_5_TURBO_0125 = :"gpt-3.5-turbo-0125"
      # @deprecated Announced shutdown date: 2024-09-13. See
      # https://developers.openai.com/api/docs/deprecations for details and recommended
      # replacements.
      GPT_3_5_TURBO_16K_0613 = :"gpt-3.5-turbo-16k-0613"

      # @!method self.values
      #   @return [Array<Symbol>]
    end
  end
end
