# typed: strong

module OpenAI
  module Models

    module Live

      class McpTool < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::McpTool,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(Symbol) }
        attr_accessor :type

        # The tool invocation context(s).
        sig { returns(T.nilable(T::Array[OpenAI::Live::McpTool::AllowedCaller::OrSymbol])) }
        attr_accessor :allowed_callers

        # A list of MCP tool names that are allowed for this server.
        sig { returns(T.nilable(T.any(T::Array[String], OpenAI::Live::McpToolFilter))) }
        attr_accessor :allowed_tools

        # The ID of a built-in MCP connector. This field is deprecated for models released
        # after September 1, 2026. Use `server_url` to connect to a remote MCP server, or
        # `tunnel_id` to connect to a local MCP server.
        sig { returns(T.nilable(String)) }
        attr_accessor :connector_id

        # Whether this MCP tool should be deferred and discovered via tool search.
        sig { returns(T.nilable(T::Boolean)) }
        attr_accessor :defer_loading

        # Controls which MCP tools require explicit user approval before execution.
        sig {
          returns(
            T.nilable(
              T.any(
                OpenAI::Live::McpRequireApprovalFilter,
                OpenAI::Live::McpTool::RequireApproval::LiveMCPRequireApprovalAPIEnum::OrSymbol
              )
            )
          )
        }
        attr_accessor :require_approval

        # An optional human-readable description of the MCP server.
        sig { returns(T.nilable(String)) }
        attr_accessor :server_description

        # A label used to identify the MCP server.
        sig { returns(T.nilable(String)) }
        attr_reader :server_label

        sig { params(server_label: String).void }
        attr_writer :server_label

        # The URL of the MCP server to connect to.
        sig { returns(T.nilable(String)) }
        attr_accessor :server_url

        # The Secure MCP Tunnel ID to use instead of a direct server URL.
        sig { returns(T.nilable(String)) }
        attr_accessor :tunnel_id

        # This value is omitted from returned Live session data.
        sig { returns(T.nilable(String)) }
        attr_accessor :authorization

        # Optional HTTP headers to send when connecting to the MCP server.
        sig { returns(T.nilable(T::Hash[Symbol, String])) }
        attr_accessor :headers

        sig do
          params(

            allowed_callers: T.nilable(T::Array[OpenAI::Live::McpTool::AllowedCaller::OrSymbol]),

            allowed_tools: T.nilable(T.any(T::Array[String], OpenAI::Live::McpToolFilter::OrHash)),

            authorization: T.nilable(String),

            connector_id: T.nilable(String),

            defer_loading: T.nilable(T::Boolean),

            headers: T.nilable(T::Hash[Symbol, String]),

            require_approval: T.nilable(
              T.any(
                OpenAI::Live::McpRequireApprovalFilter::OrHash,
                OpenAI::Live::McpTool::RequireApproval::LiveMCPRequireApprovalAPIEnum::OrSymbol
              )
            ),

            server_description: T.nilable(String),

            server_label: String,

            server_url: T.nilable(String),

            tunnel_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The tool invocation context(s).
          allowed_callers: nil,

          # A list of MCP tool names that are allowed for this server.
          allowed_tools: nil,

          # This value is omitted from returned Live session data.
          authorization: nil,

          # The ID of a built-in MCP connector. This field is deprecated for models released
          # after September 1, 2026. Use `server_url` to connect to a remote MCP server, or
          # `tunnel_id` to connect to a local MCP server.
          connector_id: nil,

          # Whether this MCP tool should be deferred and discovered via tool search.
          defer_loading: nil,

          # Optional HTTP headers to send when connecting to the MCP server.
          headers: nil,

          # Controls which MCP tools require explicit user approval before execution.
          require_approval: nil,

          # An optional human-readable description of the MCP server.
          server_description: nil,

          # A label used to identify the MCP server.
          server_label: nil,

          # The URL of the MCP server to connect to.
          server_url: nil,

          # The Secure MCP Tunnel ID to use instead of a direct server URL.
          tunnel_id: nil,

          type: :mcp
        )
        end

        sig do
          override.returns(
            {
              type: Symbol,
              allowed_callers: T.nilable(T::Array[OpenAI::Live::McpTool::AllowedCaller::OrSymbol]),
              allowed_tools: T.nilable(T.any(T::Array[String], OpenAI::Live::McpToolFilter)),
              authorization: T.nilable(String),
              connector_id: T.nilable(String),
              defer_loading: T.nilable(T::Boolean),
              headers: T.nilable(T::Hash[Symbol, String]),
              require_approval: T.nilable(
                T.any(
                  OpenAI::Live::McpRequireApprovalFilter,
                  OpenAI::Live::McpTool::RequireApproval::LiveMCPRequireApprovalAPIEnum::OrSymbol
                )
              ),
              server_description: T.nilable(String),
              server_label: String,
              server_url: T.nilable(String),
              tunnel_id: T.nilable(String)
            }
          )
        end
        def to_hash
        end

        module AllowedCaller
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::McpTool::AllowedCaller) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          DIRECT = T.let(:direct, OpenAI::Live::McpTool::AllowedCaller::TaggedSymbol)
          PROGRAMMATIC = T.let(:programmatic, OpenAI::Live::McpTool::AllowedCaller::TaggedSymbol)

          sig { override.returns(T::Array[OpenAI::Live::McpTool::AllowedCaller::TaggedSymbol]) }
          def self.values
          end
        end

        # A list of MCP tool names that are allowed for this server.
        module AllowedTools
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(T::Array[String], OpenAI::Live::McpToolFilter) }

          sig { override.returns(T::Array[OpenAI::Live::McpTool::AllowedTools::Variants]) }
          def self.variants
          end

          StringArray = T.let(
            OpenAI::Internal::Type::ArrayOf[String],
            OpenAI::Internal::Type::Converter
          )

        end

        # Controls which MCP tools require explicit user approval before execution.
        module RequireApproval
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias {
            T.any(
              OpenAI::Live::McpRequireApprovalFilter,
              OpenAI::Live::McpTool::RequireApproval::LiveMCPRequireApprovalAPIEnum::TaggedSymbol
            )
          }

          # Default approval behavior for MCP tool calls.
          module LiveMCPRequireApprovalAPIEnum
            extend OpenAI::Internal::Type::Enum

            TaggedSymbol = T.type_alias {
              T.all(Symbol, OpenAI::Live::McpTool::RequireApproval::LiveMCPRequireApprovalAPIEnum)
            }
            OrSymbol = T.type_alias { T.any(Symbol, String) }

            ALWAYS = T.let(:always, OpenAI::Live::McpTool::RequireApproval::LiveMCPRequireApprovalAPIEnum::TaggedSymbol)
            NEVER = T.let(:never, OpenAI::Live::McpTool::RequireApproval::LiveMCPRequireApprovalAPIEnum::TaggedSymbol)

            sig {
              override.returns(
                T::Array[OpenAI::Live::McpTool::RequireApproval::LiveMCPRequireApprovalAPIEnum::TaggedSymbol]
              )
            }
            def self.values
            end
          end

          sig { override.returns(T::Array[OpenAI::Live::McpTool::RequireApproval::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
