# typed: strong

module OpenAI
  module Models
    BetaResponseInjectCreatedEvent = Beta::BetaResponseInjectCreatedEvent

    module Beta
      class BetaResponseInjectCreatedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseInjectCreatedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the response that accepted the input.
        sig { returns(String) }
        attr_accessor :response_id

        # The sequence number for this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The event discriminator. Always `response.inject.created`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The multiplexed WebSocket stream that emitted the event. This field is present
        # only when WebSocket multiplexing is enabled separately.
        sig { returns(T.nilable(String)) }
        attr_reader :stream_id

        sig { params(stream_id: String).void }
        attr_writer :stream_id

        # Emitted when all injected input items were validated and committed to the active
        # response.
        sig do
          params(
            response_id: String,
            sequence_number: Integer,
            stream_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The ID of the response that accepted the input.
          response_id:,
          # The sequence number for this event.
          sequence_number:,
          # The multiplexed WebSocket stream that emitted the event. This field is present
          # only when WebSocket multiplexing is enabled separately.
          stream_id: nil,
          # The event discriminator. Always `response.inject.created`.
          type: :"response.inject.created"
        )
        end

        sig do
          override.returns(
            {
              response_id: String,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
