# typed: strong

module OpenAI
  module Models
    class EvalStringCheckGrader < OpenAI::Internal::Type::BaseModel
      # The input text. This may include template strings.
      sig { returns(String) }
      attr_accessor :input

      # The name of the grader.
      sig { returns(String) }
      attr_accessor :name

      # The string check operation to perform. One of `eq`, `ne`, `like`, or `ilike`.
      sig { returns(OpenAI::Models::EvalStringCheckGrader::Operation::OrSymbol) }
      attr_accessor :operation

      # The reference text. This may include template strings.
      sig { returns(String) }
      attr_accessor :reference

      # The object type, which is always `string_check`.
      sig { returns(Symbol) }
      attr_accessor :type

      # A StringCheckGrader object that performs a string comparison between input and
      # reference using a specified operation.
      sig do
        params(
          input: String,
          name: String,
          operation: OpenAI::Models::EvalStringCheckGrader::Operation::OrSymbol,
          reference: String,
          type: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(
        # The input text. This may include template strings.
        input:,
        # The name of the grader.
        name:,
        # The string check operation to perform. One of `eq`, `ne`, `like`, or `ilike`.
        operation:,
        # The reference text. This may include template strings.
        reference:,
        # The object type, which is always `string_check`.
        type: :string_check
      ); end
      sig do
        override
          .returns(
            {
              input: String,
              name: String,
              operation: OpenAI::Models::EvalStringCheckGrader::Operation::OrSymbol,
              reference: String,
              type: Symbol
            }
          )
      end
      def to_hash; end

      # The string check operation to perform. One of `eq`, `ne`, `like`, or `ilike`.
      module Operation
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::EvalStringCheckGrader::Operation) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        EQ = T.let(:eq, OpenAI::Models::EvalStringCheckGrader::Operation::TaggedSymbol)
        NE = T.let(:ne, OpenAI::Models::EvalStringCheckGrader::Operation::TaggedSymbol)
        LIKE = T.let(:like, OpenAI::Models::EvalStringCheckGrader::Operation::TaggedSymbol)
        ILIKE = T.let(:ilike, OpenAI::Models::EvalStringCheckGrader::Operation::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::EvalStringCheckGrader::Operation::TaggedSymbol]) }
        def self.values; end
      end
    end
  end
end
