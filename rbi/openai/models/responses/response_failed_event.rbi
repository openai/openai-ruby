# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFailedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseFailedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The response that failed.
        sig { returns(OpenAI::Responses::Response) }
        attr_reader :response

        sig { params(response: OpenAI::Responses::Response::OrHash).void }
        attr_writer :response

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.failed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # An event that is emitted when a response fails.
        sig do
          params(
            response: OpenAI::Responses::Response::OrHash,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The response that failed.
          response:,
          # The sequence number of this event.
          sequence_number:,
          # The type of the event. Always `response.failed`.
          type: :"response.failed"
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
