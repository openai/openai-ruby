# typed: strong

module OpenAI
  module Models
    BetaResponseRefusalDeltaEvent = Beta::BetaResponseRefusalDeltaEvent

    module Beta
      class BetaResponseRefusalDeltaEvent < OpenAI::Internal::Type::BaseModel
        OrHash =
          T.type_alias do
            T.any(
              OpenAI::Beta::BetaResponseRefusalDeltaEvent,
              OpenAI::Internal::AnyHash
            )
          end

        # The index of the content part that the refusal text is added to.
        sig { returns(Integer) }
        attr_accessor :content_index

        # The refusal text that is added.
        sig { returns(String) }
        attr_accessor :delta

        # The ID of the output item that the refusal text is added to.
        sig { returns(String) }
        attr_accessor :item_id

        # The index of the output item that the refusal text is added to.
        sig { returns(Integer) }
        attr_accessor :output_index

        # The sequence number of this event.
        sig { returns(Integer) }
        attr_accessor :sequence_number

        # The type of the event. Always `response.refusal.delta`.
        sig { returns(Symbol) }
        attr_accessor :type

        # The agent that owns this multi-agent streaming event.
        sig do
          returns(T.nilable(OpenAI::Beta::BetaResponseRefusalDeltaEvent::Agent))
        end
        attr_reader :agent

        sig do
          params(
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseRefusalDeltaEvent::Agent::OrHash
              )
          ).void
        end
        attr_writer :agent

        # Emitted when there is a partial refusal text.
        sig do
          params(
            content_index: Integer,
            delta: String,
            item_id: String,
            output_index: Integer,
            sequence_number: Integer,
            agent:
              T.nilable(
                OpenAI::Beta::BetaResponseRefusalDeltaEvent::Agent::OrHash
              ),
            type: Symbol
          ).returns(T.attached_class)
        end
        def self.new(
          # The index of the content part that the refusal text is added to.
          content_index:,
          # The refusal text that is added.
          delta:,
          # The ID of the output item that the refusal text is added to.
          item_id:,
          # The index of the output item that the refusal text is added to.
          output_index:,
          # The sequence number of this event.
          sequence_number:,
          # The agent that owns this multi-agent streaming event.
          agent: nil,
          # The type of the event. Always `response.refusal.delta`.
          type: :"response.refusal.delta"
        )
        end

        sig do
          override.returns(
            {
              content_index: Integer,
              delta: String,
              item_id: String,
              output_index: Integer,
              sequence_number: Integer,
              type: Symbol,
              agent:
                T.nilable(OpenAI::Beta::BetaResponseRefusalDeltaEvent::Agent)
            }
          )
        end
        def to_hash
        end

        class Agent < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::BetaResponseRefusalDeltaEvent::Agent,
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
