# typed: strong

module OpenAI
  module Models
    module Responses
      # The status of the response generation. One of `completed`, `failed`,
      #   `in_progress`, or `incomplete`.
      module ResponseStatus
        extend OpenAI::Internal::Type::Enum

        TaggedSymbol = T.type_alias { T.all(Symbol, OpenAI::Models::Responses::ResponseStatus) }
        OrSymbol =
          T.type_alias { T.any(Symbol, String, OpenAI::Models::Responses::ResponseStatus::TaggedSymbol) }

        COMPLETED = T.let(:completed, OpenAI::Models::Responses::ResponseStatus::TaggedSymbol)
        FAILED = T.let(:failed, OpenAI::Models::Responses::ResponseStatus::TaggedSymbol)
        IN_PROGRESS = T.let(:in_progress, OpenAI::Models::Responses::ResponseStatus::TaggedSymbol)
        INCOMPLETE = T.let(:incomplete, OpenAI::Models::Responses::ResponseStatus::TaggedSymbol)

        sig { override.returns(T::Array[OpenAI::Models::Responses::ResponseStatus::TaggedSymbol]) }
        def self.values; end
      end
    end
  end
end
