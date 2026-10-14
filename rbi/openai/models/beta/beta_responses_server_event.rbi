# typed: strong

module OpenAI
  module Models
    BetaResponsesServerEvent = Beta::BetaResponsesServerEvent

    module Beta
      # Server events emitted by the Responses WebSocket server.
      module BetaResponsesServerEvent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseAudioDeltaEvent,
              OpenAI::Beta::BetaResponseAudioDoneEvent,
              OpenAI::Beta::BetaResponseAudioTranscriptDeltaEvent,
              OpenAI::Beta::BetaResponseAudioTranscriptDoneEvent,
              OpenAI::Beta::BetaResponseCodeInterpreterCallCodeDeltaEvent,
              OpenAI::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent,
              OpenAI::Beta::BetaResponseCodeInterpreterCallCompletedEvent,
              OpenAI::Beta::BetaResponseCodeInterpreterCallInProgressEvent,
              OpenAI::Beta::BetaResponseCodeInterpreterCallInterpretingEvent,
              OpenAI::Beta::BetaResponseCompletedEvent,
              OpenAI::Beta::BetaResponseContentPartAddedEvent,
              OpenAI::Beta::BetaResponseContentPartDoneEvent,
              OpenAI::Beta::BetaResponseCreatedEvent,
              OpenAI::Beta::BetaResponseErrorEvent,
              OpenAI::Beta::BetaResponseFileSearchCallCompletedEvent,
              OpenAI::Beta::BetaResponseFileSearchCallInProgressEvent,
              OpenAI::Beta::BetaResponseFileSearchCallSearchingEvent,
              OpenAI::Beta::BetaResponseFunctionCallArgumentsDeltaEvent,
              OpenAI::Beta::BetaResponseFunctionCallArgumentsDoneEvent,
              OpenAI::Beta::BetaResponseInProgressEvent,
              OpenAI::Beta::BetaResponseFailedEvent,
              OpenAI::Beta::BetaResponseIncompleteEvent,
              OpenAI::Beta::BetaResponseOutputItemAddedEvent,
              OpenAI::Beta::BetaResponseOutputItemDoneEvent,
              OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent,
              OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent,
              OpenAI::Beta::BetaResponseReasoningSummaryTextDeltaEvent,
              OpenAI::Beta::BetaResponseReasoningSummaryTextDoneEvent,
              OpenAI::Beta::BetaResponseReasoningTextDeltaEvent,
              OpenAI::Beta::BetaResponseReasoningTextDoneEvent,
              OpenAI::Beta::BetaResponseRefusalDeltaEvent,
              OpenAI::Beta::BetaResponseRefusalDoneEvent,
              OpenAI::Beta::BetaResponseTextDeltaEvent,
              OpenAI::Beta::BetaResponseTextDoneEvent,
              OpenAI::Beta::BetaResponseWebSearchCallCompletedEvent,
              OpenAI::Beta::BetaResponseWebSearchCallInProgressEvent,
              OpenAI::Beta::BetaResponseWebSearchCallSearchingEvent,
              OpenAI::Beta::BetaResponseImageGenCallCompletedEvent,
              OpenAI::Beta::BetaResponseImageGenCallGeneratingEvent,
              OpenAI::Beta::BetaResponseImageGenCallInProgressEvent,
              OpenAI::Beta::BetaResponseImageGenCallPartialImageEvent,
              OpenAI::Beta::BetaResponseMcpCallArgumentsDeltaEvent,
              OpenAI::Beta::BetaResponseMcpCallArgumentsDoneEvent,
              OpenAI::Beta::BetaResponseMcpCallCompletedEvent,
              OpenAI::Beta::BetaResponseMcpCallFailedEvent,
              OpenAI::Beta::BetaResponseMcpCallInProgressEvent,
              OpenAI::Beta::BetaResponseMcpListToolsCompletedEvent,
              OpenAI::Beta::BetaResponseMcpListToolsFailedEvent,
              OpenAI::Beta::BetaResponseMcpListToolsInProgressEvent,
              OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent,
              OpenAI::Beta::BetaResponseQueuedEvent,
              OpenAI::Beta::BetaResponseCustomToolCallInputDeltaEvent,
              OpenAI::Beta::BetaResponseCustomToolCallInputDoneEvent,
              OpenAI::Beta::BetaResponseInjectCreatedEvent,
              OpenAI::Beta::BetaResponseInjectFailedEvent
            )
          end

        sig do
          override.returns(
            T::Array[OpenAI::Beta::BetaResponsesServerEvent::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
