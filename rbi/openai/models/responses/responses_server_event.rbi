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
          sig do
            params(
              delta: String,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # A chunk of Base64 encoded response audio bytes.
            delta:,
            # A sequence number for this chunk of the stream response.
            sequence_number:,
            # The type of the event. Always `response.audio.delta`.
            type: :"response.audio.delta",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                delta: String,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The sequence number of the delta.
            sequence_number:,
            # The type of the event. Always `response.audio.done`.
            type: :"response.audio.done",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              { sequence_number: Integer, type: Symbol, stream_id: String }
            )
          end
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
          sig do
            params(
              delta: String,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The partial transcript of the audio response.
            delta:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always `response.audio.transcript.delta`.
            type: :"response.audio.transcript.delta",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                delta: String,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always `response.audio.transcript.done`.
            type: :"response.audio.transcript.done",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              { sequence_number: Integer, type: Symbol, stream_id: String }
            )
          end
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
          sig do
            params(
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.code_interpreter_call_code.delta`.
            type: :"response.code_interpreter_call_code.delta",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
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
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              code: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.code_interpreter_call_code.done`.
            type: :"response.code_interpreter_call_code.done",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
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
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.code_interpreter_call.completed`.
            type: :"response.code_interpreter_call.completed",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.code_interpreter_call.in_progress`.
            type: :"response.code_interpreter_call.in_progress",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.code_interpreter_call.interpreting`.
            type: :"response.code_interpreter_call.interpreting",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              response: OpenAI::Responses::Response::OrHash,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # Properties of the completed response.
            response:,
            # The sequence number for this event.
            sequence_number:,
            # The type of the event. Always `response.completed`.
            type: :"response.completed",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                response: OpenAI::Responses::Response,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              item_id: String,
              output_index: Integer,
              part:
                T.any(
                  OpenAI::Responses::ResponseOutputText::OrHash,
                  OpenAI::Responses::ResponseOutputRefusal::OrHash,
                  OpenAI::Responses::ResponseContentPartAddedEvent::Part::ReasoningText::OrHash
                ),
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.content_part.added`.
            type: :"response.content_part.added",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                content_index: Integer,
                item_id: String,
                output_index: Integer,
                part:
                  OpenAI::Responses::ResponseContentPartAddedEvent::Part::Variants,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              item_id: String,
              output_index: Integer,
              part:
                T.any(
                  OpenAI::Responses::ResponseOutputText::OrHash,
                  OpenAI::Responses::ResponseOutputRefusal::OrHash,
                  OpenAI::Responses::ResponseContentPartDoneEvent::Part::ReasoningText::OrHash
                ),
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.content_part.done`.
            type: :"response.content_part.done",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                content_index: Integer,
                item_id: String,
                output_index: Integer,
                part:
                  OpenAI::Responses::ResponseContentPartDoneEvent::Part::Variants,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              response: OpenAI::Responses::Response::OrHash,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The response that was created.
            response:,
            # The sequence number for this event.
            sequence_number:,
            # The type of the event. Always `response.created`.
            type: :"response.created",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                response: OpenAI::Responses::Response,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              code: T.nilable(String),
              message: String,
              param: T.nilable(String),
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The error code.
            code:,
            # The error message.
            message:,
            # The error parameter.
            param:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always `error`.
            type: :error,
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                code: T.nilable(String),
                message: String,
                param: T.nilable(String),
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the output item that the file search call is initiated.
            item_id:,
            # The index of the output item that the file search call is initiated.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always `response.file_search_call.completed`.
            type: :"response.file_search_call.completed",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the output item that the file search call is initiated.
            item_id:,
            # The index of the output item that the file search call is initiated.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always `response.file_search_call.in_progress`.
            type: :"response.file_search_call.in_progress",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the output item that the file search call is initiated.
            item_id:,
            # The index of the output item that the file search call is searching.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always `response.file_search_call.searching`.
            type: :"response.file_search_call.searching",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.function_call_arguments.delta`.
            type: :"response.function_call_arguments.delta",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
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
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              arguments: String,
              item_id: String,
              name: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            type: :"response.function_call_arguments.done",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
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
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              response: OpenAI::Responses::Response::OrHash,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The response that is in progress.
            response:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always `response.in_progress`.
            type: :"response.in_progress",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                response: OpenAI::Responses::Response,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              response: OpenAI::Responses::Response::OrHash,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The response that failed.
            response:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always `response.failed`.
            type: :"response.failed",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                response: OpenAI::Responses::Response,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              response: OpenAI::Responses::Response::OrHash,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The response that was incomplete.
            response:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always `response.incomplete`.
            type: :"response.incomplete",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                response: OpenAI::Responses::Response,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item:
                T.any(
                  OpenAI::Responses::ResponseOutputMessage::OrHash,
                  OpenAI::Responses::ResponseFileSearchToolCall::OrHash,
                  OpenAI::Responses::ResponseFunctionToolCall::OrHash,
                  OpenAI::Responses::ResponseFunctionToolCallOutputItem::OrHash,
                  OpenAI::Responses::ResponseFunctionWebSearch::OrHash,
                  OpenAI::Responses::ResponseComputerToolCall::OrHash,
                  OpenAI::Responses::ResponseComputerToolCallOutputItem::OrHash,
                  OpenAI::Responses::ResponseReasoningItem::OrHash,
                  OpenAI::Responses::ResponseOutputItem::Program::OrHash,
                  OpenAI::Responses::ResponseOutputItem::ProgramOutput::OrHash,
                  OpenAI::Responses::ResponseToolSearchCall::OrHash,
                  OpenAI::Responses::ResponseToolSearchOutputItem::OrHash,
                  OpenAI::Responses::ResponseOutputItem::AdditionalTools::OrHash,
                  OpenAI::Responses::ResponseCompactionItem::OrHash,
                  OpenAI::Responses::ResponseOutputItem::ImageGenerationCall::OrHash,
                  OpenAI::Responses::ResponseCodeInterpreterToolCall::OrHash,
                  OpenAI::Responses::ResponseOutputItem::LocalShellCall::OrHash,
                  OpenAI::Responses::ResponseOutputItem::LocalShellCallOutput::OrHash,
                  OpenAI::Responses::ResponseFunctionShellToolCall::OrHash,
                  OpenAI::Responses::ResponseFunctionShellToolCallOutput::OrHash,
                  OpenAI::Responses::ResponseApplyPatchToolCall::OrHash,
                  OpenAI::Responses::ResponseApplyPatchToolCallOutput::OrHash,
                  OpenAI::Responses::ResponseOutputItem::McpCall::OrHash,
                  OpenAI::Responses::ResponseOutputItem::McpListTools::OrHash,
                  OpenAI::Responses::ResponseOutputItem::McpApprovalRequest::OrHash,
                  OpenAI::Responses::ResponseOutputItem::McpApprovalResponse::OrHash,
                  OpenAI::Responses::ResponseCustomToolCall::OrHash,
                  OpenAI::Responses::ResponseCustomToolCallOutputItem::OrHash
                ),
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The output item that was added.
            item:,
            # The index of the output item that was added.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always `response.output_item.added`.
            type: :"response.output_item.added",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item: OpenAI::Responses::ResponseOutputItem::Variants,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item:
                T.any(
                  OpenAI::Responses::ResponseOutputMessage::OrHash,
                  OpenAI::Responses::ResponseFileSearchToolCall::OrHash,
                  OpenAI::Responses::ResponseFunctionToolCall::OrHash,
                  OpenAI::Responses::ResponseFunctionToolCallOutputItem::OrHash,
                  OpenAI::Responses::ResponseFunctionWebSearch::OrHash,
                  OpenAI::Responses::ResponseComputerToolCall::OrHash,
                  OpenAI::Responses::ResponseComputerToolCallOutputItem::OrHash,
                  OpenAI::Responses::ResponseReasoningItem::OrHash,
                  OpenAI::Responses::ResponseOutputItem::Program::OrHash,
                  OpenAI::Responses::ResponseOutputItem::ProgramOutput::OrHash,
                  OpenAI::Responses::ResponseToolSearchCall::OrHash,
                  OpenAI::Responses::ResponseToolSearchOutputItem::OrHash,
                  OpenAI::Responses::ResponseOutputItem::AdditionalTools::OrHash,
                  OpenAI::Responses::ResponseCompactionItem::OrHash,
                  OpenAI::Responses::ResponseOutputItem::ImageGenerationCall::OrHash,
                  OpenAI::Responses::ResponseCodeInterpreterToolCall::OrHash,
                  OpenAI::Responses::ResponseOutputItem::LocalShellCall::OrHash,
                  OpenAI::Responses::ResponseOutputItem::LocalShellCallOutput::OrHash,
                  OpenAI::Responses::ResponseFunctionShellToolCall::OrHash,
                  OpenAI::Responses::ResponseFunctionShellToolCallOutput::OrHash,
                  OpenAI::Responses::ResponseApplyPatchToolCall::OrHash,
                  OpenAI::Responses::ResponseApplyPatchToolCallOutput::OrHash,
                  OpenAI::Responses::ResponseOutputItem::McpCall::OrHash,
                  OpenAI::Responses::ResponseOutputItem::McpListTools::OrHash,
                  OpenAI::Responses::ResponseOutputItem::McpApprovalRequest::OrHash,
                  OpenAI::Responses::ResponseOutputItem::McpApprovalResponse::OrHash,
                  OpenAI::Responses::ResponseCustomToolCall::OrHash,
                  OpenAI::Responses::ResponseCustomToolCallOutputItem::OrHash
                ),
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The output item that was marked done.
            item:,
            # The index of the output item that was marked done.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always `response.output_item.done`.
            type: :"response.output_item.done",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item: OpenAI::Responses::ResponseOutputItem::Variants,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              part:
                OpenAI::Responses::ResponseReasoningSummaryPartAddedEvent::Part::OrHash,
              sequence_number: Integer,
              summary_index: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.reasoning_summary_part.added`.
            type: :"response.reasoning_summary_part.added",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                part:
                  OpenAI::Responses::ResponseReasoningSummaryPartAddedEvent::Part,
                sequence_number: Integer,
                summary_index: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              part:
                OpenAI::Responses::ResponseReasoningSummaryPartDoneEvent::Part::OrHash,
              sequence_number: Integer,
              summary_index: Integer,
              status:
                OpenAI::Responses::ResponseReasoningSummaryPartDoneEvent::Status::OrSymbol,
              type: Symbol,
              stream_id: String
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
            # The completion status of the summary part. Omitted when the part completed
            # normally and set to `incomplete` when generation was interrupted.
            status: nil,
            # The type of the event. Always `response.reasoning_summary_part.done`.
            type: :"response.reasoning_summary_part.done",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                part:
                  OpenAI::Responses::ResponseReasoningSummaryPartDoneEvent::Part,
                sequence_number: Integer,
                summary_index: Integer,
                type: Symbol,
                status:
                  OpenAI::Responses::ResponseReasoningSummaryPartDoneEvent::Status::TaggedSymbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              summary_index: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.reasoning_summary_text.delta`.
            type: :"response.reasoning_summary_text.delta",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
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
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              summary_index: Integer,
              text: String,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.reasoning_summary_text.done`.
            type: :"response.reasoning_summary_text.done",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
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
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.reasoning_text.delta`.
            type: :"response.reasoning_text.delta",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
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
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              text: String,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.reasoning_text.done`.
            type: :"response.reasoning_text.done",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
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
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.refusal.delta`.
            type: :"response.refusal.delta",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
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
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              item_id: String,
              output_index: Integer,
              refusal: String,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.refusal.done`.
            type: :"response.refusal.done",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
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
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              delta: String,
              item_id: String,
              logprobs:
                T::Array[
                  OpenAI::Responses::ResponseTextDeltaEvent::Logprob::OrHash
                ],
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.output_text.delta`.
            type: :"response.output_text.delta",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                content_index: Integer,
                delta: String,
                item_id: String,
                logprobs:
                  T::Array[OpenAI::Responses::ResponseTextDeltaEvent::Logprob],
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              content_index: Integer,
              item_id: String,
              logprobs:
                T::Array[
                  OpenAI::Responses::ResponseTextDoneEvent::Logprob::OrHash
                ],
              output_index: Integer,
              sequence_number: Integer,
              text: String,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always `response.output_text.done`.
            type: :"response.output_text.done",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                content_index: Integer,
                item_id: String,
                logprobs:
                  T::Array[OpenAI::Responses::ResponseTextDoneEvent::Logprob],
                output_index: Integer,
                sequence_number: Integer,
                text: String,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # Unique ID for the output item associated with the web search call.
            item_id:,
            # The index of the output item that the web search call is associated with.
            output_index:,
            # The sequence number of the web search call being processed.
            sequence_number:,
            # The type of the event. Always `response.web_search_call.completed`.
            type: :"response.web_search_call.completed",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # Unique ID for the output item associated with the web search call.
            item_id:,
            # The index of the output item that the web search call is associated with.
            output_index:,
            # The sequence number of the web search call being processed.
            sequence_number:,
            # The type of the event. Always `response.web_search_call.in_progress`.
            type: :"response.web_search_call.in_progress",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # Unique ID for the output item associated with the web search call.
            item_id:,
            # The index of the output item that the web search call is associated with.
            output_index:,
            # The sequence number of the web search call being processed.
            sequence_number:,
            # The type of the event. Always `response.web_search_call.searching`.
            type: :"response.web_search_call.searching",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique identifier of the image generation item being processed.
            item_id:,
            # The index of the output item in the response's output array.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always 'response.image_generation_call.completed'.
            type: :"response.image_generation_call.completed",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique identifier of the image generation item being processed.
            item_id:,
            # The index of the output item in the response's output array.
            output_index:,
            # The sequence number of the image generation item being processed.
            sequence_number:,
            # The type of the event. Always 'response.image_generation_call.generating'.
            type: :"response.image_generation_call.generating",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique identifier of the image generation item being processed.
            item_id:,
            # The index of the output item in the response's output array.
            output_index:,
            # The sequence number of the image generation item being processed.
            sequence_number:,
            # The type of the event. Always 'response.image_generation_call.in_progress'.
            type: :"response.image_generation_call.in_progress",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              partial_image_b64: String,
              partial_image_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always 'response.image_generation_call.partial_image'.
            type: :"response.image_generation_call.partial_image",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
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
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always 'response.mcp_call_arguments.delta'.
            type: :"response.mcp_call_arguments.delta",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
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
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              arguments: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The type of the event. Always 'response.mcp_call_arguments.done'.
            type: :"response.mcp_call_arguments.done",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
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
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the MCP tool call item that completed.
            item_id:,
            # The index of the output item that completed.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always 'response.mcp_call.completed'.
            type: :"response.mcp_call.completed",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the MCP tool call item that failed.
            item_id:,
            # The index of the output item that failed.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always 'response.mcp_call.failed'.
            type: :"response.mcp_call.failed",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique identifier of the MCP tool call item being processed.
            item_id:,
            # The index of the output item in the response's output array.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always 'response.mcp_call.in_progress'.
            type: :"response.mcp_call.in_progress",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the MCP tool call item that produced this output.
            item_id:,
            # The index of the output item that was processed.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always 'response.mcp_list_tools.completed'.
            type: :"response.mcp_list_tools.completed",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the MCP tool call item that failed.
            item_id:,
            # The index of the output item that failed.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always 'response.mcp_list_tools.failed'.
            type: :"response.mcp_list_tools.failed",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The ID of the MCP tool call item that is being processed.
            item_id:,
            # The index of the output item that is being processed.
            output_index:,
            # The sequence number of this event.
            sequence_number:,
            # The type of the event. Always 'response.mcp_list_tools.in_progress'.
            type: :"response.mcp_list_tools.in_progress",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              annotation: T.anything,
              annotation_index: Integer,
              content_index: Integer,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The annotation object being added. (See annotation schema for details.)
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
            # The type of the event. Always 'response.output_text.annotation.added'.
            type: :"response.output_text.annotation.added",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                annotation: T.anything,
                annotation_index: Integer,
                content_index: Integer,
                item_id: String,
                output_index: Integer,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              response: OpenAI::Responses::Response::OrHash,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
            ).returns(T.attached_class)
          end
          def self.new(
            # The full response object that is queued.
            response:,
            # The sequence number for this event.
            sequence_number:,
            # The type of the event. Always 'response.queued'.
            type: :"response.queued",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
          )
          end

          sig do
            override.returns(
              {
                response: OpenAI::Responses::Response,
                sequence_number: Integer,
                type: Symbol,
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The event type identifier.
            type: :"response.custom_tool_call_input.delta",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
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
                stream_id: String
              }
            )
          end
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
          sig do
            params(
              input: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              stream_id: String
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
            # The event type identifier.
            type: :"response.custom_tool_call_input.done",
            # The WebSocket lane that emitted this event.
            # This field is present when the originating response.create supplied a stream_id.
            stream_id: nil
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
                stream_id: String
              }
            )
          end
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
