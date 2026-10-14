# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        # The status of the run, which can be either `queued`, `in_progress`,
        # `requires_action`, `cancelling`, `cancelled`, `failed`, `completed`,
        # `incomplete`, or `expired`.
        module RunStatus
          extend OpenAI::Internal::Type::Enum

          TaggedSymbol =
            T.type_alias { T.all(Symbol, OpenAI::Beta::Threads::RunStatus) }
          OrSymbol = T.type_alias { T.any(Symbol, String) }

          QUEUED =
            T.let(:queued, OpenAI::Beta::Threads::RunStatus::TaggedSymbol)
          IN_PROGRESS =
            T.let(:in_progress, OpenAI::Beta::Threads::RunStatus::TaggedSymbol)
          REQUIRES_ACTION =
            T.let(
              :requires_action,
              OpenAI::Beta::Threads::RunStatus::TaggedSymbol
            )
          CANCELLING =
            T.let(:cancelling, OpenAI::Beta::Threads::RunStatus::TaggedSymbol)
          CANCELLED =
            T.let(:cancelled, OpenAI::Beta::Threads::RunStatus::TaggedSymbol)
          FAILED =
            T.let(:failed, OpenAI::Beta::Threads::RunStatus::TaggedSymbol)
          COMPLETED =
            T.let(:completed, OpenAI::Beta::Threads::RunStatus::TaggedSymbol)
          INCOMPLETE =
            T.let(:incomplete, OpenAI::Beta::Threads::RunStatus::TaggedSymbol)
          EXPIRED =
            T.let(:expired, OpenAI::Beta::Threads::RunStatus::TaggedSymbol)

          sig do
            override.returns(
              T::Array[OpenAI::Beta::Threads::RunStatus::TaggedSymbol]
            )
          end
          def self.values
          end
        end
      end
    end
  end
end
