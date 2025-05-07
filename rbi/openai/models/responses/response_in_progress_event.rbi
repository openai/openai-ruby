# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseInProgressEvent < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias { T.any(T.self_type, OpenAI::Internal::AnyHash) }

        # The response that is in progress.
        sig { returns(OpenAI::Responses::Response) }
        attr_reader :response

        sig { params(response: OpenAI::Responses::Response::OrHash).void }
        attr_writer :response

        # The type of the event. Always `response.in_progress`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the response is in progress.
        sig do
          params(
            response: OpenAI::Responses::Response::OrHash,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The response that is in progress.
          response:,
          # The type of the event. Always `response.in_progress`.
          type: :"response.in_progress"
        )
        end

        sig do
          override.returns(
            { response: OpenAI::Responses::Response, type: Symbol }
          )
        end
        def to_hash
        end
      end
    end
  end
end
