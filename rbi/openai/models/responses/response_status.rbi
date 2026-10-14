# typed: strong

module OpenAI
  module Models
    module Responses
      # The status of the response generation. One of `completed`, `failed`,
      # `in_progress`, `cancelled`, `queued`, or `incomplete`.
      module ResponseStatus
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol =
          T.type_alias { T.all(Symbol, OpenAI::Responses::ResponseStatus) }
        OrSymbol = T.type_alias { T.any(Symbol, String) }

        COMPLETED =
          T.let(:completed, OpenAI::Responses::ResponseStatus::TaggedSymbol)
        FAILED = T.let(:failed, OpenAI::Responses::ResponseStatus::TaggedSymbol)
        IN_PROGRESS =
          T.let(:in_progress, OpenAI::Responses::ResponseStatus::TaggedSymbol)
        CANCELLED =
          T.let(:cancelled, OpenAI::Responses::ResponseStatus::TaggedSymbol)
        QUEUED = T.let(:queued, OpenAI::Responses::ResponseStatus::TaggedSymbol)
        INCOMPLETE =
          T.let(:incomplete, OpenAI::Responses::ResponseStatus::TaggedSymbol)

        sig do
          override.returns(
            T::Array[OpenAI::Responses::ResponseStatus::TaggedSymbol]
          )
        end
        def self.values
        end
      end
    end
  end
end
