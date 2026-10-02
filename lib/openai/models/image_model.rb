# frozen_string_literal: true

module OpenAI
  module Models
    module ImageModel
      extend OpenAI::Internal::Type::Enum

      GPT_IMAGE_1_5 = :"gpt-image-1.5"
      GPT_IMAGE_2 = :"gpt-image-2"
      GPT_IMAGE_2_2026_04_21 = :"gpt-image-2-2026-04-21"
      GPT_IMAGE_2_5_SUNBURST = :"gpt-image-2.5-sunburst"
      GPT_IMAGE_2_5_SUNBURST_2026_09_08 = :"gpt-image-2.5-sunburst-2026-09-08"
      GPT_IMAGE_2_5_FLARE = :"gpt-image-2.5-flare"
      GPT_IMAGE_2_5_FLARE_2026_09_08 = :"gpt-image-2.5-flare-2026-09-08"
      GPT_IMAGE_1 = :"gpt-image-1"
      GPT_IMAGE_1_MINI = :"gpt-image-1-mini"
      CHATGPT_IMAGE_LATEST = :"chatgpt-image-latest"
      # @deprecated This model was retired on May 12, 2026. Use a GPT image model instead.
      DALL_E_2 = :"dall-e-2"
      # @deprecated This model was retired on May 12, 2026. Use a GPT image model instead.
      DALL_E_3 = :"dall-e-3"

      # @!method self.values
      #   @return [Array<Symbol>]
    end
  end
end
