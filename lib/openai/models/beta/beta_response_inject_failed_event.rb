# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      class BetaResponseInjectFailedEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute error
        #   Information about why the input was not committed.
        #
        #   @return [OpenAI::Models::Beta::BetaResponseInjectFailedEvent::Error]
        required :error, -> { OpenAI::Beta::BetaResponseInjectFailedEvent::Error }

        # @!attribute input
        #   The raw input items that were not committed.
        #
        #   @return [Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>]
        required :input, -> { OpenAI::Internal::Type::ArrayOf[union: OpenAI::Beta::BetaResponseInputItem] }

        # @!attribute response_id
        #   The ID of the response that rejected the input.
        #
        #   @return [String]
        required :response_id, String

        # @!attribute sequence_number
        #   The sequence number for this event.
        #
        #   @return [Integer]
        required :sequence_number, Integer

        # @!attribute type
        #   The event discriminator. Always `response.inject.failed`.
        #
        #   @return [Symbol, :"response.inject.failed"]
        required :type, const: :"response.inject.failed"

        # @!attribute stream_id
        #   The multiplexed WebSocket stream that emitted the event. This field is present
        #   only when WebSocket multiplexing is enabled separately.
        #
        #   @return [String, nil]
        optional :stream_id, String

        # @!method initialize(error:, input:, response_id:, sequence_number:, stream_id: nil, type: :"response.inject.failed")
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Beta::BetaResponseInjectFailedEvent} for more details.
        #
        #   Emitted when injected input could not be committed to a response. The event
        #   returns the uncommitted raw input so the client can retry it in another response
        #   when appropriate.
        #
        #   @param error [OpenAI::Models::Beta::BetaResponseInjectFailedEvent::Error] Information about why the input was not committed.
        #
        #   @param input [Array<OpenAI::Models::Beta::BetaEasyInputMessage, OpenAI::Models::Beta::BetaResponseInputItem::Message, OpenAI::Models::Beta::BetaResponseOutputMessage, OpenAI::Models::Beta::BetaResponseFileSearchToolCall, OpenAI::Models::Beta::BetaResponseComputerToolCall, OpenAI::Models::Beta::BetaResponseInputItem::ComputerCallOutput, OpenAI::Models::Beta::BetaResponseFunctionWebSearch, OpenAI::Models::Beta::BetaResponseFunctionToolCall, OpenAI::Models::Beta::BetaResponseInputItem::FunctionCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::AgentMessage, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCall, OpenAI::Models::Beta::BetaResponseInputItem::MultiAgentCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ToolSearchCall, OpenAI::Models::Beta::BetaResponseToolSearchOutputItemParam, OpenAI::Models::Beta::BetaResponseInputItem::AdditionalTools, OpenAI::Models::Beta::BetaResponseReasoningItem, OpenAI::Models::Beta::BetaResponseCompactionItemParam, OpenAI::Models::Beta::BetaResponseInputItem::ImageGenerationCall, OpenAI::Models::Beta::BetaResponseCodeInterpreterToolCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCall, OpenAI::Models::Beta::BetaResponseInputItem::LocalShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ShellCall, OpenAI::Models::Beta::BetaResponseInputItem::ShellCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCall, OpenAI::Models::Beta::BetaResponseInputItem::ApplyPatchCallOutput, OpenAI::Models::Beta::BetaResponseInputItem::McpListTools, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalRequest, OpenAI::Models::Beta::BetaResponseInputItem::McpApprovalResponse, OpenAI::Models::Beta::BetaResponseInputItem::McpCall, OpenAI::Models::Beta::BetaResponseCustomToolCallOutput, OpenAI::Models::Beta::BetaResponseCustomToolCall, OpenAI::Models::Beta::BetaResponseInputItem::CompactionTrigger, OpenAI::Models::Beta::BetaResponseInputItem::ItemReference, OpenAI::Models::Beta::BetaResponseInputItem::Program, OpenAI::Models::Beta::BetaResponseInputItem::ProgramOutput>] The raw input items that were not committed.
        #
        #   @param response_id [String] The ID of the response that rejected the input.
        #
        #   @param sequence_number [Integer] The sequence number for this event.
        #
        #   @param stream_id [String] The multiplexed WebSocket stream that emitted the event. This field is
        #
        #   @param type [Symbol, :"response.inject.failed"] The event discriminator. Always `response.inject.failed`.

        # @see OpenAI::Models::Beta::BetaResponseInjectFailedEvent#error
        class Error < OpenAI::Internal::Type::BaseModel
          # @!attribute code
          #   A machine-readable error code.
          #
          #   @return [Symbol, OpenAI::Models::Beta::BetaResponseInjectFailedEvent::Error::Code]
          required :code, enum: -> { OpenAI::Beta::BetaResponseInjectFailedEvent::Error::Code }

          # @!attribute message
          #   A human-readable description of the error.
          #
          #   @return [String]
          required :message, String

          # @!method initialize(code:, message:)
          #   Information about why the input was not committed.
          #
          #   @param code [Symbol, OpenAI::Models::Beta::BetaResponseInjectFailedEvent::Error::Code] A machine-readable error code.
          #
          #   @param message [String] A human-readable description of the error.

          # A machine-readable error code.
          #
          # @see OpenAI::Models::Beta::BetaResponseInjectFailedEvent::Error#code
          module Code
            extend OpenAI::Internal::Type::Enum

            RESPONSE_ALREADY_COMPLETED = :response_already_completed
            RESPONSE_NOT_FOUND = :response_not_found

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end
      end
    end

    BetaResponseInjectFailedEvent = Beta::BetaResponseInjectFailedEvent
  end
end
