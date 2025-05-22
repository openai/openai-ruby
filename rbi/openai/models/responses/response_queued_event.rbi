# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseQueuedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseQueuedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The full response object that is queued.
        sig { returns(OpenAI::Responses::Response) }
        attr_reader :response

        sig { params(response: OpenAI::Responses::Response::OrHash).void }
        attr_writer :response

        # The sequence number for this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always 'response.queued'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when a response is queued and waiting to be processed.
        sig do
          params(
            response: OpenAI::Responses::Response::OrHash,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The full response object that is queued.
          response:,
          # The sequence number for this event.
          sequence_number:,
          # The type of the event. Always 'response.queued'.
          type: :"response.queued"
        )
        end

        sig do
          override.returns(
            {
              response: OpenAI::Responses::Response,
              sequence_number: Integer,
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
