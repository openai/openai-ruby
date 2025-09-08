# typed: strong

module OpenAI
  module Models
    module Realtime
      class ResponseDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ResponseDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The response resource.
        sig { returns(OpenAI::Realtime::RealtimeResponse) }
        attr_reader :response

        sig do
          params(response: OpenAI::Realtime::RealtimeResponse::OrHash).void
        end
        attr_writer :response

        # The event type, must be `response.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when a Response is done streaming. Always emitted, no matter the final
        # state. The Response object included in the `response.done` event will include
        # all output Items in the Response but will omit the raw audio data.
        #
        # Clients should check the `status` field of the Response to determine if it was
        # successful (`completed`) or if there was another outcome: `cancelled`, `failed`,
        # or `incomplete`.
        #
        # A response will contain all output items that were generated during the
        # response, excluding any audio content.
        sig do
          params(
            event_id: String,
            response: OpenAI::Realtime::RealtimeResponse::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # The response resource.
          response:,
          # The event type, must be `response.done`.
          type: :"response.done"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              response: OpenAI::Realtime::RealtimeResponse,
              type: Symbol
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
