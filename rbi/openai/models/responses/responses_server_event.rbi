# typed: strong

module OpenAI
  module Models
    module Responses
      # Server events emitted by the Responses WebSocket server.
      module ResponsesServerEvent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponsesServerEvent::ResponseAudioWsDelta,
              OpenAI::Responses::ResponsesServerEvent::ResponseAudioWsDone,
              OpenAI::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDelta,
              OpenAI::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDone,
              OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDelta,
              OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDone,
              OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsCompleted,
              OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallInWsProgress,
              OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsInterpreting,
              OpenAI::Responses::ResponsesServerEvent::ResponseWsCompleted,
              OpenAI::Responses::ResponsesServerEvent::ResponseContentPartWsAdded,
              OpenAI::Responses::ResponsesServerEvent::ResponseContentPartWsDone,
              OpenAI::Responses::ResponsesServerEvent::ResponseWsCreated,
              OpenAI::Responses::ResponsesServerEvent::ResponseWsError,
              OpenAI::Responses::ResponsesServerEvent::ResponseFileSearchCallWsCompleted,
              OpenAI::Responses::ResponsesServerEvent::ResponseFileSearchCallInWsProgress,
              OpenAI::Responses::ResponsesServerEvent::ResponseFileSearchCallWsSearching,
              OpenAI::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDelta,
              OpenAI::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDone,
              OpenAI::Responses::ResponsesServerEvent::ResponseInWsProgress,
              OpenAI::Responses::ResponsesServerEvent::ResponseWsFailed,
              OpenAI::Responses::ResponsesServerEvent::ResponseWsIncomplete,
              OpenAI::Responses::ResponsesServerEvent::ResponseOutputItemWsAdded,
              OpenAI::Responses::ResponsesServerEvent::ResponseOutputItemWsDone,
              OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsAdded,
              OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsDone,
              OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDelta,
              OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDone,
              OpenAI::Responses::ResponsesServerEvent::ResponseReasoningTextWsDelta,
              OpenAI::Responses::ResponsesServerEvent::ResponseReasoningTextWsDone,
              OpenAI::Responses::ResponsesServerEvent::ResponseRefusalWsDelta,
              OpenAI::Responses::ResponsesServerEvent::ResponseRefusalWsDone,
              OpenAI::Responses::ResponsesServerEvent::ResponseTextWsDelta,
              OpenAI::Responses::ResponsesServerEvent::ResponseTextWsDone,
              OpenAI::Responses::ResponsesServerEvent::ResponseWebSearchCallWsCompleted,
              OpenAI::Responses::ResponsesServerEvent::ResponseWebSearchCallInWsProgress,
              OpenAI::Responses::ResponsesServerEvent::ResponseWebSearchCallWsSearching,
              OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallWsCompleted,
              OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallWsGenerating,
              OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallInWsProgress,
              OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallPartialWsImage,
              OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDelta,
              OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDone,
              OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallWsCompleted,
              OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallWsFailed,
              OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallInWsProgress,
              OpenAI::Responses::ResponsesServerEvent::ResponseMcpListToolsWsCompleted,
              OpenAI::Responses::ResponsesServerEvent::ResponseMcpListToolsWsFailed,
              OpenAI::Responses::ResponsesServerEvent::ResponseMcpListToolsInWsProgress,
              OpenAI::Responses::ResponsesServerEvent::ResponseOutputTextAnnotationWsAdded,
              OpenAI::Responses::ResponsesServerEvent::ResponseWsQueued,
              OpenAI::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDelta,
              OpenAI::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDone
            )
          end

        class ResponseAudioWsDelta < OpenAI::Models::Responses::ResponseAudioDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseAudioWsDelta,
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

        class ResponseAudioWsDone < OpenAI::Models::Responses::ResponseAudioDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseAudioWsDone,
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

        class ResponseAudioTranscriptWsDelta < OpenAI::Models::Responses::ResponseAudioTranscriptDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDelta,
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

        class ResponseAudioTranscriptWsDone < OpenAI::Models::Responses::ResponseAudioTranscriptDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseAudioTranscriptWsDone,
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

        class ResponseCodeInterpreterCallCodeWsDelta < OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDelta,
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

        class ResponseCodeInterpreterCallCodeWsDone < OpenAI::Models::Responses::ResponseCodeInterpreterCallCodeDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallCodeWsDone,
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

        class ResponseCodeInterpreterCallWsCompleted < OpenAI::Models::Responses::ResponseCodeInterpreterCallCompletedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsCompleted,
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

        class ResponseCodeInterpreterCallInWsProgress < OpenAI::Models::Responses::ResponseCodeInterpreterCallInProgressEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallInWsProgress,
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

        class ResponseCodeInterpreterCallWsInterpreting < OpenAI::Models::Responses::ResponseCodeInterpreterCallInterpretingEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseCodeInterpreterCallWsInterpreting,
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

        class ResponseWsCompleted < OpenAI::Models::Responses::ResponseCompletedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseWsCompleted,
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

        class ResponseContentPartWsAdded < OpenAI::Models::Responses::ResponseContentPartAddedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseContentPartWsAdded,
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

        class ResponseContentPartWsDone < OpenAI::Models::Responses::ResponseContentPartDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseContentPartWsDone,
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

        class ResponseWsCreated < OpenAI::Models::Responses::ResponseCreatedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseWsCreated,
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

        class ResponseWsError < OpenAI::Models::Responses::ResponseErrorEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseWsError,
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

        class ResponseFileSearchCallWsCompleted < OpenAI::Models::Responses::ResponseFileSearchCallCompletedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseFileSearchCallWsCompleted,
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

        class ResponseFileSearchCallInWsProgress < OpenAI::Models::Responses::ResponseFileSearchCallInProgressEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseFileSearchCallInWsProgress,
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

        class ResponseFileSearchCallWsSearching < OpenAI::Models::Responses::ResponseFileSearchCallSearchingEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseFileSearchCallWsSearching,
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

        class ResponseFunctionCallArgumentsWsDelta < OpenAI::Models::Responses::ResponseFunctionCallArgumentsDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDelta,
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

        class ResponseFunctionCallArgumentsWsDone < OpenAI::Models::Responses::ResponseFunctionCallArgumentsDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseFunctionCallArgumentsWsDone,
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

        class ResponseInWsProgress < OpenAI::Models::Responses::ResponseInProgressEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseInWsProgress,
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

        class ResponseWsFailed < OpenAI::Models::Responses::ResponseFailedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseWsFailed,
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

        class ResponseWsIncomplete < OpenAI::Models::Responses::ResponseIncompleteEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseWsIncomplete,
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

        class ResponseOutputItemWsAdded < OpenAI::Models::Responses::ResponseOutputItemAddedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseOutputItemWsAdded,
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

        class ResponseOutputItemWsDone < OpenAI::Models::Responses::ResponseOutputItemDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseOutputItemWsDone,
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

        class ResponseReasoningSummaryPartWsAdded < OpenAI::Models::Responses::ResponseReasoningSummaryPartAddedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsAdded,
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

        class ResponseReasoningSummaryPartWsDone < OpenAI::Models::Responses::ResponseReasoningSummaryPartDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryPartWsDone,
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

        class ResponseReasoningSummaryTextWsDelta < OpenAI::Models::Responses::ResponseReasoningSummaryTextDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDelta,
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

        class ResponseReasoningSummaryTextWsDone < OpenAI::Models::Responses::ResponseReasoningSummaryTextDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseReasoningSummaryTextWsDone,
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

        class ResponseReasoningTextWsDelta < OpenAI::Models::Responses::ResponseReasoningTextDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseReasoningTextWsDelta,
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

        class ResponseReasoningTextWsDone < OpenAI::Models::Responses::ResponseReasoningTextDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseReasoningTextWsDone,
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

        class ResponseRefusalWsDelta < OpenAI::Models::Responses::ResponseRefusalDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseRefusalWsDelta,
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

        class ResponseRefusalWsDone < OpenAI::Models::Responses::ResponseRefusalDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseRefusalWsDone,
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

        class ResponseTextWsDelta < OpenAI::Models::Responses::ResponseTextDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseTextWsDelta,
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

        class ResponseTextWsDone < OpenAI::Models::Responses::ResponseTextDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseTextWsDone,
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

        class ResponseWebSearchCallWsCompleted < OpenAI::Models::Responses::ResponseWebSearchCallCompletedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseWebSearchCallWsCompleted,
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

        class ResponseWebSearchCallInWsProgress < OpenAI::Models::Responses::ResponseWebSearchCallInProgressEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseWebSearchCallInWsProgress,
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

        class ResponseWebSearchCallWsSearching < OpenAI::Models::Responses::ResponseWebSearchCallSearchingEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseWebSearchCallWsSearching,
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

        class ResponseImageGenCallWsCompleted < OpenAI::Models::Responses::ResponseImageGenCallCompletedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallWsCompleted,
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

        class ResponseImageGenCallWsGenerating < OpenAI::Models::Responses::ResponseImageGenCallGeneratingEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallWsGenerating,
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

        class ResponseImageGenCallInWsProgress < OpenAI::Models::Responses::ResponseImageGenCallInProgressEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallInWsProgress,
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

        class ResponseImageGenCallPartialWsImage < OpenAI::Models::Responses::ResponseImageGenCallPartialImageEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseImageGenCallPartialWsImage,
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

        class ResponseMcpCallArgumentsWsDelta < OpenAI::Models::Responses::ResponseMcpCallArgumentsDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDelta,
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

        class ResponseMcpCallArgumentsWsDone < OpenAI::Models::Responses::ResponseMcpCallArgumentsDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallArgumentsWsDone,
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

        class ResponseMcpCallWsCompleted < OpenAI::Models::Responses::ResponseMcpCallCompletedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallWsCompleted,
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

        class ResponseMcpCallWsFailed < OpenAI::Models::Responses::ResponseMcpCallFailedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallWsFailed,
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

        class ResponseMcpCallInWsProgress < OpenAI::Models::Responses::ResponseMcpCallInProgressEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseMcpCallInWsProgress,
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

        class ResponseMcpListToolsWsCompleted < OpenAI::Models::Responses::ResponseMcpListToolsCompletedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseMcpListToolsWsCompleted,
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

        class ResponseMcpListToolsWsFailed < OpenAI::Models::Responses::ResponseMcpListToolsFailedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseMcpListToolsWsFailed,
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

        class ResponseMcpListToolsInWsProgress < OpenAI::Models::Responses::ResponseMcpListToolsInProgressEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseMcpListToolsInWsProgress,
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

        class ResponseOutputTextAnnotationWsAdded < OpenAI::Models::Responses::ResponseOutputTextAnnotationAddedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseOutputTextAnnotationWsAdded,
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

        class ResponseWsQueued < OpenAI::Models::Responses::ResponseQueuedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseWsQueued,
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

        class ResponseCustomToolCallInputWsDelta < OpenAI::Models::Responses::ResponseCustomToolCallInputDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDelta,
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

        class ResponseCustomToolCallInputWsDone < OpenAI::Models::Responses::ResponseCustomToolCallInputDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Responses::ResponsesServerEvent::ResponseCustomToolCallInputWsDone,
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
            T::Array[OpenAI::Responses::ResponsesServerEvent::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
