# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseMcpListToolsInProgressEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseMcpListToolsInProgressEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the MCP tool call item that is being processed.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that is being processed.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always 'response.mcp_list_tools.in_progress'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the system is in the process of retrieving the list of available
        # MCP tools.
        sig do
          params(
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The ID of the MCP tool call item that is being processed.
          item_id:,
          # The index of the output item that is being processed.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The type of the event. Always 'response.mcp_list_tools.in_progress'.
          type: :"response.mcp_list_tools.in_progress"
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
