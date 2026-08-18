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
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError,
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
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsCompleted,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallInWsProgress,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFileSearchCallWsSearching,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDelta,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseFunctionCallArgumentsWsDone,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseShellCallCommandWsAdded,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseShellCallCommandWsDelta,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseShellCallCommandWsDone,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseShellCallOutputContentWsDelta,
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseShellCallOutputContentWsDone,
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
          sig do
            params(
              delta: String,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseAudioDeltaEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # A chunk of Base64 encoded response audio bytes.
            delta:,
            # A sequence number for this chunk of the stream response.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.audio.delta`.
            type: :"response.audio.delta"
          )
          end

          sig do
            override.returns(
              {
                delta: String,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(OpenAI::Beta::BetaResponseAudioDeltaEvent::Agent),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseAudioDoneEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The sequence number of the delta.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.audio.done`.
            type: :"response.audio.done"
          )
          end

          sig do
            override.returns(
              {
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(OpenAI::Beta::BetaResponseAudioDoneEvent::Agent),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              delta: String,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseAudioTranscriptDeltaEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The partial transcript of the audio response.
            delta:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.audio.transcript.delta`.
            type: :"response.audio.transcript.delta"
          )
          end

          sig do
            override.returns(
              {
                delta: String,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseAudioTranscriptDeltaEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseAudioTranscriptDoneEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.audio.transcript.done`.
            type: :"response.audio.transcript.done"
          )
          end

          sig do
            override.returns(
              {
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseAudioTranscriptDoneEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseCodeInterpreterCallCodeDeltaEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The partial code snippet being streamed by the code interpreter.
            delta:,
            # The unique identifier of the code interpreter tool call item.
            item_id:,
            # The index of the output item in the response for which the code is being
            # streamed.
            output_index:,
            # The sequence number of this event, used to order streaming events.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.code_interpreter_call_code.delta`.
            type: :"response.code_interpreter_call_code.delta"
          )
          end

          sig do
            override.returns(
              {
                delta: String,
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseCodeInterpreterCallCodeDeltaEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              code: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The final code snippet output by the code interpreter.
            code:,
            # The unique identifier of the code interpreter tool call item.
            item_id:,
            # The index of the output item in the response for which the code is finalized.
            output_index:,
            # The sequence number of this event, used to order streaming events.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.code_interpreter_call_code.done`.
            type: :"response.code_interpreter_call_code.done"
          )
          end

          sig do
            override.returns(
              {
                code: String,
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseCodeInterpreterCallCompletedEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique identifier of the code interpreter tool call item.
            item_id:,
            # The index of the output item in the response for which the code interpreter call
            # is completed.
            output_index:,
            # The sequence number of this event, used to order streaming events.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.code_interpreter_call.completed`.
            type: :"response.code_interpreter_call.completed"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseCodeInterpreterCallCompletedEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseCodeInterpreterCallInProgressEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique identifier of the code interpreter tool call item.
            item_id:,
            # The index of the output item in the response for which the code interpreter call
            # is in progress.
            output_index:,
            # The sequence number of this event, used to order streaming events.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.code_interpreter_call.in_progress`.
            type: :"response.code_interpreter_call.in_progress"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseCodeInterpreterCallInProgressEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseCodeInterpreterCallInterpretingEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique identifier of the code interpreter tool call item.
            item_id:,
            # The index of the output item in the response for which the code interpreter is
            # interpreting code.
            output_index:,
            # The sequence number of this event, used to order streaming events.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.code_interpreter_call.interpreting`.
            type: :"response.code_interpreter_call.interpreting"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseCodeInterpreterCallInterpretingEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              response: OpenAI::Beta::BetaResponse::OrHash,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseCompletedEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Properties of the completed response.
            response:,
            # The sequence number for this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.completed`.
            type: :"response.completed"
          )
          end

          sig do
            override.returns(
              {
                response: OpenAI::Beta::BetaResponse,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(OpenAI::Beta::BetaResponseCompletedEvent::Agent),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              item_id: String,
              output_index: Integer,
              part:
                T.any(
                  OpenAI::Beta::BetaResponseOutputText::OrHash,
                  OpenAI::Beta::BetaResponseOutputRefusal::OrHash,
                  OpenAI::Beta::BetaResponseContentPartAddedEvent::Part::ReasoningText::OrHash
                ),
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseContentPartAddedEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the content part that was added.
            content_index:,
            # The ID of the output item that the content part was added to.
            item_id:,
            # The index of the output item that the content part was added to.
            output_index:,
            # The content part that was added.
            part:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.content_part.added`.
            type: :"response.content_part.added"
          )
          end

          sig do
            override.returns(
              {
                content_index: Integer,
                item_id: String,
                output_index: Integer,
                part:
                  OpenAI::Beta::BetaResponseContentPartAddedEvent::Part::Variants,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseContentPartAddedEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              item_id: String,
              output_index: Integer,
              part:
                T.any(
                  OpenAI::Beta::BetaResponseOutputText::OrHash,
                  OpenAI::Beta::BetaResponseOutputRefusal::OrHash,
                  OpenAI::Beta::BetaResponseContentPartDoneEvent::Part::ReasoningText::OrHash
                ),
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseContentPartDoneEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the content part that is done.
            content_index:,
            # The ID of the output item that the content part was added to.
            item_id:,
            # The index of the output item that the content part was added to.
            output_index:,
            # The content part that is done.
            part:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.content_part.done`.
            type: :"response.content_part.done"
          )
          end

          sig do
            override.returns(
              {
                content_index: Integer,
                item_id: String,
                output_index: Integer,
                part:
                  OpenAI::Beta::BetaResponseContentPartDoneEvent::Part::Variants,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseContentPartDoneEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              response: OpenAI::Beta::BetaResponse::OrHash,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseCreatedEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The response that was created.
            response:,
            # The sequence number for this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.created`.
            type: :"response.created"
          )
          end

          sig do
            override.returns(
              {
                response: OpenAI::Beta::BetaResponse,
                sequence_number: Integer,
                type: Symbol,
                agent: T.nilable(OpenAI::Beta::BetaResponseCreatedEvent::Agent),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseFileSearchCallCompletedEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the output item that the file search call is initiated.
            item_id:,
            # The index of the output item that the file search call is initiated.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.file_search_call.completed`.
            type: :"response.file_search_call.completed"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseFileSearchCallCompletedEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseFileSearchCallInProgressEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the output item that the file search call is initiated.
            item_id:,
            # The index of the output item that the file search call is initiated.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.file_search_call.in_progress`.
            type: :"response.file_search_call.in_progress"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseFileSearchCallInProgressEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseFileSearchCallSearchingEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the output item that the file search call is initiated.
            item_id:,
            # The index of the output item that the file search call is searching.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.file_search_call.searching`.
            type: :"response.file_search_call.searching"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseFileSearchCallSearchingEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseFunctionCallArgumentsDeltaEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The function-call arguments delta that is added.
            delta:,
            # The ID of the output item that the function-call arguments delta is added to.
            item_id:,
            # The index of the output item that the function-call arguments delta is added to.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.function_call_arguments.delta`.
            type: :"response.function_call_arguments.delta"
          )
          end

          sig do
            override.returns(
              {
                delta: String,
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseFunctionCallArgumentsDeltaEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              arguments: String,
              item_id: String,
              name: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseFunctionCallArgumentsDoneEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The function-call arguments.
            arguments:,
            # The ID of the item.
            item_id:,
            # The name of the function that was called.
            name:,
            # The index of the output item.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            type: :"response.function_call_arguments.done"
          )
          end

          sig do
            override.returns(
              {
                arguments: String,
                item_id: String,
                name: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseFunctionCallArgumentsDoneEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
          def to_hash
          end
        end

        class BetaResponseShellCallCommandWsAdded < OpenAI::Models::Beta::BetaResponseShellCallCommandAddedEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseShellCallCommandWsAdded,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # A streaming event that indicated a shell command was added to a tool call.
          sig do
            params(
              command: String,
              command_index: Integer,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                OpenAI::Beta::BetaResponseShellCallCommandAddedEvent::Agent::OrHash,
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The shell command that was added.
            command:,
            # The index of the shell command that was added.
            command_index:,
            # The index of the output item that was updated.
            output_index:,
            # The sequence number of the event that was emitted.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event, always `response.shell_call_command.added`.
            type: :"response.shell_call_command.added"
          )
          end

          sig do
            override.returns(
              {
                command: String,
                command_index: Integer,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  OpenAI::Beta::BetaResponseShellCallCommandAddedEvent::Agent,
                stream_id: String
              }
            )
          end
          def to_hash
          end
        end

        class BetaResponseShellCallCommandWsDelta < OpenAI::Models::Beta::BetaResponseShellCallCommandDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseShellCallCommandWsDelta,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # A streaming event that indicated a shell command was incrementally updated.
          sig do
            params(
              command_index: Integer,
              delta: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                OpenAI::Beta::BetaResponseShellCallCommandDeltaEvent::Agent::OrHash,
              obfuscation: String,
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the shell command that was updated.
            command_index:,
            # The shell command delta that was appended.
            delta:,
            # The index of the output item that was updated.
            output_index:,
            # The sequence number of the event that was emitted.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # An obfuscation string that was added to pad the event payload.
            obfuscation: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event, always `response.shell_call_command.delta`.
            type: :"response.shell_call_command.delta"
          )
          end

          sig do
            override.returns(
              {
                command_index: Integer,
                delta: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  OpenAI::Beta::BetaResponseShellCallCommandDeltaEvent::Agent,
                obfuscation: String,
                stream_id: String
              }
            )
          end
          def to_hash
          end
        end

        class BetaResponseShellCallCommandWsDone < OpenAI::Models::Beta::BetaResponseShellCallCommandDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseShellCallCommandWsDone,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # A streaming event that indicated a shell command was completed.
          sig do
            params(
              command: String,
              command_index: Integer,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                OpenAI::Beta::BetaResponseShellCallCommandDoneEvent::Agent::OrHash,
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The final shell command that was emitted.
            command:,
            # The index of the shell command that was completed.
            command_index:,
            # The index of the output item that was updated.
            output_index:,
            # The sequence number of the event that was emitted.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event, always `response.shell_call_command.done`.
            type: :"response.shell_call_command.done"
          )
          end

          sig do
            override.returns(
              {
                command: String,
                command_index: Integer,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  OpenAI::Beta::BetaResponseShellCallCommandDoneEvent::Agent,
                stream_id: String
              }
            )
          end
          def to_hash
          end
        end

        class BetaResponseShellCallOutputContentWsDelta < OpenAI::Models::Beta::BetaResponseShellCallOutputContentDeltaEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseShellCallOutputContentWsDelta,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # A streaming event that indicated shell call output was incrementally added.
          sig do
            params(
              command_index: Integer,
              delta:
                OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Delta::OrHash,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Agent::OrHash,
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the shell command that produced output.
            command_index:,
            # The stdout/stderr delta that was emitted.
            delta:,
            # The ID of the output item that was updated.
            item_id:,
            # The index of the output item that was updated.
            output_index:,
            # The sequence number of the event that was emitted.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event, always `response.shell_call_output_content.delta`.
            type: :"response.shell_call_output_content.delta"
          )
          end

          sig do
            override.returns(
              {
                command_index: Integer,
                delta:
                  OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Delta,
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  OpenAI::Beta::BetaResponseShellCallOutputContentDeltaEvent::Agent,
                stream_id: String
              }
            )
          end
          def to_hash
          end
        end

        class BetaResponseShellCallOutputContentWsDone < OpenAI::Models::Beta::BetaResponseShellCallOutputContentDoneEvent
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseShellCallOutputContentWsDone,
                OpenAI::Internal::AnyHash
              )
            end

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # A streaming event that indicated shell call output was completed.
          sig do
            params(
              command_index: Integer,
              item_id: String,
              output:
                T::Array[
                  OpenAI::Beta::BetaResponseShellCallOutputContentDoneEvent::Output::OrHash
                ],
              output_index: Integer,
              sequence_number: Integer,
              agent:
                OpenAI::Beta::BetaResponseShellCallOutputContentDoneEvent::Agent::OrHash,
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the shell command that produced output.
            command_index:,
            # The ID of the output item that was updated.
            item_id:,
            # The output contents emitted for the shell command.
            output:,
            # The index of the output item that was updated.
            output_index:,
            # The sequence number of the event that was emitted.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event, always `response.shell_call_output_content.done`.
            type: :"response.shell_call_output_content.done"
          )
          end

          sig do
            override.returns(
              {
                command_index: Integer,
                item_id: String,
                output:
                  T::Array[
                    OpenAI::Beta::BetaResponseShellCallOutputContentDoneEvent::Output
                  ],
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  OpenAI::Beta::BetaResponseShellCallOutputContentDoneEvent::Agent,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              response: OpenAI::Beta::BetaResponse::OrHash,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseInProgressEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The response that is in progress.
            response:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.in_progress`.
            type: :"response.in_progress"
          )
          end

          sig do
            override.returns(
              {
                response: OpenAI::Beta::BetaResponse,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(OpenAI::Beta::BetaResponseInProgressEvent::Agent),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              response: OpenAI::Beta::BetaResponse::OrHash,
              sequence_number: Integer,
              agent:
                T.nilable(OpenAI::Beta::BetaResponseFailedEvent::Agent::OrHash),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The response that failed.
            response:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.failed`.
            type: :"response.failed"
          )
          end

          sig do
            override.returns(
              {
                response: OpenAI::Beta::BetaResponse,
                sequence_number: Integer,
                type: Symbol,
                agent: T.nilable(OpenAI::Beta::BetaResponseFailedEvent::Agent),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              response: OpenAI::Beta::BetaResponse::OrHash,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseIncompleteEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The response that was incomplete.
            response:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.incomplete`.
            type: :"response.incomplete"
          )
          end

          sig do
            override.returns(
              {
                response: OpenAI::Beta::BetaResponse,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(OpenAI::Beta::BetaResponseIncompleteEvent::Agent),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item:
                T.any(
                  OpenAI::Beta::BetaResponseOutputMessage::OrHash,
                  OpenAI::Beta::BetaResponseFileSearchToolCall::OrHash,
                  OpenAI::Beta::BetaResponseFunctionToolCall::OrHash,
                  OpenAI::Beta::BetaResponseFunctionToolCallOutputItem::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::AgentMessage::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseFunctionWebSearch::OrHash,
                  OpenAI::Beta::BetaResponseComputerToolCall::OrHash,
                  OpenAI::Beta::BetaResponseComputerToolCallOutputItem::OrHash,
                  OpenAI::Beta::BetaResponseReasoningItem::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::Program::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::ProgramOutput::OrHash,
                  OpenAI::Beta::BetaResponseToolSearchCall::OrHash,
                  OpenAI::Beta::BetaResponseToolSearchOutputItem::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::OrHash,
                  OpenAI::Beta::BetaResponseCompactionItem::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::OrHash,
                  OpenAI::Beta::BetaResponseCodeInterpreterToolCall::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseFunctionShellToolCall::OrHash,
                  OpenAI::Beta::BetaResponseFunctionShellToolCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseApplyPatchToolCall::OrHash,
                  OpenAI::Beta::BetaResponseApplyPatchToolCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::McpCall::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::McpListTools::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::McpApprovalRequest::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::McpApprovalResponse::OrHash,
                  OpenAI::Beta::BetaResponseCustomToolCall::OrHash,
                  OpenAI::Beta::BetaResponseCustomToolCallOutputItem::OrHash
                ),
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItemAddedEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The output item that was added. For reasoning items, `encrypted_content` may be
            # incomplete while the item is in progress. Use the reasoning item from the
            # corresponding `response.output_item.done` event when passing it as input to a
            # subsequent request.
            item:,
            # The index of the output item that was added.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.output_item.added`.
            type: :"response.output_item.added"
          )
          end

          sig do
            override.returns(
              {
                item: OpenAI::Beta::BetaResponseOutputItem::Variants,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseOutputItemAddedEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item:
                T.any(
                  OpenAI::Beta::BetaResponseOutputMessage::OrHash,
                  OpenAI::Beta::BetaResponseFileSearchToolCall::OrHash,
                  OpenAI::Beta::BetaResponseFunctionToolCall::OrHash,
                  OpenAI::Beta::BetaResponseFunctionToolCallOutputItem::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::AgentMessage::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::MultiAgentCall::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::MultiAgentCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseFunctionWebSearch::OrHash,
                  OpenAI::Beta::BetaResponseComputerToolCall::OrHash,
                  OpenAI::Beta::BetaResponseComputerToolCallOutputItem::OrHash,
                  OpenAI::Beta::BetaResponseReasoningItem::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::Program::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::ProgramOutput::OrHash,
                  OpenAI::Beta::BetaResponseToolSearchCall::OrHash,
                  OpenAI::Beta::BetaResponseToolSearchOutputItem::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::AdditionalTools::OrHash,
                  OpenAI::Beta::BetaResponseCompactionItem::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::ImageGenerationCall::OrHash,
                  OpenAI::Beta::BetaResponseCodeInterpreterToolCall::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCall::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::LocalShellCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseFunctionShellToolCall::OrHash,
                  OpenAI::Beta::BetaResponseFunctionShellToolCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseApplyPatchToolCall::OrHash,
                  OpenAI::Beta::BetaResponseApplyPatchToolCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::McpCall::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::McpListTools::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::McpApprovalRequest::OrHash,
                  OpenAI::Beta::BetaResponseOutputItem::McpApprovalResponse::OrHash,
                  OpenAI::Beta::BetaResponseCustomToolCall::OrHash,
                  OpenAI::Beta::BetaResponseCustomToolCallOutputItem::OrHash
                ),
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputItemDoneEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The output item that was marked done.
            item:,
            # The index of the output item that was marked done.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.output_item.done`.
            type: :"response.output_item.done"
          )
          end

          sig do
            override.returns(
              {
                item: OpenAI::Beta::BetaResponseOutputItem::Variants,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseOutputItemDoneEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              part:
                OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Part::OrHash,
              sequence_number: Integer,
              summary_index: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the item this summary part is associated with.
            item_id:,
            # The index of the output item this summary part is associated with.
            output_index:,
            # The summary part that was added.
            part:,
            # The sequence number of this event.
            sequence_number:,
            # The index of the summary part within the reasoning summary.
            summary_index:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.reasoning_summary_part.added`.
            type: :"response.reasoning_summary_part.added"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                part:
                  OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Part,
                sequence_number: Integer,
                summary_index: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseReasoningSummaryPartAddedEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              part:
                OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Part::OrHash,
              sequence_number: Integer,
              summary_index: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Agent::OrHash
                ),
              status:
                OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Status::OrSymbol,
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the item this summary part is associated with.
            item_id:,
            # The index of the output item this summary part is associated with.
            output_index:,
            # The completed summary part.
            part:,
            # The sequence number of this event.
            sequence_number:,
            # The index of the summary part within the reasoning summary.
            summary_index:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The completion status of the summary part. Omitted when the part completed
            # normally and set to `incomplete` when generation was interrupted.
            status: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.reasoning_summary_part.done`.
            type: :"response.reasoning_summary_part.done"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                part:
                  OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Part,
                sequence_number: Integer,
                summary_index: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Agent
                  ),
                status:
                  OpenAI::Beta::BetaResponseReasoningSummaryPartDoneEvent::Status::TaggedSymbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              summary_index: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseReasoningSummaryTextDeltaEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The text delta that was added to the summary.
            delta:,
            # The ID of the item this summary text delta is associated with.
            item_id:,
            # The index of the output item this summary text delta is associated with.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The index of the summary part within the reasoning summary.
            summary_index:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.reasoning_summary_text.delta`.
            type: :"response.reasoning_summary_text.delta"
          )
          end

          sig do
            override.returns(
              {
                delta: String,
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                summary_index: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseReasoningSummaryTextDeltaEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              summary_index: Integer,
              text: String,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseReasoningSummaryTextDoneEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the item this summary text is associated with.
            item_id:,
            # The index of the output item this summary text is associated with.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The index of the summary part within the reasoning summary.
            summary_index:,
            # The full text of the completed reasoning summary.
            text:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.reasoning_summary_text.done`.
            type: :"response.reasoning_summary_text.done"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                summary_index: Integer,
                text: String,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseReasoningSummaryTextDoneEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseReasoningTextDeltaEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the reasoning content part this delta is associated with.
            content_index:,
            # The text delta that was added to the reasoning content.
            delta:,
            # The ID of the item this reasoning text delta is associated with.
            item_id:,
            # The index of the output item this reasoning text delta is associated with.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.reasoning_text.delta`.
            type: :"response.reasoning_text.delta"
          )
          end

          sig do
            override.returns(
              {
                content_index: Integer,
                delta: String,
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseReasoningTextDeltaEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              text: String,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseReasoningTextDoneEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the reasoning content part.
            content_index:,
            # The ID of the item this reasoning text is associated with.
            item_id:,
            # The index of the output item this reasoning text is associated with.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The full text of the completed reasoning content.
            text:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.reasoning_text.done`.
            type: :"response.reasoning_text.done"
          )
          end

          sig do
            override.returns(
              {
                content_index: Integer,
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                text: String,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseReasoningTextDoneEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseRefusalDeltaEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the content part that the refusal text is added to.
            content_index:,
            # The refusal text that is added.
            delta:,
            # The ID of the output item that the refusal text is added to.
            item_id:,
            # The index of the output item that the refusal text is added to.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.refusal.delta`.
            type: :"response.refusal.delta"
          )
          end

          sig do
            override.returns(
              {
                content_index: Integer,
                delta: String,
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(OpenAI::Beta::BetaResponseRefusalDeltaEvent::Agent),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              item_id: String,
              output_index: Integer,
              refusal: String,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseRefusalDoneEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the content part that the refusal text is finalized.
            content_index:,
            # The ID of the output item that the refusal text is finalized.
            item_id:,
            # The index of the output item that the refusal text is finalized.
            output_index:,
            # The refusal text that is finalized.
            refusal:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.refusal.done`.
            type: :"response.refusal.done"
          )
          end

          sig do
            override.returns(
              {
                content_index: Integer,
                item_id: String,
                output_index: Integer,
                refusal: String,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(OpenAI::Beta::BetaResponseRefusalDoneEvent::Agent),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              delta: String,
              item_id: String,
              logprobs:
                T::Array[
                  OpenAI::Beta::BetaResponseTextDeltaEvent::Logprob::OrHash
                ],
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseTextDeltaEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the content part that the text delta was added to.
            content_index:,
            # The text delta that was added.
            delta:,
            # The ID of the output item that the text delta was added to.
            item_id:,
            # The log probabilities of the tokens in the delta.
            logprobs:,
            # The index of the output item that the text delta was added to.
            output_index:,
            # The sequence number for this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.output_text.delta`.
            type: :"response.output_text.delta"
          )
          end

          sig do
            override.returns(
              {
                content_index: Integer,
                delta: String,
                item_id: String,
                logprobs:
                  T::Array[OpenAI::Beta::BetaResponseTextDeltaEvent::Logprob],
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(OpenAI::Beta::BetaResponseTextDeltaEvent::Agent),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              item_id: String,
              logprobs:
                T::Array[
                  OpenAI::Beta::BetaResponseTextDoneEvent::Logprob::OrHash
                ],
              output_index: Integer,
              sequence_number: Integer,
              text: String,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseTextDoneEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The index of the content part that the text content is finalized.
            content_index:,
            # The ID of the output item that the text content is finalized.
            item_id:,
            # The log probabilities of the tokens in the delta.
            logprobs:,
            # The index of the output item that the text content is finalized.
            output_index:,
            # The sequence number for this event.
            sequence_number:,
            # The text content that is finalized.
            text:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.output_text.done`.
            type: :"response.output_text.done"
          )
          end

          sig do
            override.returns(
              {
                content_index: Integer,
                item_id: String,
                logprobs:
                  T::Array[OpenAI::Beta::BetaResponseTextDoneEvent::Logprob],
                output_index: Integer,
                sequence_number: Integer,
                text: String,
                type: Symbol,
                agent:
                  T.nilable(OpenAI::Beta::BetaResponseTextDoneEvent::Agent),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseWebSearchCallCompletedEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Unique ID for the output item associated with the web search call.
            item_id:,
            # The index of the output item that the web search call is associated with.
            output_index:,
            # The sequence number of the web search call being processed.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.web_search_call.completed`.
            type: :"response.web_search_call.completed"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseWebSearchCallCompletedEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseWebSearchCallInProgressEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Unique ID for the output item associated with the web search call.
            item_id:,
            # The index of the output item that the web search call is associated with.
            output_index:,
            # The sequence number of the web search call being processed.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.web_search_call.in_progress`.
            type: :"response.web_search_call.in_progress"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseWebSearchCallInProgressEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseWebSearchCallSearchingEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Unique ID for the output item associated with the web search call.
            item_id:,
            # The index of the output item that the web search call is associated with.
            output_index:,
            # The sequence number of the web search call being processed.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `response.web_search_call.searching`.
            type: :"response.web_search_call.searching"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseWebSearchCallSearchingEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseImageGenCallCompletedEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique identifier of the image generation item being processed.
            item_id:,
            # The index of the output item in the response's output array.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always 'response.image_generation_call.completed'.
            type: :"response.image_generation_call.completed"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseImageGenCallCompletedEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseImageGenCallGeneratingEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique identifier of the image generation item being processed.
            item_id:,
            # The index of the output item in the response's output array.
            output_index:,
            # The sequence number of the image generation item being processed.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always 'response.image_generation_call.generating'.
            type: :"response.image_generation_call.generating"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseImageGenCallGeneratingEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseImageGenCallInProgressEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique identifier of the image generation item being processed.
            item_id:,
            # The index of the output item in the response's output array.
            output_index:,
            # The sequence number of the image generation item being processed.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always 'response.image_generation_call.in_progress'.
            type: :"response.image_generation_call.in_progress"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseImageGenCallInProgressEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              partial_image_b64: String,
              partial_image_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseImageGenCallPartialImageEvent::Agent::OrHash
                ),
              background: String,
              output_format: String,
              quality: String,
              size: String,
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique identifier of the image generation item being processed.
            item_id:,
            # The index of the output item in the response's output array.
            output_index:,
            # Base64-encoded partial image data, suitable for rendering as an image.
            partial_image_b64:,
            # 0-based index for the partial image (backend is 1-based, but this is 0-based for
            # the user).
            partial_image_index:,
            # The sequence number of the image generation item being processed.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The background setting that was used.
            background: nil,
            # The output format that was used.
            output_format: nil,
            # The image quality that was used.
            quality: nil,
            # The image size that was used.
            size: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always 'response.image_generation_call.partial_image'.
            type: :"response.image_generation_call.partial_image"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                partial_image_b64: String,
                partial_image_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseImageGenCallPartialImageEvent::Agent
                  ),
                background: String,
                output_format: String,
                quality: String,
                size: String,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseMcpCallArgumentsDeltaEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # A JSON string containing the partial update to the arguments for the MCP tool
            # call.
            delta:,
            # The unique identifier of the MCP tool call item being processed.
            item_id:,
            # The index of the output item in the response's output array.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always 'response.mcp_call_arguments.delta'.
            type: :"response.mcp_call_arguments.delta"
          )
          end

          sig do
            override.returns(
              {
                delta: String,
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseMcpCallArgumentsDeltaEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              arguments: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseMcpCallArgumentsDoneEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # A JSON string containing the finalized arguments for the MCP tool call.
            arguments:,
            # The unique identifier of the MCP tool call item being processed.
            item_id:,
            # The index of the output item in the response's output array.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always 'response.mcp_call_arguments.done'.
            type: :"response.mcp_call_arguments.done"
          )
          end

          sig do
            override.returns(
              {
                arguments: String,
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseMcpCallArgumentsDoneEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseMcpCallCompletedEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the MCP tool call item that completed.
            item_id:,
            # The index of the output item that completed.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always 'response.mcp_call.completed'.
            type: :"response.mcp_call.completed"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseMcpCallCompletedEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseMcpCallFailedEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the MCP tool call item that failed.
            item_id:,
            # The index of the output item that failed.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always 'response.mcp_call.failed'.
            type: :"response.mcp_call.failed"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseMcpCallFailedEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseMcpCallInProgressEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique identifier of the MCP tool call item being processed.
            item_id:,
            # The index of the output item in the response's output array.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always 'response.mcp_call.in_progress'.
            type: :"response.mcp_call.in_progress"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseMcpCallInProgressEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseMcpListToolsCompletedEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the MCP tool call item that produced this output.
            item_id:,
            # The index of the output item that was processed.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always 'response.mcp_list_tools.completed'.
            type: :"response.mcp_list_tools.completed"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseMcpListToolsCompletedEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseMcpListToolsFailedEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the MCP tool call item that failed.
            item_id:,
            # The index of the output item that failed.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always 'response.mcp_list_tools.failed'.
            type: :"response.mcp_list_tools.failed"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseMcpListToolsFailedEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseMcpListToolsInProgressEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the MCP tool call item that is being processed.
            item_id:,
            # The index of the output item that is being processed.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always 'response.mcp_list_tools.in_progress'.
            type: :"response.mcp_list_tools.in_progress"
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseMcpListToolsInProgressEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              annotation:
                T.nilable(
                  T.any(
                    OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::FileCitation::OrHash,
                    OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::URLCitation::OrHash,
                    OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::ContainerFileCitation::OrHash,
                    OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::FilePath::OrHash
                  )
                ),
              annotation_index: Integer,
              content_index: Integer,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # An annotation that applies to a span of output text.
            annotation:,
            # The index of the annotation within the content part.
            annotation_index:,
            # The index of the content part within the output item.
            content_index:,
            # The unique identifier of the item to which the annotation is being added.
            item_id:,
            # The index of the output item in the response's output array.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always 'response.output_text.annotation.added'.
            type: :"response.output_text.annotation.added"
          )
          end

          sig do
            override.returns(
              {
                annotation:
                  T.nilable(
                    OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Annotation::Variants
                  ),
                annotation_index: Integer,
                content_index: Integer,
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseOutputTextAnnotationAddedEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              response: OpenAI::Beta::BetaResponse::OrHash,
              sequence_number: Integer,
              agent:
                T.nilable(OpenAI::Beta::BetaResponseQueuedEvent::Agent::OrHash),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The full response object that is queued.
            response:,
            # The sequence number for this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always 'response.queued'.
            type: :"response.queued"
          )
          end

          sig do
            override.returns(
              {
                response: OpenAI::Beta::BetaResponse,
                sequence_number: Integer,
                type: Symbol,
                agent: T.nilable(OpenAI::Beta::BetaResponseQueuedEvent::Agent),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseCustomToolCallInputDeltaEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The incremental input data (delta) for the custom tool call.
            delta:,
            # Unique identifier for the API item associated with this event.
            item_id:,
            # The index of the output this delta applies to.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The event type identifier.
            type: :"response.custom_tool_call_input.delta"
          )
          end

          sig do
            override.returns(
              {
                delta: String,
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseCustomToolCallInputDeltaEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              input: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseCustomToolCallInputDoneEvent::Agent::OrHash
                ),
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The complete input data for the custom tool call.
            input:,
            # Unique identifier for the API item associated with this event.
            item_id:,
            # The index of the output this event applies to.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The event type identifier.
            type: :"response.custom_tool_call_input.done"
          )
          end

          sig do
            override.returns(
              {
                input: String,
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponseCustomToolCallInputDoneEvent::Agent
                  ),
                stream_id: String
              }
            )
          end
          def to_hash
          end
        end

        class BetaResponseWsError < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError,
                OpenAI::Internal::AnyHash
              )
            end

          # Details about the error.
          sig do
            returns(
              OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error
            )
          end
          attr_reader :error

          sig do
            params(
              error:
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::OrHash
            ).void
          end
          attr_writer :error

          # The type of the event. Always `error`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The agent that owns this multi-agent streaming event.
          sig do
            returns(
              T.nilable(
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Agent
              )
            )
          end
          attr_reader :agent

          sig do
            params(
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Agent::OrHash
                )
            ).void
          end
          attr_writer :agent

          # The sequence number of an error emitted by the response stream.
          sig { returns(T.nilable(Integer)) }
          attr_reader :sequence_number

          sig { params(sequence_number: Integer).void }
          attr_writer :sequence_number

          # The HTTP status code associated with a WebSocket protocol error.
          sig { returns(T.nilable(Integer)) }
          attr_reader :status

          sig { params(status: Integer).void }
          attr_writer :status

          # The WebSocket lane that emitted this event. This field is present when the
          # originating `response.create` event supplied a `stream_id`.
          sig { returns(T.nilable(String)) }
          attr_reader :stream_id

          sig { params(stream_id: String).void }
          attr_writer :stream_id

          # Emitted when an error occurs while processing a Responses WebSocket request.
          sig do
            params(
              error:
                OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error::OrHash,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Agent::OrHash
                ),
              sequence_number: Integer,
              status: Integer,
              stream_id: String,
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Details about the error.
            error:,
            # The agent that owns this multi-agent streaming event.
            agent: nil,
            # The sequence number of an error emitted by the response stream.
            sequence_number: nil,
            # The HTTP status code associated with a WebSocket protocol error.
            status: nil,
            # The WebSocket lane that emitted this event. This field is present when the
            # originating `response.create` event supplied a `stream_id`.
            stream_id: nil,
            # The type of the event. Always `error`.
            type: :error
          )
          end

          sig do
            override.returns(
              {
                error:
                  OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error,
                type: Symbol,
                agent:
                  T.nilable(
                    OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Agent
                  ),
                sequence_number: Integer,
                status: Integer,
                stream_id: String
              }
            )
          end
          def to_hash
          end

          class Error < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Error,
                  OpenAI::Internal::AnyHash
                )
              end

            # The error code that was emitted, if any.
            sig { returns(T.nilable(String)) }
            attr_accessor :code

            # The human-readable error message that was emitted.
            sig { returns(String) }
            attr_accessor :message

            # The parameter name that was associated with the error, if any.
            sig { returns(T.nilable(String)) }
            attr_accessor :param

            # The error type that was emitted.
            sig { returns(String) }
            attr_accessor :type

            # The response headers that were emitted with the error, if any.
            sig { returns(T.nilable(T::Hash[Symbol, String])) }
            attr_reader :headers

            sig { params(headers: T::Hash[Symbol, String]).void }
            attr_writer :headers

            # Details about the error.
            sig do
              params(
                code: T.nilable(String),
                message: String,
                param: T.nilable(String),
                type: String,
                headers: T::Hash[Symbol, String]
              ).returns(T.attached_class)
            end
            def self.new(
              # The error code that was emitted, if any.
              code:,
              # The human-readable error message that was emitted.
              message:,
              # The parameter name that was associated with the error, if any.
              param:,
              # The error type that was emitted.
              type:,
              # The response headers that were emitted with the error, if any.
              headers: nil
            )
            end

            sig do
              override.returns(
                {
                  code: T.nilable(String),
                  message: String,
                  param: T.nilable(String),
                  type: String,
                  headers: T::Hash[Symbol, String]
                }
              )
            end
            def to_hash
            end
          end

          class Agent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::BetaResponsesServerEvent::BetaResponseWsError::Agent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The canonical name of the agent that produced this item.
            sig { returns(String) }
            attr_accessor :agent_name

            # The agent that owns this multi-agent streaming event.
            sig { params(agent_name: String).returns(T.attached_class) }
            def self.new(
              # The canonical name of the agent that produced this item.
              agent_name:
            )
            end

            sig { override.returns({ agent_name: String }) }
            def to_hash
            end
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
