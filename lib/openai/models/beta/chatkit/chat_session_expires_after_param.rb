# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionExpiresAfterParam < OpenAI::Internal::Type::BaseModel
          # @!attribute anchor
          #   Base timestamp used to calculate expiration. Currently fixed to `created_at`.
          #
          #   @return [Symbol, :created_at]
          required :anchor, const: :created_at

          # @!attribute seconds
          #   Number of seconds after the anchor when the session expires.
          #
          #   @return [Integer]
          required :seconds, Integer

          # @!method initialize(seconds:, anchor: :created_at)
          #   Controls when the session expires relative to an anchor timestamp.
          #
          #   @param seconds [Integer] Number of seconds after the anchor when the session expires.
          #
          #   @param anchor [Symbol, :created_at] Base timestamp used to calculate expiration. Currently fixed to `created_at`.
        end
      end
    end
  end
end
