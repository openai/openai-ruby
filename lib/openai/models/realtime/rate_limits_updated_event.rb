# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RateLimitsUpdatedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute event_id
        #   The unique ID of the server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute rate_limits
        #   List of rate limit information.
        #
        #   @return [Array<OpenAI::Models::Realtime::RateLimitsUpdatedEvent::RateLimit>]
        required :rate_limits,
                 -> { OpenAI::Internal::Type::ArrayOf[OpenAI::Realtime::RateLimitsUpdatedEvent::RateLimit] }

        # @!attribute type
        #   The event type, must be `rate_limits.updated`.
        #
        #   @return [Symbol, :"rate_limits.updated"]
        required :type, const: :"rate_limits.updated"

        # @!method initialize(event_id:, rate_limits:, type: :"rate_limits.updated")
        #   Emitted at the beginning of a Response to indicate the updated rate limits. When
        #   a Response is created some tokens will be "reserved" for the output tokens, the
        #   rate limits shown here reflect that reservation, which is then adjusted
        #   accordingly once the Response is completed.
        #
        #   @param event_id [String] The unique ID of the server event.
        #
        #   @param rate_limits [Array<OpenAI::Models::Realtime::RateLimitsUpdatedEvent::RateLimit>] List of rate limit information.
        #
        #   @param type [Symbol, :"rate_limits.updated"] The event type, must be `rate_limits.updated`.

        class RateLimit < OpenAI::Internal::Type::BaseModel
          # @!attribute limit
          #   The maximum allowed value for the rate limit.
          #
          #   @return [Integer, nil]
          optional :limit, Integer

          # @!attribute name
          #   The name of the rate limit (`requests`, `tokens`).
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RateLimitsUpdatedEvent::RateLimit::Name, nil]
          optional :name, enum: -> { OpenAI::Realtime::RateLimitsUpdatedEvent::RateLimit::Name }

          # @!attribute remaining
          #   The remaining value before the limit is reached.
          #
          #   @return [Integer, nil]
          optional :remaining, Integer

          # @!attribute reset_seconds
          #   Seconds until the rate limit resets.
          #
          #   @return [Float, nil]
          optional :reset_seconds, Float

          # @!method initialize(limit: nil, name: nil, remaining: nil, reset_seconds: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RateLimitsUpdatedEvent::RateLimit} for more details.
          #
          #   @param limit [Integer] The maximum allowed value for the rate limit.
          #
          #   @param name [Symbol, OpenAI::Models::Realtime::RateLimitsUpdatedEvent::RateLimit::Name] The name of the rate limit (`requests`, `tokens`).
          #
          #   @param remaining [Integer] The remaining value before the limit is reached.
          #
          #   @param reset_seconds [Float] Seconds until the rate limit resets.

          # The name of the rate limit (`requests`, `tokens`).
          #
          # @see OpenAI::Models::Realtime::RateLimitsUpdatedEvent::RateLimit#name
          module Name
            extend OpenAI::Internal::Type::Enum

            REQUESTS = :requests
            TOKENS = :tokens

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end
  end
end
