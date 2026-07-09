# typed: strong

module OpenAI
  module Models
    BetaResponseFileSearchCallInProgressEvent =
      Beta::BetaResponseFileSearchCallInProgressEvent

    module Beta
      class BetaResponseFileSearchCallInProgressEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseFileSearchCallInProgressEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The ID of the output item that the file search call is initiated.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the file search call is initiated.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.file_search_call.in_progress`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseFileSearchCallInProgressEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseFileSearchCallInProgressEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when a file search call is initiated.
        sig do
          params(
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseFileSearchCallInProgressEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The ID of the output item that the file search call is initiated.
          item_id:,
          # The index of the output item that the file search call is initiated.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.file_search_call.in_progress`.
          type: :"response.file_search_call.in_progress"
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
                  OpenAI::Beta::BetaResponseFileSearchCallInProgressEvent::Agent
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
                OpenAI::Beta::BetaResponseFileSearchCallInProgressEvent::Agent,
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
