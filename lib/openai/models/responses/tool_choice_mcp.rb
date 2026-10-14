# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      class ToolChoiceMcp < OpenAI::Internal::Type::BaseModel
        # @!attribute server_label
        #   The label of the MCP server to use.
        #
        #   @return [String]
        required :server_label, String

        # @!attribute type
        #   For MCP tools, the type is always `mcp`.
        #
        #   @return [Symbol, :mcp]
        required :type, const: :mcp

        # @!attribute name
        #   The name of the tool to call on the server.
        #
        #   @return [String, nil]
        optional :name, String, nil?: true

        # @!method initialize(server_label:, name: nil, type: :mcp)
        #   Some parameter documentations has been truncated, see
        #   {OpenAI::Models::Responses::ToolChoiceMcp} for more details.
        #
        #   Use this option to force the model to call a specific tool on a remote MCP
        #   server.
        #
        #   @param server_label [String] The label of the MCP server to use.
        #
        #   @param name [String, nil] The name of the tool to call on the server.
        #
        #   @param type [Symbol, :mcp] For MCP tools, the type is always `mcp`.
      end
    end
  end
end
