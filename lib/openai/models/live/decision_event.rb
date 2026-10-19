# frozen_string_literal: true

module OpenAI
  module Models
    module Live
      class DecisionEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute delegation_id
        #   The Live delegation ID, or null for a transcript trigger.
        #
        #   @return [String, nil]
        required :delegation_id, String, nil?: true

        # @!attribute event
        #
        #   @return [OpenAI::Models::Live::DecisionEvent::Event]
        required :event, -> { OpenAI::Live::DecisionEvent::Event }

        # @!attribute event_id
        #   The unique ID of this Live server event.
        #
        #   @return [String]
        required :event_id, String

        # @!attribute source_event_id
        #   The event_id of the transcript delta that fired this trigger, or null for a
        #   delegation.
        #
        #   @return [String, nil]
        required :source_event_id, String, nil?: true

        # @!attribute source_event_type
        #
        #   @return [Symbol, OpenAI::Models::Live::DecisionEvent::SourceEventType, nil]
        required :source_event_type, union: -> { OpenAI::Live::DecisionEvent::SourceEventType }, nil?: true

        # @!attribute trigger_id
        #   The Live-assigned ID of this trigger firing, or null for a delegation.
        #
        #   @return [String, nil]
        required :trigger_id, String, nil?: true

        # @!attribute type
        #
        #   @return [Symbol, :"decision.event"]
        required :type, const: :"decision.event"

        # @!method initialize(delegation_id:, event:, event_id:, source_event_id:, source_event_type:, trigger_id:, type: :"decision.event")
        #   A Decision API event for a Live delegation or transcript trigger. For a trigger,
        #   source_event_id identifies the transcript delta that caused this evaluation.
        #
        #   @param delegation_id [String, nil]
        #     The Live delegation ID, or null for a transcript trigger.
        #
        #   @param event [OpenAI::Models::Live::DecisionEvent::Event]
        #
        #   @param event_id [String]
        #     The unique ID of this Live server event.
        #
        #   @param source_event_id [String, nil]
        #     The event_id of the transcript delta that fired this trigger, or null for a
        #     delegation.
        #
        #   @param source_event_type [Symbol, OpenAI::Models::Live::DecisionEvent::SourceEventType, nil]
        #
        #   @param trigger_id [String, nil]
        #     The Live-assigned ID of this trigger firing, or null for a delegation.
        #
        #   @param type [Symbol, :"decision.event"]

        # @see OpenAI::Models::Live::DecisionEvent#event
        class Event < OpenAI::Internal::Type::BaseModel
          # @!attribute decision
          #   The native Decision API response, including its model, ordered answers, and
          #   token usage.
          #
          #   @return [OpenAI::Models::Decision]
          required :decision, -> { OpenAI::Decision }

          # @!attribute type
          #
          #   @return [Symbol, :"decision.completed"]
          required :type, const: :"decision.completed"

          # @!method initialize(decision:, type: :"decision.completed")
          #   @param decision [OpenAI::Models::Decision]
          #     The native Decision API response, including its model, ordered answers, and
          #     token usage.
          #
          #   @param type [Symbol, :"decision.completed"]
        end

        # @see OpenAI::Models::Live::DecisionEvent#source_event_type
        module SourceEventType
          extend OpenAI::Internal::Type::Union

          variant const: -> { OpenAI::Models::Live::DecisionEvent::SourceEventType::SESSION_INPUT_TRANSCRIPT_DELTA }

          variant const: -> { OpenAI::Models::Live::DecisionEvent::SourceEventType::SESSION_OUTPUT_TRANSCRIPT_DELTA }

          # @!method self.variants
          #   @return [Array(Symbol)]

          define_sorbet_constant!(:Variants) do
            T.type_alias { OpenAI::Live::DecisionEvent::SourceEventType::TaggedSymbol }
          end

          # @!group

          SESSION_INPUT_TRANSCRIPT_DELTA = :"session.input_transcript.delta"
          SESSION_OUTPUT_TRANSCRIPT_DELTA = :"session.output_transcript.delta"

          # @!endgroup
        end
      end
    end
  end
end
