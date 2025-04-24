# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class RunStepDeltaEvent < OpenAI::Internal::Type::BaseModel
            # @!attribute id
            #   The identifier of the run step, which can be referenced in API endpoints.
            #
            #   @return [String]
            required :id, String

            # @!attribute delta
            #   The delta containing the fields that have changed on the run step.
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::RunStepDelta]
            required :delta, -> { OpenAI::Models::Beta::Threads::Runs::RunStepDelta }

            # @!attribute object
            #   The object type, which is always `thread.run.step.delta`.
            #
            #   @return [Symbol, :"thread.run.step.delta"]
            required :object, const: :"thread.run.step.delta"

            # @!method initialize(id:, delta:, object: :"thread.run.step.delta")
            #   Represents a run step delta i.e. any changed fields on a run step during
            #   streaming.
            #
            #   @param id [String] The identifier of the run step, which can be referenced in API endpoints.
            #
            #   @param delta [OpenAI::Models::Beta::Threads::Runs::RunStepDelta] The delta containing the fields that have changed on the run step.
            #
            #   @param object [Symbol, :"thread.run.step.delta"] The object type, which is always `thread.run.step.delta`.
          end
        end

        RunStepDeltaEvent = Runs::RunStepDeltaEvent
      end
    end
  end
end
