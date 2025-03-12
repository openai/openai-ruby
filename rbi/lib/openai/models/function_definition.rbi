# typed: strong

module OpenAI
  module Models
    class FunctionDefinition < OpenAI::BaseModel
      sig { returns(String) }
      def name
      end

      sig { params(_: String).returns(String) }
      def name=(_)
      end

      sig { returns(T.nilable(String)) }
      def description
      end

      sig { params(_: String).returns(String) }
      def description=(_)
      end

      sig { returns(T.nilable(OpenAI::Models::FunctionParameters)) }
      def parameters
      end

      sig { params(_: OpenAI::Models::FunctionParameters).returns(OpenAI::Models::FunctionParameters) }
      def parameters=(_)
      end

      sig { returns(T.nilable(T::Boolean)) }
      def strict
      end

      sig { params(_: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def strict=(_)
      end

      sig do
        params(
          name: String,
          description: String,
          parameters: OpenAI::Models::FunctionParameters,
          strict: T.nilable(T::Boolean)
        )
          .returns(T.attached_class)
      end
      def self.new(name:, description: nil, parameters: nil, strict: nil)
      end

      sig do
        override
          .returns(
            {name: String, description: String, parameters: OpenAI::Models::FunctionParameters, strict: T.nilable(T::Boolean)}
          )
      end
      def to_hash
      end
    end
  end
end
