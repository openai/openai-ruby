# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCompletedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseCompletedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Properties of the completed response.
        sig { returns(OpenAI::Responses::Response) }
        attr_reader :response

        sig { params(response: OpenAI::Responses::Response::OrHash).void }
        attr_writer :response

        # The sequence number for this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.completed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the model response is complete.
        sig do
          params(
            response: OpenAI::Responses::Response::OrHash,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Properties of the completed response.
          response:,
          # The sequence number for this event.
          sequence_number:,
          # The type of the event. Always `response.completed`.
          type: :"response.completed"
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
