# typed: strong

module OpenAI
  module Models

    module Beta

      class AgentMcpCallItem < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::AgentMcpCallItem,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the MCP call item.
        sig { returns(String) }
        attr_accessor :id

        # The arguments passed to the MCP tool.
        sig { returns(T.anything) }
        attr_accessor :arguments

        # The error returned by the MCP tool, if any.
        sig { returns(T.anything) }
        attr_accessor :error

        # The name of the MCP tool.
        sig { returns(String) }
        attr_accessor :name

        # The output returned by the MCP tool, if any.
        sig { returns(T.anything) }
        attr_accessor :output

        # The label of the MCP server.
        sig { returns(String) }
        attr_accessor :server_label

        # The status of the MCP tool call.
        sig { returns(OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol) }
        attr_accessor :status

        # The ID of the turn that contains this item.
        sig { returns(String) }
        attr_accessor :turn_id

        # The item type. Always `mcp_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A call to a tool on an MCP server.
        sig do
          params(

            id: String,

            arguments: T.anything,

            error: T.anything,

            name: String,

            output: T.anything,

            server_label: String,

            status: OpenAI::Beta::AgentFunctionCallStatus::OrSymbol,

            turn_id: String,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the MCP call item.
          id:,

          # The arguments passed to the MCP tool.
          arguments:,

          # The error returned by the MCP tool, if any.
          error:,

          # The name of the MCP tool.
          name:,

          # The output returned by the MCP tool, if any.
          output:,

          # The label of the MCP server.
          server_label:,

          # The status of the MCP tool call.
          status:,

          # The ID of the turn that contains this item.
          turn_id:,

          # The item type. Always `mcp_call`.

          type: :mcp_call
        )
        end

        sig do
          override.returns(
            {
              id: String,
              arguments: T.anything,
              error: T.anything,
              name: String,
              output: T.anything,
              server_label: String,
              status: OpenAI::Beta::AgentFunctionCallStatus::TaggedSymbol,
              turn_id: String,
              type: Symbol
            }
          )
        end
        def to_hash
        end

      end

    end

  end
end
