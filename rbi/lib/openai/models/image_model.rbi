# typed: strong

module OpenAI
  module Models
    class ImageModel < OpenAI::Enum
      abstract!

      Value = type_template(:out) { {fixed: Symbol} }

      DALL_E_2 = :"dall-e-2"
      DALL_E_3 = :"dall-e-3"
    end
  end
end
