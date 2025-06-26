# typed: strong

module OpenAI
  module Models
    module Responses
      class ToolChoiceMcp < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(OpenAI::Responses::ToolChoiceMcp, OpenAI::Internal::AnyHash)
          end

        # The label of the MCP server to use.
        sig { returns(String) }
        attr_accessor :server_label

        # For MCP tools, the type is always `mcp`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The name of the tool to call on the server.
        sig { returns(T.nilable(String)) }
        attr_accessor :name

        # Use this option to force the model to call a specific tool on a remote MCP
        # server.
        sig do
          params(
            server_label: String,
            name: T.nilable(String),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The label of the MCP server to use.
          server_label:,
          # The name of the tool to call on the server.
          name: nil,
          # For MCP tools, the type is always `mcp`.
          type: :mcp
        )
        end

        sig do
          override.returns(
            { server_label: String, type: Symbol, name: T.nilable(String) }
          )
        end
        def to_hash
        end
      end
    end
  end
end
