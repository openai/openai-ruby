# typed: strong

module OpenAI
  module Models

    module Live

      module DecisionQuestion
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias do
          T.any(
            OpenAI::Live::DecisionQuestion::Choice,
            OpenAI::Live::DecisionQuestion::Predicate,
            OpenAI::Live::DecisionQuestion::Score
          )
        end

        class Choice < OpenAI::Internal::Type::BaseModel
          Choice = ::OpenAI::Models::Live::DecisionChoiceOption

          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::DecisionQuestion::Choice,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(T::Array[OpenAI::Live::DecisionChoiceOption]) }
          attr_accessor :choices

          sig { returns(OpenAI::Live::DecisionQuestion::Choice::Instructions::Variants) }
          attr_accessor :instructions

          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          sig do
            params(

              choices: T::Array[OpenAI::Live::DecisionChoiceOption::OrHash],

              instructions: OpenAI::Live::DecisionQuestion::Choice::Instructions::Variants,

              name: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            choices:,

            instructions:,

            name: nil,

            type: :choice
          )
          end

          sig do
            override.returns(
              {
                choices: T::Array[OpenAI::Live::DecisionChoiceOption],
                instructions: OpenAI::Live::DecisionQuestion::Choice::Instructions::Variants,
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

            sig { override.returns(T::Array[OpenAI::Live::DecisionQuestion::Choice::Instructions::Variants]) }
            def self.variants
            end

            DecisionQuestionInputPartArray = T.let(
              OpenAI::Internal::Type::ArrayOf[union: OpenAI::DecisionQuestionInputPart],
              OpenAI::Internal::Type::Converter
            )

          end
        end

        class Predicate < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Live::DecisionQuestion::Predicate,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(OpenAI::Live::DecisionQuestion::Predicate::Instructions::Variants) }
          attr_accessor :instructions

          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          sig do
            params(

              instructions: OpenAI::Live::DecisionQuestion::Predicate::Instructions::Variants,

              name: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            instructions:,

            name: nil,

            type: :predicate
          )
          end

          sig do
            override.returns(
              {
                instructions: OpenAI::Live::DecisionQuestion::Predicate::Instructions::Variants,
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

            sig { override.returns(T::Array[OpenAI::Live::DecisionQuestion::Predicate::Instructions::Variants]) }
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
              OpenAI::Live::DecisionQuestion::Score,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(OpenAI::Live::DecisionQuestion::Score::Instructions::Variants) }
          attr_accessor :instructions

          sig { returns(T::Array[OpenAI::Live::DecisionQuestion::Score::Level]) }
          attr_accessor :levels

          sig { returns(Symbol) }
          attr_accessor :type

          sig { returns(T.nilable(String)) }
          attr_reader :name

          sig { params(name: String).void }
          attr_writer :name

          sig do
            params(

              instructions: OpenAI::Live::DecisionQuestion::Score::Instructions::Variants,

              levels: T::Array[OpenAI::Live::DecisionQuestion::Score::Level::OrHash],

              name: String,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            instructions:,

            levels:,

            name: nil,

            type: :score
          )
          end

          sig do
            override.returns(
              {
                instructions: OpenAI::Live::DecisionQuestion::Score::Instructions::Variants,
                levels: T::Array[OpenAI::Live::DecisionQuestion::Score::Level],
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

            sig { override.returns(T::Array[OpenAI::Live::DecisionQuestion::Score::Instructions::Variants]) }
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
                OpenAI::Live::DecisionQuestion::Score::Level,
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

        sig { override.returns(T::Array[OpenAI::Live::DecisionQuestion::Variants]) }
        def self.variants
        end

      end

    end

  end
end
