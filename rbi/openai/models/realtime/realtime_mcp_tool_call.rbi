# typed: strong

module OpenAI
  module Models
    module Realtime
      class RealtimeMcpToolCall < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::RealtimeMcpToolCall,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the tool call.
        sig { returns(String) }
        attr_accessor :id

        # A JSON string of the arguments passed to the tool.
        sig { returns(String) }
        attr_accessor :arguments

        # The name of the tool that was run.
        sig { returns(String) }
        attr_accessor :name

        # The label of the MCP server running the tool.
        sig { returns(String) }
        attr_accessor :server_label

        # The type of the item. Always `mcp_tool_call`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The ID of an associated approval request, if any.
        sig { returns(T.nilable(String)) }
        attr_accessor :approval_request_id

        # The error from the tool call, if any.
        sig do
          returns(
            T.nilable(
              T.any(
                OpenAI::Realtime::RealtimeMcpProtocolError,
                OpenAI::Realtime::RealtimeMcpToolExecutionError,
                OpenAI::Realtime::RealtimeMcphttpError
              )
            )
          )
        end
        attr_accessor :error

        # The output from the tool call.
        sig { returns(T.nilable(String)) }
        attr_accessor :output

        # A Realtime item representing an invocation of a tool on an MCP server.
        sig do
          params(
            id: String,
            arguments: String,
            name: String,
            server_label: String,
            approval_request_id: T.nilable(String),
            error:
              T.nilable(
                T.any(
                  OpenAI::Realtime::RealtimeMcpProtocolError::OrHash,
                  OpenAI::Realtime::RealtimeMcpToolExecutionError::OrHash,
                  OpenAI::Realtime::RealtimeMcphttpError::OrHash
                )
              ),
            output: T.nilable(String),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the tool call.
          id:,
          # A JSON string of the arguments passed to the tool.
          arguments:,
          # The name of the tool that was run.
          name:,
          # The label of the MCP server running the tool.
          server_label:,
          # The ID of an associated approval request, if any.
          approval_request_id: nil,
          # The error from the tool call, if any.
          error: nil,
          # The output from the tool call.
          output: nil,
          # The type of the item. Always `mcp_tool_call`.
          type: :mcp_tool_call
        )
        end

        sig do
          override.returns(
            {
              id: String,
              arguments: String,
              name: String,
              server_label: String,
              type: Symbol,
              approval_request_id: T.nilable(String),
              error:
                T.nilable(
                  T.any(
                    OpenAI::Realtime::RealtimeMcpProtocolError,
                    OpenAI::Realtime::RealtimeMcpToolExecutionError,
                    OpenAI::Realtime::RealtimeMcphttpError
                  )
                ),
              output: T.nilable(String)
            }
          )
        end
        def to_hash
        end

        # The error from the tool call, if any.
        module Error
          extend OpenAI::Internal::Type::Union

          Variants =
            T.type_alias do
              T.any(
                OpenAI::Realtime::RealtimeMcpProtocolError,
                OpenAI::Realtime::RealtimeMcpToolExecutionError,
                OpenAI::Realtime::RealtimeMcphttpError
              )
            end

          sig do
            override.returns(
              T::Array[OpenAI::Realtime::RealtimeMcpToolCall::Error::Variants]
            )
          end
          def self.variants
          end
        end
      end
    end
  end
end
