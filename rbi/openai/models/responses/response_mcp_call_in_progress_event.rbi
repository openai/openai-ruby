# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseMcpCallInProgressEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseMcpCallInProgressEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The unique identifier of the MCP tool call item being processed.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response's output array.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The type of the event. Always 'response.mcp_call.in_progress'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when an MCP tool call is in progress.
        sig do
          params(item_id: String, output_index: Integer, type: Symbol).returns(
            T.attached_class
          )
        end
        def self.new(
          # The unique identifier of the MCP tool call item being processed.
          item_id:,
          # The index of the output item in the response's output array.
          output_index:,
          # The type of the event. Always 'response.mcp_call.in_progress'.
          type: :"response.mcp_call.in_progress"
        )
        end

        sig do
          override.returns(
            { item_id: String, output_index: Integer, type: Symbol }
          )
        end
        def to_hash
        end
      end
    end
  end
end
