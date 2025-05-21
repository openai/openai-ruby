# typed: strong

module OpenAI
  module Models
    module Responses
      class ResponseMcpListToolsFailedEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Responses::ResponseMcpListToolsFailedEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The type of the event. Always 'response.mcp_list_tools.failed'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the attempt to list available MCP tools has failed.
        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(
          # The type of the event. Always 'response.mcp_list_tools.failed'.
          type: :"response.mcp_list_tools.failed"
        )
        end

        sig { override.returns({ type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
