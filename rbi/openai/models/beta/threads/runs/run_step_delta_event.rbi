# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        RunStepDeltaEvent = Runs::RunStepDeltaEvent

        module Runs
          class RunStepDeltaEvent < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::Runs::RunStepDeltaEvent,
                  OpenAI::Internal::AnyHash
                )
              end

            # The identifier of the run step, which can be referenced in API endpoints.
            sig { returns(String) }
            attr_accessor :id

            # The delta containing the fields that have changed on the run step.
            sig { returns(OpenAI::Beta::Threads::Runs::RunStepDelta) }
            attr_reader :delta

            sig do
              params(
                delta: OpenAI::Beta::Threads::Runs::RunStepDelta::OrHash
              ).void
            end
            attr_writer :delta

            # The object type, which is always `thread.run.step.delta`.
            sig { returns(Symbol) }
            attr_accessor :object

            # Represents a run step delta i.e. any changed fields on a run step during
            # streaming.
            sig do
              params(
                id: String,
                delta: OpenAI::Beta::Threads::Runs::RunStepDelta::OrHash,
                object: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              # The identifier of the run step, which can be referenced in API endpoints.
              id:,
              # The delta containing the fields that have changed on the run step.
              delta:,
              # The object type, which is always `thread.run.step.delta`.
              object: :"thread.run.step.delta"
            )
            end

            sig do
              override.returns(
                {
                  id: String,
                  delta: OpenAI::Beta::Threads::Runs::RunStepDelta,
                  object: Symbol
                }
              )
            end
            def to_hash
            end
          end
        end
      end
    end
  end
end
