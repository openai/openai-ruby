# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionRateLimits < OpenAI::Internal::Type::BaseModel
          # @!attribute max_requests_per_1_minute
          #   Maximum allowed requests per one-minute window.
          #
          #   @return [Integer]
          required :max_requests_per_1_minute, Integer

          # @!method initialize(max_requests_per_1_minute:)
          #   Active per-minute request limit for the session.
          #
          #   @param max_requests_per_1_minute [Integer] Maximum allowed requests per one-minute window.
        end
      end
    end
  end
end
