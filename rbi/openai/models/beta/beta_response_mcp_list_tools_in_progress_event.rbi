# typed: strong

module OpenAI
  module Models
    BetaResponseMcpListToolsInProgressEvent =
      Beta::BetaResponseMcpListToolsInProgressEvent

    module Beta
      class BetaResponseMcpListToolsInProgressEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseMcpListToolsInProgressEvent,
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

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseMcpListToolsInProgressEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseMcpListToolsInProgressEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when the system is in the process of retrieving the list of available
        # MCP tools.
        sig do
          params(
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseMcpListToolsInProgressEvent::Agent::OrHash
              ),
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
          # The agent that owns this multi-agent streaming event.
          agent: nil,
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
              type: Symbol,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseMcpListToolsInProgressEvent::Agent
                )
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseMcpListToolsInProgressEvent::Agent,
                OpenAI::Internal::AnyHash
              )
            end

          # The canonical name of the agent that produced this item.
          sig { returns(String) }
          attr_accessor :agent_name

          # The agent that owns this multi-agent streaming event.
          sig { params(agent_name: String).returns(T.attached_class) }
          def self.new(
            # The canonical name of the agent that produced this item.
            agent_name:
          )
          end

          sig { override.returns({ agent_name: String }) }
          def to_hash
          end
        end
      end
    end
  end
end
