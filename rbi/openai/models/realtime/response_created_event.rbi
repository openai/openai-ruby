# typed: strong

module OpenAI
  module Models
    module Realtime
      class ResponseCreatedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ResponseCreatedEvent,
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

        # The event type, must be `response.created`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when a new Response is created. The first event of response creation,
        # where the response is in an initial state of `in_progress`.
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
          # The event type, must be `response.created`.
          type: :"response.created"
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
