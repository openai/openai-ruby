# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCreatedEvent < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The response that was created.
        sig { returns(OpenAI::Responses::Response) }
        attr_reader :response

        sig { params(response: OpenAI::Responses::Response::OrHash).void }
        attr_writer :response

        # The type of the event. Always `response.created`.
        sig { returns(Symbol) }
        attr_accessor :type

        # An event that is emitted when a response is created.
        sig do
          params(
            response: OpenAI::Responses::Response::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The response that was created.
          response:,
          # The type of the event. Always `response.created`.
          type: :"response.created"
        )
        end

        sig do
          override.returns(
            { response: OpenAI::Responses::Response, type: Symbol }
          )
        end
        def to_hash
        end
      end
    end
  end
end
