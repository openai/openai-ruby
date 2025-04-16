# frozen_string_literal: true

module OpenAI
  module Models
    module ChatModel
      extend OpenAI::Internal::Type::Enum

      GPT_4_1 = :"gpt-4.1"
      GPT_4_1_MINI = :"gpt-4.1-mini"
      GPT_4_1_NANO = :"gpt-4.1-nano"
      GPT_4_1_2025_04_14 = :"gpt-4.1-2025-04-14"
      GPT_4_1_MINI_2025_04_14 = :"gpt-4.1-mini-2025-04-14"
      GPT_4_1_NANO_2025_04_14 = :"gpt-4.1-nano-2025-04-14"
      O4_MINI = :"o4-mini"
      O4_MINI_2025_04_16 = :"o4-mini-2025-04-16"
      O3 = :o3
      O3_2025_04_16 = :"o3-2025-04-16"
      O3_MINI = :"o3-mini"
      O3_MINI_2025_01_31 = :"o3-mini-2025-01-31"
      O1 = :o1
      O1_2024_12_17 = :"o1-2024-12-17"
      O1_PREVIEW = :"o1-preview"
      O1_PREVIEW_2024_09_12 = :"o1-preview-2024-09-12"
      O1_MINI = :"o1-mini"
      O1_MINI_2024_09_12 = :"o1-mini-2024-09-12"
      GPT_4O = :"gpt-4o"
      GPT_4O_2024_11_20 = :"gpt-4o-2024-11-20"
      GPT_4O_2024_08_06 = :"gpt-4o-2024-08-06"
      GPT_4O_2024_05_13 = :"gpt-4o-2024-05-13"
      GPT_4O_AUDIO_PREVIEW = :"gpt-4o-audio-preview"
      GPT_4O_AUDIO_PREVIEW_2024_10_01 = :"gpt-4o-audio-preview-2024-10-01"
      GPT_4O_AUDIO_PREVIEW_2024_12_17 = :"gpt-4o-audio-preview-2024-12-17"
      GPT_4O_MINI_AUDIO_PREVIEW = :"gpt-4o-mini-audio-preview"
      GPT_4O_MINI_AUDIO_PREVIEW_2024_12_17 = :"gpt-4o-mini-audio-preview-2024-12-17"
      GPT_4O_SEARCH_PREVIEW = :"gpt-4o-search-preview"
      GPT_4O_MINI_SEARCH_PREVIEW = :"gpt-4o-mini-search-preview"
      GPT_4O_SEARCH_PREVIEW_2025_03_11 = :"gpt-4o-search-preview-2025-03-11"
      GPT_4O_MINI_SEARCH_PREVIEW_2025_03_11 = :"gpt-4o-mini-search-preview-2025-03-11"
      CHATGPT_4O_LATEST = :"chatgpt-4o-latest"
      GPT_4O_MINI = :"gpt-4o-mini"
      GPT_4O_MINI_2024_07_18 = :"gpt-4o-mini-2024-07-18"
      GPT_4_TURBO = :"gpt-4-turbo"
      GPT_4_TURBO_2024_04_09 = :"gpt-4-turbo-2024-04-09"
      GPT_4_0125_PREVIEW = :"gpt-4-0125-preview"
      GPT_4_TURBO_PREVIEW = :"gpt-4-turbo-preview"
      GPT_4_1106_PREVIEW = :"gpt-4-1106-preview"
      GPT_4_VISION_PREVIEW = :"gpt-4-vision-preview"
      GPT_4 = :"gpt-4"
      GPT_4_0314 = :"gpt-4-0314"
      GPT_4_0613 = :"gpt-4-0613"
      GPT_4_32K = :"gpt-4-32k"
      GPT_4_32K_0314 = :"gpt-4-32k-0314"
      GPT_4_32K_0613 = :"gpt-4-32k-0613"
      GPT_3_5_TURBO = :"gpt-3.5-turbo"
      GPT_3_5_TURBO_16K = :"gpt-3.5-turbo-16k"
      GPT_3_5_TURBO_0301 = :"gpt-3.5-turbo-0301"
      GPT_3_5_TURBO_0613 = :"gpt-3.5-turbo-0613"
      GPT_3_5_TURBO_1106 = :"gpt-3.5-turbo-1106"
      GPT_3_5_TURBO_0125 = :"gpt-3.5-turbo-0125"
      GPT_3_5_TURBO_16K_0613 = :"gpt-3.5-turbo-16k-0613"

      finalize!

      # @!parse
      #   # @return [Array<Symbol>]
      #   def self.values; end
    end
  end
end
