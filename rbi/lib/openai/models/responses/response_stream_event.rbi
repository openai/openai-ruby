# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseStreamEvent < OpenAI::Union
        abstract!

        class << self
          sig do
            override
              .returns(
                [[Symbol, OpenAI::Models::Responses::ResponseAudioDeltaEvent], [Symbol, OpenAI::Models::Responses::ResponseAudioDoneEvent], [Symbol, OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent], [Symbol, OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent], [Symbol, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent], [Symbol, OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent], [Symbol, OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent], [Symbol, OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent], [Symbol, OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent], [Symbol, OpenAI::Models::Responses::ResponseCompletedEvent], [Symbol, OpenAI::Models::Responses::ResponseContentPartAddedEvent], [Symbol, OpenAI::Models::Responses::ResponseContentPartDoneEvent], [Symbol, OpenAI::Models::Responses::ResponseCreatedEvent], [Symbol, OpenAI::Models::Responses::ResponseErrorEvent], [Symbol, OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent], [Symbol, OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent], [Symbol, OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent], [Symbol, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent], [Symbol, OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent], [Symbol, OpenAI::Models::Responses::ResponseInProgressEvent], [Symbol, OpenAI::Models::Responses::ResponseFailedEvent], [Symbol, OpenAI::Models::Responses::ResponseIncompleteEvent], [Symbol, OpenAI::Models::Responses::ResponseOutputItemAddedEvent], [Symbol, OpenAI::Models::Responses::ResponseOutputItemDoneEvent], [Symbol, OpenAI::Models::Responses::ResponseRefusalDeltaEvent], [Symbol, OpenAI::Models::Responses::ResponseRefusalDoneEvent], [Symbol, OpenAI::Models::Responses::ResponseTextAnnotationDeltaEvent], [Symbol, OpenAI::Models::Responses::ResponseTextDeltaEvent], [Symbol, OpenAI::Models::Responses::ResponseTextDoneEvent], [Symbol, OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent], [Symbol, OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent], [Symbol, OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent]]
              )
          end
          private def variants
          end
        end
      end
    end
  end
end
