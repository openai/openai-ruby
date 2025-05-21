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

        # The type of the event. Always 'response.mcp_list_tools.in_progress'.
        sig { returns(Symbol) }
        attr_accessor :type

        # Emitted when the system is in the process of retrieving the list of available
        # MCP tools.
        sig { params(type: Symbol).returns(T.attached_class) }
        def self.new(
          # The type of the event. Always 'response.mcp_list_tools.in_progress'.
          type: :"response.mcp_list_tools.in_progress"
        )
        end

        sig { override.returns({ type: Symbol }) }
        def to_hash
        end
      end
    end
  end
end
