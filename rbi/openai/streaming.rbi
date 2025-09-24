# typed: strong

module OpenAI
  module Streaming
    ResponseTextDeltaEvent = OpenAI::Helpers::Streaming::ResponseTextDeltaEvent
    ResponseTextDoneEvent = OpenAI::Helpers::Streaming::ResponseTextDoneEvent
    ResponseFunctionCallArgumentsDeltaEvent =
      OpenAI::Helpers::Streaming::ResponseFunctionCallArgumentsDeltaEvent
    ResponseCompletedEvent = OpenAI::Helpers::Streaming::ResponseCompletedEvent

    ChatChunkEvent = OpenAI::Helpers::Streaming::ChatChunkEvent
    ChatContentDeltaEvent = OpenAI::Helpers::Streaming::ChatContentDeltaEvent
    ChatContentDoneEvent = OpenAI::Helpers::Streaming::ChatContentDoneEvent
    ChatRefusalDeltaEvent = OpenAI::Helpers::Streaming::ChatRefusalDeltaEvent
    ChatRefusalDoneEvent = OpenAI::Helpers::Streaming::ChatRefusalDoneEvent
    ChatFunctionToolCallArgumentsDeltaEvent =
      OpenAI::Helpers::Streaming::ChatFunctionToolCallArgumentsDeltaEvent
    ChatFunctionToolCallArgumentsDoneEvent =
      OpenAI::Helpers::Streaming::ChatFunctionToolCallArgumentsDoneEvent
    ChatLogprobsContentDeltaEvent =
      OpenAI::Helpers::Streaming::ChatLogprobsContentDeltaEvent
    ChatLogprobsContentDoneEvent =
      OpenAI::Helpers::Streaming::ChatLogprobsContentDoneEvent
    ChatLogprobsRefusalDeltaEvent =
      OpenAI::Helpers::Streaming::ChatLogprobsRefusalDeltaEvent
    ChatLogprobsRefusalDoneEvent =
      OpenAI::Helpers::Streaming::ChatLogprobsRefusalDoneEvent

    ResponseStream = OpenAI::Helpers::Streaming::ResponseStream
    ChatCompletionStream = OpenAI::Helpers::Streaming::ChatCompletionStream
  end
end
