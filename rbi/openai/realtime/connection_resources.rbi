# typed: strong

module OpenAI
  module Models
    module Realtime
      module ConnectionResources
        class Base
          # @api private
          sig do
            params(connection: OpenAI::Realtime::BaseConnection).returns(
              T.attached_class
            )
          end
          def self.new(connection)
          end
        end

        class Session < Base
          sig do
            params(
              type: Symbol,
              audio:
                T.any(
                  OpenAI::Realtime::RealtimeAudioConfig::OrHash,
                  OpenAI::Realtime::RealtimeTranscriptionSessionAudio::OrHash
                ),
              include: T::Array[Symbol],
              instructions: String,
              max_output_tokens: T.any(Integer, Symbol),
              model: T.any(String, Symbol),
              output_modalities: T::Array[Symbol],
              parallel_tool_calls: T::Boolean,
              prompt: T.nilable(OpenAI::Responses::ResponsePrompt::OrHash),
              reasoning: OpenAI::Realtime::RealtimeReasoning::OrHash,
              tool_choice:
                T.any(
                  OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                  OpenAI::Responses::ToolChoiceFunction::OrHash,
                  OpenAI::Responses::ToolChoiceMcp::OrHash
                ),
              tools:
                T::Array[
                  T.any(
                    OpenAI::Realtime::RealtimeFunctionTool::OrHash,
                    OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::OrHash
                  )
                ],
              tracing:
                T.nilable(
                  T.any(
                    Symbol,
                    OpenAI::Realtime::RealtimeTracingConfig::TracingConfiguration::OrHash
                  )
                ),
              truncation:
                T.any(
                  OpenAI::Realtime::RealtimeTruncation::RealtimeTruncationStrategy::OrSymbol,
                  OpenAI::Realtime::RealtimeTruncationRetentionRatio::OrHash
                ),
              event_id: T.nilable(String)
            ).void
          end
          def update(
            type:,
            audio: nil,
            include: nil,
            instructions: nil,
            max_output_tokens: nil,
            model: nil,
            output_modalities: nil,
            parallel_tool_calls: nil,
            prompt: nil,
            reasoning: nil,
            tool_choice: nil,
            tools: nil,
            tracing: nil,
            truncation: nil,
            event_id: nil
          )
          end
        end

        class TranscriptionSession < Base
          sig do
            params(
              audio:
                OpenAI::Realtime::RealtimeTranscriptionSessionAudio::OrHash,
              include:
                T::Array[
                  OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest::Include::OrSymbol
                ],
              event_id: T.nilable(String)
            ).void
          end
          def update(audio: nil, include: nil, event_id: nil)
          end
        end

        class TranslationSession < Session
          sig do
            params(
              audio:
                OpenAI::Realtime::RealtimeTranslationSessionUpdateRequest::Audio::OrHash,
              event_id: T.nilable(String)
            ).void
          end
          def update(audio: nil, event_id: nil)
          end

          sig { params(event_id: T.nilable(String)).void }
          def close(event_id: nil)
          end
        end

        class Response < Base
          sig do
            params(
              audio: OpenAI::Realtime::RealtimeResponseCreateAudioOutput::OrHash,
              conversation: T.any(String, Symbol),
              input:
                T::Array[
                  T.any(
                    OpenAI::Realtime::RealtimeConversationItemSystemMessage::OrHash,
                    OpenAI::Realtime::RealtimeConversationItemUserMessage::OrHash,
                    OpenAI::Realtime::RealtimeConversationItemAssistantMessage::OrHash,
                    OpenAI::Realtime::RealtimeConversationItemFunctionCall::OrHash,
                    OpenAI::Realtime::RealtimeConversationItemFunctionCallOutput::OrHash,
                    OpenAI::Realtime::RealtimeMcpApprovalResponse::OrHash,
                    OpenAI::Realtime::RealtimeMcpListTools::OrHash,
                    OpenAI::Realtime::RealtimeMcpToolCall::OrHash,
                    OpenAI::Realtime::RealtimeMcpApprovalRequest::OrHash,
                    OpenAI::Realtime::ConversationItemWithReference::OrHash
                  )
                ],
              instructions: String,
              max_output_tokens: T.any(Integer, Symbol),
              metadata: T.nilable(T::Hash[Symbol, String]),
              output_modalities: T::Array[Symbol],
              parallel_tool_calls: T::Boolean,
              prompt: T.nilable(OpenAI::Responses::ResponsePrompt::OrHash),
              reasoning: OpenAI::Realtime::RealtimeReasoning::OrHash,
              tool_choice:
                T.any(
                  OpenAI::Responses::ToolChoiceOptions::OrSymbol,
                  OpenAI::Responses::ToolChoiceFunction::OrHash,
                  OpenAI::Responses::ToolChoiceMcp::OrHash
                ),
              tools:
                T::Array[
                  T.any(
                    OpenAI::Realtime::RealtimeFunctionTool::OrHash,
                    OpenAI::Realtime::RealtimeResponseCreateMcpTool::OrHash
                  )
                ],
              event_id: T.nilable(String)
            ).void
          end
          def create(
            audio: nil,
            conversation: nil,
            input: nil,
            instructions: nil,
            max_output_tokens: nil,
            metadata: nil,
            output_modalities: nil,
            parallel_tool_calls: nil,
            prompt: nil,
            reasoning: nil,
            tool_choice: nil,
            tools: nil,
            event_id: nil
          )
          end

          sig do
            params(
              response_id: T.nilable(String),
              event_id: T.nilable(String)
            ).void
          end
          def cancel(response_id: nil, event_id: nil)
          end
        end

        class InputAudioBuffer < Base
          sig { params(audio: String, event_id: T.nilable(String)).void }
          def append(audio:, event_id: nil)
          end

          sig { params(bytes: String, event_id: T.nilable(String)).void }
          def append_bytes(bytes, event_id: nil)
          end

          sig { params(event_id: T.nilable(String)).void }
          def commit(event_id: nil)
          end

          sig { params(event_id: T.nilable(String)).void }
          def clear(event_id: nil)
          end
        end

        class TranslationInputAudioBuffer < Base
          sig { params(audio: String, event_id: T.nilable(String)).void }
          def append(audio:, event_id: nil)
          end

          sig { params(bytes: String, event_id: T.nilable(String)).void }
          def append_bytes(bytes, event_id: nil)
          end
        end

        class Conversation < Base
          sig do
            returns(OpenAI::Realtime::ConnectionResources::ConversationItems)
          end
          attr_reader :items
        end

        class ConversationItems < Base
          sig do
            params(
              type: Symbol,
              arguments: String,
              approval_request_id: T.nilable(String),
              approve: T::Boolean,
              call_id: String,
              content: T::Array[OpenAI::Internal::AnyHash],
              error: T.untyped,
              id: String,
              name: String,
              object: Symbol,
              output: T.nilable(String),
              reason: T.nilable(String),
              role: Symbol,
              server_label: String,
              status: Symbol,
              tools: T::Array[OpenAI::Realtime::RealtimeMcpListTools::Tool::OrHash],
              event_id: T.nilable(String),
              previous_item_id: T.nilable(String)
            ).void
          end
          def create(
            type:,
            arguments: nil,
            approval_request_id: nil,
            approve: nil,
            call_id: nil,
            content: nil,
            error: nil,
            id: nil,
            name: nil,
            object: nil,
            output: nil,
            reason: nil,
            role: nil,
            server_label: nil,
            status: nil,
            tools: nil,
            event_id: nil,
            previous_item_id: nil
          )
          end

          sig { params(item_id: String, event_id: T.nilable(String)).void }
          def delete(item_id:, event_id: nil)
          end

          sig { params(item_id: String, event_id: T.nilable(String)).void }
          def retrieve(item_id:, event_id: nil)
          end

          sig do
            params(
              item_id: String,
              content_index: Integer,
              audio_end_ms: Integer,
              event_id: T.nilable(String)
            ).void
          end
          def truncate(item_id:, content_index:, audio_end_ms:, event_id: nil)
          end

          sig do
            params(
              call_id: String,
              output: String,
              id: T.nilable(String),
              status: T.nilable(T.any(String, Symbol)),
              event_id: T.nilable(String)
            ).void
          end
          def create_function_call_output(
            call_id:,
            output:,
            id: nil,
            status: nil,
            event_id: nil
          )
          end

          sig do
            params(
              approval_request_id: String,
              approve: T::Boolean,
              reason: T.nilable(String),
              id: T.nilable(String),
              event_id: T.nilable(String)
            ).void
          end
          def respond_to_mcp_approval(
            approval_request_id:,
            approve:,
            reason: nil,
            id: nil,
            event_id: nil
          )
          end
        end

        class OutputAudioBuffer < Base
          sig { params(event_id: T.nilable(String)).void }
          def clear(event_id: nil)
          end
        end
      end
    end
  end
end
