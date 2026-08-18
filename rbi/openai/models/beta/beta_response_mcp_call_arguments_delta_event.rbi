# typed: strong

module OpenAI
  module Models
    BetaResponseMcpCallArgumentsDeltaEvent =
      Beta::BetaResponseMcpCallArgumentsDeltaEvent

    module Beta
      class BetaResponseMcpCallArgumentsDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseMcpCallArgumentsDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # A JSON string containing the partial update to the arguments for the MCP tool
        # call.
        sig { returns(String) }
        attr_accessor :delta

        # The unique identifier of the MCP tool call item being processed.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response's output array.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always 'response.mcp_call_arguments.delta'.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseMcpCallArgumentsDeltaEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseMcpCallArgumentsDeltaEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when there is a delta (partial update) to the arguments of an MCP tool
        # call.
        sig do
          params(
            delta: String,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseMcpCallArgumentsDeltaEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # A JSON string containing the partial update to the arguments for the MCP tool
          # call.
          delta:,
          # The unique identifier of the MCP tool call item being processed.
          item_id:,
          # The index of the output item in the response's output array.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always 'response.mcp_call_arguments.delta'.
          type: :"response.mcp_call_arguments.delta"
        )
        end

        sig do
          override.returns(
            {
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseMcpCallArgumentsDeltaEvent::Agent
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
                OpenAI::Beta::BetaResponseMcpCallArgumentsDeltaEvent::Agent,
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
