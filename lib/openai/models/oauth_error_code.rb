# frozen_string_literal: true

module OpenAI
  module Models
    module OAuthErrorCode
      extend OpenAI::Internal::Type::Union

      variant const: -> { OpenAI::Models::OAuthErrorCode::INVALID_GRANT }

      variant const: -> { OpenAI::Models::OAuthErrorCode::INVALID_SUBJECT_TOKEN }

      variant String

      # @!method self.variants
      #   @return [Array(Symbol, String)]

      define_sorbet_constant!(:Variants) do
        T.type_alias { T.any(OpenAI::OAuthErrorCode::TaggedSymbol, String) }
      end

      # @!group

      INVALID_GRANT = :invalid_grant
      INVALID_SUBJECT_TOKEN = :invalid_subject_token

      # @!endgroup
    end
  end
end
