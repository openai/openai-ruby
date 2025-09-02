# typed: strong

module OpenAI
  module Models
    module Realtime
      class ResponseMcpCallArgumentsDelta < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Realtime::ResponseMcpCallArgumentsDelta,
              OpenAI::Internal::AnyHash
            )
          end

        # The JSON-encoded arguments delta.
        sig { returns(String) }
        attr_accessor :delta

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

        # The event type, must be `response.mcp_call_arguments.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # If present, indicates the delta text was obfuscated.
        sig { returns(T.nilable(String)) }
        attr_accessor :obfuscation

        # Returned when MCP tool call arguments are updated during response generation.
        sig do
          params(
            delta: String,
            event_id: String,
            item_id: String,
            output_index: Integer,
            response_id: String,
            obfuscation: T.nilable(String),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The JSON-encoded arguments delta.
          delta:,
          # The unique ID of the server event.
          event_id:,
          # The ID of the MCP tool call item.
          item_id:,
          # The index of the output item in the response.
          output_index:,
          # The ID of the response.
          response_id:,
          # If present, indicates the delta text was obfuscated.
          obfuscation: nil,
          # The event type, must be `response.mcp_call_arguments.delta`.
          type: :"response.mcp_call_arguments.delta"
        )
        end

        sig do
          override.returns(
            {
              delta: String,
              event_id: String,
              item_id: String,
              output_index: Integer,
              response_id: String,
              type: Symbol,
              obfuscation: T.nilable(String)
            }
          )
        end
        def to_hash
        end
      end
    end
  end
end
