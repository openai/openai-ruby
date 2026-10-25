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
                OpenAI::Live::DecisionQuestion::Choice,
                OpenAI::Live::DecisionQuestion::Predicate,
                OpenAI::Live::DecisionQuestion::Score
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
                OpenAI::Live::DecisionQuestion::Choice::OrHash,
                OpenAI::Live::DecisionQuestion::Predicate::OrHash,
                OpenAI::Live::DecisionQuestion::Score::OrHash
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
