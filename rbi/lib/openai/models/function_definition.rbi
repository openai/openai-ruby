# typed: strong

module OpenAI
  module Models
    class FunctionDefinition < OpenAI::BaseModel
      # The name of the function to be called. Must be a-z, A-Z, 0-9, or contain
      #   underscores and dashes, with a maximum length of 64.
      sig { returns(String) }
      def name
      end

      sig { params(_: String).returns(String) }
      def name=(_)
      end

      # A description of what the function does, used by the model to choose when and
      #   how to call the function.
      sig { returns(T.nilable(String)) }
      def description
      end

      sig { params(_: String).returns(String) }
      def description=(_)
      end

      # The parameters the functions accepts, described as a JSON Schema object. See the
      #   [guide](https://platform.openai.com/docs/guides/function-calling) for examples,
      #   and the
      #   [JSON Schema reference](https://json-schema.org/understanding-json-schema/) for
      #   documentation about the format.
      #
      #   Omitting `parameters` defines a function with an empty parameter list.
      sig { returns(T.nilable(T::Hash[Symbol, T.anything])) }
      def parameters
      end

      sig { params(_: T::Hash[Symbol, T.anything]).returns(T::Hash[Symbol, T.anything]) }
      def parameters=(_)
      end

      # Whether to enable strict schema adherence when generating the function call. If
      #   set to true, the model will follow the exact schema defined in the `parameters`
      #   field. Only a subset of JSON Schema is supported when `strict` is `true`. Learn
      #   more about Structured Outputs in the
      #   [function calling guide](docs/guides/function-calling).
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
          parameters: T::Hash[Symbol, T.anything],
          strict: T.nilable(T::Boolean)
        )
          .returns(T.attached_class)
      end
      def self.new(name:, description: nil, parameters: nil, strict: nil)
      end

      sig do
        override
          .returns(
            {
              name: String,
              description: String,
              parameters: T::Hash[Symbol, T.anything],
              strict: T.nilable(T::Boolean)
            }
          )
      end
      def to_hash
      end
    end
  end
end
