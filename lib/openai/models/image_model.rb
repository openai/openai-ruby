# frozen_string_literal: true

module OpenAI
  module Models
    # @abstract
    #
    class ImageModel < OpenAI::Enum
      DALL_E_2 = :"dall-e-2"
      DALL_E_3 = :"dall-e-3"

      finalize!
    end
  end
end
