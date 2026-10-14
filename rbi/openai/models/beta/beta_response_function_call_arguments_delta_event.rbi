# typed: strong

module OpenAI
  module Models
    BetaResponseFunctionCallArgumentsDeltaEvent =
      Beta::BetaResponseFunctionCallArgumentsDeltaEvent

    module Beta
      class BetaResponseFunctionCallArgumentsDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseFunctionCallArgumentsDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The function-call arguments delta that is added.
        sig { returns(String) }
        attr_accessor :delta

        # The ID of the output item that the function-call arguments delta is added to.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the function-call arguments delta is added to.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.function_call_arguments.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseFunctionCallArgumentsDeltaEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseFunctionCallArgumentsDeltaEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when there is a partial function-call arguments delta.
        sig do
          params(
            delta: String,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseFunctionCallArgumentsDeltaEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The function-call arguments delta that is added.
          delta:,
          # The ID of the output item that the function-call arguments delta is added to.
          item_id:,
          # The index of the output item that the function-call arguments delta is added to.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.function_call_arguments.delta`.
          type: :"response.function_call_arguments.delta"
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
                  OpenAI::Beta::BetaResponseFunctionCallArgumentsDeltaEvent::Agent
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
                OpenAI::Beta::BetaResponseFunctionCallArgumentsDeltaEvent::Agent,
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
