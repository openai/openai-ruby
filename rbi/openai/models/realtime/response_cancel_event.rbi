# typed: strong

module OpenAI
  module Models
    module Realtime
      class ResponseCancelEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ResponseCancelEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The event type, must be `response.cancel`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client-generated ID used to identify this event.
        sig { returns(T.nilable(String)) }
        attr_reader :event_id

        sig { params(event_id: String).void }
        attr_writer :event_id

        # A specific response ID to cancel - if not provided, will cancel an in-progress
        # response in the default conversation.
        sig { returns(T.nilable(String)) }
        attr_reader :response_id

        sig { params(response_id: String).void }
        attr_writer :response_id

        # Send this event to cancel an in-progress response. The server will respond with
        # a `response.done` event with a status of `response.status=cancelled`. If there
        # is no response to cancel, the server will respond with an error.
        sig do
          params(event_id: String, response_id: String, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # Optional client-generated ID used to identify this event.
          event_id: nil,
          # A specific response ID to cancel - if not provided, will cancel an in-progress
          # response in the default conversation.
          response_id: nil,
          # The event type, must be `response.cancel`.
          type: :"response.cancel"
        )
        end

        sig do
          override.returns(
            { type: Symbol, event_id: String, response_id: String }
          )
        end
        def to_hash
        end
      end
    end
  end
end
