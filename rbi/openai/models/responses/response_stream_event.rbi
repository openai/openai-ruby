# typed: strong

module OpenAI
  module Models
    module Responses
      # Emitted when there is a partial audio response.
      module ResponseStreamEvent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseAudioDeltaEvent,
              OpenAI::Responses::ResponseAudioDoneEvent,
              OpenAI::Responses::ResponseAudioTranscriptDeltaEvent,
              OpenAI::Responses::ResponseAudioTranscriptDoneEvent,
              OpenAI::Responses::ResponseCodeInterpreterCallCodeDeltaEvent,
              OpenAI::Responses::ResponseCodeInterpreterCallCodeDoneEvent,
              OpenAI::Responses::ResponseCodeInterpreterCallCompletedEvent,
              OpenAI::Responses::ResponseCodeInterpreterCallInProgressEvent,
              OpenAI::Responses::ResponseCodeInterpreterCallInterpretingEvent,
              OpenAI::Responses::ResponseCompletedEvent,
              OpenAI::Responses::ResponseContentPartAddedEvent,
              OpenAI::Responses::ResponseContentPartDoneEvent,
              OpenAI::Responses::ResponseCreatedEvent,
              OpenAI::Responses::ResponseErrorEvent,
              OpenAI::Responses::ResponseFileSearchCallCompletedEvent,
              OpenAI::Responses::ResponseFileSearchCallInProgressEvent,
              OpenAI::Responses::ResponseFileSearchCallSearchingEvent,
              OpenAI::Responses::ResponseFunctionCallArgumentsDeltaEvent,
              OpenAI::Responses::ResponseFunctionCallArgumentsDoneEvent,
              OpenAI::Responses::ResponseInProgressEvent,
              OpenAI::Responses::ResponseFailedEvent,
              OpenAI::Responses::ResponseIncompleteEvent,
              OpenAI::Responses::ResponseOutputItemAddedEvent,
              OpenAI::Responses::ResponseOutputItemDoneEvent,
              OpenAI::Responses::ResponseReasoningSummaryPartAddedEvent,
              OpenAI::Responses::ResponseReasoningSummaryPartDoneEvent,
              OpenAI::Responses::ResponseReasoningSummaryTextDeltaEvent,
              OpenAI::Responses::ResponseReasoningSummaryTextDoneEvent,
              OpenAI::Responses::ResponseRefusalDeltaEvent,
              OpenAI::Responses::ResponseRefusalDoneEvent,
              OpenAI::Responses::ResponseTextAnnotationDeltaEvent,
              OpenAI::Responses::ResponseTextDeltaEvent,
              OpenAI::Responses::ResponseTextDoneEvent,
              OpenAI::Responses::ResponseWebSearchCallCompletedEvent,
              OpenAI::Responses::ResponseWebSearchCallInProgressEvent,
              OpenAI::Responses::ResponseWebSearchCallSearchingEvent
            )
          end

        sig do
          override.returns(
            T::Array[OpenAI::Responses::ResponseStreamEvent::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
