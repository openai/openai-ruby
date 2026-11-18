# typed: strong

module OpenAI
  module Models

    class CsamModerationResponse < OpenAI::Internal::Type::BaseModel

      OrHash = T.type_alias do
        T.any(
          OpenAI::CsamModerationResponse,
          OpenAI::Internal::AnyHash
        )
      end

      sig { returns(String) }
      attr_accessor :id

      sig { returns(Symbol) }
      attr_accessor :model

      sig { returns(T::Array[OpenAI::CsamModeration]) }
      attr_accessor :results

      sig do
        params(

          id: String,

          results: T::Array[OpenAI::CsamModeration::OrHash],

          model: Symbol
        )
          .returns(T.attached_class)
      end
      def self.new(

        id:,

        results:,

        model: :"omni-moderation-csam-latest"
      )
      end

      sig do
        override.returns(
          {id: String, model: Symbol, results: T::Array[OpenAI::CsamModeration]}
        )
      end
      def to_hash
      end

    end

  end
end
