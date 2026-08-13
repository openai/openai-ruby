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
              OpenAI::Beta::BetaResponseInjectCreatedEvent,
              OpenAI::Beta::BetaResponseInjectFailedEvent,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseAudioWsDelta,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseAudioWsDone,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDelta,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDone,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDelta,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDone,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsCompleted,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallInWsProgress,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsInterpreting,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsCompleted,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsAdded,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsDone,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsCreated,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsCompleted,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallInWsProgress,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsSearching,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDelta,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDone,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseInWsProgress,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsFailed,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsIncomplete,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsAdded,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsDone,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsAdded,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsDone,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDelta,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDone,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDelta,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDone,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDelta,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDone,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseTextWsDelta,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseTextWsDone,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsCompleted,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallInWsProgress,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsSearching,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsCompleted,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsGenerating,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallInWsProgress,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallPartialWsImage,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDelta,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDone,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsCompleted,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsFailed,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallInWsProgress,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsCompleted,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsFailed,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsInWsProgress,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseOutputTextAnnotationWsAdded,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsQueued,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDelta,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDone
            )
          end

        class BetaResponseAudioWsDelta < OpenAI::Models::Beta::BetaResponseAudioDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseAudioWsDelta,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when there is a partial audio response.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseAudioWsDone < OpenAI::Models::Beta::BetaResponseAudioDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseAudioWsDone,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when the audio response is complete.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseAudioTranscriptWsDelta < OpenAI::Models::Beta::BetaResponseAudioTranscriptDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDelta,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when there is a partial transcript of audio.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseAudioTranscriptWsDone < OpenAI::Models::Beta::BetaResponseAudioTranscriptDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseAudioTranscriptWsDone,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when the full audio transcript is completed.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseCodeInterpreterCallCodeWsDelta < OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDelta,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a partial code snippet is streamed by the code interpreter.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseCodeInterpreterCallCodeWsDone < OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallCodeWsDone,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when the code snippet is finalized by the code interpreter.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseCodeInterpreterCallWsCompleted < OpenAI::Models::Beta::BetaResponseCodeInterpreterCallCompletedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsCompleted,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when the code interpreter call is completed.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseCodeInterpreterCallInWsProgress < OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInProgressEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallInWsProgress,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a code interpreter call is in progress.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseCodeInterpreterCallWsInterpreting < OpenAI::Models::Beta::BetaResponseCodeInterpreterCallInterpretingEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCodeInterpreterCallWsInterpreting,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when the code interpreter is actively interpreting the code snippet.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseWsCompleted < OpenAI::Models::Beta::BetaResponseCompletedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsCompleted,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when the model response is complete.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseContentPartWsAdded < OpenAI::Models::Beta::BetaResponseContentPartAddedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsAdded,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a new content part is added.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseContentPartWsDone < OpenAI::Models::Beta::BetaResponseContentPartDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseContentPartWsDone,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a content part is done.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseWsCreated < OpenAI::Models::Beta::BetaResponseCreatedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsCreated,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # An event that is emitted when a response is created.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseWsError < OpenAI::Models::Beta::BetaResponseErrorEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when an error occurs.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseFileSearchCallWsCompleted < OpenAI::Models::Beta::BetaResponseFileSearchCallCompletedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsCompleted,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a file search call is completed (results found).
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseFileSearchCallInWsProgress < OpenAI::Models::Beta::BetaResponseFileSearchCallInProgressEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallInWsProgress,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a file search call is initiated.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseFileSearchCallWsSearching < OpenAI::Models::Beta::BetaResponseFileSearchCallSearchingEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsSearching,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a file search is currently searching.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseFunctionCallArgumentsWsDelta < OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDelta,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when there is a partial function-call arguments delta.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseFunctionCallArgumentsWsDone < OpenAI::Models::Beta::BetaResponseFunctionCallArgumentsDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDone,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when function-call arguments are finalized.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseInWsProgress < OpenAI::Models::Beta::BetaResponseInProgressEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseInWsProgress,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when the response is in progress.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseWsFailed < OpenAI::Models::Beta::BetaResponseFailedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsFailed,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # An event that is emitted when a response fails.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseWsIncomplete < OpenAI::Models::Beta::BetaResponseIncompleteEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsIncomplete,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # An event that is emitted when a response finishes as incomplete.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseOutputItemWsAdded < OpenAI::Models::Beta::BetaResponseOutputItemAddedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsAdded,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a new output item is added.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseOutputItemWsDone < OpenAI::Models::Beta::BetaResponseOutputItemDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseOutputItemWsDone,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when an output item is marked done.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseReasoningSummaryPartWsAdded < OpenAI::Models::Beta::BetaResponseReasoningSummaryPartAddedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsAdded,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a new reasoning summary part is added.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseReasoningSummaryPartWsDone < OpenAI::Models::Beta::BetaResponseReasoningSummaryPartDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryPartWsDone,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a reasoning summary part is completed.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseReasoningSummaryTextWsDelta < OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDelta,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a delta is added to a reasoning summary text.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseReasoningSummaryTextWsDone < OpenAI::Models::Beta::BetaResponseReasoningSummaryTextDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningSummaryTextWsDone,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a reasoning summary text is completed.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseReasoningTextWsDelta < OpenAI::Models::Beta::BetaResponseReasoningTextDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDelta,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a delta is added to a reasoning text.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseReasoningTextWsDone < OpenAI::Models::Beta::BetaResponseReasoningTextDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseReasoningTextWsDone,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a reasoning text is completed.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseRefusalWsDelta < OpenAI::Models::Beta::BetaResponseRefusalDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDelta,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when there is a partial refusal text.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseRefusalWsDone < OpenAI::Models::Beta::BetaResponseRefusalDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseRefusalWsDone,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when refusal text is finalized.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseTextWsDelta < OpenAI::Models::Beta::BetaResponseTextDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseTextWsDelta,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when there is an additional text delta.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseTextWsDone < OpenAI::Models::Beta::BetaResponseTextDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseTextWsDone,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when text content is finalized.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseWebSearchCallWsCompleted < OpenAI::Models::Beta::BetaResponseWebSearchCallCompletedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsCompleted,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a web search call is completed.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseWebSearchCallInWsProgress < OpenAI::Models::Beta::BetaResponseWebSearchCallInProgressEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallInWsProgress,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a web search call is initiated.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseWebSearchCallWsSearching < OpenAI::Models::Beta::BetaResponseWebSearchCallSearchingEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWebSearchCallWsSearching,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a web search call is executing.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseImageGenCallWsCompleted < OpenAI::Models::Beta::BetaResponseImageGenCallCompletedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsCompleted,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when an image generation tool call has completed and the final image is
          # available.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseImageGenCallWsGenerating < OpenAI::Models::Beta::BetaResponseImageGenCallGeneratingEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallWsGenerating,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when an image generation tool call is actively generating an image
          # (intermediate state).
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseImageGenCallInWsProgress < OpenAI::Models::Beta::BetaResponseImageGenCallInProgressEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallInWsProgress,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when an image generation tool call is in progress.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseImageGenCallPartialWsImage < OpenAI::Models::Beta::BetaResponseImageGenCallPartialImageEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseImageGenCallPartialWsImage,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a partial image is available during image generation streaming.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseMcpCallArgumentsWsDelta < OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDelta,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when there is a delta (partial update) to the arguments of an MCP tool
          # call.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseMcpCallArgumentsWsDone < OpenAI::Models::Beta::BetaResponseMcpCallArgumentsDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallArgumentsWsDone,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when the arguments for an MCP tool call are finalized.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseMcpCallWsCompleted < OpenAI::Models::Beta::BetaResponseMcpCallCompletedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsCompleted,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when an MCP tool call has completed successfully.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseMcpCallWsFailed < OpenAI::Models::Beta::BetaResponseMcpCallFailedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallWsFailed,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when an MCP tool call has failed.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseMcpCallInWsProgress < OpenAI::Models::Beta::BetaResponseMcpCallInProgressEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpCallInWsProgress,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when an MCP tool call is in progress.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseMcpListToolsWsCompleted < OpenAI::Models::Beta::BetaResponseMcpListToolsCompletedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsCompleted,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when the list of available MCP tools has been successfully retrieved.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseMcpListToolsWsFailed < OpenAI::Models::Beta::BetaResponseMcpListToolsFailedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsWsFailed,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when the attempt to list available MCP tools has failed.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseMcpListToolsInWsProgress < OpenAI::Models::Beta::BetaResponseMcpListToolsInProgressEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseMcpListToolsInWsProgress,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when the system is in the process of retrieving the list of available
          # MCP tools.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseOutputTextAnnotationWsAdded < OpenAI::Models::Beta::BetaResponseOutputTextAnnotationAddedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseOutputTextAnnotationWsAdded,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when an annotation is added to output text content.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseWsQueued < OpenAI::Models::Beta::BetaResponseQueuedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsQueued,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when a response is queued and waiting to be processed.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseCustomToolCallInputWsDelta < OpenAI::Models::Beta::BetaResponseCustomToolCallInputDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDelta,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Event representing a delta (partial update) to the input of a custom tool call.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
        end

        class BetaResponseCustomToolCallInputWsDone < OpenAI::Models::Beta::BetaResponseCustomToolCallInputDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseCustomToolCallInputWsDone,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Event indicating that input for a custom tool call is complete.
          sig { params(stream_id: String).returns(T.attached_class) }
          def self.new(
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil
          )
          end

          sig { override.returns({ stream_id: String }) }
          def to_hash
          end
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
