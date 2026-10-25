# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionTrigger < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionTrigger,
            OpenAI::Internal::AnyHash
          )
        end

        # Questions evaluated using the current transcript and the session's shared
        # Decision items.
        sig { returns(OpenAI::Live::DecisionTrigger::Decisions) }
        attr_reader :decisions

        sig { params(decisions: OpenAI::Live::DecisionTrigger::Decisions::OrHash).void }
        attr_writer :decisions

        sig { returns(OpenAI::Live::DecisionTrigger::EventType::OrSymbol) }
        attr_accessor :event_type

        sig { returns(Symbol) }
        attr_accessor :type

        sig do
          params(

            decisions: OpenAI::Live::DecisionTrigger::Decisions::OrHash,

            event_type: OpenAI::Live::DecisionTrigger::EventType::OrSymbol,

            type: Symbol
          )
            .returns(T.attached_class)
        end
        def self.new(

          # Questions evaluated using the current transcript and the session's shared
          # Decision items.
          decisions:,

          event_type:,

          type: :decisions
        )
        end

        sig do
          override.returns(
            {
              decisions: OpenAI::Live::DecisionTrigger::Decisions,
              event_type: OpenAI::Live::DecisionTrigger::EventType::OrSymbol,
              type: Symbol
            }
          )
        end
        def to_hash
        end

        class Decisions < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::DecisionTrigger::Decisions,
              OpenAI::Internal::AnyHash
            )
          end

          # Native Decision API questions evaluated together, in order.
          sig {
            returns(
              T::Array[
                T.any(
                  OpenAI::Live::DecisionQuestion::Choice,
                  OpenAI::Live::DecisionQuestion::Predicate,
                  OpenAI::Live::DecisionQuestion::Score
                )
              ]
            )
          }
          attr_accessor :questions

          # Questions evaluated using the current transcript and the session's shared
          # Decision items.
          sig do
            params(

              questions: T::Array[
                T.any(
                  OpenAI::Live::DecisionQuestion::Choice::OrHash,
                  OpenAI::Live::DecisionQuestion::Predicate::OrHash,
                  OpenAI::Live::DecisionQuestion::Score::OrHash
                )
              ]
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Native Decision API questions evaluated together, in order.

            questions:
          )
          end

          sig do
            override.returns(
              {
                questions: T::Array[
                  T.any(
                    OpenAI::Live::DecisionQuestion::Choice,
                    OpenAI::Live::DecisionQuestion::Predicate,
                    OpenAI::Live::DecisionQuestion::Score
                  )
                ]
              }
            )
          end
          def to_hash
          end

        end

        module EventType
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Live::DecisionTrigger::EventType) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          SESSION_INPUT_TRANSCRIPT_DELTA = T.let(
            :"session.input_transcript.delta",
            OpenAI::Live::DecisionTrigger::EventType::TaggedSymbol
          )
          SESSION_OUTPUT_TRANSCRIPT_DELTA = T.let(
            :"session.output_transcript.delta",
            OpenAI::Live::DecisionTrigger::EventType::TaggedSymbol
          )

          sig { override.returns(T::Array[OpenAI::Live::DecisionTrigger::EventType::TaggedSymbol]) }
          def self.values
          end
        end

      end

    end

  end
end
