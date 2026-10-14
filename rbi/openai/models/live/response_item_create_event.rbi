# typed: strong

module OpenAI
  module Models

    module Live

      class ResponseItemCreateEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::ResponseItemCreateEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # An input item to append to the Responses backend conversation, such as a user
        # message or a function tool result.
        sig {
          returns(
            T.any(
              OpenAI::Responses::EasyInputMessage,
              OpenAI::Responses::ResponseInputItem::Message,
              OpenAI::Responses::ResponseOutputMessage,
              OpenAI::Responses::ResponseFileSearchToolCall,
              OpenAI::Responses::ResponseComputerToolCall,
              OpenAI::Responses::ResponseInputItem::ComputerCallOutput,
              OpenAI::Responses::ResponseFunctionWebSearch,
              OpenAI::Responses::ResponseFunctionToolCall,
              OpenAI::Responses::ResponseInputItem::FunctionCallOutput,
              OpenAI::Responses::ResponseInputItem::ToolSearchCall,
              OpenAI::Responses::ResponseToolSearchOutputItemParam,
              OpenAI::Responses::ResponseInputItem::AdditionalTools,
              OpenAI::Responses::ResponseConfigurationUpdateItemParam,
              OpenAI::Responses::ResponseReasoningItem,
              OpenAI::Responses::ResponseCompactionItemParam,
              OpenAI::Responses::ResponseInputItem::ImageGenerationCall,
              OpenAI::Responses::ResponseCodeInterpreterToolCall,
              OpenAI::Responses::ResponseInputItem::LocalShellCall,
              OpenAI::Responses::ResponseInputItem::LocalShellCallOutput,
              OpenAI::Responses::ResponseInputItem::ShellCall,
              OpenAI::Responses::ResponseInputItem::ShellCallOutput,
              OpenAI::Responses::ResponseInputItem::ApplyPatchCall,
              OpenAI::Responses::ResponseInputItem::ApplyPatchCallOutput,
              OpenAI::Responses::ResponseInputItem::McpListTools,
              OpenAI::Responses::ResponseInputItem::McpApprovalRequest,
              OpenAI::Responses::ResponseInputItem::McpApprovalResponse,
              OpenAI::Responses::ResponseInputItem::McpCall,
              OpenAI::Responses::ResponseCustomToolCallOutput,
              OpenAI::Responses::ResponseCustomToolCall,
              OpenAI::Responses::ResponseInputItem::CompactionTrigger,
              OpenAI::Responses::ResponseInputItem::ItemReference,
              OpenAI::Responses::ResponseInputItem::Program,
              OpenAI::Responses::ResponseInputItem::ProgramOutput
            )
          )
        }
        attr_accessor :item

        # The Live client event type. Always `response.item.create`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Optional client identifier for correlating this command with a server event's
        # client_event_id or error.client_event_id.
        sig { returns(T.nilable(String)) }
        attr_accessor :event_id

        # Add an input item to the Live session’s Responses backend. Requires Responses
        # delegation; use `response.create` to request a response.
        sig do
          params(

            item: T.any(
              OpenAI::Responses::EasyInputMessage::OrHash,
              OpenAI::Responses::ResponseInputItem::Message::OrHash,
              OpenAI::Responses::ResponseOutputMessage::OrHash,
              OpenAI::Responses::ResponseFileSearchToolCall::OrHash,
              OpenAI::Responses::ResponseComputerToolCall::OrHash,
              OpenAI::Responses::ResponseInputItem::ComputerCallOutput::OrHash,
              OpenAI::Responses::ResponseFunctionWebSearch::OrHash,
              OpenAI::Responses::ResponseFunctionToolCall::OrHash,
              OpenAI::Responses::ResponseInputItem::FunctionCallOutput::OrHash,
              OpenAI::Responses::ResponseInputItem::ToolSearchCall::OrHash,
              OpenAI::Responses::ResponseToolSearchOutputItemParam::OrHash,
              OpenAI::Responses::ResponseInputItem::AdditionalTools::OrHash,
              OpenAI::Responses::ResponseConfigurationUpdateItemParam::OrHash,
              OpenAI::Responses::ResponseReasoningItem::OrHash,
              OpenAI::Responses::ResponseCompactionItemParam::OrHash,
              OpenAI::Responses::ResponseInputItem::ImageGenerationCall::OrHash,
              OpenAI::Responses::ResponseCodeInterpreterToolCall::OrHash,
              OpenAI::Responses::ResponseInputItem::LocalShellCall::OrHash,
              OpenAI::Responses::ResponseInputItem::LocalShellCallOutput::OrHash,
              OpenAI::Responses::ResponseInputItem::ShellCall::OrHash,
              OpenAI::Responses::ResponseInputItem::ShellCallOutput::OrHash,
              OpenAI::Responses::ResponseInputItem::ApplyPatchCall::OrHash,
              OpenAI::Responses::ResponseInputItem::ApplyPatchCallOutput::OrHash,
              OpenAI::Responses::ResponseInputItem::McpListTools::OrHash,
              OpenAI::Responses::ResponseInputItem::McpApprovalRequest::OrHash,
              OpenAI::Responses::ResponseInputItem::McpApprovalResponse::OrHash,
              OpenAI::Responses::ResponseInputItem::McpCall::OrHash,
              OpenAI::Responses::ResponseCustomToolCallOutput::OrHash,
              OpenAI::Responses::ResponseCustomToolCall::OrHash,
              OpenAI::Responses::ResponseInputItem::CompactionTrigger::OrHash,
              OpenAI::Responses::ResponseInputItem::ItemReference::OrHash,
              OpenAI::Responses::ResponseInputItem::Program::OrHash,
              OpenAI::Responses::ResponseInputItem::ProgramOutput::OrHash
            ),

            event_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # An input item to append to the Responses backend conversation, such as a user
          # message or a function tool result.
          item:,

          # Optional client identifier for correlating this command with a server event's
          # client_event_id or error.client_event_id.
          event_id: nil,

          # The Live client event type. Always `response.item.create`.

          type: :"response.item.create"
        )
        end

        sig do
          override.returns(
            {
              item: T.any(
                OpenAI::Responses::EasyInputMessage,
                OpenAI::Responses::ResponseInputItem::Message,
                OpenAI::Responses::ResponseOutputMessage,
                OpenAI::Responses::ResponseFileSearchToolCall,
                OpenAI::Responses::ResponseComputerToolCall,
                OpenAI::Responses::ResponseInputItem::ComputerCallOutput,
                OpenAI::Responses::ResponseFunctionWebSearch,
                OpenAI::Responses::ResponseFunctionToolCall,
                OpenAI::Responses::ResponseInputItem::FunctionCallOutput,
                OpenAI::Responses::ResponseInputItem::ToolSearchCall,
                OpenAI::Responses::ResponseToolSearchOutputItemParam,
                OpenAI::Responses::ResponseInputItem::AdditionalTools,
                OpenAI::Responses::ResponseConfigurationUpdateItemParam,
                OpenAI::Responses::ResponseReasoningItem,
                OpenAI::Responses::ResponseCompactionItemParam,
                OpenAI::Responses::ResponseInputItem::ImageGenerationCall,
                OpenAI::Responses::ResponseCodeInterpreterToolCall,
                OpenAI::Responses::ResponseInputItem::LocalShellCall,
                OpenAI::Responses::ResponseInputItem::LocalShellCallOutput,
                OpenAI::Responses::ResponseInputItem::ShellCall,
                OpenAI::Responses::ResponseInputItem::ShellCallOutput,
                OpenAI::Responses::ResponseInputItem::ApplyPatchCall,
                OpenAI::Responses::ResponseInputItem::ApplyPatchCallOutput,
                OpenAI::Responses::ResponseInputItem::McpListTools,
                OpenAI::Responses::ResponseInputItem::McpApprovalRequest,
                OpenAI::Responses::ResponseInputItem::McpApprovalResponse,
                OpenAI::Responses::ResponseInputItem::McpCall,
                OpenAI::Responses::ResponseCustomToolCallOutput,
                OpenAI::Responses::ResponseCustomToolCall,
                OpenAI::Responses::ResponseInputItem::CompactionTrigger,
                OpenAI::Responses::ResponseInputItem::ItemReference,
                OpenAI::Responses::ResponseInputItem::Program,
                OpenAI::Responses::ResponseInputItem::ProgramOutput
              ),
              type: Symbol,
              event_id: T.nilable(String)
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
