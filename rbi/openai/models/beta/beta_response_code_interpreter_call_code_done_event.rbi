# typed: strong

module OpenAI
  module Models
    BetaResponseCodeInterpreterCallCodeDoneEvent =
      Beta::BetaResponseCodeInterpreterCallCodeDoneEvent

    module Beta
      class BetaResponseCodeInterpreterCallCodeDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The final code snippet output by the code interpreter.
        sig { returns(String) }
        attr_accessor :code

        # The unique identifier of the code interpreter tool call item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item in the response for which the code is finalized.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event, used to order streaming events.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.code_interpreter_call_code.done`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when the code snippet is finalized by the code interpreter.
        sig do
          params(
            code: String,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The final code snippet output by the code interpreter.
          code:,
          # The unique identifier of the code interpreter tool call item.
          item_id:,
          # The index of the output item in the response for which the code is finalized.
          output_index:,
          # The sequence number of this event, used to order streaming events.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.code_interpreter_call_code.done`.
          type: :"response.code_interpreter_call_code.done"
        )
        end

        sig do
          override.returns(
            {
              code: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent::Agent
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
                OpenAI::Beta::BetaResponseCodeInterpreterCallCodeDoneEvent::Agent,
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
