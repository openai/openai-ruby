# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionsDelegationConfig < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionsDelegationConfig,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(String) }
        attr_accessor :model

        # Native Decision API questions evaluated together, in order.
        sig {
          returns(
            T::Array[
              T.any(
                OpenAI::Live::DecisionsDelegationConfig::Question::Predicate,
                OpenAI::Live::DecisionsDelegationConfig::Question::Choice,
                OpenAI::Live::DecisionsDelegationConfig::Question::Score
              )
            ]
          )
        }
        attr_accessor :questions

        sig do
          params(

            model: String,

            questions: T::Array[
              T.any(
                OpenAI::Live::DecisionsDelegationConfig::Question::Predicate::OrHash,
                OpenAI::Live::DecisionsDelegationConfig::Question::Choice::OrHash,
                OpenAI::Live::DecisionsDelegationConfig::Question::Score::OrHash
              )
            ]
          )
            .returns(T.attached_class)
        end
        def self.new(

          model:,

          # Native Decision API questions evaluated together, in order.

          questions:
        )
        end

        sig do
          override.returns(
            {
              model: String,
              questions: T::Array[
                T.any(
                  OpenAI::Live::DecisionsDelegationConfig::Question::Predicate,
                  OpenAI::Live::DecisionsDelegationConfig::Question::Choice,
                  OpenAI::Live::DecisionsDelegationConfig::Question::Score
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
              OpenAI::Live::DecisionsDelegationConfig::Question::Predicate,
              OpenAI::Live::DecisionsDelegationConfig::Question::Choice,
              OpenAI::Live::DecisionsDelegationConfig::Question::Score
            )
          }

          class Predicate < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::DecisionsDelegationConfig::Question::Predicate,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
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

                instructions: String,

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
                {instructions: String, type: Symbol, name: String}
              )
            end
            def to_hash
            end

          end

          class Choice < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::DecisionsDelegationConfig::Question::Choice,
                OpenAI::Internal::AnyHash
              )
            end

            # Provide between 2 and 255 choices. Each choice must be unique.
            sig { returns(T::Array[OpenAI::Live::DecisionsDelegationConfig::Question::Choice::Choice]) }
            attr_accessor :choices

            sig { returns(String) }
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

                choices: T::Array[OpenAI::Live::DecisionsDelegationConfig::Question::Choice::Choice::OrHash],

                instructions: String,

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
                  choices: T::Array[OpenAI::Live::DecisionsDelegationConfig::Question::Choice::Choice],
                  instructions: String,
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
                  OpenAI::Live::DecisionsDelegationConfig::Question::Choice::Choice,
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
                    T::Array[OpenAI::Live::DecisionsDelegationConfig::Question::Choice::Choice::Value::Variants]
                  )
                }
                def self.variants
                end

              end
            end
          end

          class Score < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Live::DecisionsDelegationConfig::Question::Score,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :instructions

            sig { returns(T::Array[OpenAI::Live::DecisionsDelegationConfig::Question::Score::Level]) }
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

                instructions: String,

                levels: T::Array[OpenAI::Live::DecisionsDelegationConfig::Question::Score::Level::OrHash],

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
                  instructions: String,
                  levels: T::Array[OpenAI::Live::DecisionsDelegationConfig::Question::Score::Level],
                  type: Symbol,
                  name: String
                }
              )
            end
            def to_hash
            end

            class Level < OpenAI::Internal::Type::BaseModel
              OrHash = T.type_alias do
                T.any(
                  OpenAI::Live::DecisionsDelegationConfig::Question::Score::Level,
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

          sig { override.returns(T::Array[OpenAI::Live::DecisionsDelegationConfig::Question::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
