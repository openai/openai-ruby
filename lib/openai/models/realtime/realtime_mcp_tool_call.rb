# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      class RealtimeMcpToolCall < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The unique ID of the tool call.
        #
        #   @return [String]
        required :id, String

        # @!attribute arguments
        #   A JSON string of the arguments passed to the tool.
        #
        #   @return [String]
        required :arguments, String

        # @!attribute name
        #   The name of the tool that was run.
        #
        #   @return [String]
        required :name, String

        # @!attribute server_label
        #   The label of the MCP server running the tool.
        #
        #   @return [String]
        required :server_label, String

        # @!attribute type
        #   The type of the item. Always `mcp_tool_call`.
        #
        #   @return [Symbol, :mcp_tool_call]
        required :type, const: :mcp_tool_call

        # @!attribute approval_request_id
        #   The ID of an associated approval request, if any.
        #
        #   @return [String, nil]
        optional :approval_request_id, String, nil?: true

        # @!attribute error
        #   The error from the tool call, if any.
        #
        #   @return [OpenAI::Models::Realtime::RealtimeMcpProtocolError, OpenAI::Models::Realtime::RealtimeMcpToolExecutionError, OpenAI::Models::Realtime::RealtimeMcphttpError, nil]
        optional :error, union: -> { OpenAI::Realtime::RealtimeMcpToolCall::Error }, nil?: true

        # @!attribute output
        #   The output from the tool call.
        #
        #   @return [String, nil]
        optional :output, String, nil?: true

        # @!method initialize(id:, arguments:, name:, server_label:, approval_request_id: nil, error: nil, output: nil, type: :mcp_tool_call)
        #   A Realtime item representing an invocation of a tool on an MCP server.
        #
        #   @param id [String] The unique ID of the tool call.
        #
        #   @param arguments [String] A JSON string of the arguments passed to the tool.
        #
        #   @param name [String] The name of the tool that was run.
        #
        #   @param server_label [String] The label of the MCP server running the tool.
        #
        #   @param approval_request_id [String, nil] The ID of an associated approval request, if any.
        #
        #   @param error [OpenAI::Models::Realtime::RealtimeMcpProtocolError, OpenAI::Models::Realtime::RealtimeMcpToolExecutionError, OpenAI::Models::Realtime::RealtimeMcphttpError, nil] The error from the tool call, if any.
        #
        #   @param output [String, nil] The output from the tool call.
        #
        #   @param type [Symbol, :mcp_tool_call] The type of the item. Always `mcp_tool_call`.

        # The error from the tool call, if any.
        #
        # @see OpenAI::Models::Realtime::RealtimeMcpToolCall#error
        module Error
          extend OpenAI::Internal::Type::Union

          discriminator :type

          variant :protocol_error, -> { OpenAI::Realtime::RealtimeMcpProtocolError }

          variant :tool_execution_error, -> { OpenAI::Realtime::RealtimeMcpToolExecutionError }

          variant :http_error, -> { OpenAI::Realtime::RealtimeMcphttpError }

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Realtime::RealtimeMcpProtocolError, OpenAI::Models::Realtime::RealtimeMcpToolExecutionError, OpenAI::Models::Realtime::RealtimeMcphttpError)]
        end
      end
    end
  end
end
