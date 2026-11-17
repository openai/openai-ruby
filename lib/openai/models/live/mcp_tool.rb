# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class McpTool < OpenAI::Internal::Type::BaseModel
        # @!attribute type
        #
        #   @return [Symbol, :mcp]
        required :type, const: :mcp

        # @!attribute allowed_callers
        #   The tool invocation context(s).
        #
        #   @return [Array<Symbol, OpenAI::Models::Live::McpTool::AllowedCaller>, nil]
        optional(
          :allowed_callers,
          -> { OpenAI::Internal::Type::ArrayOf[enum: OpenAI::Live::McpTool::AllowedCaller] },
          nil?: true
        )

        # @!attribute allowed_tools
        #   A list of MCP tool names that are allowed for this server.
        #
        #   @return [Array<String>, OpenAI::Models::Live::McpToolFilter, nil]
        optional :allowed_tools, union: -> { OpenAI::Live::McpTool::AllowedTools }, nil?: true

        # @!attribute connector_id
        #   @deprecated
        #
        #   The ID of a built-in MCP connector. This field is deprecated for models released
        #   after September 1, 2026. Use `server_url` to connect to a remote MCP server, or
        #   `tunnel_id` to connect to a local MCP server.
        #
        #   @return [String, nil]
        optional :connector_id, String, nil?: true

        # @!attribute defer_loading
        #   Whether this MCP tool should be deferred and discovered via tool search.
        #
        #   @return [Boolean, nil]
        optional :defer_loading, OpenAI::Internal::Type::Boolean, nil?: true

        # @!attribute require_approval
        #   Controls which MCP tools require explicit user approval before execution.
        #
        #   @return [OpenAI::Models::Live::McpRequireApprovalFilter, Symbol, OpenAI::Models::Live::McpTool::RequireApproval::LiveMCPRequireApprovalAPIEnum, nil]
        optional :require_approval, union: -> { OpenAI::Live::McpTool::RequireApproval }, nil?: true

        # @!attribute server_description
        #   An optional human-readable description of the MCP server.
        #
        #   @return [String, nil]
        optional :server_description, String, nil?: true

        # @!attribute server_label
        #   A label used to identify the MCP server.
        #
        #   @return [String, nil]
        optional :server_label, String

        # @!attribute server_url
        #   The URL of the MCP server to connect to.
        #
        #   @return [String, nil]
        optional :server_url, String, nil?: true

        # @!attribute tunnel_id
        #   The Secure MCP Tunnel ID to use instead of a direct server URL.
        #
        #   @return [String, nil]
        optional :tunnel_id, String, nil?: true

        request_only do
          # @!attribute authorization
          #   This value is omitted from returned Live session data.
          #
          #   @return [String, nil]
          optional :authorization, String, nil?: true

          # @!attribute headers
          #   Optional HTTP headers to send when connecting to the MCP server.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :headers, OpenAI::Internal::Type::HashOf[String], nil?: true
        end

        # @!method initialize(allowed_callers: nil, allowed_tools: nil, authorization: nil, connector_id: nil, defer_loading: nil, headers: nil, require_approval: nil, server_description: nil, server_label: nil, server_url: nil, tunnel_id: nil, type: :mcp)
        #   @param allowed_callers [Array<Symbol, OpenAI::Models::Live::McpTool::AllowedCaller>, nil]
        #     The tool invocation context(s).
        #
        #   @param allowed_tools [Array<String>, OpenAI::Models::Live::McpToolFilter, nil]
        #     A list of MCP tool names that are allowed for this server.
        #
        #   @param authorization [String, nil]
        #     This value is omitted from returned Live session data.
        #
        #   @param connector_id [String, nil]
        #     The ID of a built-in MCP connector. This field is deprecated for models released
        #     after September 1, 2026. Use `server_url` to connect to a remote MCP server, or
        #     `tunnel_id` to connect to a local MCP server.
        #
        #   @param defer_loading [Boolean, nil]
        #     Whether this MCP tool should be deferred and discovered via tool search.
        #
        #   @param headers [Hash{Symbol=>String}, nil]
        #     Optional HTTP headers to send when connecting to the MCP server.
        #
        #   @param require_approval [OpenAI::Models::Live::McpRequireApprovalFilter, Symbol, OpenAI::Models::Live::McpTool::RequireApproval::LiveMCPRequireApprovalAPIEnum, nil]
        #     Controls which MCP tools require explicit user approval before execution.
        #
        #   @param server_description [String, nil]
        #     An optional human-readable description of the MCP server.
        #
        #   @param server_label [String]
        #     A label used to identify the MCP server.
        #
        #   @param server_url [String, nil]
        #     The URL of the MCP server to connect to.
        #
        #   @param tunnel_id [String, nil]
        #     The Secure MCP Tunnel ID to use instead of a direct server URL.
        #
        #   @param type [Symbol, :mcp]

        module AllowedCaller
          extend OpenAI::Internal::Type::Enum

          DIRECT = :direct
          PROGRAMMATIC = :programmatic

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # A list of MCP tool names that are allowed for this server.
        #
        # @see OpenAI::Models::Live::McpTool#allowed_tools
        module AllowedTools
          extend OpenAI::Internal::Type::Union

          variant -> { OpenAI::Models::Live::McpTool::AllowedTools::StringArray }

          variant -> { OpenAI::Live::McpToolFilter }

          # @!method self.variants
          #   @return [Array(Array<String>, OpenAI::Models::Live::McpToolFilter)]

          # @type [OpenAI::Internal::Type::Converter]
          StringArray = OpenAI::Internal::Type::ArrayOf[String]
        end

        # Controls which MCP tools require explicit user approval before execution.
        #
        # @see OpenAI::Models::Live::McpTool#require_approval
        module RequireApproval
          extend OpenAI::Internal::Type::Union

          variant -> { OpenAI::Live::McpRequireApprovalFilter }

          # Default approval behavior for MCP tool calls.
          variant enum: -> { OpenAI::Live::McpTool::RequireApproval::LiveMCPRequireApprovalAPIEnum }

          # Default approval behavior for MCP tool calls.
          module LiveMCPRequireApprovalAPIEnum
            extend OpenAI::Internal::Type::Enum

            ALWAYS = :always
            NEVER = :never

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @!method self.variants
          #   @return [Array(OpenAI::Models::Live::McpRequireApprovalFilter, Symbol, OpenAI::Models::Live::McpTool::RequireApproval::LiveMCPRequireApprovalAPIEnum)]
        end
      end
    end
  end
end
