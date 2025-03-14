# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInProgressEvent < OpenAI::BaseModel
        # The response that is in progress.
        sig { returns(OpenAI::Models::Responses::Response) }
        def response
        end

        sig { params(_: OpenAI::Models::Responses::Response).returns(OpenAI::Models::Responses::Response) }
        def response=(_)
        end

        # The type of the event. Always `response.in_progress`.
        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        # Emitted when the response is in progress.
        sig { params(response: OpenAI::Models::Responses::Response, type: Symbol).returns(T.attached_class) }
        def self.new(response:, type: :"response.in_progress")
        end

        sig { override.returns({response: OpenAI::Models::Responses::Response, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
