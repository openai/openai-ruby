# frozen_string_literal: true

module OpenAI
  module Models
    module VideoModel
      extend OpenAI::Internal::Type::Enum

      SORA_2 = :"sora-2"
      SORA_2_PRO = :"sora-2-pro"
      SORA_2_2025_10_06 = :"sora-2-2025-10-06"
      SORA_2_PRO_2025_10_06 = :"sora-2-pro-2025-10-06"
      SORA_2_2025_12_08 = :"sora-2-2025-12-08"

      # @!method self.values
      #   @return [Array<Symbol>]
    end
  end
end
