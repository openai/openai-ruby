# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        RunStepDeltaEvent = T.type_alias { Runs::RunStepDeltaEvent }

        module Runs
          class RunStepDeltaEvent < OpenAI::BaseModel
            # The identifier of the run step, which can be referenced in API endpoints.
            sig { returns(String) }
            def id
            end

            sig { params(_: String).returns(String) }
            def id=(_)
            end

            # The delta containing the fields that have changed on the run step.
            sig { returns(OpenAI::Models::Beta::Threads::Runs::RunStepDelta) }
            def delta
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Runs::RunStepDelta)
                .returns(OpenAI::Models::Beta::Threads::Runs::RunStepDelta)
            end
            def delta=(_)
            end

            # The object type, which is always `thread.run.step.delta`.
            sig { returns(Symbol) }
            def object
            end

            sig { params(_: Symbol).returns(Symbol) }
            def object=(_)
            end

            # Represents a run step delta i.e. any changed fields on a run step during
            #   streaming.
            sig do
              params(id: String, delta: OpenAI::Models::Beta::Threads::Runs::RunStepDelta, object: Symbol)
                .returns(T.attached_class)
            end
            def self.new(id:, delta:, object: :"thread.run.step.delta")
            end

            sig { override.returns({id: String, delta: OpenAI::Models::Beta::Threads::Runs::RunStepDelta, object: Symbol}) }
            def to_hash
            end
          end
        end
      end
    end
  end
end
