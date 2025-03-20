# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCompletedEvent < OpenAI::BaseModel
        # Properties of the completed response.
        sig { returns(OpenAI::Models::Responses::Response) }
        def response
        end

        sig do
          params(_: T.any(OpenAI::Models::Responses::Response, OpenAI::Util::AnyHash))
            .returns(T.any(OpenAI::Models::Responses::Response, OpenAI::Util::AnyHash))
        end
        def response=(_)
        end

        # The type of the event. Always `response.completed`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Emitted when the model response is complete.
        sig { params(response: OpenAI::Models::Responses::Response, type: Symbol).returns(T.attached_class) }
        def self.new(response:, type: :"response.completed")
        end

        sig { override.returns({response: OpenAI::Models::Responses::Response, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
