# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCreatedEvent < OpenAI::BaseModel
        # The response that was created.
        sig { returns(OpenAI::Models::Responses::Response) }
        def response
        end

        sig do
          params(_: T.any(OpenAI::Models::Responses::Response, OpenAI::Util::AnyHash))
            .returns(T.any(OpenAI::Models::Responses::Response, OpenAI::Util::AnyHash))
        end
        def response=(_)
        end

        # The type of the event. Always `response.created`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # An event that is emitted when a response is created.
        sig do
          params(response: T.any(OpenAI::Models::Responses::Response, OpenAI::Util::AnyHash), type: Symbol)
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
