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
                  OpenAI::Live::DecisionTrigger::Decisions::Question::Predicate,
                  OpenAI::Live::DecisionTrigger::Decisions::Question::Choice,
                  OpenAI::Live::DecisionTrigger::Decisions::Question::Score
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
                  OpenAI::Live::DecisionTrigger::Decisions::Question::Predicate::OrHash,
                  OpenAI::Live::DecisionTrigger::Decisions::Question::Choice::OrHash,
                  OpenAI::Live::DecisionTrigger::Decisions::Question::Score::OrHash
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
                    OpenAI::Live::DecisionTrigger::Decisions::Question::Predicate,
                    OpenAI::Live::DecisionTrigger::Decisions::Question::Choice,
                    OpenAI::Live::DecisionTrigger::Decisions::Question::Score
                  )
                ]
              }
            )
          end
          def to_hash
          end

          # A question about the request's input, with an optional correlation name.
          module Question
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias {
              T.any(
                OpenAI::Live::DecisionTrigger::Decisions::Question::Predicate,
                OpenAI::Live::DecisionTrigger::Decisions::Question::Choice,
                OpenAI::Live::DecisionTrigger::Decisions::Question::Score
              )
            }

            class Predicate < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Live::DecisionTrigger::Decisions::Question::Predicate,
                  OpenAI::Internal::AnyHash
                )
              end

              sig { returns(OpenAI::Live::DecisionTrigger::Decisions::Question::Predicate::Instructions::Variants) }
              attr_accessor :instructions

              # The type of the object. Always `predicate`.
              sig { returns(Symbol) }
              attr_accessor :type

              sig { returns(T.nilable(String)) }
              attr_reader :name

              sig { params(name: String).void }
              attr_writer :name

              # Estimate how likely it is that a statement about the input is true.
              sig do
                params(

                  instructions: OpenAI::Live::DecisionTrigger::Decisions::Question::Predicate::Instructions::Variants,

                  name: String,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                instructions:,

                name: nil,

                # The type of the object. Always `predicate`.

                type: :predicate
              )
              end

              sig do
                override.returns(
                  {
                    instructions: OpenAI::Live::DecisionTrigger::Decisions::Question::Predicate::Instructions::Variants,
                    type: Symbol,
                    name: String
                  }
                )
              end
              def to_hash
              end

              module Instructions
                extend OpenAI::Internal::Type::Union

                Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionQuestionInputPart::Variants]) }

                sig {
                  override.returns(
                    T::Array[OpenAI::Live::DecisionTrigger::Decisions::Question::Predicate::Instructions::Variants]
                  )
                }
                def self.variants
                end

                DecisionQuestionInputPartArray = T.let(
                  OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionQuestionInputPart],
                  OpenAI::Internal::Type::Converter
                )

              end
            end

            class Choice < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Live::DecisionTrigger::Decisions::Question::Choice,
                  OpenAI::Internal::AnyHash
                )
              end

              # Provide between 2 and 255 choices. Each choice must be unique.
              sig { returns(T::Array[OpenAI::Live::DecisionTrigger::Decisions::Question::Choice::Choice]) }
              attr_accessor :choices

              sig { returns(OpenAI::Live::DecisionTrigger::Decisions::Question::Choice::Instructions::Variants) }
              attr_accessor :instructions

              # The type of the object. Always `choice`.
              sig { returns(Symbol) }
              attr_accessor :type

              sig { returns(T.nilable(String)) }
              attr_reader :name

              sig { params(name: String).void }
              attr_writer :name

              # Choose from the supplied options based on the input.
              sig do
                params(

                  choices: T::Array[OpenAI::Live::DecisionTrigger::Decisions::Question::Choice::Choice::OrHash],

                  instructions: OpenAI::Live::DecisionTrigger::Decisions::Question::Choice::Instructions::Variants,

                  name: String,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                # Provide between 2 and 255 choices. Each choice must be unique.
                choices:,

                instructions:,

                name: nil,

                # The type of the object. Always `choice`.

                type: :choice
              )
              end

              sig do
                override.returns(
                  {
                    choices: T::Array[OpenAI::Live::DecisionTrigger::Decisions::Question::Choice::Choice],
                    instructions: OpenAI::Live::DecisionTrigger::Decisions::Question::Choice::Instructions::Variants,
                    type: Symbol,
                    name: String
                  }
                )
              end
              def to_hash
              end

              class Choice < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Live::DecisionTrigger::Decisions::Question::Choice::Choice,
                    OpenAI::Internal::AnyHash
                  )
                end

                # Choice values are typed: a string and a boolean with the same text are distinct.
                sig { returns(T.any(String, T::Boolean)) }
                attr_accessor :value

                sig { returns(T.nilable(String)) }
                attr_reader :description

                sig { params(description: String).void }
                attr_writer :description

                sig do
                  params(

                    value: T.any(String, T::Boolean),

                    description: String
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  # Choice values are typed: a string and a boolean with the same text are distinct.
                  value:,

                  description: nil
                )
                end

                sig do
                  override.returns(
                    {value: T.any(String, T::Boolean), description: String}
                  )
                end
                def to_hash
                end

                # Choice values are typed: a string and a boolean with the same text are distinct.
                module Value
                  extend OpenAI::Internal::Type::Union

                  Variants = T.type_alias { T.any(String, T::Boolean) }

                  sig {
                    override.returns(
                      T::Array[OpenAI::Live::DecisionTrigger::Decisions::Question::Choice::Choice::Value::Variants]
                    )
                  }
                  def self.variants
                  end

                end
              end

              module Instructions
                extend OpenAI::Internal::Type::Union

                Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionQuestionInputPart::Variants]) }

                sig {
                  override.returns(
                    T::Array[OpenAI::Live::DecisionTrigger::Decisions::Question::Choice::Instructions::Variants]
                  )
                }
                def self.variants
                end

                DecisionQuestionInputPartArray = T.let(
                  OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionQuestionInputPart],
                  OpenAI::Internal::Type::Converter
                )

              end
            end

            class Score < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Live::DecisionTrigger::Decisions::Question::Score,
                  OpenAI::Internal::AnyHash
                )
              end

              sig { returns(OpenAI::Live::DecisionTrigger::Decisions::Question::Score::Instructions::Variants) }
              attr_accessor :instructions

              sig { returns(T::Array[OpenAI::Live::DecisionTrigger::Decisions::Question::Score::Level]) }
              attr_accessor :levels

              # The type of the object. Always `score`.
              sig { returns(Symbol) }
              attr_accessor :type

              sig { returns(T.nilable(String)) }
              attr_reader :name

              sig { params(name: String).void }
              attr_writer :name

              # Rate the input against the supplied ordered levels.
              sig do
                params(

                  instructions: OpenAI::Live::DecisionTrigger::Decisions::Question::Score::Instructions::Variants,

                  levels: T::Array[OpenAI::Live::DecisionTrigger::Decisions::Question::Score::Level::OrHash],

                  name: String,

                  type: Symbol
                )
                  .returns(T.attached_class)
              end
              def self.new(

                instructions:,

                levels:,

                name: nil,

                # The type of the object. Always `score`.

                type: :score
              )
              end

              sig do
                override.returns(
                  {
                    instructions: OpenAI::Live::DecisionTrigger::Decisions::Question::Score::Instructions::Variants,
                    levels: T::Array[OpenAI::Live::DecisionTrigger::Decisions::Question::Score::Level],
                    type: Symbol,
                    name: String
                  }
                )
              end
              def to_hash
              end

              module Instructions
                extend OpenAI::Internal::Type::Union

                Variants = T.type_alias { T.any(String, T::Array[OpenAI::DecisionQuestionInputPart::Variants]) }

                sig {
                  override.returns(
                    T::Array[OpenAI::Live::DecisionTrigger::Decisions::Question::Score::Instructions::Variants]
                  )
                }
                def self.variants
                end

                DecisionQuestionInputPartArray = T.let(
                  OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionQuestionInputPart],
                  OpenAI::Internal::Type::Converter
                )

              end

              class Level < OpenAI::Internal::Type::BaseModel
                OrHash = T.type_alias do
                  T.any(
                    OpenAI::Live::DecisionTrigger::Decisions::Question::Score::Level,
                    OpenAI::Internal::AnyHash
                  )
                end

                sig { returns(String) }
                attr_accessor :label

                sig { returns(T.nilable(String)) }
                attr_reader :description

                sig { params(description: String).void }
                attr_writer :description

                sig do
                  params(

                    label: String,

                    description: String
                  )
                    .returns(T.attached_class)
                end
                def self.new(

                  label:,

                  description: nil
                )
                end

                sig do
                  override.returns(
                    {label: String, description: String}
                  )
                end
                def to_hash
                end

              end
            end

            sig { override.returns(T::Array[OpenAI::Live::DecisionTrigger::Decisions::Question::Variants]) }
            def self.variants
            end

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
