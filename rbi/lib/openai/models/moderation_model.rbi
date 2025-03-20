# typed: strong

module OpenAI
  module Models
    class ModerationModel < OpenAI::Enum
      abstract!

      Value = type_template(:out) { {fixed: Symbol} }

      OMNI_MODERATION_LATEST = :"omni-moderation-latest"
      OMNI_MODERATION_2024_09_26 = :"omni-moderation-2024-09-26"
      TEXT_MODERATION_LATEST = :"text-moderation-latest"
      TEXT_MODERATION_STABLE = :"text-moderation-stable"
    end
  end
end
