# frozen_string_literal: true

module OpenAI
  module Models
    module ModerationModel
      extend OpenAI::Enum

      OMNI_MODERATION_LATEST = :"omni-moderation-latest"
      OMNI_MODERATION_2024_09_26 = :"omni-moderation-2024-09-26"
      TEXT_MODERATION_LATEST = :"text-moderation-latest"
      TEXT_MODERATION_STABLE = :"text-moderation-stable"

      finalize!

      class << self
        # @!parse
        #   # @return [Array<Symbol>]
        #   def values; end
      end
    end
  end
end
