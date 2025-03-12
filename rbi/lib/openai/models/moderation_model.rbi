# typed: strong

module OpenAI
  module Models
    class ModerationModel < OpenAI::Enum
      abstract!

      OMNI_MODERATION_LATEST = :"omni-moderation-latest"
      OMNI_MODERATION_2024_09_26 = :"omni-moderation-2024-09-26"
      TEXT_MODERATION_LATEST = :"text-moderation-latest"
      TEXT_MODERATION_STABLE = :"text-moderation-stable"

      class << self
        sig { override.returns(T::Array[Symbol]) }
        def values
        end
      end
    end
  end
end
