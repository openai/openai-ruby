# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseMcpListToolsCompletedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseMcpListToolsCompletedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the MCP tool call item that produced this output.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that was processed.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always 'response.mcp_list_tools.completed'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the list of available MCP tools has been successfully retrieved.
        sig do
          params(
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The ID of the MCP tool call item that produced this output.
          item_id:,
          # The index of the output item that was processed.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The type of the event. Always 'response.mcp_list_tools.completed'.
          type: :"response.mcp_list_tools.completed"
        )
        end

        sig do
          override.returns(
            {
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
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
