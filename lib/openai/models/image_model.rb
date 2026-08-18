# frozen_string_literal: true

module OpenAI
  module Models
    module ImageModel
      extend OpenAI::Internal::Type::Enum

      GPT_IMAGE_1 = :"gpt-image-1"
      GPT_IMAGE_1_MINI = :"gpt-image-1-mini"
      GPT_IMAGE_2 = :"gpt-image-2"
      GPT_IMAGE_2_2026_04_21 = :"gpt-image-2-2026-04-21"
      GPT_IMAGE_1_5 = :"gpt-image-1.5"
      CHATGPT_IMAGE_LATEST = :"chatgpt-image-latest"
      DALL_E_2 = :"dall-e-2"
      DALL_E_3 = :"dall-e-3"

      # @!method self.values
      #   @return [Array<Symbol>]
    end
  end
end
