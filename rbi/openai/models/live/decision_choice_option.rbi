# typed: strong

module OpenAI
  module Models

    module Live

      class DecisionChoiceOption < OpenAI::Internal::Type::BaseModel

        OrHash = T.type_alias do
          T.any(
            OpenAI::Live::DecisionChoiceOption,
            OpenAI::Internal::AnyHash
          )
        end

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

        module Value
          extend OpenAI::Internal::Type::Union

          Variants = T.type_alias { T.any(String, T::Boolean) }

          sig { override.returns(T::Array[OpenAI::Live::DecisionChoiceOption::Value::Variants]) }
          def self.variants
          end

        end

      end

    end

  end
end
