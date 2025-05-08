# frozen_string_literal: true

module OpenAI
  module Models
    module ImageModel
      extend OpenAI::Internal::Type::Enum

      DALL_E_2 = :"dall-e-2"
      DALL_E_3 = :"dall-e-3"
      GPT_IMAGE_1 = :"gpt-image-1"

      # @!method self.values
      #   @return [Array<Symbol>]
    end
  end
end
