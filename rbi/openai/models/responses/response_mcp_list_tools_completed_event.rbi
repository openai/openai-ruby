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

        # The type of the event. Always 'response.mcp_list_tools.completed'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the list of available MCP tools has been successfully retrieved.
        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(
          # The type of the event. Always 'response.mcp_list_tools.completed'.
          type: :"response.mcp_list_tools.completed"
        )
        end

        sig { override.returns({ type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
