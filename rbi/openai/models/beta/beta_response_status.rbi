# typed: strong

module OpenAI
  module Models
    BetaResponseStatus = Beta::BetaResponseStatus

    module Beta
      # The status of the response generation. One of `completed`, `failed`,
      # `in_progress`, `cancelled`, `queued`, or `incomplete`.
      module BetaResponseStatus
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Beta::BetaResponseStatus) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        COMPLETED =
          T.let(:completed, OpenAI::Beta::BetaResponseStatus::TaggedSymbol)
        FAILED = T.let(:failed, OpenAI::Beta::BetaResponseStatus::TaggedSymbol)
        IN_PROGRESS =
          T.let(:in_progress, OpenAI::Beta::BetaResponseStatus::TaggedSymbol)
        CANCELLED =
          T.let(:cancelled, OpenAI::Beta::BetaResponseStatus::TaggedSymbol)
        QUEUED = T.let(:queued, OpenAI::Beta::BetaResponseStatus::TaggedSymbol)
        INCOMPLETE =
          T.let(:incomplete, OpenAI::Beta::BetaResponseStatus::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::Beta::BetaResponseStatus::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end
