# frozen_string_literal: true

module OpenAI
  module Models
    module Realtime
      # Give the model access to additional tools via remote Model Context Protocol
      # (MCP) servers.
      # [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp).
      module RealtimeToolsConfigUnion
        extend OpenAI::Internal::Type::Union

        discriminator :type

        variant :function, -> { OpenAI::Realtime::RealtimeToolsConfigUnion::Function }

        # Give the model access to additional tools via remote Model Context Protocol
        # (MCP) servers. [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp).
        variant :mcp, -> { OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp }

        class Function < OpenAI::Internal::Type::BaseModel
          # @!attribute description
          #   The description of the function, including guidance on when and how to call it,
          #   and guidance about what to tell the user when calling (if anything).
          #
          #   @return [String, nil]
          optional :description, String

          # @!attribute name
          #   The name of the function.
          #
          #   @return [String, nil]
          optional :name, String

          # @!attribute parameters
          #   Parameters of the function in JSON Schema.
          #
          #   @return [Object, nil]
          optional :parameters, OpenAI::Internal::Type::Unknown

          # @!attribute type
          #   The type of the tool, i.e. `function`.
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Function::Type, nil]
          optional :type, enum: -> { OpenAI::Realtime::RealtimeToolsConfigUnion::Function::Type }

          # @!method initialize(description: nil, name: nil, parameters: nil, type: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Function} for more details.
          #
          #   @param description [String] The description of the function, including guidance on when and how
          #
          #   @param name [String] The name of the function.
          #
          #   @param parameters [Object] Parameters of the function in JSON Schema.
          #
          #   @param type [Symbol, OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Function::Type] The type of the tool, i.e. `function`.

          # The type of the tool, i.e. `function`.
          #
          # @see OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Function#type
          module Type
            extend OpenAI::Internal::Type::Enum

            FUNCTION = :function

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class Mcp < OpenAI::Internal::Type::BaseModel
          # @!attribute server_label
          #   A label for this MCP server, used to identify it in tool calls.
          #
          #   @return [String]
          required :server_label, String

          # @!attribute type
          #   The type of the MCP tool. Always `mcp`.
          #
          #   @return [Symbol, :mcp]
          required :type, const: :mcp

          # @!attribute allowed_tools
          #   List of allowed tool names or a filter object.
          #
          #   @return [Array<String>, OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::AllowedTools::McpToolFilter, nil]
          optional :allowed_tools,
                   union: -> { OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::AllowedTools },
                   nil?: true

          # @!attribute authorization
          #   An OAuth access token that can be used with a remote MCP server, either with a
          #   custom MCP server URL or a service connector. Your application must handle the
          #   OAuth authorization flow and provide the token here.
          #
          #   @return [String, nil]
          optional :authorization, String

          # @!attribute connector_id
          #   Identifier for service connectors, like those available in ChatGPT. One of
          #   `server_url` or `connector_id` must be provided. Learn more about service
          #   connectors
          #   [here](https://platform.openai.com/docs/guides/tools-remote-mcp#connectors).
          #
          #   Currently supported `connector_id` values are:
          #
          #   - Dropbox: `connector_dropbox`
          #   - Gmail: `connector_gmail`
          #   - Google Calendar: `connector_googlecalendar`
          #   - Google Drive: `connector_googledrive`
          #   - Microsoft Teams: `connector_microsoftteams`
          #   - Outlook Calendar: `connector_outlookcalendar`
          #   - Outlook Email: `connector_outlookemail`
          #   - SharePoint: `connector_sharepoint`
          #
          #   @return [Symbol, OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID, nil]
          optional :connector_id, enum: -> { OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID }

          # @!attribute headers
          #   Optional HTTP headers to send to the MCP server. Use for authentication or other
          #   purposes.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :headers, OpenAI::Internal::Type::HashOf[String], nil?: true

          # @!attribute require_approval
          #   Specify which of the MCP server's tools require approval.
          #
          #   @return [OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter, Symbol, OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalSetting, nil]
          optional :require_approval,
                   union: -> { OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval },
                   nil?: true

          # @!attribute server_description
          #   Optional description of the MCP server, used to provide more context.
          #
          #   @return [String, nil]
          optional :server_description, String

          # @!attribute server_url
          #   The URL for the MCP server. One of `server_url` or `connector_id` must be
          #   provided.
          #
          #   @return [String, nil]
          optional :server_url, String

          # @!method initialize(server_label:, allowed_tools: nil, authorization: nil, connector_id: nil, headers: nil, require_approval: nil, server_description: nil, server_url: nil, type: :mcp)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp} for more details.
          #
          #   Give the model access to additional tools via remote Model Context Protocol
          #   (MCP) servers.
          #   [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp).
          #
          #   @param server_label [String] A label for this MCP server, used to identify it in tool calls.
          #
          #   @param allowed_tools [Array<String>, OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::AllowedTools::McpToolFilter, nil] List of allowed tool names or a filter object.
          #
          #   @param authorization [String] An OAuth access token that can be used with a remote MCP server, either
          #
          #   @param connector_id [Symbol, OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::ConnectorID] Identifier for service connectors, like those available in ChatGPT. One of
          #
          #   @param headers [Hash{Symbol=>String}, nil] Optional HTTP headers to send to the MCP server. Use for authentication
          #
          #   @param require_approval [OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter, Symbol, OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalSetting, nil] Specify which of the MCP server's tools require approval.
          #
          #   @param server_description [String] Optional description of the MCP server, used to provide more context.
          #
          #   @param server_url [String] The URL for the MCP server. One of `server_url` or `connector_id` must be
          #
          #   @param type [Symbol, :mcp] The type of the MCP tool. Always `mcp`.

          # List of allowed tool names or a filter object.
          #
          # @see OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp#allowed_tools
          module AllowedTools
            extend OpenAI::Internal::Type::Union

            # A string array of allowed tool names
            variant -> { OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::AllowedTools::StringArray }

            # A filter object to specify which tools are allowed.
            variant -> { OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::AllowedTools::McpToolFilter }

            class McpToolFilter < OpenAI::Internal::Type::BaseModel
              # @!attribute read_only
              #   Indicates whether or not a tool modifies data or is read-only. If an MCP server
              #   is
              #   [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
              #   it will match this filter.
              #
              #   @return [Boolean, nil]
              optional :read_only, OpenAI::Internal::Type::Boolean

              # @!attribute tool_names
              #   List of allowed tool names.
              #
              #   @return [Array<String>, nil]
              optional :tool_names, OpenAI::Internal::Type::ArrayOf[String]

              # @!method initialize(read_only: nil, tool_names: nil)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::AllowedTools::McpToolFilter}
              #   for more details.
              #
              #   A filter object to specify which tools are allowed.
              #
              #   @param read_only [Boolean] Indicates whether or not a tool modifies data or is read-only. If an
              #
              #   @param tool_names [Array<String>] List of allowed tool names.
            end

            # @!method self.variants
            #   @return [Array(Array<String>, OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::AllowedTools::McpToolFilter)]

            # @type [OpenAI::Internal::Type::Converter]
            StringArray = OpenAI::Internal::Type::ArrayOf[String]
          end

          # Identifier for service connectors, like those available in ChatGPT. One of
          # `server_url` or `connector_id` must be provided. Learn more about service
          # connectors
          # [here](https://platform.openai.com/docs/guides/tools-remote-mcp#connectors).
          #
          # Currently supported `connector_id` values are:
          #
          # - Dropbox: `connector_dropbox`
          # - Gmail: `connector_gmail`
          # - Google Calendar: `connector_googlecalendar`
          # - Google Drive: `connector_googledrive`
          # - Microsoft Teams: `connector_microsoftteams`
          # - Outlook Calendar: `connector_outlookcalendar`
          # - Outlook Email: `connector_outlookemail`
          # - SharePoint: `connector_sharepoint`
          #
          # @see OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp#connector_id
          module ConnectorID
            extend OpenAI::Internal::Type::Enum

            CONNECTOR_DROPBOX = :connector_dropbox
            CONNECTOR_GMAIL = :connector_gmail
            CONNECTOR_GOOGLECALENDAR = :connector_googlecalendar
            CONNECTOR_GOOGLEDRIVE = :connector_googledrive
            CONNECTOR_MICROSOFTTEAMS = :connector_microsoftteams
            CONNECTOR_OUTLOOKCALENDAR = :connector_outlookcalendar
            CONNECTOR_OUTLOOKEMAIL = :connector_outlookemail
            CONNECTOR_SHAREPOINT = :connector_sharepoint

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # Specify which of the MCP server's tools require approval.
          #
          # @see OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp#require_approval
          module RequireApproval
            extend OpenAI::Internal::Type::Union

            # Specify which of the MCP server's tools require approval. Can be
            # `always`, `never`, or a filter object associated with tools
            # that require approval.
            variant -> { OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter }

            # Specify a single approval policy for all tools. One of `always` or
            # `never`. When set to `always`, all tools will require approval. When
            # set to `never`, all tools will not require approval.
            variant enum: -> { OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalSetting }

            class McpToolApprovalFilter < OpenAI::Internal::Type::BaseModel
              # @!attribute always
              #   A filter object to specify which tools are allowed.
              #
              #   @return [OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Always, nil]
              optional :always,
                       -> { OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Always }

              # @!attribute never
              #   A filter object to specify which tools are allowed.
              #
              #   @return [OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Never, nil]
              optional :never,
                       -> { OpenAI::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Never }

              # @!method initialize(always: nil, never: nil)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter}
              #   for more details.
              #
              #   Specify which of the MCP server's tools require approval. Can be `always`,
              #   `never`, or a filter object associated with tools that require approval.
              #
              #   @param always [OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Always] A filter object to specify which tools are allowed.
              #
              #   @param never [OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Never] A filter object to specify which tools are allowed.

              # @see OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter#always
              class Always < OpenAI::Internal::Type::BaseModel
                # @!attribute read_only
                #   Indicates whether or not a tool modifies data or is read-only. If an MCP server
                #   is
                #   [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                #   it will match this filter.
                #
                #   @return [Boolean, nil]
                optional :read_only, OpenAI::Internal::Type::Boolean

                # @!attribute tool_names
                #   List of allowed tool names.
                #
                #   @return [Array<String>, nil]
                optional :tool_names, OpenAI::Internal::Type::ArrayOf[String]

                # @!method initialize(read_only: nil, tool_names: nil)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Always}
                #   for more details.
                #
                #   A filter object to specify which tools are allowed.
                #
                #   @param read_only [Boolean] Indicates whether or not a tool modifies data or is read-only. If an
                #
                #   @param tool_names [Array<String>] List of allowed tool names.
              end

              # @see OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter#never
              class Never < OpenAI::Internal::Type::BaseModel
                # @!attribute read_only
                #   Indicates whether or not a tool modifies data or is read-only. If an MCP server
                #   is
                #   [annotated with `readOnlyHint`](https://modelcontextprotocol.io/specification/2025-06-18/schema#toolannotations-readonlyhint),
                #   it will match this filter.
                #
                #   @return [Boolean, nil]
                optional :read_only, OpenAI::Internal::Type::Boolean

                # @!attribute tool_names
                #   List of allowed tool names.
                #
                #   @return [Array<String>, nil]
                optional :tool_names, OpenAI::Internal::Type::ArrayOf[String]

                # @!method initialize(read_only: nil, tool_names: nil)
                #   Some parameter documentations has been truncated, see
                #   {OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter::Never}
                #   for more details.
                #
                #   A filter object to specify which tools are allowed.
                #
                #   @param read_only [Boolean] Indicates whether or not a tool modifies data or is read-only. If an
                #
                #   @param tool_names [Array<String>] List of allowed tool names.
              end
            end

            # Specify a single approval policy for all tools. One of `always` or `never`. When
            # set to `always`, all tools will require approval. When set to `never`, all tools
            # will not require approval.
            module McpToolApprovalSetting
              extend OpenAI::Internal::Type::Enum

              ALWAYS = :always
              NEVER = :never

              # @!method self.values
              #   @return [Array<Symbol>]
            end

            # @!method self.variants
            #   @return [Array(OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalFilter, Symbol, OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp::RequireApproval::McpToolApprovalSetting)]
          end
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Function, OpenAI::Models::Realtime::RealtimeToolsConfigUnion::Mcp)]
      end
    end
  end
end
