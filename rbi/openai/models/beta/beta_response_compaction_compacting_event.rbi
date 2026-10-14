# typed: strong

module OpenAI
  module Models

    BetaResponseCompactionCompactingEvent = Beta::BetaResponseCompactionCompactingEvent

    module Beta

      class BetaResponseCompactionCompactingEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Beta::BetaResponseCompactionCompactingEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The ID of the compaction output item.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the compaction output item.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of the event that was emitted.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event, always `response.compaction.compacting`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig { returns(T.nilable(OpenAI::Beta::BetaResponseCompactionCompactingEvent::Agent)) }
        attr_reader :agent

        sig { params(agent: OpenAI::Beta::BetaResponseCompactionCompactingEvent::Agent::OrHash).void }
        attr_writer :agent

        # Emitted when new summary content is sampled for a compaction trigger. Contains
        # no summary content.
        sig do
          params(

            item_id: String,

            output_index: Integer,

            sequence_number: Integer,

            agent: OpenAI::Beta::BetaResponseCompactionCompactingEvent::Agent::OrHash,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The ID of the compaction output item.
          item_id:,

          # The index of the compaction output item.
          output_index:,

          # The sequence number of the event that was emitted.
          sequence_number:,

          # The agent that owns this multi-agent streaming event.
          agent: nil,

          # The type of the event, always `response.compaction.compacting`.

          type: :"response.compaction.compacting"
        )
        end

        sig do
          override.returns(
            {
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              agent: OpenAI::Beta::BetaResponseCompactionCompactingEvent::Agent
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseCompactionCompactingEvent::Agent,
              OpenAI::Internal::AnyHash
            )
          end

          # The canonical name of the agent that produced this item.
          sig { returns(String) }
          attr_accessor :agent_name

          # The agent that owns this multi-agent streaming event.
          sig do
            params(

              agent_name: String
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The canonical name of the agent that produced this item.

            agent_name:
          )
          end

          sig do
            override.returns(
              {agent_name: String}
            )
          end
          def to_hash
          end

        end

      end

    end

  end
end
