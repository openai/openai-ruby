# frozen_string_literal: true

module OpenAI
  module Models
    module Responses
      # A tool that can be used to generate a response.
      module Tool
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # Defines a function in your own code the model can choose to call. Learn more about [function calling](https://platform.openai.com/docs/guides/function-calling).
        variant :function, -> { OpenAI::Responses::FunctionTool }

        variant -> { OpenAI::StructuredOutput::JsonSchemaConverter }

        # A tool that searches for relevant content from uploaded files. Learn more about the [file search tool](https://platform.openai.com/docs/guides/tools-file-search).
        variant :file_search, -> { OpenAI::Responses::FileSearchTool }

        # A tool that controls a virtual computer. Learn more about the [computer tool](https://platform.openai.com/docs/guides/tools-computer-use).
        variant :computer_use_preview, -> { OpenAI::Responses::ComputerTool }

        # Give the model access to additional tools via remote Model Context Protocol
        # (MCP) servers. [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp).
        variant :mcp, -> { OpenAI::Responses::Tool::Mcp }

        # A tool that runs Python code to help generate a response to a prompt.
        variant :code_interpreter, -> { OpenAI::Responses::Tool::CodeInterpreter }

        # A tool that generates images using a model like `gpt-image-1`.
        variant :image_generation, -> { OpenAI::Responses::Tool::ImageGeneration }

        # A tool that allows the model to execute shell commands in a local environment.
        variant :local_shell, -> { OpenAI::Responses::Tool::LocalShell }

        # A custom tool that processes input using a specified format. Learn more about
        # [custom tools](https://platform.openai.com/docs/guides/function-calling#custom-tools).
        variant :custom, -> { OpenAI::Responses::CustomTool }

        # Search the Internet for sources related to the prompt. Learn more about the
        # [web search tool](https://platform.openai.com/docs/guides/tools-web-search).
        variant -> { OpenAI::Responses::Tool::WebSearchTool }

        # This tool searches the web for relevant results to use in a response. Learn more about the [web search tool](https://platform.openai.com/docs/guides/tools-web-search).
        variant -> { OpenAI::Responses::WebSearchTool }

        class WebSearchTool < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of the web search tool. One of `web_search` or `web_search_2025_08_26`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::Tool::WebSearchTool::Type]
          required :type, enum: -> { OpenAI::Responses::Tool::WebSearchTool::Type }

          # @!attribute filters
          #   Filters for the search.
          #
          #   @return [OpenAI::Models::Responses::Tool::WebSearchTool::Filters, nil]
          optional :filters, -> { OpenAI::Responses::Tool::WebSearchTool::Filters }, nil?: true

          # @!attribute search_context_size
          #   High level guidance for the amount of context window space to use for the
          #   search. One of `low`, `medium`, or `high`. `medium` is the default.
          #
          #   @return [Symbol, OpenAI::Models::Responses::Tool::WebSearchTool::SearchContextSize, nil]
          optional :search_context_size, enum: -> { OpenAI::Responses::Tool::WebSearchTool::SearchContextSize }

          # @!attribute user_location
          #   The approximate location of the user.
          #
          #   @return [OpenAI::Models::Responses::Tool::WebSearchTool::UserLocation, nil]
          optional :user_location, -> { OpenAI::Responses::Tool::WebSearchTool::UserLocation }, nil?: true

          # @!method initialize(type:, filters: nil, search_context_size: nil, user_location: nil)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::Tool::WebSearchTool} for more details.
          #
          #   Search the Internet for sources related to the prompt. Learn more about the
          #   [web search tool](https://platform.openai.com/docs/guides/tools-web-search).
          #
          #   @param type [Symbol, OpenAI::Models::Responses::Tool::WebSearchTool::Type] The type of the web search tool. One of `web_search` or `web_search_2025_08_26`.
          #
          #   @param filters [OpenAI::Models::Responses::Tool::WebSearchTool::Filters, nil] Filters for the search.
          #
          #   @param search_context_size [Symbol, OpenAI::Models::Responses::Tool::WebSearchTool::SearchContextSize] High level guidance for the amount of context window space to use for the search
          #
          #   @param user_location [OpenAI::Models::Responses::Tool::WebSearchTool::UserLocation, nil] The approximate location of the user.

          # The type of the web search tool. One of `web_search` or `web_search_2025_08_26`.
          #
          # @see OpenAI::Models::Responses::Tool::WebSearchTool#type
          module Type
            extend OpenAI::Internal::Type::Enum

            WEB_SEARCH = :web_search
            WEB_SEARCH_2025_08_26 = :web_search_2025_08_26

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @see OpenAI::Models::Responses::Tool::WebSearchTool#filters
          class Filters < OpenAI::Internal::Type::BaseModel
            # @!attribute allowed_domains
            #   Allowed domains for the search. If not provided, all domains are allowed.
            #   Subdomains of the provided domains are allowed as well.
            #
            #   Example: `["pubmed.ncbi.nlm.nih.gov"]`
            #
            #   @return [Array<String>, nil]
            optional :allowed_domains, OpenAI::Internal::Type::ArrayOf[String], nil?: true

            # @!method initialize(allowed_domains: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Responses::Tool::WebSearchTool::Filters} for more details.
            #
            #   Filters for the search.
            #
            #   @param allowed_domains [Array<String>, nil] Allowed domains for the search. If not provided, all domains are allowed.
          end

          # High level guidance for the amount of context window space to use for the
          # search. One of `low`, `medium`, or `high`. `medium` is the default.
          #
          # @see OpenAI::Models::Responses::Tool::WebSearchTool#search_context_size
          module SearchContextSize
            extend OpenAI::Internal::Type::Enum

            LOW = :low
            MEDIUM = :medium
            HIGH = :high

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @see OpenAI::Models::Responses::Tool::WebSearchTool#user_location
          class UserLocation < OpenAI::Internal::Type::BaseModel
            # @!attribute city
            #   Free text input for the city of the user, e.g. `San Francisco`.
            #
            #   @return [String, nil]
            optional :city, String, nil?: true

            # @!attribute country
            #   The two-letter [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of
            #   the user, e.g. `US`.
            #
            #   @return [String, nil]
            optional :country, String, nil?: true

            # @!attribute region
            #   Free text input for the region of the user, e.g. `California`.
            #
            #   @return [String, nil]
            optional :region, String, nil?: true

            # @!attribute timezone
            #   The [IANA timezone](https://timeapi.io/documentation/iana-timezones) of the
            #   user, e.g. `America/Los_Angeles`.
            #
            #   @return [String, nil]
            optional :timezone, String, nil?: true

            # @!attribute type
            #   The type of location approximation. Always `approximate`.
            #
            #   @return [Symbol, OpenAI::Models::Responses::Tool::WebSearchTool::UserLocation::Type, nil]
            optional :type, enum: -> { OpenAI::Responses::Tool::WebSearchTool::UserLocation::Type }

            # @!method initialize(city: nil, country: nil, region: nil, timezone: nil, type: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Responses::Tool::WebSearchTool::UserLocation} for more details.
            #
            #   The approximate location of the user.
            #
            #   @param city [String, nil] Free text input for the city of the user, e.g. `San Francisco`.
            #
            #   @param country [String, nil] The two-letter [ISO country code](https://en.wikipedia.org/wiki/ISO_3166-1) of t
            #
            #   @param region [String, nil] Free text input for the region of the user, e.g. `California`.
            #
            #   @param timezone [String, nil] The [IANA timezone](https://timeapi.io/documentation/iana-timezones) of the user
            #
            #   @param type [Symbol, OpenAI::Models::Responses::Tool::WebSearchTool::UserLocation::Type] The type of location approximation. Always `approximate`.

            # The type of location approximation. Always `approximate`.
            #
            # @see OpenAI::Models::Responses::Tool::WebSearchTool::UserLocation#type
            module Type
              extend OpenAI::Internal::Type::Enum

              APPROXIMATE = :approximate

              # @!method self.values
              #   @return [Array<Symbol>]
            end
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
          #   @return [Array<String>, OpenAI::Models::Responses::Tool::Mcp::AllowedTools::McpToolFilter, nil]
          optional :allowed_tools, union: -> { OpenAI::Responses::Tool::Mcp::AllowedTools }, nil?: true

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
          #   @return [Symbol, OpenAI::Models::Responses::Tool::Mcp::ConnectorID, nil]
          optional :connector_id, enum: -> { OpenAI::Responses::Tool::Mcp::ConnectorID }

          # @!attribute headers
          #   Optional HTTP headers to send to the MCP server. Use for authentication or other
          #   purposes.
          #
          #   @return [Hash{Symbol=>String}, nil]
          optional :headers, OpenAI::Internal::Type::HashOf[String], nil?: true

          # @!attribute require_approval
          #   Specify which of the MCP server's tools require approval.
          #
          #   @return [OpenAI::Models::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter, Symbol, OpenAI::Models::Responses::Tool::Mcp::RequireApproval::McpToolApprovalSetting, nil]
          optional :require_approval, union: -> { OpenAI::Responses::Tool::Mcp::RequireApproval }, nil?: true

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
          #   {OpenAI::Models::Responses::Tool::Mcp} for more details.
          #
          #   Give the model access to additional tools via remote Model Context Protocol
          #   (MCP) servers.
          #   [Learn more about MCP](https://platform.openai.com/docs/guides/tools-remote-mcp).
          #
          #   @param server_label [String] A label for this MCP server, used to identify it in tool calls.
          #
          #   @param allowed_tools [Array<String>, OpenAI::Models::Responses::Tool::Mcp::AllowedTools::McpToolFilter, nil] List of allowed tool names or a filter object.
          #
          #   @param authorization [String] An OAuth access token that can be used with a remote MCP server, either
          #
          #   @param connector_id [Symbol, OpenAI::Models::Responses::Tool::Mcp::ConnectorID] Identifier for service connectors, like those available in ChatGPT. One of
          #
          #   @param headers [Hash{Symbol=>String}, nil] Optional HTTP headers to send to the MCP server. Use for authentication
          #
          #   @param require_approval [OpenAI::Models::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter, Symbol, OpenAI::Models::Responses::Tool::Mcp::RequireApproval::McpToolApprovalSetting, nil] Specify which of the MCP server's tools require approval.
          #
          #   @param server_description [String] Optional description of the MCP server, used to provide more context.
          #
          #   @param server_url [String] The URL for the MCP server. One of `server_url` or `connector_id` must be
          #
          #   @param type [Symbol, :mcp] The type of the MCP tool. Always `mcp`.

          # List of allowed tool names or a filter object.
          #
          # @see OpenAI::Models::Responses::Tool::Mcp#allowed_tools
          module AllowedTools
            extend OpenAI::Internal::Type::Union

            # A string array of allowed tool names
            variant -> { OpenAI::Models::Responses::Tool::Mcp::AllowedTools::StringArray }

            # A filter object to specify which tools are allowed.
            variant -> { OpenAI::Responses::Tool::Mcp::AllowedTools::McpToolFilter }

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
              #   {OpenAI::Models::Responses::Tool::Mcp::AllowedTools::McpToolFilter} for more
              #   details.
              #
              #   A filter object to specify which tools are allowed.
              #
              #   @param read_only [Boolean] Indicates whether or not a tool modifies data or is read-only. If an
              #
              #   @param tool_names [Array<String>] List of allowed tool names.
            end

            # @!method self.variants
            #   @return [Array(Array<String>, OpenAI::Models::Responses::Tool::Mcp::AllowedTools::McpToolFilter)]

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
          # @see OpenAI::Models::Responses::Tool::Mcp#connector_id
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
          # @see OpenAI::Models::Responses::Tool::Mcp#require_approval
          module RequireApproval
            extend OpenAI::Internal::Type::Union

            # Specify which of the MCP server's tools require approval. Can be
            # `always`, `never`, or a filter object associated with tools
            # that require approval.
            variant -> { OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter }

            # Specify a single approval policy for all tools. One of `always` or
            # `never`. When set to `always`, all tools will require approval. When
            # set to `never`, all tools will not require approval.
            variant enum: -> { OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalSetting }

            class McpToolApprovalFilter < OpenAI::Internal::Type::BaseModel
              # @!attribute always
              #   A filter object to specify which tools are allowed.
              #
              #   @return [OpenAI::Models::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Always, nil]
              optional :always, -> { OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Always }

              # @!attribute never
              #   A filter object to specify which tools are allowed.
              #
              #   @return [OpenAI::Models::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Never, nil]
              optional :never, -> { OpenAI::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Never }

              # @!method initialize(always: nil, never: nil)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter}
              #   for more details.
              #
              #   Specify which of the MCP server's tools require approval. Can be `always`,
              #   `never`, or a filter object associated with tools that require approval.
              #
              #   @param always [OpenAI::Models::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Always] A filter object to specify which tools are allowed.
              #
              #   @param never [OpenAI::Models::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Never] A filter object to specify which tools are allowed.

              # @see OpenAI::Models::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter#always
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
                #   {OpenAI::Models::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Always}
                #   for more details.
                #
                #   A filter object to specify which tools are allowed.
                #
                #   @param read_only [Boolean] Indicates whether or not a tool modifies data or is read-only. If an
                #
                #   @param tool_names [Array<String>] List of allowed tool names.
              end

              # @see OpenAI::Models::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter#never
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
                #   {OpenAI::Models::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter::Never}
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
            #   @return [Array(OpenAI::Models::Responses::Tool::Mcp::RequireApproval::McpToolApprovalFilter, Symbol, OpenAI::Models::Responses::Tool::Mcp::RequireApproval::McpToolApprovalSetting)]
          end
        end

        class CodeInterpreter < OpenAI::Internal::Type::BaseModel
          # @!attribute container
          #   The code interpreter container. Can be a container ID or an object that
          #   specifies uploaded file IDs to make available to your code.
          #
          #   @return [String, OpenAI::Models::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto]
          required :container, union: -> { OpenAI::Responses::Tool::CodeInterpreter::Container }

          # @!attribute type
          #   The type of the code interpreter tool. Always `code_interpreter`.
          #
          #   @return [Symbol, :code_interpreter]
          required :type, const: :code_interpreter

          # @!method initialize(container:, type: :code_interpreter)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::Tool::CodeInterpreter} for more details.
          #
          #   A tool that runs Python code to help generate a response to a prompt.
          #
          #   @param container [String, OpenAI::Models::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto] The code interpreter container. Can be a container ID or an object that
          #
          #   @param type [Symbol, :code_interpreter] The type of the code interpreter tool. Always `code_interpreter`.

          # The code interpreter container. Can be a container ID or an object that
          # specifies uploaded file IDs to make available to your code.
          #
          # @see OpenAI::Models::Responses::Tool::CodeInterpreter#container
          module Container
            extend OpenAI::Internal::Type::Union

            # The container ID.
            variant String

            # Configuration for a code interpreter container. Optionally specify the IDs
            # of the files to run the code on.
            variant -> { OpenAI::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto }

            class CodeInterpreterToolAuto < OpenAI::Internal::Type::BaseModel
              # @!attribute type
              #   Always `auto`.
              #
              #   @return [Symbol, :auto]
              required :type, const: :auto

              # @!attribute file_ids
              #   An optional list of uploaded files to make available to your code.
              #
              #   @return [Array<String>, nil]
              optional :file_ids, OpenAI::Internal::Type::ArrayOf[String]

              # @!method initialize(file_ids: nil, type: :auto)
              #   Some parameter documentations has been truncated, see
              #   {OpenAI::Models::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto}
              #   for more details.
              #
              #   Configuration for a code interpreter container. Optionally specify the IDs of
              #   the files to run the code on.
              #
              #   @param file_ids [Array<String>] An optional list of uploaded files to make available to your code.
              #
              #   @param type [Symbol, :auto] Always `auto`.
            end

            # @!method self.variants
            #   @return [Array(String, OpenAI::Models::Responses::Tool::CodeInterpreter::Container::CodeInterpreterToolAuto)]
          end
        end

        class ImageGeneration < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of the image generation tool. Always `image_generation`.
          #
          #   @return [Symbol, :image_generation]
          required :type, const: :image_generation

          # @!attribute background
          #   Background type for the generated image. One of `transparent`, `opaque`, or
          #   `auto`. Default: `auto`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::Tool::ImageGeneration::Background, nil]
          optional :background, enum: -> { OpenAI::Responses::Tool::ImageGeneration::Background }

          # @!attribute input_fidelity
          #   Control how much effort the model will exert to match the style and features,
          #   especially facial features, of input images. This parameter is only supported
          #   for `gpt-image-1`. Supports `high` and `low`. Defaults to `low`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::Tool::ImageGeneration::InputFidelity, nil]
          optional :input_fidelity,
                   enum: -> {
                     OpenAI::Responses::Tool::ImageGeneration::InputFidelity
                   },
                   nil?: true

          # @!attribute input_image_mask
          #   Optional mask for inpainting. Contains `image_url` (string, optional) and
          #   `file_id` (string, optional).
          #
          #   @return [OpenAI::Models::Responses::Tool::ImageGeneration::InputImageMask, nil]
          optional :input_image_mask, -> { OpenAI::Responses::Tool::ImageGeneration::InputImageMask }

          # @!attribute model
          #   The image generation model to use. Default: `gpt-image-1`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::Tool::ImageGeneration::Model, nil]
          optional :model, enum: -> { OpenAI::Responses::Tool::ImageGeneration::Model }

          # @!attribute moderation
          #   Moderation level for the generated image. Default: `auto`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::Tool::ImageGeneration::Moderation, nil]
          optional :moderation, enum: -> { OpenAI::Responses::Tool::ImageGeneration::Moderation }

          # @!attribute output_compression
          #   Compression level for the output image. Default: 100.
          #
          #   @return [Integer, nil]
          optional :output_compression, Integer

          # @!attribute output_format
          #   The output format of the generated image. One of `png`, `webp`, or `jpeg`.
          #   Default: `png`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::Tool::ImageGeneration::OutputFormat, nil]
          optional :output_format, enum: -> { OpenAI::Responses::Tool::ImageGeneration::OutputFormat }

          # @!attribute partial_images
          #   Number of partial images to generate in streaming mode, from 0 (default value)
          #   to 3.
          #
          #   @return [Integer, nil]
          optional :partial_images, Integer

          # @!attribute quality
          #   The quality of the generated image. One of `low`, `medium`, `high`, or `auto`.
          #   Default: `auto`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::Tool::ImageGeneration::Quality, nil]
          optional :quality, enum: -> { OpenAI::Responses::Tool::ImageGeneration::Quality }

          # @!attribute size
          #   The size of the generated image. One of `1024x1024`, `1024x1536`, `1536x1024`,
          #   or `auto`. Default: `auto`.
          #
          #   @return [Symbol, OpenAI::Models::Responses::Tool::ImageGeneration::Size, nil]
          optional :size, enum: -> { OpenAI::Responses::Tool::ImageGeneration::Size }

          # @!method initialize(background: nil, input_fidelity: nil, input_image_mask: nil, model: nil, moderation: nil, output_compression: nil, output_format: nil, partial_images: nil, quality: nil, size: nil, type: :image_generation)
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Responses::Tool::ImageGeneration} for more details.
          #
          #   A tool that generates images using a model like `gpt-image-1`.
          #
          #   @param background [Symbol, OpenAI::Models::Responses::Tool::ImageGeneration::Background] Background type for the generated image. One of `transparent`,
          #
          #   @param input_fidelity [Symbol, OpenAI::Models::Responses::Tool::ImageGeneration::InputFidelity, nil] Control how much effort the model will exert to match the style and features,
          #
          #   @param input_image_mask [OpenAI::Models::Responses::Tool::ImageGeneration::InputImageMask] Optional mask for inpainting. Contains `image_url`
          #
          #   @param model [Symbol, OpenAI::Models::Responses::Tool::ImageGeneration::Model] The image generation model to use. Default: `gpt-image-1`.
          #
          #   @param moderation [Symbol, OpenAI::Models::Responses::Tool::ImageGeneration::Moderation] Moderation level for the generated image. Default: `auto`.
          #
          #   @param output_compression [Integer] Compression level for the output image. Default: 100.
          #
          #   @param output_format [Symbol, OpenAI::Models::Responses::Tool::ImageGeneration::OutputFormat] The output format of the generated image. One of `png`, `webp`, or
          #
          #   @param partial_images [Integer] Number of partial images to generate in streaming mode, from 0 (default value) t
          #
          #   @param quality [Symbol, OpenAI::Models::Responses::Tool::ImageGeneration::Quality] The quality of the generated image. One of `low`, `medium`, `high`,
          #
          #   @param size [Symbol, OpenAI::Models::Responses::Tool::ImageGeneration::Size] The size of the generated image. One of `1024x1024`, `1024x1536`,
          #
          #   @param type [Symbol, :image_generation] The type of the image generation tool. Always `image_generation`.

          # Background type for the generated image. One of `transparent`, `opaque`, or
          # `auto`. Default: `auto`.
          #
          # @see OpenAI::Models::Responses::Tool::ImageGeneration#background
          module Background
            extend OpenAI::Internal::Type::Enum

            TRANSPARENT = :transparent
            OPAQUE = :opaque
            AUTO = :auto

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # Control how much effort the model will exert to match the style and features,
          # especially facial features, of input images. This parameter is only supported
          # for `gpt-image-1`. Supports `high` and `low`. Defaults to `low`.
          #
          # @see OpenAI::Models::Responses::Tool::ImageGeneration#input_fidelity
          module InputFidelity
            extend OpenAI::Internal::Type::Enum

            HIGH = :high
            LOW = :low

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @see OpenAI::Models::Responses::Tool::ImageGeneration#input_image_mask
          class InputImageMask < OpenAI::Internal::Type::BaseModel
            # @!attribute file_id
            #   File ID for the mask image.
            #
            #   @return [String, nil]
            optional :file_id, String

            # @!attribute image_url
            #   Base64-encoded mask image.
            #
            #   @return [String, nil]
            optional :image_url, String

            # @!method initialize(file_id: nil, image_url: nil)
            #   Some parameter documentations has been truncated, see
            #   {OpenAI::Models::Responses::Tool::ImageGeneration::InputImageMask} for more
            #   details.
            #
            #   Optional mask for inpainting. Contains `image_url` (string, optional) and
            #   `file_id` (string, optional).
            #
            #   @param file_id [String] File ID for the mask image.
            #
            #   @param image_url [String] Base64-encoded mask image.
          end

          # The image generation model to use. Default: `gpt-image-1`.
          #
          # @see OpenAI::Models::Responses::Tool::ImageGeneration#model
          module Model
            extend OpenAI::Internal::Type::Enum

            GPT_IMAGE_1 = :"gpt-image-1"

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # Moderation level for the generated image. Default: `auto`.
          #
          # @see OpenAI::Models::Responses::Tool::ImageGeneration#moderation
          module Moderation
            extend OpenAI::Internal::Type::Enum

            AUTO = :auto
            LOW = :low

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The output format of the generated image. One of `png`, `webp`, or `jpeg`.
          # Default: `png`.
          #
          # @see OpenAI::Models::Responses::Tool::ImageGeneration#output_format
          module OutputFormat
            extend OpenAI::Internal::Type::Enum

            PNG = :png
            WEBP = :webp
            JPEG = :jpeg

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The quality of the generated image. One of `low`, `medium`, `high`, or `auto`.
          # Default: `auto`.
          #
          # @see OpenAI::Models::Responses::Tool::ImageGeneration#quality
          module Quality
            extend OpenAI::Internal::Type::Enum

            LOW = :low
            MEDIUM = :medium
            HIGH = :high
            AUTO = :auto

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # The size of the generated image. One of `1024x1024`, `1024x1536`, `1536x1024`,
          # or `auto`. Default: `auto`.
          #
          # @see OpenAI::Models::Responses::Tool::ImageGeneration#size
          module Size
            extend OpenAI::Internal::Type::Enum

            SIZE_1024X1024 = :"1024x1024"
            SIZE_1024X1536 = :"1024x1536"
            SIZE_1536X1024 = :"1536x1024"
            AUTO = :auto

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class LocalShell < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of the local shell tool. Always `local_shell`.
          #
          #   @return [Symbol, :local_shell]
          required :type, const: :local_shell

          # @!method initialize(type: :local_shell)
          #   A tool that allows the model to execute shell commands in a local environment.
          #
          #   @param type [Symbol, :local_shell] The type of the local shell tool. Always `local_shell`.
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Responses::FunctionTool, OpenAI::Models::Responses::FileSearchTool, OpenAI::Models::Responses::ComputerTool, OpenAI::Models::Responses::Tool::Mcp, OpenAI::Models::Responses::Tool::CodeInterpreter, OpenAI::Models::Responses::Tool::ImageGeneration, OpenAI::Models::Responses::Tool::LocalShell, OpenAI::Models::Responses::CustomTool, OpenAI::Models::Responses::Tool::WebSearchTool, OpenAI::Models::Responses::WebSearchTool)]
      end
    end
  end
end
