# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class RunStepDeltaEvent < OpenAI::Internal::Type::BaseModel
            # The identifier of the run step, which can be referenced in API endpoints.
            sig { returns(String) }
            attr_accessor :id

            # The delta containing the fields that have changed on the run step.
            sig { returns(OpenAI::Models::Beta::Threads::Runs::RunStepDelta) }
            attr_reader :delta

            sig { params(delta: T.any(OpenAI::Models::Beta::Threads::Runs::RunStepDelta, OpenAI::Internal::AnyHash)).void }
            attr_writer :delta

            # The object type, which is always `thread.run.step.delta`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Represents a run step delta i.e. any changed fields on a run step during
            #   streaming.
            sig do
              params(
                id: String,
                delta: T.any(OpenAI::Models::Beta::Threads::Runs::RunStepDelta, OpenAI::Internal::AnyHash),
                object: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(id:, delta:, object: :"thread.run.step.delta"); end

            sig { override.returns({id: String, delta: OpenAI::Models::Beta::Threads::Runs::RunStepDelta, object: Symbol}) }
            def to_hash; end
          end
        end

        RunStepDeltaEvent = Runs::RunStepDeltaEvent
      end
    end
  end
end
