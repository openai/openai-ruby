# typed: strong

module OpenAI
  module Models

    module OAuthErrorCode
      extend OpenAI::Internal::Type::Union

      Variants = T.type_alias do
        T.any(
          OpenAI::OAuthErrorCode::TaggedSymbol,
          String
        )
      end

      sig { override.returns(T::Array[OpenAI::OAuthErrorCode::Variants]) }
      def self.variants
      end

      TaggedSymbol = T.type_alias do
        T.all(Symbol, OpenAI::OAuthErrorCode)
      end

      OrSymbol = T.type_alias { T.any(Symbol, String) }

      INVALID_GRANT = T.let(:invalid_grant, OpenAI::OAuthErrorCode::TaggedSymbol)
      INVALID_SUBJECT_TOKEN = T.let(:invalid_subject_token, OpenAI::OAuthErrorCode::TaggedSymbol)

    end

  end
end
