# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # Occurs when a
      #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
      #   is created.
      module RunStepStreamEvent
        extend OpenAI::Union

        discriminator :event

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) is created.
        variant :"thread.run.step.created", -> { OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCreated }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) moves to an `in_progress` state.
        variant :"thread.run.step.in_progress",
                -> { OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepInProgress }

        # Occurs when parts of a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) are being streamed.
        variant :"thread.run.step.delta", -> { OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepDelta }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) is completed.
        variant :"thread.run.step.completed",
                -> { OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCompleted }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) fails.
        variant :"thread.run.step.failed", -> { OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepFailed }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) is cancelled.
        variant :"thread.run.step.cancelled",
                -> { OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCancelled }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) expires.
        variant :"thread.run.step.expired", -> { OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepExpired }

        class ThreadRunStepCreated < OpenAI::BaseModel
          # @!attribute data
          #   Represents a step in execution of a run.
          #
          #   @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
          required :data, -> { OpenAI::Models::Beta::Threads::Runs::RunStep }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.step.created"]
          required :event, const: :"thread.run.step.created"

          # @!parse
          #   # Occurs when a
          #   #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   #   is created.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Runs::RunStep]
          #   # @param event [Symbol, :"thread.run.step.created"]
          #   #
          #   def initialize(data:, event: :"thread.run.step.created", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunStepInProgress < OpenAI::BaseModel
          # @!attribute data
          #   Represents a step in execution of a run.
          #
          #   @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
          required :data, -> { OpenAI::Models::Beta::Threads::Runs::RunStep }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.step.in_progress"]
          required :event, const: :"thread.run.step.in_progress"

          # @!parse
          #   # Occurs when a
          #   #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   #   moves to an `in_progress` state.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Runs::RunStep]
          #   # @param event [Symbol, :"thread.run.step.in_progress"]
          #   #
          #   def initialize(data:, event: :"thread.run.step.in_progress", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunStepDelta < OpenAI::BaseModel
          # @!attribute data
          #   Represents a run step delta i.e. any changed fields on a run step during
          #     streaming.
          #
          #   @return [OpenAI::Models::Beta::Threads::Runs::RunStepDeltaEvent]
          required :data, -> { OpenAI::Models::Beta::Threads::Runs::RunStepDeltaEvent }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.step.delta"]
          required :event, const: :"thread.run.step.delta"

          # @!parse
          #   # Occurs when parts of a
          #   #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   #   are being streamed.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Runs::RunStepDeltaEvent]
          #   # @param event [Symbol, :"thread.run.step.delta"]
          #   #
          #   def initialize(data:, event: :"thread.run.step.delta", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunStepCompleted < OpenAI::BaseModel
          # @!attribute data
          #   Represents a step in execution of a run.
          #
          #   @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
          required :data, -> { OpenAI::Models::Beta::Threads::Runs::RunStep }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.step.completed"]
          required :event, const: :"thread.run.step.completed"

          # @!parse
          #   # Occurs when a
          #   #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   #   is completed.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Runs::RunStep]
          #   # @param event [Symbol, :"thread.run.step.completed"]
          #   #
          #   def initialize(data:, event: :"thread.run.step.completed", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunStepFailed < OpenAI::BaseModel
          # @!attribute data
          #   Represents a step in execution of a run.
          #
          #   @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
          required :data, -> { OpenAI::Models::Beta::Threads::Runs::RunStep }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.step.failed"]
          required :event, const: :"thread.run.step.failed"

          # @!parse
          #   # Occurs when a
          #   #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   #   fails.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Runs::RunStep]
          #   # @param event [Symbol, :"thread.run.step.failed"]
          #   #
          #   def initialize(data:, event: :"thread.run.step.failed", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunStepCancelled < OpenAI::BaseModel
          # @!attribute data
          #   Represents a step in execution of a run.
          #
          #   @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
          required :data, -> { OpenAI::Models::Beta::Threads::Runs::RunStep }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.step.cancelled"]
          required :event, const: :"thread.run.step.cancelled"

          # @!parse
          #   # Occurs when a
          #   #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   #   is cancelled.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Runs::RunStep]
          #   # @param event [Symbol, :"thread.run.step.cancelled"]
          #   #
          #   def initialize(data:, event: :"thread.run.step.cancelled", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunStepExpired < OpenAI::BaseModel
          # @!attribute data
          #   Represents a step in execution of a run.
          #
          #   @return [OpenAI::Models::Beta::Threads::Runs::RunStep]
          required :data, -> { OpenAI::Models::Beta::Threads::Runs::RunStep }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.step.expired"]
          required :event, const: :"thread.run.step.expired"

          # @!parse
          #   # Occurs when a
          #   #   [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          #   #   expires.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Runs::RunStep]
          #   # @param event [Symbol, :"thread.run.step.expired"]
          #   #
          #   def initialize(data:, event: :"thread.run.step.expired", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        # @!parse
        #   class << self
        #     # @return [Array(OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCreated, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepInProgress, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepDelta, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCompleted, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepFailed, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepCancelled, OpenAI::Models::Beta::RunStepStreamEvent::ThreadRunStepExpired)]
        #     def variants; end
        #   end
      end
    end
  end
end
