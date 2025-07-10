# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseMcpCallArgumentsDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseMcpCallArgumentsDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The finalized arguments for the MCP tool call.
        sig { returns(T.anything) }
        attr_accessor :arguments

        # The unique identifier of the MCP tool call item being processed.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response's output array.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always 'response.mcp_call_arguments.done'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the arguments for an MCP tool call are finalized.
        sig do
          params(
            arguments: T.anything,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The finalized arguments for the MCP tool call.
          arguments:,
          # The unique identifier of the MCP tool call item being processed.
          item_id:,
          # The index of the output item in the response's output array.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The type of the event. Always 'response.mcp_call_arguments.done'.
          type: :"response.mcp_call_arguments.done"
        )
        end

        sig do
          override.returns(
            {
              arguments: T.anything,
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
