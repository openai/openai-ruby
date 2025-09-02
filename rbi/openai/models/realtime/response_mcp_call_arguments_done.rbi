# typed: strong

module OpenAI
  module Models
    module Realtime
      class ResponseMcpCallArgumentsDone < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ResponseMcpCallArgumentsDone,
              OpenAI::Internal::AnyHash
            )
          end

        # The final JSON-encoded arguments string.
        sig { returns(String) }
        attr_accessor :arguments

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the MCP tool call item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The ID of the response.
        sig { returns(String) }
        attr_accessor :response_id

        # The event type, must be `response.mcp_call_arguments.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when MCP tool call arguments are finalized during response generation.
        sig do
          params(
            arguments: String,
            event_id: String,
            item_id: String,
            output_index: Integer,
            response_id: String,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The final JSON-encoded arguments string.
          arguments:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the MCP tool call item.
          item_id:,
          # The index of the output item in the response.
          output_index:,
          # The ID of the response.
          response_id:,
          # The event type, must be `response.mcp_call_arguments.done`.
          type: :"response.mcp_call_arguments.done"
        )
        end

        sig do
          override.returns(
            {
              arguments: String,
              event_id: String,
              item_id: String,
              output_index: Integer,
              response_id: String,
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
