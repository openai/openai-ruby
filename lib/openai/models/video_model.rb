# frozen_string_literal: true

module OpenAI
  module Models
    module VideoModel
      extend OpenAI::Internal::Type::Enum

      SORA_2 = :"sora-2"
      SORA_2_PRO = :"sora-2-pro"

      # @!method self.values
      #   @return [Array<Symbol>]
    end
  end
end
