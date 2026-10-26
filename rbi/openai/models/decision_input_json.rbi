# typed: strong

module OpenAI
  module Models

    class DecisionInputJSON < OpenAI::Internal::Type::BaseModel

      OrHash = T.type_alias do
        T.any(
          OpenAI::DecisionInputJSON,
          OpenAI::Internal::AnyHash
        )
      end

      sig { returns(OpenAI::DecisionInputJSON::Data::Variants) }
      attr_accessor :data

      sig { returns(Symbol) }
      attr_accessor :type

      # A JSON object or an array of objects rendered as text. Nested values may be any
      # JSON value. Limited to 32 container levels, 10,000 values, and 256 KiB of
      # compact UTF-8 JSON.
      sig do
        params(

          data: OpenAI::DecisionInputJSON::Data::Variants,

          type: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(

        data:,

        type: :input_json
      )
      end

      sig do
        override.returns(
          {data: OpenAI::DecisionInputJSON::Data::Variants, type: Symbol}
        )
      end
      def to_hash
      end

      module Data
        extend OpenAI::Internal::Type::Union

        Variants = T.type_alias {
          T.any(T::Hash[Symbol, T.anything], T::Array[T::Hash[Symbol, T.nilable(T.anything)]])
        }

        sig { override.returns(T::Array[OpenAI::DecisionInputJSON::Data::Variants]) }
        def self.variants
        end

        UnionMember0Map = T.let(
          OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown],
          OpenAI::Internal::Type::Converter
        )

        UnionMember1Array = T.let(
          OpenAI::Internal::Type::ArrayOf[OpenAI::Internal::Type::HashOf[OpenAI::Internal::Type::Unknown, nil?: true]],
          OpenAI::Internal::Type::Converter
        )

      end

    end

  end
end
