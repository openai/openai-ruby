# frozen_string_literal: true

module OpenAI
  module Models
    module VideoModel
      extend OpenAI::Internal::Type::Union

      variant String

      variant const: -> { OpenAI::Models::VideoModel::SORA_2 }

      variant const: -> { OpenAI::Models::VideoModel::SORA_2_PRO }

      variant const: -> { OpenAI::Models::VideoModel::SORA_2_2025_10_06 }

      variant const: -> { OpenAI::Models::VideoModel::SORA_2_PRO_2025_10_06 }

      variant const: -> { OpenAI::Models::VideoModel::SORA_2_2025_12_08 }

      # @!method self.variants
      #   @return [Array(String, Symbol)]

      define_sorbet_constant!(:Variants) do
        T.type_alias { T.any(String, OpenAI::VideoModel::TaggedSymbol) }
      end

      # @!group

      SORA_2 = :"sora-2"
      SORA_2_PRO = :"sora-2-pro"
      SORA_2_2025_10_06 = :"sora-2-2025-10-06"
      SORA_2_PRO_2025_10_06 = :"sora-2-pro-2025-10-06"
      SORA_2_2025_12_08 = :"sora-2-2025-12-08"

      # @!endgroup
    end
  end
end
