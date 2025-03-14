# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # @abstract
      #
      # Represents an event emitted when streaming a Run.
      #
      #   Each event in a server-sent events stream has an `event` and `data` property:
      #
      #   ```
      #   event: thread.created
      #   data: {"id": "thread_123", "object": "thread", ...}
      #   ```
      #
      #   We emit events whenever a new object is created, transitions to a new state, or
      #   is being streamed in parts (deltas). For example, we emit `thread.run.created`
      #   when a new run is created, `thread.run.completed` when a run completes, and so
      #   on. When an Assistant chooses to create a message during a run, we emit a
      #   `thread.message.created event`, a `thread.message.in_progress` event, many
      #   `thread.message.delta` events, and finally a `thread.message.completed` event.
      #
      #   We may add additional events over time, so we recommend handling unknown events
      #   gracefully in your code. See the
      #   [Assistants API quickstart](https://platform.openai.com/docs/assistants/overview)
      #   to learn how to integrate the Assistants API with streaming.
      class AssistantStreamEvent < OpenAI::Union
        discriminator :event

        # Occurs when a new [thread](https://platform.openai.com/docs/api-reference/threads/object) is created.
        variant :"thread.created", -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated }

        # Occurs when a new [run](https://platform.openai.com/docs/api-reference/runs/object) is created.
        variant :"thread.run.created", -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) moves to a `queued` status.
        variant :"thread.run.queued", -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) moves to an `in_progress` status.
        variant :"thread.run.in_progress", -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) moves to a `requires_action` status.
        variant :"thread.run.requires_action",
                -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) is completed.
        variant :"thread.run.completed", -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) ends with status `incomplete`.
        variant :"thread.run.incomplete", -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) fails.
        variant :"thread.run.failed", -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) moves to a `cancelling` status.
        variant :"thread.run.cancelling", -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) is cancelled.
        variant :"thread.run.cancelled", -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) expires.
        variant :"thread.run.expired", -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) is created.
        variant :"thread.run.step.created",
                -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) moves to an `in_progress` state.
        variant :"thread.run.step.in_progress",
                -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress }

        # Occurs when parts of a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) are being streamed.
        variant :"thread.run.step.delta", -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) is completed.
        variant :"thread.run.step.completed",
                -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) fails.
        variant :"thread.run.step.failed", -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) is cancelled.
        variant :"thread.run.step.cancelled",
                -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) expires.
        variant :"thread.run.step.expired",
                -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired }

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) is created.
        variant :"thread.message.created", -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated }

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) moves to an `in_progress` state.
        variant :"thread.message.in_progress",
                -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress }

        # Occurs when parts of a [Message](https://platform.openai.com/docs/api-reference/messages/object) are being streamed.
        variant :"thread.message.delta", -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta }

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) is completed.
        variant :"thread.message.completed",
                -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted }

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) ends before it is completed.
        variant :"thread.message.incomplete",
                -> { OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete }

        # Occurs when an [error](https://platform.openai.com/docs/guides/error-codes#api-errors) occurs. This can happen due to an internal server error or a timeout.
        variant :error, -> { OpenAI::Models::Beta::AssistantStreamEvent::ErrorEvent }

        class ThreadCreated < OpenAI::BaseModel
          # @!attribute data
          #   Represents a thread that contains
          #     [messages](https://platform.openai.com/docs/api-reference/messages).
          #
          #   @return [OpenAI::Models::Beta::Thread]
          required :data, -> { OpenAI::Models::Beta::Thread }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.created"]
          required :event, const: :"thread.created"

          # @!attribute [r] enabled
          #   Whether to enable input audio transcription.
          #
          #   @return [Boolean, nil]
          optional :enabled, OpenAI::BooleanModel

          # @!parse
          #   # @return [Boolean]
          #   attr_writer :enabled

          # @!parse
          #   # Occurs when a new
          #   #   [thread](https://platform.openai.com/docs/api-reference/threads/object) is
          #   #   created.
          #   #
          #   # @param data [OpenAI::Models::Beta::Thread]
          #   # @param enabled [Boolean]
          #   # @param event [Symbol, :"thread.created"]
          #   #
          #   def initialize(data:, enabled: nil, event: :"thread.created", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunCreated < OpenAI::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Models::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.created"]
          required :event, const: :"thread.run.created"

          # @!parse
          #   # Occurs when a new
          #   #   [run](https://platform.openai.com/docs/api-reference/runs/object) is created.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Run]
          #   # @param event [Symbol, :"thread.run.created"]
          #   #
          #   def initialize(data:, event: :"thread.run.created", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunQueued < OpenAI::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Models::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.queued"]
          required :event, const: :"thread.run.queued"

          # @!parse
          #   # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   #   moves to a `queued` status.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Run]
          #   # @param event [Symbol, :"thread.run.queued"]
          #   #
          #   def initialize(data:, event: :"thread.run.queued", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunInProgress < OpenAI::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Models::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.in_progress"]
          required :event, const: :"thread.run.in_progress"

          # @!parse
          #   # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   #   moves to an `in_progress` status.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Run]
          #   # @param event [Symbol, :"thread.run.in_progress"]
          #   #
          #   def initialize(data:, event: :"thread.run.in_progress", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunRequiresAction < OpenAI::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Models::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.requires_action"]
          required :event, const: :"thread.run.requires_action"

          # @!parse
          #   # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   #   moves to a `requires_action` status.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Run]
          #   # @param event [Symbol, :"thread.run.requires_action"]
          #   #
          #   def initialize(data:, event: :"thread.run.requires_action", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunCompleted < OpenAI::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Models::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.completed"]
          required :event, const: :"thread.run.completed"

          # @!parse
          #   # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   #   is completed.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Run]
          #   # @param event [Symbol, :"thread.run.completed"]
          #   #
          #   def initialize(data:, event: :"thread.run.completed", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunIncomplete < OpenAI::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Models::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.incomplete"]
          required :event, const: :"thread.run.incomplete"

          # @!parse
          #   # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   #   ends with status `incomplete`.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Run]
          #   # @param event [Symbol, :"thread.run.incomplete"]
          #   #
          #   def initialize(data:, event: :"thread.run.incomplete", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunFailed < OpenAI::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Models::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.failed"]
          required :event, const: :"thread.run.failed"

          # @!parse
          #   # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   #   fails.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Run]
          #   # @param event [Symbol, :"thread.run.failed"]
          #   #
          #   def initialize(data:, event: :"thread.run.failed", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunCancelling < OpenAI::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Models::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.cancelling"]
          required :event, const: :"thread.run.cancelling"

          # @!parse
          #   # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   #   moves to a `cancelling` status.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Run]
          #   # @param event [Symbol, :"thread.run.cancelling"]
          #   #
          #   def initialize(data:, event: :"thread.run.cancelling", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunCancelled < OpenAI::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Models::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.cancelled"]
          required :event, const: :"thread.run.cancelled"

          # @!parse
          #   # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   #   is cancelled.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Run]
          #   # @param event [Symbol, :"thread.run.cancelled"]
          #   #
          #   def initialize(data:, event: :"thread.run.cancelled", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadRunExpired < OpenAI::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Models::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.expired"]
          required :event, const: :"thread.run.expired"

          # @!parse
          #   # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   #   expires.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Run]
          #   # @param event [Symbol, :"thread.run.expired"]
          #   #
          #   def initialize(data:, event: :"thread.run.expired", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

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

        class ThreadMessageCreated < OpenAI::BaseModel
          # @!attribute data
          #   Represents a message within a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Message]
          required :data, -> { OpenAI::Models::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.created"]
          required :event, const: :"thread.message.created"

          # @!parse
          #   # Occurs when a
          #   #   [message](https://platform.openai.com/docs/api-reference/messages/object) is
          #   #   created.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Message]
          #   # @param event [Symbol, :"thread.message.created"]
          #   #
          #   def initialize(data:, event: :"thread.message.created", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadMessageInProgress < OpenAI::BaseModel
          # @!attribute data
          #   Represents a message within a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Message]
          required :data, -> { OpenAI::Models::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.in_progress"]
          required :event, const: :"thread.message.in_progress"

          # @!parse
          #   # Occurs when a
          #   #   [message](https://platform.openai.com/docs/api-reference/messages/object) moves
          #   #   to an `in_progress` state.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Message]
          #   # @param event [Symbol, :"thread.message.in_progress"]
          #   #
          #   def initialize(data:, event: :"thread.message.in_progress", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadMessageDelta < OpenAI::BaseModel
          # @!attribute data
          #   Represents a message delta i.e. any changed fields on a message during
          #     streaming.
          #
          #   @return [OpenAI::Models::Beta::Threads::MessageDeltaEvent]
          required :data, -> { OpenAI::Models::Beta::Threads::MessageDeltaEvent }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.delta"]
          required :event, const: :"thread.message.delta"

          # @!parse
          #   # Occurs when parts of a
          #   #   [Message](https://platform.openai.com/docs/api-reference/messages/object) are
          #   #   being streamed.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::MessageDeltaEvent]
          #   # @param event [Symbol, :"thread.message.delta"]
          #   #
          #   def initialize(data:, event: :"thread.message.delta", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadMessageCompleted < OpenAI::BaseModel
          # @!attribute data
          #   Represents a message within a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Message]
          required :data, -> { OpenAI::Models::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.completed"]
          required :event, const: :"thread.message.completed"

          # @!parse
          #   # Occurs when a
          #   #   [message](https://platform.openai.com/docs/api-reference/messages/object) is
          #   #   completed.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Message]
          #   # @param event [Symbol, :"thread.message.completed"]
          #   #
          #   def initialize(data:, event: :"thread.message.completed", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ThreadMessageIncomplete < OpenAI::BaseModel
          # @!attribute data
          #   Represents a message within a
          #     [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Message]
          required :data, -> { OpenAI::Models::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.incomplete"]
          required :event, const: :"thread.message.incomplete"

          # @!parse
          #   # Occurs when a
          #   #   [message](https://platform.openai.com/docs/api-reference/messages/object) ends
          #   #   before it is completed.
          #   #
          #   # @param data [OpenAI::Models::Beta::Threads::Message]
          #   # @param event [Symbol, :"thread.message.incomplete"]
          #   #
          #   def initialize(data:, event: :"thread.message.incomplete", **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        class ErrorEvent < OpenAI::BaseModel
          # @!attribute data
          #
          #   @return [OpenAI::Models::ErrorObject]
          required :data, -> { OpenAI::Models::ErrorObject }

          # @!attribute event
          #
          #   @return [Symbol, :error]
          required :event, const: :error

          # @!parse
          #   # Occurs when an
          #   #   [error](https://platform.openai.com/docs/guides/error-codes#api-errors) occurs.
          #   #   This can happen due to an internal server error or a timeout.
          #   #
          #   # @param data [OpenAI::Models::ErrorObject]
          #   # @param event [Symbol, :error]
          #   #
          #   def initialize(data:, event: :error, **) = super

          # def initialize: (Hash | OpenAI::BaseModel) -> void
        end

        # @!parse
        #   class << self
        #     # @return [Array(OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ErrorEvent)]
        #     def variants; end
        #   end
      end
    end
  end
end
