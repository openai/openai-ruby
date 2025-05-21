# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseMcpCallCompletedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseMcpCallCompletedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The type of the event. Always 'response.mcp_call.completed'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when an MCP tool call has completed successfully.
        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(
          # The type of the event. Always 'response.mcp_call.completed'.
          type: :"response.mcp_call.completed"
        )
        end

        sig { override.returns({ type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
