# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseIncompleteEvent < OpenAI::BaseModel
        # The response that was incomplete.
        sig { returns(OpenAI::Models::Responses::Response) }
        attr_reader :response

        sig { params(response: T.any(OpenAI::Models::Responses::Response, OpenAI::Internal::Util::AnyHash)).void }
        attr_writer :response

        # The type of the event. Always `response.incomplete`.
        sig { returns(Symbol) }
        attr_accessor :type

        # An event that is emitted when a response finishes as incomplete.
        sig do
          params(
            response: T.any(OpenAI::Models::Responses::Response, OpenAI::Internal::Util::AnyHash),
            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(response:, type: :"response.incomplete")
        end

        sig { override.returns({response: OpenAI::Models::Responses::Response, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
