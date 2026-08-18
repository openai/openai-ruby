# typed: strong

module OpenAI
  module Models
    BetaResponseWebSearchCallSearchingEvent =
      Beta::BetaResponseWebSearchCallSearchingEvent

    module Beta
      class BetaResponseWebSearchCallSearchingEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseWebSearchCallSearchingEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # Unique ID for the output item associated with the web search call.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the web search call is associated with.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of the web search call being processed.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.web_search_call.searching`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(
            T.nilable(
              OpenAI::Beta::BetaResponseWebSearchCallSearchingEvent::Agent
            )
          )
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseWebSearchCallSearchingEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when a web search call is executing.
        sig do
          params(
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseWebSearchCallSearchingEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # Unique ID for the output item associated with the web search call.
          item_id:,
          # The index of the output item that the web search call is associated with.
          output_index:,
          # The sequence number of the web search call being processed.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.web_search_call.searching`.
          type: :"response.web_search_call.searching"
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
                  OpenAI::Beta::BetaResponseWebSearchCallSearchingEvent::Agent
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
                OpenAI::Beta::BetaResponseWebSearchCallSearchingEvent::Agent,
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
