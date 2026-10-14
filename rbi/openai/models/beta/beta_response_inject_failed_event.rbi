# typed: strong

module OpenAI
  module Models
    BetaResponseInjectFailedEvent = Beta::BetaResponseInjectFailedEvent

    module Beta
      class BetaResponseInjectFailedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseInjectFailedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Information about why the input was not committed.
        sig { returns(OpenAI::Beta::BetaResponseInjectFailedEvent::Error) }
        attr_reader :error

        sig do
          params(
            error: OpenAI::Beta::BetaResponseInjectFailedEvent::Error::OrHash
          ).void
        end
        attr_writer :error

        # The raw input items that were not committed.
        sig do
          returns(
            T::Array[
              T.any(
                OpenAI::Beta::BetaEasyInputMessage,
                OpenAI::Beta::BetaResponseInputItem::Message,
                OpenAI::Beta::BetaResponseOutputMessage,
                OpenAI::Beta::BetaResponseFileSearchToolCall,
                OpenAI::Beta::BetaResponseComputerToolCall,
                OpenAI::Beta::BetaResponseInputItem::ComputerCallOutput,
                OpenAI::Beta::BetaResponseFunctionWebSearch,
                OpenAI::Beta::BetaResponseFunctionToolCall,
                OpenAI::Beta::BetaResponseInputItem::FunctionCallOutput,
                OpenAI::Beta::BetaResponseInputItem::AgentMessage,
                OpenAI::Beta::BetaResponseInputItem::MultiAgentCall,
                OpenAI::Beta::BetaResponseInputItem::MultiAgentCallOutput,
                OpenAI::Beta::BetaResponseInputItem::ToolSearchCall,
                OpenAI::Beta::BetaResponseToolSearchOutputItemParam,
                OpenAI::Beta::BetaResponseInputItem::AdditionalTools,
                OpenAI::Beta::BetaResponseReasoningItem,
                OpenAI::Beta::BetaResponseCompactionItemParam,
                OpenAI::Beta::BetaResponseInputItem::ImageGenerationCall,
                OpenAI::Beta::BetaResponseCodeInterpreterToolCall,
                OpenAI::Beta::BetaResponseInputItem::LocalShellCall,
                OpenAI::Beta::BetaResponseInputItem::LocalShellCallOutput,
                OpenAI::Beta::BetaResponseInputItem::ShellCall,
                OpenAI::Beta::BetaResponseInputItem::ShellCallOutput,
                OpenAI::Beta::BetaResponseInputItem::ApplyPatchCall,
                OpenAI::Beta::BetaResponseInputItem::ApplyPatchCallOutput,
                OpenAI::Beta::BetaResponseInputItem::McpListTools,
                OpenAI::Beta::BetaResponseInputItem::McpApprovalRequest,
                OpenAI::Beta::BetaResponseInputItem::McpApprovalResponse,
                OpenAI::Beta::BetaResponseInputItem::McpCall,
                OpenAI::Beta::BetaResponseCustomToolCallOutput,
                OpenAI::Beta::BetaResponseCustomToolCall,
                OpenAI::Beta::BetaResponseInputItem::CompactionTrigger,
                OpenAI::Beta::BetaResponseInputItem::ItemReference,
                OpenAI::Beta::BetaResponseInputItem::Program,
                OpenAI::Beta::BetaResponseInputItem::ProgramOutput
              )
            ]
          )
        end
        attr_accessor :input

        # The ID of the response that rejected the input.
        sig { returns(String) }
        attr_accessor :response_id

        # The sequence number for this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The event discriminator. Always `response.inject.failed`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The multiplexed WebSocket stream that emitted the event. This field is present
        # only when WebSocket multiplexing is enabled separately.
        sig { returns(T.nilable(String)) }
        attr_reader :stream_id

        sig { params(stream_id: String).void }
        attr_writer :stream_id

        # Emitted when injected input could not be committed to a response. The event
        # returns the uncommitted raw input so the client can retry it in another response
        # when appropriate.
        sig do
          params(
            error: OpenAI::Beta::BetaResponseInjectFailedEvent::Error::OrHash,
            input:
              T::Array[
                T.any(
                  OpenAI::Beta::BetaEasyInputMessage::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::Message::OrHash,
                  OpenAI::Beta::BetaResponseOutputMessage::OrHash,
                  OpenAI::Beta::BetaResponseFileSearchToolCall::OrHash,
                  OpenAI::Beta::BetaResponseComputerToolCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ComputerCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseFunctionWebSearch::OrHash,
                  OpenAI::Beta::BetaResponseFunctionToolCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::FunctionCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::AgentMessage::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::MultiAgentCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::MultiAgentCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ToolSearchCall::OrHash,
                  OpenAI::Beta::BetaResponseToolSearchOutputItemParam::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::AdditionalTools::OrHash,
                  OpenAI::Beta::BetaResponseReasoningItem::OrHash,
                  OpenAI::Beta::BetaResponseCompactionItemParam::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ImageGenerationCall::OrHash,
                  OpenAI::Beta::BetaResponseCodeInterpreterToolCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::LocalShellCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::LocalShellCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ShellCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ShellCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ApplyPatchCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ApplyPatchCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::McpListTools::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::McpApprovalRequest::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::McpApprovalResponse::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::McpCall::OrHash,
                  OpenAI::Beta::BetaResponseCustomToolCallOutput::OrHash,
                  OpenAI::Beta::BetaResponseCustomToolCall::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::CompactionTrigger::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ItemReference::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::Program::OrHash,
                  OpenAI::Beta::BetaResponseInputItem::ProgramOutput::OrHash
                )
              ],
            response_id: String,
            sequence_number: Integer,
            stream_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Information about why the input was not committed.
          error:,
          # The raw input items that were not committed.
          input:,
          # The ID of the response that rejected the input.
          response_id:,
          # The sequence number for this event.
          sequence_number:,
          # The multiplexed WebSocket stream that emitted the event. This field is present
          # only when WebSocket multiplexing is enabled separately.
          stream_id: nil,
          # The event discriminator. Always `response.inject.failed`.
          type: :"response.inject.failed"
        )
        end

        sig do
          override.returns(
            {
              error: OpenAI::Beta::BetaResponseInjectFailedEvent::Error,
              input:
                T::Array[
                  T.any(
                    OpenAI::Beta::BetaEasyInputMessage,
                    OpenAI::Beta::BetaResponseInputItem::Message,
                    OpenAI::Beta::BetaResponseOutputMessage,
                    OpenAI::Beta::BetaResponseFileSearchToolCall,
                    OpenAI::Beta::BetaResponseComputerToolCall,
                    OpenAI::Beta::BetaResponseInputItem::ComputerCallOutput,
                    OpenAI::Beta::BetaResponseFunctionWebSearch,
                    OpenAI::Beta::BetaResponseFunctionToolCall,
                    OpenAI::Beta::BetaResponseInputItem::FunctionCallOutput,
                    OpenAI::Beta::BetaResponseInputItem::AgentMessage,
                    OpenAI::Beta::BetaResponseInputItem::MultiAgentCall,
                    OpenAI::Beta::BetaResponseInputItem::MultiAgentCallOutput,
                    OpenAI::Beta::BetaResponseInputItem::ToolSearchCall,
                    OpenAI::Beta::BetaResponseToolSearchOutputItemParam,
                    OpenAI::Beta::BetaResponseInputItem::AdditionalTools,
                    OpenAI::Beta::BetaResponseReasoningItem,
                    OpenAI::Beta::BetaResponseCompactionItemParam,
                    OpenAI::Beta::BetaResponseInputItem::ImageGenerationCall,
                    OpenAI::Beta::BetaResponseCodeInterpreterToolCall,
                    OpenAI::Beta::BetaResponseInputItem::LocalShellCall,
                    OpenAI::Beta::BetaResponseInputItem::LocalShellCallOutput,
                    OpenAI::Beta::BetaResponseInputItem::ShellCall,
                    OpenAI::Beta::BetaResponseInputItem::ShellCallOutput,
                    OpenAI::Beta::BetaResponseInputItem::ApplyPatchCall,
                    OpenAI::Beta::BetaResponseInputItem::ApplyPatchCallOutput,
                    OpenAI::Beta::BetaResponseInputItem::McpListTools,
                    OpenAI::Beta::BetaResponseInputItem::McpApprovalRequest,
                    OpenAI::Beta::BetaResponseInputItem::McpApprovalResponse,
                    OpenAI::Beta::BetaResponseInputItem::McpCall,
                    OpenAI::Beta::BetaResponseCustomToolCallOutput,
                    OpenAI::Beta::BetaResponseCustomToolCall,
                    OpenAI::Beta::BetaResponseInputItem::CompactionTrigger,
                    OpenAI::Beta::BetaResponseInputItem::ItemReference,
                    OpenAI::Beta::BetaResponseInputItem::Program,
                    OpenAI::Beta::BetaResponseInputItem::ProgramOutput
                  )
                ],
              response_id: String,
              sequence_number: Integer,
              type: Symbol,
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
                OpenAI::Beta::BetaResponseInjectFailedEvent::Error,
                OpenAI::Internal::AnyHash
              )
            end

          # A machine-readable error code.
          sig do
            returns(
              OpenAI::Beta::BetaResponseInjectFailedEvent::Error::Code::OrSymbol
            )
          end
          attr_accessor :code

          # A human-readable description of the error.
          sig { returns(String) }
          attr_accessor :message

          # Information about why the input was not committed.
          sig do
            params(
              code:
                OpenAI::Beta::BetaResponseInjectFailedEvent::Error::Code::OrSymbol,
              message: String
            ).returns(T.attached_class)
          end
          def self.new(
            # A machine-readable error code.
            code:,
            # A human-readable description of the error.
            message:
          )
          end

          sig do
            override.returns(
              {
                code:
                  OpenAI::Beta::BetaResponseInjectFailedEvent::Error::Code::OrSymbol,
                message: String
              }
            )
          end
          def to_hash
          end

          # A machine-readable error code.
          module Code
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol =
              T.type_alias do
                T.all(
                  Symbol,
                  OpenAI::Beta::BetaResponseInjectFailedEvent::Error::Code
                )
              end
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            RESPONSE_ALREADY_COMPLETED =
              T.let(
                :response_already_completed,
                OpenAI::Beta::BetaResponseInjectFailedEvent::Error::Code::TaggedSymbol
              )
            RESPONSE_NOT_FOUND =
              T.let(
                :response_not_found,
                OpenAI::Beta::BetaResponseInjectFailedEvent::Error::Code::TaggedSymbol
              )

            sig do
              override.returns(
                T::Array[
                  OpenAI::Beta::BetaResponseInjectFailedEvent::Error::Code::TaggedSymbol
                ]
              )
            end
            def self.values
            end
          end
        end
      end
    end
  end
end
