# typed: strong

module OpenAI
  module Models
    module Realtime
      class RateLimitsUpdatedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RateLimitsUpdatedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # List of rate limit information.
        sig do
          returns(T::Array[OpenAI::Realtime::RateLimitsUpdatedEvent::RateLimit])
        end
        attr_accessor :rate_limits

        # The event type, must be `rate_limits.updated`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted at the beginning of a Response to indicate the updated rate limits. When
        # a Response is created some tokens will be "reserved" for the output tokens, the
        # rate limits shown here reflect that reservation, which is then adjusted
        # accordingly once the Response is completed.
        sig do
          params(
            event_id: String,
            rate_limits:
              T::Array[
                OpenAI::Realtime::RateLimitsUpdatedEvent::RateLimit::OrHash
              ],
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # List of rate limit information.
          rate_limits:,
          # The event type, must be `rate_limits.updated`.
          type: :"rate_limits.updated"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              rate_limits:
                T::Array[OpenAI::Realtime::RateLimitsUpdatedEvent::RateLimit],
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class RateLimit < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RateLimitsUpdatedEvent::RateLimit,
                OpenAI::Internal::AnyHash
              )
            end

          # The maximum allowed value for the rate limit.
          sig { returns(T.nilable(Integer)) }
          attr_reader :limit

          sig { params(limit: Integer).void }
          attr_writer :limit

          # The name of the rate limit (`requests`, `tokens`).
          sig do
            returns(
              T.nilable(
                OpenAI::Realtime::RateLimitsUpdatedEvent::RateLimit::Name::OrSymbol
              )
            )
          end
          attr_reader :name

          sig do
            params(
              name:
                OpenAI::Realtime::RateLimitsUpdatedEvent::RateLimit::Name::OrSymbol
            ).void
          end
          attr_writer :name

          # The remaining value before the limit is reached.
          sig { returns(T.nilable(Integer)) }
          attr_reader :remaining

          sig { params(remaining: Integer).void }
          attr_writer :remaining

          # Seconds until the rate limit resets.
          sig { returns(T.nilable(Float)) }
          attr_reader :reset_seconds

          sig { params(reset_seconds: Float).void }
          attr_writer :reset_seconds

          sig do
            params(
              limit: Integer,
              name:
                OpenAI::Realtime::RateLimitsUpdatedEvent::RateLimit::Name::OrSymbol,
              remaining: Integer,
              reset_seconds: Float
            ).returns(T.attached_class)
          end
          def self.new(
            # The maximum allowed value for the rate limit.
            limit: nil,
            # The name of the rate limit (`requests`, `tokens`).
            name: nil,
            # The remaining value before the limit is reached.
            remaining: nil,
            # Seconds until the rate limit resets.
            reset_seconds: nil
          )
          end

          sig do
            override.returns(
              {
                limit: Integer,
                name:
                  OpenAI::Realtime::RateLimitsUpdatedEvent::RateLimit::Name::OrSymbol,
                remaining: Integer,
                reset_seconds: Float
              }
            )
          end
          def to_hash
          end

          # The name of the rate limit (`requests`, `tokens`).
          module Name
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Realtime::RateLimitsUpdatedEvent::RateLimit::Name
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            REQUESTS =
              T.let(
                :requests,
                OpenAI::Realtime::RateLimitsUpdatedEvent::RateLimit::Name::TaggedSymbol
              )
            TOKENS =
              T.let(
                :tokens,
                OpenAI::Realtime::RateLimitsUpdatedEvent::RateLimit::Name::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Realtime::RateLimitsUpdatedEvent::RateLimit::Name::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
