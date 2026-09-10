# typed: strong

module OpenAI
  module Models

    module Beta

      # A tool that can be stored on a reusable agent without session credentials.
      module PersistedAgentToolParam
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Beta::PersistedAgentToolParam::Function,
            OpenAI::Beta::PersistedAgentToolParam::ToolSearch,
            OpenAI::Beta::PersistedAgentToolParam::ProgrammaticToolCalling,
            OpenAI::Beta::PersistedAgentToolParam::Mcp,
            OpenAI::Beta::PersistedAgentToolParam::WebSearch
          )
        end

        class Function < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::PersistedAgentToolParam::Function,
              OpenAI::Internal::AnyHash
            )
          end

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

          # Whether this function is deferred and discovered through tool search. Defaults
          # to `false`.
          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :defer_loading

          sig { params(defer_loading: T::Boolean).void }
          attr_writer :defer_loading

          # A function defined by the application.
          sig do
            params(

              description: String,

              name: String,

              parameters: T::Hash[Symbol, T.anything],

              defer_loading: T::Boolean,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # A description of what the function does.
            description:,

            # The name of the function.
            name:,

            # A JSON Schema object describing the function's arguments.
            parameters:,

            # Whether this function is deferred and discovered through tool search. Defaults
            # to `false`.
            defer_loading: nil,

            # The type of the object. Always `function`.

            type: :function
          )
          end

          sig do
            override.returns(
              {
                description: String,
                name: String,
                parameters: T::Hash[Symbol, T.anything],
                type: Symbol,
                defer_loading: T::Boolean
              }
            )
          end
          def to_hash
          end

        end

        class ToolSearch < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::PersistedAgentToolParam::ToolSearch,
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
              OpenAI::Beta::PersistedAgentToolParam::ProgrammaticToolCalling,
              OpenAI::Internal::AnyHash
            )
          end

          # The type of the object. Always `programmatic_tool_calling`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Whether tools can be called from model-generated code. Defaults to `true`.
          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :enabled

          sig { params(enabled: T::Boolean).void }
          attr_writer :enabled

          # Enables calling tools from model-generated code.
          sig do
            params(

              enabled: T::Boolean,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Whether tools can be called from model-generated code. Defaults to `true`.
            enabled: nil,

            # The type of the object. Always `programmatic_tool_calling`.

            type: :programmatic_tool_calling
          )
          end

          sig do
            override.returns(
              {type: Symbol, enabled: T::Boolean}
            )
          end
          def to_hash
          end

        end

        class Mcp < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::PersistedAgentToolParam::Mcp,
              OpenAI::Internal::AnyHash
            )
          end

          # A label used to identify the MCP server in tool calls.
          sig { returns(String) }
          attr_accessor :server_label

          # The credential-free transport used to connect to the MCP server.
          sig {
            returns(
              T.any(OpenAI::Beta::PersistedMcpTransportParam::HTTP, OpenAI::Beta::PersistedMcpTransportParam::Stdio)
            )
          }
          attr_accessor :transport

          # The type of the object. Always `mcp`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The MCP tools the agent may call. All server tools are allowed when omitted.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :allowed_tools

          # Where outbound MCP HTTP connections originate.
          sig { returns(T.nilable(OpenAI::Beta::PersistedAgentToolParam::Mcp::ConnectionOrigin::OrSymbol)) }
          attr_accessor :connection_origin

          # The vault credential selected for this MCP server. Optional when exactly one
          # attached credential matches the server URL.
          sig { returns(T.nilable(String)) }
          attr_accessor :credential_id

          # Metadata included with requests to this MCP server.
          sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
          attr_accessor :request_metadata

          # Whether this MCP server must initialize before the first turn. Defaults to
          # `false`.
          sig { returns(T.nilable(T::Boolean)) }
          attr_reader :required

          sig { params(required: T::Boolean).void }
          attr_writer :required

          # Tools provided by a remote MCP server without stored credentials.
          sig do
            params(

              server_label: String,

              transport: T.any(
                OpenAI::Beta::PersistedMcpTransportParam::HTTP::OrHash,
                OpenAI::Beta::PersistedMcpTransportParam::Stdio::OrHash
              ),

              allowed_tools: T.nilable(T::Array[String]),

              connection_origin: T.nilable(OpenAI::Beta::PersistedAgentToolParam::Mcp::ConnectionOrigin::OrSymbol),

              credential_id: T.nilable(String),

              request_metadata: T.nilable(T::Hash[Symbol, T.anything]),

              required: T::Boolean,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # A label used to identify the MCP server in tool calls.
            server_label:,

            # The credential-free transport used to connect to the MCP server.
            transport:,

            # The MCP tools the agent may call. All server tools are allowed when omitted.
            allowed_tools: nil,

            # Where outbound MCP HTTP connections originate.
            connection_origin: nil,

            # The vault credential selected for this MCP server. Optional when exactly one
            # attached credential matches the server URL.
            credential_id: nil,

            # Metadata included with requests to this MCP server.
            request_metadata: nil,

            # Whether this MCP server must initialize before the first turn. Defaults to
            # `false`.
            required: nil,

            # The type of the object. Always `mcp`.

            type: :mcp
          )
          end

          sig do
            override.returns(
              {
                server_label: String,
                transport: T.any(
                  OpenAI::Beta::PersistedMcpTransportParam::HTTP,
                  OpenAI::Beta::PersistedMcpTransportParam::Stdio
                ),
                type: Symbol,
                allowed_tools: T.nilable(T::Array[String]),
                connection_origin: T.nilable(OpenAI::Beta::PersistedAgentToolParam::Mcp::ConnectionOrigin::OrSymbol),
                credential_id: T.nilable(String),
                request_metadata: T.nilable(T::Hash[Symbol, T.anything]),
                required: T::Boolean
              }
            )
          end
          def to_hash
          end

          # Where outbound MCP HTTP connections originate.
          module ConnectionOrigin
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::PersistedAgentToolParam::Mcp::ConnectionOrigin) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            # Uses the Managed Agents service network.
            SERVICE = T.let(:service, OpenAI::Beta::PersistedAgentToolParam::Mcp::ConnectionOrigin::TaggedSymbol)

            # Uses the session's execution environment.
            ENVIRONMENT = T.let(
              :environment,
              OpenAI::Beta::PersistedAgentToolParam::Mcp::ConnectionOrigin::TaggedSymbol
            )

            sig {
              override.returns(T::Array[OpenAI::Beta::PersistedAgentToolParam::Mcp::ConnectionOrigin::TaggedSymbol])
            }
            def self.values
            end
          end
        end

        class WebSearch < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::PersistedAgentToolParam::WebSearch,
              OpenAI::Internal::AnyHash
            )
          end

          # The type of the object. Always `web_search`.
          sig { returns(Symbol) }
          attr_accessor :type

          # Domains the search may include.
          sig { returns(T.nilable(T::Array[String])) }
          attr_accessor :allowed_domains

          # The amount of web search context made available to the model.
          sig { returns(T.nilable(OpenAI::Beta::PersistedAgentToolParam::WebSearch::ContextSize::OrSymbol)) }
          attr_accessor :context_size

          # Approximate user location used to localize web search results.
          sig { returns(T.nilable(OpenAI::Beta::PersistedAgentToolParam::WebSearch::Location)) }
          attr_reader :location

          sig { params(location: T.nilable(OpenAI::Beta::PersistedAgentToolParam::WebSearch::Location::OrHash)).void }
          attr_writer :location

          # The source used for web search results.
          sig { returns(T.nilable(OpenAI::Beta::PersistedAgentToolParam::WebSearch::Mode::OrSymbol)) }
          attr_accessor :mode

          # Web search.
          sig do
            params(

              allowed_domains: T.nilable(T::Array[String]),

              context_size: T.nilable(OpenAI::Beta::PersistedAgentToolParam::WebSearch::ContextSize::OrSymbol),

              location: T.nilable(OpenAI::Beta::PersistedAgentToolParam::WebSearch::Location::OrHash),

              mode: T.nilable(OpenAI::Beta::PersistedAgentToolParam::WebSearch::Mode::OrSymbol),

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Domains the search may include.
            allowed_domains: nil,

            # The amount of web search context made available to the model.
            context_size: nil,

            # Approximate user location used to localize web search results.
            location: nil,

            # The source used for web search results.
            mode: nil,

            # The type of the object. Always `web_search`.

            type: :web_search
          )
          end

          sig do
            override.returns(
              {
                type: Symbol,
                allowed_domains: T.nilable(T::Array[String]),
                context_size: T.nilable(OpenAI::Beta::PersistedAgentToolParam::WebSearch::ContextSize::OrSymbol),
                location: T.nilable(OpenAI::Beta::PersistedAgentToolParam::WebSearch::Location),
                mode: T.nilable(OpenAI::Beta::PersistedAgentToolParam::WebSearch::Mode::OrSymbol)
              }
            )
          end
          def to_hash
          end

          # The amount of web search context made available to the model.
          module ContextSize
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Beta::PersistedAgentToolParam::WebSearch::ContextSize)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            LOW = T.let(:low, OpenAI::Beta::PersistedAgentToolParam::WebSearch::ContextSize::TaggedSymbol)
            MEDIUM = T.let(:medium, OpenAI::Beta::PersistedAgentToolParam::WebSearch::ContextSize::TaggedSymbol)
            HIGH = T.let(:high, OpenAI::Beta::PersistedAgentToolParam::WebSearch::ContextSize::TaggedSymbol)

            sig {
              override.returns(T::Array[OpenAI::Beta::PersistedAgentToolParam::WebSearch::ContextSize::TaggedSymbol])
            }
            def self.values
            end
          end

          class Location < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Beta::PersistedAgentToolParam::WebSearch::Location,
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
              city: nil,

              # The two-letter ISO country code, such as `US`.
              country: nil,

              # The region or state name.
              region: nil,

              # The IANA timezone, such as `America/Los_Angeles`.

              timezone: nil
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

            TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Beta::PersistedAgentToolParam::WebSearch::Mode) }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            # Disables web search.
            DISABLED = T.let(:disabled, OpenAI::Beta::PersistedAgentToolParam::WebSearch::Mode::TaggedSymbol)

            # Uses cached search results.
            CACHED = T.let(:cached, OpenAI::Beta::PersistedAgentToolParam::WebSearch::Mode::TaggedSymbol)

            # Searches the live web.
            LIVE = T.let(:live, OpenAI::Beta::PersistedAgentToolParam::WebSearch::Mode::TaggedSymbol)

            sig { override.returns(T::Array[OpenAI::Beta::PersistedAgentToolParam::WebSearch::Mode::TaggedSymbol]) }
            def self.values
            end
          end
        end

        sig { override.returns(T::Array[OpenAI::Beta::PersistedAgentToolParam::Variants]) }
        def self.variants
        end

      end

    end

  end
end
