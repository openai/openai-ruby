# typed: strong

module OpenAI
  module Models

    class Decision < OpenAI::Internal::Type::BaseModel

      OrHash = T.type_alias do
        T.any(
          OpenAI::Decision,
          OpenAI::Internal::AnyHash
        )
      end

      sig { returns(T::Array[OpenAI::Decision::Answer::Variants]) }
      attr_accessor :answers

      sig { returns(String) }
      attr_accessor :model

      sig { returns(OpenAI::Decision::Usage) }
      attr_reader :usage

      sig { params(usage: OpenAI::Decision::Usage::OrHash).void }
      attr_writer :usage

      sig do
        params(

          answers: T::Array[
            T.any(
              OpenAI::Decision::Answer::Predicate::OrHash,
              OpenAI::Decision::Answer::Choice::OrHash,
              OpenAI::Decision::Answer::Score::OrHash,
              OpenAI::Decision::Answer::Refusal::OrHash
            )
          ],

          model: String,

          usage: OpenAI::Decision::Usage::OrHash
        )
          .returns(T.attached_class)
      end
      def self.new(

        answers:,

        model:,

        usage:
      )
      end

      sig do
        override.returns(
          {answers: T::Array[OpenAI::Decision::Answer::Variants], model: String, usage: OpenAI::Decision::Usage}
        )
      end
      def to_hash
      end

      # A completed question always includes its name, including null when unnamed.
      module Answer
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias {
          T.any(
            OpenAI::Decision::Answer::Predicate,
            OpenAI::Decision::Answer::Choice,
            OpenAI::Decision::Answer::Score,
            OpenAI::Decision::Answer::Refusal
          )
        }

        class Predicate < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Decision::Answer::Predicate,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(T.nilable(String)) }
          attr_accessor :name

          sig { returns(Float) }
          attr_accessor :probability

          # The type of the object. Always `predicate`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig do
            params(

              name: T.nilable(String),

              probability: Float,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            name:,

            probability:,

            # The type of the object. Always `predicate`.

            type: :predicate
          )
          end

          sig do
            override.returns(
              {name: T.nilable(String), probability: Float, type: Symbol}
            )
          end
          def to_hash
          end

        end

        class Choice < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Decision::Answer::Choice,
              OpenAI::Internal::AnyHash
            )
          end

          # Choice values are typed: a string and a boolean with the same text are distinct.
          sig { returns(T.any(String, T::Boolean)) }
          attr_accessor :choice

          sig { returns(Float) }
          attr_accessor :confidence

          sig { returns(T.nilable(String)) }
          attr_accessor :name

          sig { returns(T::Array[OpenAI::Decision::Answer::Choice::Probability]) }
          attr_accessor :probabilities

          # The type of the object. Always `choice`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig do
            params(

              choice: T.any(String, T::Boolean),

              confidence: Float,

              name: T.nilable(String),

              probabilities: T::Array[OpenAI::Decision::Answer::Choice::Probability::OrHash],

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            # Choice values are typed: a string and a boolean with the same text are distinct.
            choice:,

            confidence:,

            name:,

            probabilities:,

            # The type of the object. Always `choice`.

            type: :choice
          )
          end

          sig do
            override.returns(
              {
                choice: T.any(String, T::Boolean),
                confidence: Float,
                name: T.nilable(String),
                probabilities: T::Array[OpenAI::Decision::Answer::Choice::Probability],
                type: Symbol
              }
            )
          end
          def to_hash
          end

          # Choice values are typed: a string and a boolean with the same text are distinct.
          module Choice
            extend OpenAI::Internal::Type::Union

            Variants = T.type_alias { T.any(String, T::Boolean) }

            sig { override.returns(T::Array[OpenAI::Decision::Answer::Choice::Choice::Variants]) }
            def self.variants
            end

          end

          class Probability < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Decision::Answer::Choice::Probability,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(Float) }
            attr_accessor :probability

            # Choice values are typed: a string and a boolean with the same text are distinct.
            sig { returns(T.any(String, T::Boolean)) }
            attr_accessor :value

            sig do
              params(

                probability: Float,

                value: T.any(String, T::Boolean)
              )
                .returns(T.attached_class)
            end
            def self.new(

              probability:,

              # Choice values are typed: a string and a boolean with the same text are distinct.

              value:
            )
            end

            sig do
              override.returns(
                {probability: Float, value: T.any(String, T::Boolean)}
              )
            end
            def to_hash
            end

            # Choice values are typed: a string and a boolean with the same text are distinct.
            module Value
              extend OpenAI::Internal::Type::Union

              Variants = T.type_alias { T.any(String, T::Boolean) }

              sig { override.returns(T::Array[OpenAI::Decision::Answer::Choice::Probability::Value::Variants]) }
              def self.variants
              end

            end
          end
        end

        class Score < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Decision::Answer::Score,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(Float) }
          attr_accessor :confidence

          sig { returns(T.nilable(String)) }
          attr_accessor :name

          sig { returns(T::Array[OpenAI::Decision::Answer::Score::Probability]) }
          attr_accessor :probabilities

          sig { returns(Float) }
          attr_accessor :score

          # The type of the object. Always `score`.
          sig { returns(Symbol) }
          attr_accessor :type

          sig do
            params(

              confidence: Float,

              name: T.nilable(String),

              probabilities: T::Array[OpenAI::Decision::Answer::Score::Probability::OrHash],

              score: Float,

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            confidence:,

            name:,

            probabilities:,

            score:,

            # The type of the object. Always `score`.

            type: :score
          )
          end

          sig do
            override.returns(
              {
                confidence: Float,
                name: T.nilable(String),
                probabilities: T::Array[OpenAI::Decision::Answer::Score::Probability],
                score: Float,
                type: Symbol
              }
            )
          end
          def to_hash
          end

          class Probability < OpenAI::Internal::Type::BaseModel
            OrHash = T.type_alias do
              T.any(
                OpenAI::Decision::Answer::Score::Probability,
                OpenAI::Internal::AnyHash
              )
            end

            sig { returns(String) }
            attr_accessor :label

            sig { returns(Float) }
            attr_accessor :probability

            sig { returns(Integer) }
            attr_accessor :value

            sig do
              params(

                label: String,

                probability: Float,

                value: Integer
              )
                .returns(T.attached_class)
            end
            def self.new(

              label:,

              probability:,

              value:
            )
            end

            sig do
              override.returns(
                {label: String, probability: Float, value: Integer}
              )
            end
            def to_hash
            end

          end
        end

        class Refusal < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Decision::Answer::Refusal,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(T.nilable(String)) }
          attr_accessor :name

          # The type of the object. Always `refusal`.
          sig { returns(Symbol) }
          attr_accessor :type

          # The host may decline one question without disclosing its refusal score.
          sig do
            params(

              name: T.nilable(String),

              type: Symbol
            )
              .returns(T.attached_class)
          end
          def self.new(

            name:,

            # The type of the object. Always `refusal`.

            type: :refusal
          )
          end

          sig do
            override.returns(
              {name: T.nilable(String), type: Symbol}
            )
          end
          def to_hash
          end

        end

        sig { override.returns(T::Array[OpenAI::Decision::Answer::Variants]) }
        def self.variants
        end

      end

      class Usage < OpenAI::Internal::Type::BaseModel
        OrHash = T.type_alias do
          T.any(
            OpenAI::Decision::Usage,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(Integer) }
        attr_accessor :input_tokens

        sig { returns(OpenAI::Decision::Usage::InputTokensDetails) }
        attr_reader :input_tokens_details

        sig { params(input_tokens_details: OpenAI::Decision::Usage::InputTokensDetails::OrHash).void }
        attr_writer :input_tokens_details

        sig { returns(Integer) }
        attr_accessor :output_tokens

        sig { returns(OpenAI::Decision::Usage::OutputTokensDetails) }
        attr_reader :output_tokens_details

        sig { params(output_tokens_details: OpenAI::Decision::Usage::OutputTokensDetails::OrHash).void }
        attr_writer :output_tokens_details

        sig { returns(Integer) }
        attr_accessor :total_tokens

        sig { returns(T.nilable(Integer)) }
        attr_accessor :compute_units

        sig do
          params(

            input_tokens: Integer,

            input_tokens_details: OpenAI::Decision::Usage::InputTokensDetails::OrHash,

            output_tokens: Integer,

            output_tokens_details: OpenAI::Decision::Usage::OutputTokensDetails::OrHash,

            total_tokens: Integer,

            compute_units: T.nilable(Integer)
          )
            .returns(T.attached_class)
        end
        def self.new(

          input_tokens:,

          input_tokens_details:,

          output_tokens:,

          output_tokens_details:,

          total_tokens:,

          compute_units: nil
        )
        end

        sig do
          override.returns(
            {
              input_tokens: Integer,
              input_tokens_details: OpenAI::Decision::Usage::InputTokensDetails,
              output_tokens: Integer,
              output_tokens_details: OpenAI::Decision::Usage::OutputTokensDetails,
              total_tokens: Integer,
              compute_units: T.nilable(Integer)
            }
          )
        end
        def to_hash
        end

        class InputTokensDetails < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Decision::Usage::InputTokensDetails,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(Integer) }
          attr_accessor :cache_write_tokens

          sig { returns(Integer) }
          attr_accessor :cached_tokens

          sig do
            params(

              cache_write_tokens: Integer,

              cached_tokens: Integer
            )
              .returns(T.attached_class)
          end
          def self.new(

            cache_write_tokens:,

            cached_tokens:
          )
          end

          sig do
            override.returns(
              {cache_write_tokens: Integer, cached_tokens: Integer}
            )
          end
          def to_hash
          end

        end

        class OutputTokensDetails < OpenAI::Internal::Type::BaseModel
          OrHash = T.type_alias do
            T.any(
              OpenAI::Decision::Usage::OutputTokensDetails,
              OpenAI::Internal::AnyHash
            )
          end

          sig { returns(Integer) }
          attr_accessor :reasoning_tokens

          sig do
            params(

              reasoning_tokens: Integer
            )
              .returns(T.attached_class)
          end
          def self.new(

            reasoning_tokens:
          )
          end

          sig do
            override.returns(
              {reasoning_tokens: Integer}
            )
          end
          def to_hash
          end

        end
      end

    end

  end
end
