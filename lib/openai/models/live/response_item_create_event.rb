# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class ResponseItemCreateEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute item
        #   An input item to append to the Responses backend conversation, such as a user
        #   message or a function tool result.
        #
        #   @return [OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseInputItem::ToolSearchCall, OpenAI::Models::Responses::ResponseToolSearchOutputItemParam, OpenAI::Models::Responses::ResponseInputItem::AdditionalTools, OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCompactionItemParam, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ShellCall, OpenAI::Models::Responses::ResponseInputItem::ShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCall, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::CompactionTrigger, OpenAI::Models::Responses::ResponseInputItem::ItemReference, OpenAI::Models::Responses::ResponseInputItem::Program, OpenAI::Models::Responses::ResponseInputItem::ProgramOutput]
        required :item, union: -> { OpenAI::Responses::ResponseInputItem }

        # @!attribute type
        #   The Live client event type. Always `response.item.create`.
        #
        #   @return [Symbol, :"response.item.create"]
        required :type, const: :"response.item.create"

        # @!attribute event_id
        #   Optional client identifier for correlating this command with a server event's
        #   client_event_id or error.client_event_id.
        #
        #   @return [String, nil]
        optional :event_id, String, nil?: true

        # @!method initialize(item:, event_id: nil, type: :"response.item.create")
        #   Add an input item to the Live session’s Responses backend. Requires Responses
        #   delegation; use `response.create` to request a response.
        #
        #   @param item [OpenAI::Models::Responses::EasyInputMessage, OpenAI::Models::Responses::ResponseInputItem::Message, OpenAI::Models::Responses::ResponseOutputMessage, OpenAI::Models::Responses::ResponseFileSearchToolCall, OpenAI::Models::Responses::ResponseComputerToolCall, OpenAI::Models::Responses::ResponseInputItem::ComputerCallOutput, OpenAI::Models::Responses::ResponseFunctionWebSearch, OpenAI::Models::Responses::ResponseFunctionToolCall, OpenAI::Models::Responses::ResponseInputItem::FunctionCallOutput, OpenAI::Models::Responses::ResponseInputItem::ToolSearchCall, OpenAI::Models::Responses::ResponseToolSearchOutputItemParam, OpenAI::Models::Responses::ResponseInputItem::AdditionalTools, OpenAI::Models::Responses::ResponseConfigurationUpdateItemParam, OpenAI::Models::Responses::ResponseReasoningItem, OpenAI::Models::Responses::ResponseCompactionItemParam, OpenAI::Models::Responses::ResponseInputItem::ImageGenerationCall, OpenAI::Models::Responses::ResponseCodeInterpreterToolCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCall, OpenAI::Models::Responses::ResponseInputItem::LocalShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ShellCall, OpenAI::Models::Responses::ResponseInputItem::ShellCallOutput, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCall, OpenAI::Models::Responses::ResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Responses::ResponseInputItem::McpListTools, OpenAI::Models::Responses::ResponseInputItem::McpApprovalRequest, OpenAI::Models::Responses::ResponseInputItem::McpApprovalResponse, OpenAI::Models::Responses::ResponseInputItem::McpCall, OpenAI::Models::Responses::ResponseCustomToolCallOutput, OpenAI::Models::Responses::ResponseCustomToolCall, OpenAI::Models::Responses::ResponseInputItem::CompactionTrigger, OpenAI::Models::Responses::ResponseInputItem::ItemReference, OpenAI::Models::Responses::ResponseInputItem::Program, OpenAI::Models::Responses::ResponseInputItem::ProgramOutput]
        #     An input item to append to the Responses backend conversation, such as a user
        #     message or a function tool result.
        #
        #   @param event_id [String, nil]
        #     Optional client identifier for correlating this command with a server event's
        #     client_event_id or error.client_event_id.
        #
        #   @param type [Symbol, :"response.item.create"]
        #     The Live client event type. Always `response.item.create`.
      end
    end
  end
end
