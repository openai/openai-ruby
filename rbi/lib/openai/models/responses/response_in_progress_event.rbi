# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInProgressEvent < OpenAI::BaseModel
        # The response that is in progress.
        sig { returns(OpenAI::Models::Responses::Response) }
        attr_reader :response

        sig { params(response: T.any(OpenAI::Models::Responses::Response, OpenAI::Util::AnyHash)).void }
        attr_writer :response

        # The type of the event. Always `response.in_progress`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the response is in progress.
        sig do
          params(response: T.any(OpenAI::Models::Responses::Response, OpenAI::Util::AnyHash), type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(response:, type: :"response.in_progress")
        end

        sig { override.returns({response: OpenAI::Models::Responses::Response, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
