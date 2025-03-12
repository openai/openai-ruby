# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseFailedEvent < OpenAI::BaseModel
        sig { returns(OpenAI::Models::Responses::Response) }
        def response
        end

        sig { params(_: OpenAI::Models::Responses::Response).returns(OpenAI::Models::Responses::Response) }
        def response=(_)
        end

        sig { returns(Symbol) }
        def type
        end

        sig { params(_: Symbol).returns(Symbol) }
        def type=(_)
        end

        sig { params(response: OpenAI::Models::Responses::Response, type: Symbol).returns(T.attached_class) }
        def self.new(response:, type: :"response.failed")
        end

        sig { override.returns({response: OpenAI::Models::Responses::Response, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
