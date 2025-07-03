# typed: strong

module OpenAI
  module Helpers
    module Streaming
      class ResponseTextDeltaEvent < OpenAI::Models::Responses::ResponseTextDeltaEvent
        sig { returns(String) }
        def snapshot
        end
      end

      class ResponseTextDoneEvent < OpenAI::Models::Responses::ResponseTextDoneEvent
        sig { returns(T.untyped) }
        def parsed
        end
      end

      class ResponseFunctionCallArgumentsDeltaEvent < OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent
        sig { returns(String) }
        def snapshot
        end
      end

      class ResponseCompletedEvent < OpenAI::Models::Responses::ResponseCompletedEvent
        sig { returns(OpenAI::Models::Responses::Response) }
        def response
        end
      end
    end
  end
end
