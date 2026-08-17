# frozen_string_literal: true

module OpenAI
  module Helpers
    module Streaming
      class ResponseTextDeltaEvent < OpenAI::Models::Responses::ResponseTextDeltaEvent
        required :snapshot, String
      end

      class ResponseTextDoneEvent < OpenAI::Models::Responses::ResponseTextDoneEvent
        optional :parsed, Object
      end

      class ResponseFunctionCallArgumentsDeltaEvent < OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent
        required :snapshot, String
      end

      class ResponseCompletedEvent < OpenAI::Models::Responses::ResponseCompletedEvent
        required :response, OpenAI::Models::Responses::Response
      end
    end
  end
end
