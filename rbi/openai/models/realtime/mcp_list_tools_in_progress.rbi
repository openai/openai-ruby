# typed: strong

module OpenAI
  module Models
    module Realtime
      class McpListToolsInProgress < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::McpListToolsInProgress,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique ID of the server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The ID of the MCP list tools item.
        sig { returns(String) }
        attr_accessor :item_id

        # The event type, must be `mcp_list_tools.in_progress`.
        sig { returns(Symbol) }
        attr_accessor :type

        # Returned when listing MCP tools is in progress for an item.
        sig do
          params(event_id: String, item_id: String, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # The unique ID of the server event.
          event_id:,
          # The ID of the MCP list tools item.
          item_id:,
          # The event type, must be `mcp_list_tools.in_progress`.
          type: :"mcp_list_tools.in_progress"
        )
        end

        sig do
          override.returns({ event_id: String, item_id: String, type: Symbol })
        end
        def to_hash
        end
      end
    end
  end
end
