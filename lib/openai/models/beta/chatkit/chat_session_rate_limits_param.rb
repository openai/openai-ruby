# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module ChatKit
        class ChatSessionRateLimitsParam < OpenAI::Internal::Type::BaseModel
          # @!attribute max_requests_per_1_minute
          #   Maximum number of requests allowed per minute for the session. Defaults to 10.
          #
          #   @return [Integer, nil]
          optional :max_requests_per_1_minute, Integer

          # @!method initialize(max_requests_per_1_minute: nil)
          #   Controls request rate limits for the session.
          #
          #   @param max_requests_per_1_minute [Integer] Maximum number of requests allowed per minute for the session. Defaults to 10.
        end
      end
    end
  end
end
