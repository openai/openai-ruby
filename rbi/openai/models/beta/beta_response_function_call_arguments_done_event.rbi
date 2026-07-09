# typed: strong

module OpenAI
  module Models
    BetaResponseFunctionCallArgumentsDoneEvent =
      Beta::BetaResponseFunctionCallArgumentsDoneEvent

    module Beta
      class BetaResponseFunctionCallArgumentsDoneEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseFunctionCallArgumentsDoneEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The function-call arguments.
        sig { returns(String) }
        attr_accessor :arguments

        # The ID of the item.
        sig { returns(String) }
        attr_accessor :item_id

        # The name of the function that was called.
        sig { returns(String) }
        attr_accessor :name

        # The index of the output item.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseFunctionCallArgumentsDoneEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseFunctionCallArgumentsDoneEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when function-call arguments are finalized.
        sig do
          params(
            arguments: String,
            item_id: String,
            name: String,
            output_index: Integer,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseFunctionCallArgumentsDoneEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The function-call arguments.
          arguments:,
          # The ID of the item.
          item_id:,
          # The name of the function that was called.
          name:,
          # The index of the output item.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          type: :"response.function_call_arguments.done"
        )
        end

        sig do
          override.returns(
            {
              arguments: String,
              item_id: String,
              name: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              agent:
                T.nilable(
                  OpenAI::Beta::BetaResponseFunctionCallArgumentsDoneEvent::Agent
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
                OpenAI::Beta::BetaResponseFunctionCallArgumentsDoneEvent::Agent,
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
