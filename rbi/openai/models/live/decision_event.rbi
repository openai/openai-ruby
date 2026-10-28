# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionEvent < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionEvent,
            OpenAI::Internal::AnyHash
          )
        end

        # The Live delegation ID, or null for a transcript trigger.
        sig { returns(T.nilable(String)) }
        attr_accessor :delegation_id

        sig { returns(OpenAI::Live::DecisionEvent::Event) }
        attr_reader :event

        sig { params(event: OpenAI::Live::DecisionEvent::Event::OrHash).void }
        attr_writer :event

        # The unique ID of this Live server event.
        sig { returns(String) }
        attr_accessor :event_id

        # The event_id of the transcript delta that fired this trigger, or null for a
        # delegation.
        sig { returns(T.nilable(String)) }
        attr_accessor :source_event_id

        sig { returns(T.nilable(OpenAI::Live::DecisionEvent::SourceEventType::Variants)) }
        attr_reader :source_event_type

        sig { params(source_event_type: T.nilable(OpenAI::Live::DecisionEvent::SourceEventType::OrSymbol)).void }
        attr_writer :source_event_type

        # The Live-assigned ID of this trigger firing, or null for a delegation.
        sig { returns(T.nilable(String)) }
        attr_accessor :trigger_id

        sig { returns(Symbol) }
        attr_accessor :type

        # A Decision API event for a Live delegation or transcript trigger. For a trigger,
        # source_event_id identifies the transcript delta that caused this evaluation.
        sig do
          params(

            delegation_id: T.nilable(String),

            event: OpenAI::Live::DecisionEvent::Event::OrHash,

            event_id: String,

            source_event_id: T.nilable(String),

            source_event_type: T.nilable(OpenAI::Live::DecisionEvent::SourceEventType::OrSymbol),

            trigger_id: T.nilable(String),

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # The Live delegation ID, or null for a transcript trigger.
          delegation_id:,

          event:,

          # The unique ID of this Live server event.
          event_id:,

          # The event_id of the transcript delta that fired this trigger, or null for a
          # delegation.
          source_event_id:,

          source_event_type:,

          # The Live-assigned ID of this trigger firing, or null for a delegation.
          trigger_id:,

          type: :"decision.event"
        )
        end

        sig do
          override.returns(
            {
              delegation_id: T.nilable(String),
              event: OpenAI::Live::DecisionEvent::Event,
              event_id: String,
              source_event_id: T.nilable(String),
              source_event_type: T.nilable(OpenAI::Live::DecisionEvent::SourceEventType::Variants),
              trigger_id: T.nilable(String),
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Event < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::DecisionEvent::Event,
              OpenAI::Internal::AnyHash
            )
          end

          # The native Decision API response, including its model, ordered answers, and
          # token usage.
          sig { returns(OpenAI::Decision) }
          attr_reader :decision

          sig { params(decision: OpenAI::Decision::OrHash).void }
          attr_writer :decision

          sig { returns(Symbol) }
          attr_accessor :type

          sig do
            params(

              decision: OpenAI::Decision::OrHash,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # The native Decision API response, including its model, ordered answers, and
            # token usage.
            decision:,

            type: :"decision.completed"
          )
          end

          sig do
            override.returns(
              {decision: OpenAI::Decision, type: Symbol}
            )
          end
          def to_hash
          end

        end

        module SourceEventType
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { OpenAI::Live::DecisionEvent::SourceEventType::TaggedSymbol }

          sig { override.returns(T::Array[OpenAI::Live::DecisionEvent::SourceEventType::Variants]) }
          def self.variants
          end

          TaggedSymbol = T.type_alias do
            T.all(Symbol, OpenAI::Live::DecisionEvent::SourceEventType)
          end

          OrSymbol = T.type_alias { T.any(Symbol, String) }

          SESSION_INPUT_TRANSCRIPT_DELTA = T.let(
            :"session.input_transcript.delta",
            OpenAI::Live::DecisionEvent::SourceEventType::TaggedSymbol
          )
          SESSION_OUTPUT_TRANSCRIPT_DELTA = T.let(
            :"session.output_transcript.delta",
            OpenAI::Live::DecisionEvent::SourceEventType::TaggedSymbol
          )

        end

      end

    end

  end
end
