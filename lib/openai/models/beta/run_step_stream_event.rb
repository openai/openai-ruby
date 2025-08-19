# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # Occurs when a
      # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
      # is created.
      module RunStepStreamEvent
        extend OpenAI::Internal::Type::Union

        discriminator :event

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) is created.
        variant :"thread.run.step.created", -> { OpenAI::Beta::RunStepStreamEvent::ThreadRunStepCreated }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) moves to an `in_progress` state.
        variant :"thread.run.step.in_progress", -> { OpenAI::Beta::RunStepStreamEvent::ThreadRunStepInProgress }

        # Occurs when parts of a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) are being streamed.
        variant :"thread.run.step.delta", -> { OpenAI::Beta::RunStepStreamEvent::ThreadRunStepDelta }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) is completed.
        variant :"thread.run.step.completed", -> { OpenAI::Beta::RunStepStreamEvent::ThreadRunStepCompleted }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) fails.
        variant :"thread.run.step.failed", -> { OpenAI::Beta::RunStepStreamEvent::ThreadRunStepFailed }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) is cancelled.
        variant :"thread.run.step.cancelled", -> { OpenAI::Beta::RunStepStreamEvent::ThreadRunStepCancelled }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) expires.
        variant :"thread.run.step.expired", -> { OpenAI::Beta::RunStepStreamEvent::ThreadRunStepExpired }

        class ThreadRunStepCreated < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a step in execution of a run.
          #
          #   @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
          required :data, -> { OpenAI::Beta::Threads::Runs::RunStep }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.step.created"]
          required :event, const: :"thread.run.step.created"

          # @!method initialize(data:, event: :"thread.run.step.created")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCreated} for more
          #   details.
          #
          #   Occurs when a
          #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   is created.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Runs::RunStep] Represents a step in execution of a run.
          #
          #   @param event [Symbol, :"thread.run.step.created"]
        end

        class ThreadRunStepInProgress < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a step in execution of a run.
          #
          #   @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
          required :data, -> { OpenAI::Beta::Threads::Runs::RunStep }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.step.in_progress"]
          required :event, const: :"thread.run.step.in_progress"

          # @!method initialize(data:, event: :"thread.run.step.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepInProgress} for more
          #   details.
          #
          #   Occurs when a
          #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   moves to an `in_progress` state.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Runs::RunStep] Represents a step in execution of a run.
          #
          #   @param event [Symbol, :"thread.run.step.in_progress"]
        end

        class ThreadRunStepDelta < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a run step delta i.e. any changed fields on a run step during
          #   streaming.
          #
          #   @return [OpenAI::Models::Beta::Threads::Runs::RunStepDeltaEvent]
          required :data, -> { OpenAI::Beta::Threads::Runs::RunStepDeltaEvent }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.step.delta"]
          required :event, const: :"thread.run.step.delta"

          # @!method initialize(data:, event: :"thread.run.step.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepDelta} for more details.
          #
          #   Occurs when parts of a
          #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   are being streamed.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Runs::RunStepDeltaEvent] Represents a run step delta i.e. any changed fields on a run step during streami
          #
          #   @param event [Symbol, :"thread.run.step.delta"]
        end

        class ThreadRunStepCompleted < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a step in execution of a run.
          #
          #   @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
          required :data, -> { OpenAI::Beta::Threads::Runs::RunStep }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.step.completed"]
          required :event, const: :"thread.run.step.completed"

          # @!method initialize(data:, event: :"thread.run.step.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCompleted} for more
          #   details.
          #
          #   Occurs when a
          #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   is completed.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Runs::RunStep] Represents a step in execution of a run.
          #
          #   @param event [Symbol, :"thread.run.step.completed"]
        end

        class ThreadRunStepFailed < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a step in execution of a run.
          #
          #   @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
          required :data, -> { OpenAI::Beta::Threads::Runs::RunStep }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.step.failed"]
          required :event, const: :"thread.run.step.failed"

          # @!method initialize(data:, event: :"thread.run.step.failed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepFailed} for more
          #   details.
          #
          #   Occurs when a
          #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   fails.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Runs::RunStep] Represents a step in execution of a run.
          #
          #   @param event [Symbol, :"thread.run.step.failed"]
        end

        class ThreadRunStepCancelled < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a step in execution of a run.
          #
          #   @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
          required :data, -> { OpenAI::Beta::Threads::Runs::RunStep }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.step.cancelled"]
          required :event, const: :"thread.run.step.cancelled"

          # @!method initialize(data:, event: :"thread.run.step.cancelled")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCancelled} for more
          #   details.
          #
          #   Occurs when a
          #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   is cancelled.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Runs::RunStep] Represents a step in execution of a run.
          #
          #   @param event [Symbol, :"thread.run.step.cancelled"]
        end

        class ThreadRunStepExpired < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a step in execution of a run.
          #
          #   @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
          required :data, -> { OpenAI::Beta::Threads::Runs::RunStep }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.step.expired"]
          required :event, const: :"thread.run.step.expired"

          # @!method initialize(data:, event: :"thread.run.step.expired")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepExpired} for more
          #   details.
          #
          #   Occurs when a
          #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   expires.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Runs::RunStep] Represents a step in execution of a run.
          #
          #   @param event [Symbol, :"thread.run.step.expired"]
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCreated, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepInProgress, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepDelta, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCompleted, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepFailed, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCancelled, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepExpired)]
      end
    end
  end
end
