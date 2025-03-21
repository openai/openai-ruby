# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseCompletedEvent < OpenAI::BaseModel
        # Properties of the completed response.
        sig { returns(OpenAI::Models::Responses::Response) }
        attr_reader :response

        sig { params(response: T.any(OpenAI::Models::Responses::Response, OpenAI::Util::AnyHash)).void }
        attr_writer :response

        # The type of the event. Always `response.completed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the model response is complete.
        sig do
          params(response: T.any(OpenAI::Models::Responses::Response, OpenAI::Util::AnyHash), type: Symbol)
            .returns(T.attached_class)
        end
        def self.new(response:, type: :"response.completed")
        end

        sig { override.returns({response: OpenAI::Models::Responses::Response, type: Symbol}) }
        def to_hash
        end
      end
    end
  end
end
