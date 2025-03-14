# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseIncompleteEvent < OpenAI::BaseModel
        # The response that was incomplete.
        sig { returns(OpenAI::Models::Responses::Response) }
        def response
        end

        sig { params(_: OpenAI::Models::Responses::Response).returns(OpenAI::Models::Responses::Response) }
        def response=(_)
        end

        # The type of the event. Always `response.incomplete`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # An event that is emitted when a response finishes as incomplete.
        sig { params(response: OpenAI::Models::Responses::Response, type: Symbol).returns(T.attached_class) }
        def self.new(response:, type: :"response.incomplete")
        end

        sig { override.returns({response: OpenAI::Models::Responses::Response, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
