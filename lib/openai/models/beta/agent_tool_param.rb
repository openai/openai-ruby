# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # A tool available to the agent.
      module AgentToolParam
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A function defined by the application.
        variant :function, -> { OpenAI::Beta::AgentToolParam::Function }

        # Discovers deferred function tools and loads them into the model context.
        variant :tool_search, -> { OpenAI::Beta::AgentToolParam::ToolSearch }

        # Enables calling tools from model-generated code.
        variant :programmatic_tool_calling, -> { OpenAI::Beta::AgentToolParam::ProgrammaticToolCalling }

        # Tools provided by a remote MCP server.
        variant :mcp, -> { OpenAI::Beta::AgentToolParam::Mcp }

        # Web search.
        variant :web_search, -> { OpenAI::Beta::AgentToolParam::WebSearch }

        class Function < OpenAI::Internal::Type::BaseModel
          # @!attribute description
          #   A description of what the function does.
          #
          #   @return [String]
          required :description, String

          # @!attribute name
          #   The name of the function.
          #
          #   @return [String]
          required :name, String

          # @!attribute parameters
          #   A JSON Schema object describing the function's arguments.
          #
          #   @return [Hash{Symbol=>Object}]
          required :parameters, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

          # @!attribute type
          #   The type of the object. Always `function`.
          #
          #   @return [Symbol, :function]
          required :type, const: :function

          # @!attribute defer_loading
          #   Whether this function is deferred and discovered through tool search. Defaults
          #   to `false`.
          #
          #   @return [Boolean, nil]
          optional :defer_loading, OpenAI::Internal::Type::Boolean

          # @!method initialize(description:, name:, parameters:, defer_loading: nil, type: :function)
          #   A function defined by the application.
          #
          #   @param description [String]
          #     A description of what the function does.
          #
          #   @param name [String]
          #     The name of the function.
          #
          #   @param parameters [Hash{Symbol=>Object}]
          #     A JSON Schema object describing the function's arguments.
          #
          #   @param defer_loading [Boolean]
          #     Whether this function is deferred and discovered through tool search. Defaults
          #     to `false`.
          #
          #   @param type [Symbol, :function]
          #     The type of the object. Always `function`.
        end

        class ToolSearch < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of the object. Always `tool_search`.
          #
          #   @return [Symbol, :tool_search]
          required :type, const: :tool_search

          # @!method initialize(type: :tool_search)
          #   Discovers deferred function tools and loads them into the model context.
          #
          #   @param type [Symbol, :tool_search]
          #     The type of the object. Always `tool_search`.
        end

        class ProgrammaticToolCalling < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of the object. Always `programmatic_tool_calling`.
          #
          #   @return [Symbol, :programmatic_tool_calling]
          required :type, const: :programmatic_tool_calling

          # @!attribute enabled
          #   Whether tools can be called from model-generated code. Defaults to `true`.
          #
          #   @return [Boolean, nil]
          optional :enabled, OpenAI::Internal::Type::Boolean

          # @!method initialize(enabled: nil, type: :programmatic_tool_calling)
          #   Enables calling tools from model-generated code.
          #
          #   @param enabled [Boolean]
          #     Whether tools can be called from model-generated code. Defaults to `true`.
          #
          #   @param type [Symbol, :programmatic_tool_calling]
          #     The type of the object. Always `programmatic_tool_calling`.
        end

        class Mcp < OpenAI::Internal::Type::BaseModel
          # @!attribute server_label
          #   A label used to identify the MCP server in tool calls.
          #
          #   @return [String]
          required :server_label, String

          # @!attribute transport
          #   The transport used to connect to the MCP server.
          #
          #   @return [OpenAI::Models::Beta::McpTransportParam::HTTP, OpenAI::Models::Beta::McpTransportParam::Stdio]
          required :transport, union: -> { OpenAI::Beta::McpTransportParam }

          # @!attribute type
          #   The type of the object. Always `mcp`.
          #
          #   @return [Symbol, :mcp]
          required :type, const: :mcp

          # @!attribute allowed_tools
          #   The MCP tools the agent may call. All server tools are allowed when omitted.
          #
          #   @return [Array<String>, nil]
          optional :allowed_tools, OpenAI::Internal::Type::ArrayOf[String], nil?: true

          # @!attribute connection_origin
          #   Where outbound MCP HTTP connections originate.
          #
          #   @return [Symbol, OpenAI::Models::Beta::AgentToolParam::Mcp::ConnectionOrigin, nil]
          optional(
            :connection_origin,
            enum: -> {
              OpenAI::Beta::AgentToolParam::Mcp::ConnectionOrigin
            },
            nil?: true
          )

          # @!attribute credential_id
          #   The attached vault credential used to authenticate this MCP server. Optional
          #   when exactly one attached credential matches the server URL.
          #
          #   @return [String, nil]
          optional :credential_id, String, nil?: true

          # @!attribute request_metadata
          #   Metadata included with requests to this MCP server.
          #
          #   @return [Hash{Symbol=>Object}, nil]
          optional(
            :request_metadata,
            OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown],
            nil?: true
          )

          # @!attribute required
          #   Whether this MCP server must initialize before the first turn. Defaults to
          #   `false`.
          #
          #   @return [Boolean, nil]
          optional :required, OpenAI::Internal::Type::Boolean

          # @!method initialize(server_label:, transport:, allowed_tools: nil, connection_origin: nil, credential_id: nil, request_metadata: nil, required: nil, type: :mcp)
          #   Tools provided by a remote MCP server.
          #
          #   @param server_label [String]
          #     A label used to identify the MCP server in tool calls.
          #
          #   @param transport [OpenAI::Models::Beta::McpTransportParam::HTTP, OpenAI::Models::Beta::McpTransportParam::Stdio]
          #     The transport used to connect to the MCP server.
          #
          #   @param allowed_tools [Array<String>, nil]
          #     The MCP tools the agent may call. All server tools are allowed when omitted.
          #
          #   @param connection_origin [Symbol, OpenAI::Models::Beta::AgentToolParam::Mcp::ConnectionOrigin, nil]
          #     Where outbound MCP HTTP connections originate.
          #
          #   @param credential_id [String, nil]
          #     The attached vault credential used to authenticate this MCP server. Optional
          #     when exactly one attached credential matches the server URL.
          #
          #   @param request_metadata [Hash{Symbol=>Object}, nil]
          #     Metadata included with requests to this MCP server.
          #
          #   @param required [Boolean]
          #     Whether this MCP server must initialize before the first turn. Defaults to
          #     `false`.
          #
          #   @param type [Symbol, :mcp]
          #     The type of the object. Always `mcp`.

          # Where outbound MCP HTTP connections originate.
          #
          # @see OpenAI::Models::Beta::AgentToolParam::Mcp#connection_origin
          module ConnectionOrigin
            extend OpenAI::Internal::Type::Enum

            # Uses the Managed Agents service network.
            SERVICE = :service

            # Uses the session's execution environment.
            ENVIRONMENT = :environment

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class WebSearch < OpenAI::Internal::Type::BaseModel
          # @!attribute type
          #   The type of the object. Always `web_search`.
          #
          #   @return [Symbol, :web_search]
          required :type, const: :web_search

          # @!attribute allowed_domains
          #   Domains the search may include.
          #
          #   @return [Array<String>, nil]
          optional :allowed_domains, OpenAI::Internal::Type::ArrayOf[String], nil?: true

          # @!attribute context_size
          #   The amount of web search context made available to the model.
          #
          #   @return [Symbol, OpenAI::Models::Beta::AgentToolParam::WebSearch::ContextSize, nil]
          optional(
            :context_size,
            enum: -> {
              OpenAI::Beta::AgentToolParam::WebSearch::ContextSize
            },
            nil?: true
          )

          # @!attribute location
          #   Approximate user location used to localize web search results.
          #
          #   @return [OpenAI::Models::Beta::AgentToolParam::WebSearch::Location, nil]
          optional :location, -> { OpenAI::Beta::AgentToolParam::WebSearch::Location }, nil?: true

          # @!attribute mode
          #   The source used for web search results.
          #
          #   @return [Symbol, OpenAI::Models::Beta::AgentToolParam::WebSearch::Mode, nil]
          optional :mode, enum: -> { OpenAI::Beta::AgentToolParam::WebSearch::Mode }, nil?: true

          # @!method initialize(allowed_domains: nil, context_size: nil, location: nil, mode: nil, type: :web_search)
          #   Web search.
          #
          #   @param allowed_domains [Array<String>, nil]
          #     Domains the search may include.
          #
          #   @param context_size [Symbol, OpenAI::Models::Beta::AgentToolParam::WebSearch::ContextSize, nil]
          #     The amount of web search context made available to the model.
          #
          #   @param location [OpenAI::Models::Beta::AgentToolParam::WebSearch::Location, nil]
          #     Approximate user location used to localize web search results.
          #
          #   @param mode [Symbol, OpenAI::Models::Beta::AgentToolParam::WebSearch::Mode, nil]
          #     The source used for web search results.
          #
          #   @param type [Symbol, :web_search]
          #     The type of the object. Always `web_search`.

          # The amount of web search context made available to the model.
          #
          # @see OpenAI::Models::Beta::AgentToolParam::WebSearch#context_size
          module ContextSize
            extend OpenAI::Internal::Type::Enum

            LOW = :low
            MEDIUM = :medium
            HIGH = :high

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @see OpenAI::Models::Beta::AgentToolParam::WebSearch#location
          class Location < OpenAI::Internal::Type::BaseModel
            # @!attribute city
            #   The city name.
            #
            #   @return [String, nil]
            optional :city, String, nil?: true

            # @!attribute country
            #   The two-letter ISO country code, such as `US`.
            #
            #   @return [String, nil]
            optional :country, String, nil?: true

            # @!attribute region
            #   The region or state name.
            #
            #   @return [String, nil]
            optional :region, String, nil?: true

            # @!attribute timezone
            #   The IANA timezone, such as `America/Los_Angeles`.
            #
            #   @return [String, nil]
            optional :timezone, String, nil?: true

            # @!method initialize(city: nil, country: nil, region: nil, timezone: nil)
            #   Approximate user location used to localize web search results.
            #
            #   @param city [String, nil]
            #     The city name.
            #
            #   @param country [String, nil]
            #     The two-letter ISO country code, such as `US`.
            #
            #   @param region [String, nil]
            #     The region or state name.
            #
            #   @param timezone [String, nil]
            #     The IANA timezone, such as `America/Los_Angeles`.
          end

          # The source used for web search results.
          #
          # @see OpenAI::Models::Beta::AgentToolParam::WebSearch#mode
          module Mode
            extend OpenAI::Internal::Type::Enum

            # Disables web search.
            DISABLED = :disabled

            # Uses cached search results.
            CACHED = :cached

            # Searches the live web.
            LIVE = :live

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::AgentToolParam::Function, OpenAI::Models::Beta::AgentToolParam::ToolSearch, OpenAI::Models::Beta::AgentToolParam::ProgrammaticToolCalling, OpenAI::Models::Beta::AgentToolParam::Mcp, OpenAI::Models::Beta::AgentToolParam::WebSearch)]
      end
    end
  end
end
