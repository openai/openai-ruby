# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFailedEvent < OpenAI::Internal::Type::BaseModel
        # The response that failed.
        sig { returns(OpenAI::Models::Responses::Response) }
        attr_reader :response

        sig { params(response: T.any(OpenAI::Models::Responses::Response, OpenAI::Internal::AnyHash)).void }
        attr_writer :response

        # The type of the event. Always `response.failed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # An event that is emitted when a response fails.
        sig do
          params(response: T.any(OpenAI::Models::Responses::Response, OpenAI::Internal::AnyHash), type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(response:, type: :"response.failed")
        end

        sig { override.returns({response: OpenAI::Models::Responses::Response, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
