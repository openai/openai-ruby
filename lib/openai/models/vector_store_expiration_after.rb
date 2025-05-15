# frozen_string_literal: true

module OpenAI
  module Models
    class VectorStoreExpirationAfter < OpenAI::Internal::Type::BaseModel
      # @!attribute anchor
      #   Anchor timestamp after which the expiration policy applies. Supported anchors:
      #   `last_active_at`.
      #
      #   @return [Symbol, :last_active_at]
      required :anchor, const: :last_active_at

      # @!attribute days
      #   The number of days after the anchor time that the vector store will expire.
      #
      #   @return [Integer]
      required :days, Integer

      # @!method initialize(days:, anchor: :last_active_at)
      #   Some parameter documentations has been truncated, see
      #   {OpenAI::VectorStoreExpirationAfter} for more details.
      #
      #   The expiration policy for a vector store.
      #
      #   @param days [Integer] The number of days after the anchor time that the vector store will expire.
      #
      #   @param anchor [Symbol, :last_active_at] Anchor timestamp after which the expiration policy applies. Supported anchors: `
    end
  end
end
