# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeMcpApprovalRequest < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeMcpApprovalRequest,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the approval request.
        sig { returns(String) }
        attr_accessor :id

        # A JSON string of arguments for the tool.
        sig { returns(String) }
        attr_accessor :arguments

        # The name of the tool to run.
        sig { returns(String) }
        attr_accessor :name

        # The label of the MCP server making the request.
        sig { returns(String) }
        attr_accessor :server_label

        # The type of the item. Always `mcp_approval_request`.
        sig { returns(Symbol) }
        attr_accessor :type

        # A Realtime item requesting human approval of a tool invocation.
        sig do
          params(
            id: String,
            arguments: String,
            name: String,
            server_label: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the approval request.
          id:,
          # A JSON string of arguments for the tool.
          arguments:,
          # The name of the tool to run.
          name:,
          # The label of the MCP server making the request.
          server_label:,
          # The type of the item. Always `mcp_approval_request`.
          type: :mcp_approval_request
        )
        end

        sig do
          override.returns(
            {
              id: String,
              arguments: String,
              name: String,
              server_label: String,
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
