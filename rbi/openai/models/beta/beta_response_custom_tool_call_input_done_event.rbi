# typed: strong

module OpenAI
  module Models
    BetaResponseCustomToolCallInputDoneEvent =
      Beta::BetaResponseCustomToolCallInputDoneEvent

    module Beta
      class BetaResponseCustomToolCallInputDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseCustomToolCallInputDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The complete input data for the custom tool call.
        sig { returns(String) }
        attr_accessor :input

        # Unique identifier for the API item associated with this event.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output this event applies to.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The event type identifier.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseCustomToolCallInputDoneEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseCustomToolCallInputDoneEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Event indicating that input for a custom tool call is complete.
        sig do
          params(
            input: String,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseCustomToolCallInputDoneEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The complete input data for the custom tool call.
          input:,
          # Unique identifier for the API item associated with this event.
          item_id:,
          # The index of the output this event applies to.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The event type identifier.
          type: :"response.custom_tool_call_input.done"
        )
        end

        sig do
          override.returns(
            {
              input: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseCustomToolCallInputDoneEvent::Agent
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
                OpenAI::Beta::BetaResponseCustomToolCallInputDoneEvent::Agent,
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
