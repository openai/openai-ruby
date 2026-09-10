# typed: strong

module OpenAI
  module Models

    module Beta

      # A credential-free tool available to a reusable agent.
      module PersistedAgentTool
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::PersistedAgentTool::Function,
            OpenAI::Beta::PersistedAgentTool::ToolSearch,
            OpenAI::Beta::PersistedAgentTool::ProgrammaticToolCalling,
            OpenAI::Beta::PersistedAgentTool::Mcp,
            OpenAI::Beta::PersistedAgentTool::WebSearch
          )
        end

        class Function < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::PersistedAgentTool::Function,
              OpenAI::Internal::AnyHash
            )
          end

          # Whether the function is deferred and discovered through tool search.
          sig { returns(T::Boolean) }
          attr_accessor :defer_loading

          # A description of what the function does.
          sig { returns(String) }
          attr_accessor :description

          # The name of the function.
          sig { returns(String) }
          attr_accessor :name

          # A JSON Schema object describing the function's arguments.
          sig { returns(T::Hash[Symbol, T.anything]) }
          attr_accessor :parameters

          # The type of the object. Always `function`.
          sig { returns(Symbol) }
          attr_accessor :type

          # A function defined by the application.
          sig do
            params(

              defer_loading: T::Boolean,

              description: String,

              name: String,

              parameters: T::Hash[Symbol, T.anything],

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Whether the function is deferred and discovered through tool search.
            defer_loading:,

            # A description of what the function does.
            description:,

            # The name of the function.
            name:,

            # A JSON Schema object describing the function's arguments.
            parameters:,

            # The type of the object. Always `function`.

            type: :function
          )
          end

          sig do
            override.returns(
              {
                defer_loading: T::Boolean,
                description: String,
                name: String,
                parameters: T::Hash[Symbol, T.anything],
                type: Symbol
              }
            )
          end
          def to_hash
          end

        end

        class ToolSearch < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::PersistedAgentTool::ToolSearch,
              OpenAI::Internal::AnyHash
            )
          end

          # The type of the object. Always `tool_search`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Discovers deferred function tools and loads them into the model context.
          sig do
            params(

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The type of the object. Always `tool_search`.

            type: :tool_search
          )
          end

          sig do
            override.returns(
              {type: Symbol}
            )
          end
          def to_hash
          end

        end

        class ProgrammaticToolCalling < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::PersistedAgentTool::ProgrammaticToolCalling,
              OpenAI::Internal::AnyHash
            )
          end

          # Whether tools can be called from model-generated code.
          sig { returns(T::Boolean) }
          attr_accessor :enabled

          # The type of the object. Always `programmatic_tool_calling`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Enables calling tools from model-generated code.
          sig do
            params(

              enabled: T::Boolean,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Whether tools can be called from model-generated code.
            enabled:,

            # The type of the object. Always `programmatic_tool_calling`.

            type: :programmatic_tool_calling
          )
          end

          sig do
            override.returns(
              {enabled: T::Boolean, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class Mcp < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::PersistedAgentTool::Mcp,
              OpenAI::Internal::AnyHash
            )
          end

          # The MCP tools the agent may call, or null when all server tools are allowed.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :allowed_tools

          # Where outbound MCP HTTP connections originate.
          sig { returns(OpenAI::Beta::PersistedAgentTool::Mcp::ConnectionOrigin::TaggedSymbol) }
          attr_accessor :connection_origin

          # The vault credential selected for this MCP server, if any.
          sig { returns(T.nilable(String)) }
          attr_accessor :credential_id

          # Metadata included with requests to this MCP server.
          sig { returns(T::Hash[Symbol, T.anything]) }
          attr_accessor :request_metadata

          # Whether this MCP server must initialize before the first turn.
          sig { returns(T::Boolean) }
          attr_accessor :required

          # A label used to identify the MCP server in tool calls.
          sig { returns(String) }
          attr_accessor :server_label

          # The credential-free transport used to connect to the MCP server.
          sig { returns(OpenAI::Beta::PersistedMcpTransport::Variants) }
          attr_accessor :transport

          # The type of the object. Always `mcp`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Tools provided by a remote MCP server without stored credentials.
          sig do
            params(

              allowed_tools: T.nilable(T::Array[String]),

              connection_origin: OpenAI::Beta::PersistedAgentTool::Mcp::ConnectionOrigin::OrSymbol,

              credential_id: T.nilable(String),

              request_metadata: T::Hash[Symbol, T.anything],

              required: T::Boolean,

              server_label: String,

              transport: T.any(
                OpenAI::Beta::PersistedMcpTransport::HTTP::OrHash,
                OpenAI::Beta::PersistedMcpTransport::Stdio::OrHash
              ),

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The MCP tools the agent may call, or null when all server tools are allowed.
            allowed_tools:,

            # Where outbound MCP HTTP connections originate.
            connection_origin:,

            # The vault credential selected for this MCP server, if any.
            credential_id:,

            # Metadata included with requests to this MCP server.
            request_metadata:,

            # Whether this MCP server must initialize before the first turn.
            required:,

            # A label used to identify the MCP server in tool calls.
            server_label:,

            # The credential-free transport used to connect to the MCP server.
            transport:,

            # The type of the object. Always `mcp`.

            type: :mcp
          )
          end

          sig do
            override.returns(
              {
                allowed_tools: T.nilable(T::Array[String]),
                connection_origin: OpenAI::Beta::PersistedAgentTool::Mcp::ConnectionOrigin::TaggedSymbol,
                credential_id: T.nilable(String),
                request_metadata: T::Hash[Symbol, T.anything],
                required: T::Boolean,
                server_label: String,
                transport: OpenAI::Beta::PersistedMcpTransport::Variants,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          # Where outbound MCP HTTP connections originate.
          module ConnectionOrigin
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::PersistedAgentTool::Mcp::ConnectionOrigin) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            SERVICE = T.let(:service, OpenAI::Beta::PersistedAgentTool::Mcp::ConnectionOrigin::TaggedSymbol)
            ENVIRONMENT = T.let(:environment, OpenAI::Beta::PersistedAgentTool::Mcp::ConnectionOrigin::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Beta::PersistedAgentTool::Mcp::ConnectionOrigin::TaggedSymbol]) }
            def self.values
            end
          end
        end

        class WebSearch < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::PersistedAgentTool::WebSearch,
              OpenAI::Internal::AnyHash
            )
          end

          # Allowed search domains, or `null` when the search is unrestricted.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :allowed_domains

          # The amount of search context made available to the model. Defaults to `medium`.
          sig { returns(OpenAI::Beta::PersistedAgentTool::WebSearch::ContextSize::TaggedSymbol) }
          attr_accessor :context_size

          # Approximate user location used to localize web search results.
          sig { returns(T.nilable(OpenAI::Beta::PersistedAgentTool::WebSearch::Location)) }
          attr_reader :location

          sig { params(location: T.nilable(OpenAI::Beta::PersistedAgentTool::WebSearch::Location::OrHash)).void }
          attr_writer :location

          # The source used for web search results.
          sig { returns(OpenAI::Beta::PersistedAgentTool::WebSearch::Mode::TaggedSymbol) }
          attr_accessor :mode

          # The type of the object. Always `web_search`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Web search.
          sig do
            params(

              allowed_domains: T.nilable(T::Array[String]),

              context_size: OpenAI::Beta::PersistedAgentTool::WebSearch::ContextSize::OrSymbol,

              location: T.nilable(OpenAI::Beta::PersistedAgentTool::WebSearch::Location::OrHash),

              mode: OpenAI::Beta::PersistedAgentTool::WebSearch::Mode::OrSymbol,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Allowed search domains, or `null` when the search is unrestricted.
            allowed_domains:,

            # The amount of search context made available to the model. Defaults to `medium`.
            context_size:,

            # Approximate user location used to localize web search results.
            location:,

            # The source used for web search results.
            mode:,

            # The type of the object. Always `web_search`.

            type: :web_search
          )
          end

          sig do
            override.returns(
              {
                allowed_domains: T.nilable(T::Array[String]),
                context_size: OpenAI::Beta::PersistedAgentTool::WebSearch::ContextSize::TaggedSymbol,
                location: T.nilable(OpenAI::Beta::PersistedAgentTool::WebSearch::Location),
                mode: OpenAI::Beta::PersistedAgentTool::WebSearch::Mode::TaggedSymbol,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          # The amount of search context made available to the model. Defaults to `medium`.
          module ContextSize
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::PersistedAgentTool::WebSearch::ContextSize) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            LOW = T.let(:low, OpenAI::Beta::PersistedAgentTool::WebSearch::ContextSize::TaggedSymbol)
            MEDIUM = T.let(:medium, OpenAI::Beta::PersistedAgentTool::WebSearch::ContextSize::TaggedSymbol)
            HIGH = T.let(:high, OpenAI::Beta::PersistedAgentTool::WebSearch::ContextSize::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Beta::PersistedAgentTool::WebSearch::ContextSize::TaggedSymbol]) }
            def self.values
            end
          end

          class Location < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::PersistedAgentTool::WebSearch::Location,
                OpenAI::Internal::AnyHash
              )
            end

            # The city name.
            sig { returns(T.nilable(String)) }
            attr_accessor :city

            # The two-letter ISO country code, such as `US`.
            sig { returns(T.nilable(String)) }
            attr_accessor :country

            # The region or state name.
            sig { returns(T.nilable(String)) }
            attr_accessor :region

            # The IANA timezone, such as `America/Los_Angeles`.
            sig { returns(T.nilable(String)) }
            attr_accessor :timezone

            # Approximate user location used to localize web search results.
            sig do
              params(

                city: T.nilable(String),

                country: T.nilable(String),

                region: T.nilable(String),

                timezone: T.nilable(String)
              )
                .returns(T.attached_class)
            end
            def self.new(

              # The city name.
              city:,

              # The two-letter ISO country code, such as `US`.
              country:,

              # The region or state name.
              region:,

              # The IANA timezone, such as `America/Los_Angeles`.

              timezone:
            )
            end

            sig do
              override.returns(
                {
                  city: T.nilable(String),
                  country: T.nilable(String),
                  region: T.nilable(String),
                  timezone: T.nilable(String)
                }
              )
            end
            def to_hash
            end

          end

          # The source used for web search results.
          module Mode
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::PersistedAgentTool::WebSearch::Mode) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            DISABLED = T.let(:disabled, OpenAI::Beta::PersistedAgentTool::WebSearch::Mode::TaggedSymbol)
            CACHED = T.let(:cached, OpenAI::Beta::PersistedAgentTool::WebSearch::Mode::TaggedSymbol)
            LIVE = T.let(:live, OpenAI::Beta::PersistedAgentTool::WebSearch::Mode::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Beta::PersistedAgentTool::WebSearch::Mode::TaggedSymbol]) }
            def self.values
            end
          end
        end

        sig { override.returns(T::Array[OpenAI::Beta::PersistedAgentTool::Variants]) }
        def self.variants
        end

      end

    end

  end
end
