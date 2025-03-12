# typed: strong

module OpenAI
  module Models
    class ImageModel < OpenAI::Enum
      abstract!

      DALL_E_2 = :"dall-e-2"
      DALL_E_3 = :"dall-e-3"

      class << self
        sig { override.returns(T::Array[Symbol]) }
        def values
        end
      end
    end
  end
end
