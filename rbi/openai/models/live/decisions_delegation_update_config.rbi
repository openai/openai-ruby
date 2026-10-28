# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionsDelegationUpdateConfig < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionsDelegationUpdateConfig,
            OpenAI::Internal::AnyHash
          )
        end

        sig { returns(T.nilable(String)) }
        attr_reader :model

        sig { params(model: String).void }
        attr_writer :model

        # Native Decision API questions evaluated together, in order.
        sig {
          returns(
            T.nilable(
              T::Array[
                T.any(
                  OpenAI::Live::DecisionQuestion::Choice,
                  OpenAI::Live::DecisionQuestion::Predicate,
                  OpenAI::Live::DecisionQuestion::Score
                )
              ]
            )
          )
        }
        attr_reader :questions

        sig {
          params(
            questions: T::Array[
              T.any(
                OpenAI::Live::DecisionQuestion::Choice::OrHash,
                OpenAI::Live::DecisionQuestion::Predicate::OrHash,
                OpenAI::Live::DecisionQuestion::Score::OrHash
              )
            ]
          )
            .void
        }
        attr_writer :questions

        sig do
          params(

            model: String,

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

          model: nil,

          # Native Decision API questions evaluated together, in order.

          questions: nil
        )
        end

        sig do
          override.returns(
            {
              model: String,
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

        Question = ::OpenAI::Models::Live::DecisionQuestion
      end

    end

  end
end
