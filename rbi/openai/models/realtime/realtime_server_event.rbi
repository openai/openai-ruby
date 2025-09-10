# typed: strong

module OpenAI
  module Models
    module Realtime
      # A realtime server event.
      module RealtimeServerEvent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ConversationCreatedEvent,
              OpenAI::Realtime::ConversationItemCreatedEvent,
              OpenAI::Realtime::ConversationItemDeletedEvent,
              OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent,
              OpenAI::Realtime::ConversationItemInputAudioTranscriptionDeltaEvent,
              OpenAI::Realtime::ConversationItemInputAudioTranscriptionFailedEvent,
              OpenAI::Realtime::RealtimeServerEvent::ConversationItemRetrieved,
              OpenAI::Realtime::ConversationItemTruncatedEvent,
              OpenAI::Realtime::RealtimeErrorEvent,
              OpenAI::Realtime::InputAudioBufferClearedEvent,
              OpenAI::Realtime::InputAudioBufferCommittedEvent,
              OpenAI::Realtime::InputAudioBufferSpeechStartedEvent,
              OpenAI::Realtime::InputAudioBufferSpeechStoppedEvent,
              OpenAI::Realtime::RateLimitsUpdatedEvent,
              OpenAI::Realtime::ResponseAudioDeltaEvent,
              OpenAI::Realtime::ResponseAudioDoneEvent,
              OpenAI::Realtime::ResponseAudioTranscriptDeltaEvent,
              OpenAI::Realtime::ResponseAudioTranscriptDoneEvent,
              OpenAI::Realtime::ResponseContentPartAddedEvent,
              OpenAI::Realtime::ResponseContentPartDoneEvent,
              OpenAI::Realtime::ResponseCreatedEvent,
              OpenAI::Realtime::ResponseDoneEvent,
              OpenAI::Realtime::ResponseFunctionCallArgumentsDeltaEvent,
              OpenAI::Realtime::ResponseFunctionCallArgumentsDoneEvent,
              OpenAI::Realtime::ResponseOutputItemAddedEvent,
              OpenAI::Realtime::ResponseOutputItemDoneEvent,
              OpenAI::Realtime::ResponseTextDeltaEvent,
              OpenAI::Realtime::ResponseTextDoneEvent,
              OpenAI::Realtime::SessionCreatedEvent,
              OpenAI::Realtime::SessionUpdatedEvent,
              OpenAI::Realtime::RealtimeServerEvent::OutputAudioBufferStarted,
              OpenAI::Realtime::RealtimeServerEvent::OutputAudioBufferStopped,
              OpenAI::Realtime::RealtimeServerEvent::OutputAudioBufferCleared,
              OpenAI::Realtime::ConversationItemAdded,
              OpenAI::Realtime::ConversationItemDone,
              OpenAI::Realtime::InputAudioBufferTimeoutTriggered,
              OpenAI::Realtime::ConversationItemInputAudioTranscriptionSegment,
              OpenAI::Realtime::McpListToolsInProgress,
              OpenAI::Realtime::McpListToolsCompleted,
              OpenAI::Realtime::McpListToolsFailed,
              OpenAI::Realtime::ResponseMcpCallArgumentsDelta,
              OpenAI::Realtime::ResponseMcpCallArgumentsDone,
              OpenAI::Realtime::ResponseMcpCallInProgress,
              OpenAI::Realtime::ResponseMcpCallCompleted,
              OpenAI::Realtime::ResponseMcpCallFailed
            )
          end

        class ConversationItemRetrieved < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeServerEvent::ConversationItemRetrieved,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the server event.
          sig { returns(String) }
          attr_accessor :event_id

          # A single item within a Realtime conversation.
          sig do
            returns(
              T.any(
                OpenAI::Realtime::RealtimeConversationItemSystemMessage,
                OpenAI::Realtime::RealtimeConversationItemUserMessage,
                OpenAI::Realtime::RealtimeConversationItemAssistantMessage,
                OpenAI::Realtime::RealtimeConversationItemFunctionCall,
                OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput,
                OpenAI::Realtime::RealtimeMcpApprovalResponse,
                OpenAI::Realtime::RealtimeMcpListTools,
                OpenAI::Realtime::RealtimeMcpToolCall,
                OpenAI::Realtime::RealtimeMcpApprovalRequest
              )
            )
          end
          attr_accessor :item

          # The event type, must be `conversation.item.retrieved`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Returned when a conversation item is retrieved with
          # `conversation.item.retrieve`. This is provided as a way to fetch the server's
          # representation of an item, for example to get access to the post-processed audio
          # data after noise cancellation and VAD. It includes the full content of the Item,
          # including audio data.
          sig do
            params(
              event_id: String,
              item:
                T.any(
                  OpenAI::Realtime::RealtimeConversationItemSystemMessage::OrHash,
                  OpenAI::Realtime::RealtimeConversationItemUserMessage::OrHash,
                  OpenAI::Realtime::RealtimeConversationItemAssistantMessage::OrHash,
                  OpenAI::Realtime::RealtimeConversationItemFunctionCall::OrHash,
                  OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::OrHash,
                  OpenAI::Realtime::RealtimeMcpApprovalResponse::OrHash,
                  OpenAI::Realtime::RealtimeMcpListTools::OrHash,
                  OpenAI::Realtime::RealtimeMcpToolCall::OrHash,
                  OpenAI::Realtime::RealtimeMcpApprovalRequest::OrHash
                ),
              type: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # The unique ID of the server event.
            event_id:,
            # A single item within a Realtime conversation.
            item:,
            # The event type, must be `conversation.item.retrieved`.
            type: :"conversation.item.retrieved"
          )
          end

          sig do
            override.returns(
              {
                event_id: String,
                item:
                  T.any(
                    OpenAI::Realtime::RealtimeConversationItemSystemMessage,
                    OpenAI::Realtime::RealtimeConversationItemUserMessage,
                    OpenAI::Realtime::RealtimeConversationItemAssistantMessage,
                    OpenAI::Realtime::RealtimeConversationItemFunctionCall,
                    OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput,
                    OpenAI::Realtime::RealtimeMcpApprovalResponse,
                    OpenAI::Realtime::RealtimeMcpListTools,
                    OpenAI::Realtime::RealtimeMcpToolCall,
                    OpenAI::Realtime::RealtimeMcpApprovalRequest
                  ),
                type: Symbol
              }
            )
          end
          def to_hash
          end
        end

        class OutputAudioBufferStarted < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeServerEvent::OutputAudioBufferStarted,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the server event.
          sig { returns(String) }
          attr_accessor :event_id

          # The unique ID of the response that produced the audio.
          sig { returns(String) }
          attr_accessor :response_id

          # The event type, must be `output_audio_buffer.started`.
          sig { returns(Symbol) }
          attr_accessor :type

          # **WebRTC Only:** Emitted when the server begins streaming audio to the client.
          # This event is emitted after an audio content part has been added
          # (`response.content_part.added`) to the response.
          # [Learn more](https://platform.openai.com/docs/guides/realtime-conversations#client-and-server-events-for-audio-in-webrtc).
          sig do
            params(event_id: String, response_id: String, type: Symbol).returns(
              T.attached_class
            )
          end
          def self.new(
            # The unique ID of the server event.
            event_id:,
            # The unique ID of the response that produced the audio.
            response_id:,
            # The event type, must be `output_audio_buffer.started`.
            type: :"output_audio_buffer.started"
          )
          end

          sig do
            override.returns(
              { event_id: String, response_id: String, type: Symbol }
            )
          end
          def to_hash
          end
        end

        class OutputAudioBufferStopped < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeServerEvent::OutputAudioBufferStopped,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the server event.
          sig { returns(String) }
          attr_accessor :event_id

          # The unique ID of the response that produced the audio.
          sig { returns(String) }
          attr_accessor :response_id

          # The event type, must be `output_audio_buffer.stopped`.
          sig { returns(Symbol) }
          attr_accessor :type

          # **WebRTC Only:** Emitted when the output audio buffer has been completely
          # drained on the server, and no more audio is forthcoming. This event is emitted
          # after the full response data has been sent to the client (`response.done`).
          # [Learn more](https://platform.openai.com/docs/guides/realtime-conversations#client-and-server-events-for-audio-in-webrtc).
          sig do
            params(event_id: String, response_id: String, type: Symbol).returns(
              T.attached_class
            )
          end
          def self.new(
            # The unique ID of the server event.
            event_id:,
            # The unique ID of the response that produced the audio.
            response_id:,
            # The event type, must be `output_audio_buffer.stopped`.
            type: :"output_audio_buffer.stopped"
          )
          end

          sig do
            override.returns(
              { event_id: String, response_id: String, type: Symbol }
            )
          end
          def to_hash
          end
        end

        class OutputAudioBufferCleared < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeServerEvent::OutputAudioBufferCleared,
                OpenAI::Internal::AnyHash
              )
            end

          # The unique ID of the server event.
          sig { returns(String) }
          attr_accessor :event_id

          # The unique ID of the response that produced the audio.
          sig { returns(String) }
          attr_accessor :response_id

          # The event type, must be `output_audio_buffer.cleared`.
          sig { returns(Symbol) }
          attr_accessor :type

          # **WebRTC Only:** Emitted when the output audio buffer is cleared. This happens
          # either in VAD mode when the user has interrupted
          # (`input_audio_buffer.speech_started`), or when the client has emitted the
          # `output_audio_buffer.clear` event to manually cut off the current audio
          # response.
          # [Learn more](https://platform.openai.com/docs/guides/realtime-conversations#client-and-server-events-for-audio-in-webrtc).
          sig do
            params(event_id: String, response_id: String, type: Symbol).returns(
              T.attached_class
            )
          end
          def self.new(
            # The unique ID of the server event.
            event_id:,
            # The unique ID of the response that produced the audio.
            response_id:,
            # The event type, must be `output_audio_buffer.cleared`.
            type: :"output_audio_buffer.cleared"
          )
          end

          sig do
            override.returns(
              { event_id: String, response_id: String, type: Symbol }
            )
          end
          def to_hash
          end
        end

        sig do
          override.returns(
            T::Array[OpenAI::Realtime::RealtimeServerEvent::Variants]
          )
        end
        def self.variants
        end
      end
    end
  end
end
