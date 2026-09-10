# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # A tool available to the agent.
      module AgentTool
        extend OpenAI::Internal::Type::Union

        discriminator :type

        # A function defined by the application.
        variant :function, -> { OpenAI::Beta::AgentTool::Function }

        # Enables calling tools from model-generated code.
        variant :programmatic_tool_calling, -> { OpenAI::Beta::AgentTool::ProgrammaticToolCalling }

        # Tools provided by a remote MCP server.
        variant :mcp, -> { OpenAI::Beta::AgentTool::Mcp }

        # Web search.
        variant :web_search, -> { OpenAI::Beta::AgentTool::WebSearch }

        class Function < OpenAI::Internal::Type::BaseModel
          # @!attribute defer_loading
          #   Whether the function is deferred and discovered through tool search.
          #
          #   @return [Boolean]
          required :defer_loading, OpenAI::Internal::Type::Boolean

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

          # @!method initialize(defer_loading:, description:, name:, parameters:, type: :function)
          #   A function defined by the application.
          #
          #   @param defer_loading [Boolean]
          #     Whether the function is deferred and discovered through tool search.
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
          #   @param type [Symbol, :function]
          #     The type of the object. Always `function`.
        end

        class ProgrammaticToolCalling < OpenAI::Internal::Type::BaseModel
          # @!attribute enabled
          #   Whether tools can be called from model-generated code.
          #
          #   @return [Boolean]
          required :enabled, OpenAI::Internal::Type::Boolean

          # @!attribute type
          #   The type of the object. Always `programmatic_tool_calling`.
          #
          #   @return [Symbol, :programmatic_tool_calling]
          required :type, const: :programmatic_tool_calling

          # @!method initialize(enabled:, type: :programmatic_tool_calling)
          #   Enables calling tools from model-generated code.
          #
          #   @param enabled [Boolean]
          #     Whether tools can be called from model-generated code.
          #
          #   @param type [Symbol, :programmatic_tool_calling]
          #     The type of the object. Always `programmatic_tool_calling`.
        end

        class Mcp < OpenAI::Internal::Type::BaseModel
          # @!attribute allowed_tools
          #   The MCP tools the agent may call.
          #
          #   @return [Array<String>, nil]
          required :allowed_tools, OpenAI::Internal::Type::ArrayOf[String], nil?: true

          # @!attribute connection_origin
          #   Where outbound MCP HTTP connections originate.
          #
          #   @return [Symbol, OpenAI::Models::Beta::AgentTool::Mcp::ConnectionOrigin]
          required :connection_origin, enum: -> { OpenAI::Beta::AgentTool::Mcp::ConnectionOrigin }

          # @!attribute credential_id
          #   The attached vault credential selected for this MCP server, if any. Optional
          #   when exactly one attached credential matches the server URL.
          #
          #   @return [String, nil]
          required :credential_id, String, nil?: true

          # @!attribute request_metadata
          #   Metadata included with requests to this MCP server.
          #
          #   @return [Hash{Symbol=>Object}]
          required :request_metadata, OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown]

          # @!attribute required
          #   Whether this MCP server must initialize before the first turn.
          #
          #   @return [Boolean]
          required :required, OpenAI::Internal::Type::Boolean

          # @!attribute server_label
          #   A label used to identify the MCP server in tool calls.
          #
          #   @return [String]
          required :server_label, String

          # @!attribute transport
          #   The transport used to connect to the MCP server.
          #
          #   @return [OpenAI::Models::Beta::McpTransport::HTTP, OpenAI::Models::Beta::McpTransport::Stdio]
          required :transport, union: -> { OpenAI::Beta::McpTransport }

          # @!attribute type
          #   The type of the object. Always `mcp`.
          #
          #   @return [Symbol, :mcp]
          required :type, const: :mcp

          # @!method initialize(allowed_tools:, connection_origin:, credential_id:, request_metadata:, required:, server_label:, transport:, type: :mcp)
          #   Tools provided by a remote MCP server.
          #
          #   @param allowed_tools [Array<String>, nil]
          #     The MCP tools the agent may call.
          #
          #   @param connection_origin [Symbol, OpenAI::Models::Beta::AgentTool::Mcp::ConnectionOrigin]
          #     Where outbound MCP HTTP connections originate.
          #
          #   @param credential_id [String, nil]
          #     The attached vault credential selected for this MCP server, if any. Optional
          #     when exactly one attached credential matches the server URL.
          #
          #   @param request_metadata [Hash{Symbol=>Object}]
          #     Metadata included with requests to this MCP server.
          #
          #   @param required [Boolean]
          #     Whether this MCP server must initialize before the first turn.
          #
          #   @param server_label [String]
          #     A label used to identify the MCP server in tool calls.
          #
          #   @param transport [OpenAI::Models::Beta::McpTransport::HTTP, OpenAI::Models::Beta::McpTransport::Stdio]
          #     The transport used to connect to the MCP server.
          #
          #   @param type [Symbol, :mcp]
          #     The type of the object. Always `mcp`.

          # Where outbound MCP HTTP connections originate.
          #
          # @see OpenAI::Models::Beta::AgentTool::Mcp#connection_origin
          module ConnectionOrigin
            extend OpenAI::Internal::Type::Enum

            SERVICE = :service
            ENVIRONMENT = :environment

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        class WebSearch < OpenAI::Internal::Type::BaseModel
          # @!attribute allowed_domains
          #   Allowed search domains, or `null` when the search is unrestricted.
          #
          #   @return [Array<String>, nil]
          required :allowed_domains, OpenAI::Internal::Type::ArrayOf[String], nil?: true

          # @!attribute context_size
          #   The amount of search context made available to the model. Defaults to `medium`.
          #
          #   @return [Symbol, OpenAI::Models::Beta::AgentTool::WebSearch::ContextSize]
          required :context_size, enum: -> { OpenAI::Beta::AgentTool::WebSearch::ContextSize }

          # @!attribute location
          #   Approximate user location used to localize web search results.
          #
          #   @return [OpenAI::Models::Beta::AgentTool::WebSearch::Location, nil]
          required :location, -> { OpenAI::Beta::AgentTool::WebSearch::Location }, nil?: true

          # @!attribute mode
          #   The source used for web search results.
          #
          #   @return [Symbol, OpenAI::Models::Beta::AgentTool::WebSearch::Mode]
          required :mode, enum: -> { OpenAI::Beta::AgentTool::WebSearch::Mode }

          # @!attribute type
          #   The type of the object. Always `web_search`.
          #
          #   @return [Symbol, :web_search]
          required :type, const: :web_search

          # @!method initialize(allowed_domains:, context_size:, location:, mode:, type: :web_search)
          #   Web search.
          #
          #   @param allowed_domains [Array<String>, nil]
          #     Allowed search domains, or `null` when the search is unrestricted.
          #
          #   @param context_size [Symbol, OpenAI::Models::Beta::AgentTool::WebSearch::ContextSize]
          #     The amount of search context made available to the model. Defaults to `medium`.
          #
          #   @param location [OpenAI::Models::Beta::AgentTool::WebSearch::Location, nil]
          #     Approximate user location used to localize web search results.
          #
          #   @param mode [Symbol, OpenAI::Models::Beta::AgentTool::WebSearch::Mode]
          #     The source used for web search results.
          #
          #   @param type [Symbol, :web_search]
          #     The type of the object. Always `web_search`.

          # The amount of search context made available to the model. Defaults to `medium`.
          #
          # @see OpenAI::Models::Beta::AgentTool::WebSearch#context_size
          module ContextSize
            extend OpenAI::Internal::Type::Enum

            LOW = :low
            MEDIUM = :medium
            HIGH = :high

            # @!method self.values
            #   @return [Array<Symbol>]
          end

          # @see OpenAI::Models::Beta::AgentTool::WebSearch#location
          class Location < OpenAI::Internal::Type::BaseModel
            # @!attribute city
            #   The city name.
            #
            #   @return [String, nil]
            required :city, String, nil?: true

            # @!attribute country
            #   The two-letter ISO country code, such as `US`.
            #
            #   @return [String, nil]
            required :country, String, nil?: true

            # @!attribute region
            #   The region or state name.
            #
            #   @return [String, nil]
            required :region, String, nil?: true

            # @!attribute timezone
            #   The IANA timezone, such as `America/Los_Angeles`.
            #
            #   @return [String, nil]
            required :timezone, String, nil?: true

            # @!method initialize(city:, country:, region:, timezone:)
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
          # @see OpenAI::Models::Beta::AgentTool::WebSearch#mode
          module Mode
            extend OpenAI::Internal::Type::Enum

            DISABLED = :disabled
            CACHED = :cached
            LIVE = :live

            # @!method self.values
            #   @return [Array<Symbol>]
          end
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::AgentTool::Function, OpenAI::Models::Beta::AgentTool::ProgrammaticToolCalling, OpenAI::Models::Beta::AgentTool::Mcp, OpenAI::Models::Beta::AgentTool::WebSearch)]
      end
    end
  end
end
