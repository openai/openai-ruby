# typed: strong

module OpenAI
  module Models
    module Realtime
      class ResponseMcpCallInProgress < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ResponseMcpCallInProgress,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the MCP tool call item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The event type, must be `response.mcp_call.in_progress`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when an MCP tool call has started and is in progress.
        sig do
          params(
            event_id: String,
            item_id: String,
            output_index: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # The ID of the MCP tool call item.
          item_id:,
          # The index of the output item in the response.
          output_index:,
          # The event type, must be `response.mcp_call.in_progress`.
          type: :"response.mcp_call.in_progress"
        )
        end

        sig do
          override.returns(
            {
              event_id: String,
              item_id: String,
              output_index: Integer,
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
