# frozen_string_literal: true

module OpenAI
  module Helpers
    module Streaming
      class ResponseTextDeltaEvent < OpenAI::Models::Responses::ResponseTextDeltaEvent
        optional :snapshot, String, nil?: true
      end

      class ResponseTextDoneEvent < OpenAI::Models::Responses::ResponseTextDoneEvent
        optional :parsed, Object
      end

      class ResponseFunctionCallArgumentsDeltaEvent < OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent
        optional :snapshot, String, nil?: true
      end

      class ResponseCompletedEvent < OpenAI::Models::Responses::ResponseCompletedEvent
        required :response, OpenAI::Models::Responses::Response
      end
    end
  end
end
