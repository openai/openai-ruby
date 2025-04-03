# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCreatedEvent < OpenAI::Internal::Type::BaseModel
        # The response that was created.
        sig { returns(OpenAI::Models::Responses::Response) }
        attr_reader :response

        sig { params(response: T.any(OpenAI::Models::Responses::Response, OpenAI::Internal::AnyHash)).void }
        attr_writer :response

        # The type of the event. Always `response.created`.
        sig { returns(Symbol) }
        attr_accessor :type

        # An event that is emitted when a response is created.
        sig do
          params(response: T.any(OpenAI::Models::Responses::Response, OpenAI::Internal::AnyHash), type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(response:, type: :"response.created")
        end

        sig { override.returns({response: OpenAI::Models::Responses::Response, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
