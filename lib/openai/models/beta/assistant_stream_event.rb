# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # Represents an event emitted when streaming a Run.
      #
      # Each event in a server-sent events stream has an `event` and `data` property:
      #
      # ```
      # event: thread.created
      # data: {"id": "thread_123", "object": "thread", ...}
      # ```
      #
      # We emit events whenever a new object is created, transitions to a new state, or
      # is being streamed in parts (deltas). For example, we emit `thread.run.created`
      # when a new run is created, `thread.run.completed` when a run completes, and so
      # on. When an Assistant chooses to create a message during a run, we emit a
      # `thread.message.created event`, a `thread.message.in_progress` event, many
      # `thread.message.delta` events, and finally a `thread.message.completed` event.
      #
      # We may add additional events over time, so we recommend handling unknown events
      # gracefully in your code. See the
      # [Assistants API quickstart](https://platform.openai.com/docs/assistants/overview)
      # to learn how to integrate the Assistants API with streaming.
      module AssistantStreamEvent
        extend OpenAI::Internal::Type::Union

        discriminator :event

        # Occurs when a new [thread](https://platform.openai.com/docs/api-reference/threads/object) is created.
        variant :"thread.created", -> { OpenAI::Beta::AssistantStreamEvent::ThreadCreated }

        # Occurs when a new [run](https://platform.openai.com/docs/api-reference/runs/object) is created.
        variant :"thread.run.created", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunCreated }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) moves to a `queued` status.
        variant :"thread.run.queued", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunQueued }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) moves to an `in_progress` status.
        variant :"thread.run.in_progress", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunInProgress }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) moves to a `requires_action` status.
        variant :"thread.run.requires_action", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunRequiresAction }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) is completed.
        variant :"thread.run.completed", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunCompleted }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) ends with status `incomplete`.
        variant :"thread.run.incomplete", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunIncomplete }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) fails.
        variant :"thread.run.failed", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunFailed }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) moves to a `cancelling` status.
        variant :"thread.run.cancelling", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunCancelling }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) is cancelled.
        variant :"thread.run.cancelled", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunCancelled }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) expires.
        variant :"thread.run.expired", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunExpired }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) is created.
        variant :"thread.run.step.created", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCreated }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) moves to an `in_progress` state.
        variant :"thread.run.step.in_progress", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunStepInProgress }

        # Occurs when parts of a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) are being streamed.
        variant :"thread.run.step.delta", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunStepDelta }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) is completed.
        variant :"thread.run.step.completed", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCompleted }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) fails.
        variant :"thread.run.step.failed", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunStepFailed }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) is cancelled.
        variant :"thread.run.step.cancelled", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunStepCancelled }

        # Occurs when a [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object) expires.
        variant :"thread.run.step.expired", -> { OpenAI::Beta::AssistantStreamEvent::ThreadRunStepExpired }

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) is created.
        variant :"thread.message.created", -> { OpenAI::Beta::AssistantStreamEvent::ThreadMessageCreated }

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) moves to an `in_progress` state.
        variant :"thread.message.in_progress", -> { OpenAI::Beta::AssistantStreamEvent::ThreadMessageInProgress }

        # Occurs when parts of a [Message](https://platform.openai.com/docs/api-reference/messages/object) are being streamed.
        variant :"thread.message.delta", -> { OpenAI::Beta::AssistantStreamEvent::ThreadMessageDelta }

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) is completed.
        variant :"thread.message.completed", -> { OpenAI::Beta::AssistantStreamEvent::ThreadMessageCompleted }

        # Occurs when a [message](https://platform.openai.com/docs/api-reference/messages/object) ends before it is completed.
        variant :"thread.message.incomplete", -> { OpenAI::Beta::AssistantStreamEvent::ThreadMessageIncomplete }

        # Occurs when an [error](https://platform.openai.com/docs/guides/error-codes#api-errors) occurs. This can happen due to an internal server error or a timeout.
        variant :error, -> { OpenAI::Beta::AssistantStreamEvent::ErrorEvent }

        class ThreadCreated < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a thread that contains
          #   [messages](https://platform.openai.com/docs/api-reference/messages).
          #
          #   @return [OpenAI::Models::Beta::Thread]
          required :data, -> { OpenAI::Beta::Thread }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.created"]
          required :event, const: :"thread.created"

          # @!attribute enabled
          #   Whether to enable input audio transcription.
          #
          #   @return [Boolean, nil]
          optional :enabled, OpenAI::Internal::Type::Boolean

          # @!method initialize(data:, enabled: nil, event: :"thread.created")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated} for more details.
          #
          #   Occurs when a new
          #   [thread](https://platform.openai.com/docs/api-reference/threads/object) is
          #   created.
          #
          #   @param data [OpenAI::Models::Beta::Thread] Represents a thread that contains [messages](https://platform.openai.com/docs/ap
          #
          #   @param enabled [Boolean] Whether to enable input audio transcription.
          #
          #   @param event [Symbol, :"thread.created"]
        end

        class ThreadRunCreated < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.created"]
          required :event, const: :"thread.run.created"

          # @!method initialize(data:, event: :"thread.run.created")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated} for more details.
          #
          #   Occurs when a new
          #   [run](https://platform.openai.com/docs/api-reference/runs/object) is created.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.created"]
        end

        class ThreadRunQueued < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.queued"]
          required :event, const: :"thread.run.queued"

          # @!method initialize(data:, event: :"thread.run.queued")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued} for more details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   moves to a `queued` status.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.queued"]
        end

        class ThreadRunInProgress < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.in_progress"]
          required :event, const: :"thread.run.in_progress"

          # @!method initialize(data:, event: :"thread.run.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress} for more
          #   details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   moves to an `in_progress` status.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.in_progress"]
        end

        class ThreadRunRequiresAction < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.requires_action"]
          required :event, const: :"thread.run.requires_action"

          # @!method initialize(data:, event: :"thread.run.requires_action")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction} for more
          #   details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   moves to a `requires_action` status.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.requires_action"]
        end

        class ThreadRunCompleted < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.completed"]
          required :event, const: :"thread.run.completed"

          # @!method initialize(data:, event: :"thread.run.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted} for more
          #   details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   is completed.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.completed"]
        end

        class ThreadRunIncomplete < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.incomplete"]
          required :event, const: :"thread.run.incomplete"

          # @!method initialize(data:, event: :"thread.run.incomplete")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete} for more
          #   details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   ends with status `incomplete`.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.incomplete"]
        end

        class ThreadRunFailed < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.failed"]
          required :event, const: :"thread.run.failed"

          # @!method initialize(data:, event: :"thread.run.failed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed} for more details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   fails.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.failed"]
        end

        class ThreadRunCancelling < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.cancelling"]
          required :event, const: :"thread.run.cancelling"

          # @!method initialize(data:, event: :"thread.run.cancelling")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling} for more
          #   details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   moves to a `cancelling` status.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.cancelling"]
        end

        class ThreadRunCancelled < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.cancelled"]
          required :event, const: :"thread.run.cancelled"

          # @!method initialize(data:, event: :"thread.run.cancelled")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled} for more
          #   details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   is cancelled.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.cancelled"]
        end

        class ThreadRunExpired < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.expired"]
          required :event, const: :"thread.run.expired"

          # @!method initialize(data:, event: :"thread.run.expired")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired} for more details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   expires.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.expired"]
        end

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
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated} for more
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
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress} for more
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
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta} for more
          #   details.
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
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted} for more
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
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed} for more
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
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled} for more
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
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired} for more
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

        class ThreadMessageCreated < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a message within a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Message]
          required :data, -> { OpenAI::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.created"]
          required :event, const: :"thread.message.created"

          # @!method initialize(data:, event: :"thread.message.created")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated} for more
          #   details.
          #
          #   Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) is
          #   created.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Message] Represents a message within a [thread](https://platform.openai.com/docs/api-refe
          #
          #   @param event [Symbol, :"thread.message.created"]
        end

        class ThreadMessageInProgress < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a message within a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Message]
          required :data, -> { OpenAI::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.in_progress"]
          required :event, const: :"thread.message.in_progress"

          # @!method initialize(data:, event: :"thread.message.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress} for more
          #   details.
          #
          #   Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) moves
          #   to an `in_progress` state.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Message] Represents a message within a [thread](https://platform.openai.com/docs/api-refe
          #
          #   @param event [Symbol, :"thread.message.in_progress"]
        end

        class ThreadMessageDelta < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a message delta i.e. any changed fields on a message during
          #   streaming.
          #
          #   @return [OpenAI::Models::Beta::Threads::MessageDeltaEvent]
          required :data, -> { OpenAI::Beta::Threads::MessageDeltaEvent }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.delta"]
          required :event, const: :"thread.message.delta"

          # @!method initialize(data:, event: :"thread.message.delta")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta} for more
          #   details.
          #
          #   Occurs when parts of a
          #   [Message](https://platform.openai.com/docs/api-reference/messages/object) are
          #   being streamed.
          #
          #   @param data [OpenAI::Models::Beta::Threads::MessageDeltaEvent] Represents a message delta i.e. any changed fields on a message during streaming
          #
          #   @param event [Symbol, :"thread.message.delta"]
        end

        class ThreadMessageCompleted < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a message within a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Message]
          required :data, -> { OpenAI::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.completed"]
          required :event, const: :"thread.message.completed"

          # @!method initialize(data:, event: :"thread.message.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted} for more
          #   details.
          #
          #   Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) is
          #   completed.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Message] Represents a message within a [thread](https://platform.openai.com/docs/api-refe
          #
          #   @param event [Symbol, :"thread.message.completed"]
        end

        class ThreadMessageIncomplete < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents a message within a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Models::Beta::Threads::Message]
          required :data, -> { OpenAI::Beta::Threads::Message }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.message.incomplete"]
          required :event, const: :"thread.message.incomplete"

          # @!method initialize(data:, event: :"thread.message.incomplete")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete} for more
          #   details.
          #
          #   Occurs when a
          #   [message](https://platform.openai.com/docs/api-reference/messages/object) ends
          #   before it is completed.
          #
          #   @param data [OpenAI::Models::Beta::Threads::Message] Represents a message within a [thread](https://platform.openai.com/docs/api-refe
          #
          #   @param event [Symbol, :"thread.message.incomplete"]
        end

        class ErrorEvent < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #
          #   @return [OpenAI::Models::ErrorObject]
          required :data, -> { OpenAI::ErrorObject }

          # @!attribute event
          #
          #   @return [Symbol, :error]
          required :event, const: :error

          # @!method initialize(data:, event: :error)
          #   Occurs when an
          #   [error](https://platform.openai.com/docs/guides/error-codes#api-errors) occurs.
          #   This can happen due to an internal server error or a timeout.
          #
          #   @param data [OpenAI::Models::ErrorObject]
          #   @param event [Symbol, :error]
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Models::Beta::AssistantStreamEvent::ThreadCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunQueued, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunRequiresAction, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelling, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepFailed, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepCancelled, OpenAI::Models::Beta::AssistantStreamEvent::ThreadRunStepExpired, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCreated, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageInProgress, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageDelta, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageCompleted, OpenAI::Models::Beta::AssistantStreamEvent::ThreadMessageIncomplete, OpenAI::Models::Beta::AssistantStreamEvent::ErrorEvent)]
      end
    end
  end
end
