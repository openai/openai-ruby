# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      # Occurs when a new
      # [run](https://platform.openai.com/docs/api-reference/runs/object) is created.
      module RunStreamEvent
        extend OpenAI::Internal::Type::Union

        discriminator :event

        # Occurs when a new [run](https://platform.openai.com/docs/api-reference/runs/object) is created.
        variant :"thread.run.created", -> { OpenAI::Beta::RunStreamEvent::ThreadRunCreated }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) moves to a `queued` status.
        variant :"thread.run.queued", -> { OpenAI::Beta::RunStreamEvent::ThreadRunQueued }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) moves to an `in_progress` status.
        variant :"thread.run.in_progress", -> { OpenAI::Beta::RunStreamEvent::ThreadRunInProgress }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) moves to a `requires_action` status.
        variant :"thread.run.requires_action", -> { OpenAI::Beta::RunStreamEvent::ThreadRunRequiresAction }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) is completed.
        variant :"thread.run.completed", -> { OpenAI::Beta::RunStreamEvent::ThreadRunCompleted }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) ends with status `incomplete`.
        variant :"thread.run.incomplete", -> { OpenAI::Beta::RunStreamEvent::ThreadRunIncomplete }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) fails.
        variant :"thread.run.failed", -> { OpenAI::Beta::RunStreamEvent::ThreadRunFailed }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) moves to a `cancelling` status.
        variant :"thread.run.cancelling", -> { OpenAI::Beta::RunStreamEvent::ThreadRunCancelling }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) is cancelled.
        variant :"thread.run.cancelled", -> { OpenAI::Beta::RunStreamEvent::ThreadRunCancelled }

        # Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object) expires.
        variant :"thread.run.expired", -> { OpenAI::Beta::RunStreamEvent::ThreadRunExpired }

        class ThreadRunCreated < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.created"]
          required :event, const: :"thread.run.created"

          # @!method initialize(data:, event: :"thread.run.created")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::RunStreamEvent::ThreadRunCreated} for more details.
          #
          #   Occurs when a new
          #   [run](https://platform.openai.com/docs/api-reference/runs/object) is created.
          #
          #   @param data [OpenAI::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.created"]
        end

        class ThreadRunQueued < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.queued"]
          required :event, const: :"thread.run.queued"

          # @!method initialize(data:, event: :"thread.run.queued")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::RunStreamEvent::ThreadRunQueued} for more details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   moves to a `queued` status.
          #
          #   @param data [OpenAI::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.queued"]
        end

        class ThreadRunInProgress < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.in_progress"]
          required :event, const: :"thread.run.in_progress"

          # @!method initialize(data:, event: :"thread.run.in_progress")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::RunStreamEvent::ThreadRunInProgress} for more details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   moves to an `in_progress` status.
          #
          #   @param data [OpenAI::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.in_progress"]
        end

        class ThreadRunRequiresAction < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.requires_action"]
          required :event, const: :"thread.run.requires_action"

          # @!method initialize(data:, event: :"thread.run.requires_action")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::RunStreamEvent::ThreadRunRequiresAction} for more details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   moves to a `requires_action` status.
          #
          #   @param data [OpenAI::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.requires_action"]
        end

        class ThreadRunCompleted < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.completed"]
          required :event, const: :"thread.run.completed"

          # @!method initialize(data:, event: :"thread.run.completed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::RunStreamEvent::ThreadRunCompleted} for more details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   is completed.
          #
          #   @param data [OpenAI::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.completed"]
        end

        class ThreadRunIncomplete < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.incomplete"]
          required :event, const: :"thread.run.incomplete"

          # @!method initialize(data:, event: :"thread.run.incomplete")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::RunStreamEvent::ThreadRunIncomplete} for more details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   ends with status `incomplete`.
          #
          #   @param data [OpenAI::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.incomplete"]
        end

        class ThreadRunFailed < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.failed"]
          required :event, const: :"thread.run.failed"

          # @!method initialize(data:, event: :"thread.run.failed")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::RunStreamEvent::ThreadRunFailed} for more details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   fails.
          #
          #   @param data [OpenAI::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.failed"]
        end

        class ThreadRunCancelling < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.cancelling"]
          required :event, const: :"thread.run.cancelling"

          # @!method initialize(data:, event: :"thread.run.cancelling")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::RunStreamEvent::ThreadRunCancelling} for more details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   moves to a `cancelling` status.
          #
          #   @param data [OpenAI::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.cancelling"]
        end

        class ThreadRunCancelled < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.cancelled"]
          required :event, const: :"thread.run.cancelled"

          # @!method initialize(data:, event: :"thread.run.cancelled")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::RunStreamEvent::ThreadRunCancelled} for more details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   is cancelled.
          #
          #   @param data [OpenAI::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.cancelled"]
        end

        class ThreadRunExpired < OpenAI::Internal::Type::BaseModel
          # @!attribute data
          #   Represents an execution run on a
          #   [thread](https://platform.openai.com/docs/api-reference/threads).
          #
          #   @return [OpenAI::Beta::Threads::Run]
          required :data, -> { OpenAI::Beta::Threads::Run }

          # @!attribute event
          #
          #   @return [Symbol, :"thread.run.expired"]
          required :event, const: :"thread.run.expired"

          # @!method initialize(data:, event: :"thread.run.expired")
          #   Some parameter documentations has been truncated, see
          #   {OpenAI::Beta::RunStreamEvent::ThreadRunExpired} for more details.
          #
          #   Occurs when a [run](https://platform.openai.com/docs/api-reference/runs/object)
          #   expires.
          #
          #   @param data [OpenAI::Beta::Threads::Run] Represents an execution run on a [thread](https://platform.openai.com/docs/api-r
          #
          #   @param event [Symbol, :"thread.run.expired"]
        end

        # @!method self.variants
        #   @return [Array(OpenAI::Beta::RunStreamEvent::ThreadRunCreated, OpenAI::Beta::RunStreamEvent::ThreadRunQueued, OpenAI::Beta::RunStreamEvent::ThreadRunInProgress, OpenAI::Beta::RunStreamEvent::ThreadRunRequiresAction, OpenAI::Beta::RunStreamEvent::ThreadRunCompleted, OpenAI::Beta::RunStreamEvent::ThreadRunIncomplete, OpenAI::Beta::RunStreamEvent::ThreadRunFailed, OpenAI::Beta::RunStreamEvent::ThreadRunCancelling, OpenAI::Beta::RunStreamEvent::ThreadRunCancelled, OpenAI::Beta::RunStreamEvent::ThreadRunExpired)]

        define_sorbet_constant!(:Variants) do
          T.type_alias do
            T.any(
              OpenAI::Beta::RunStreamEvent::ThreadRunCreated,
              OpenAI::Beta::RunStreamEvent::ThreadRunQueued,
              OpenAI::Beta::RunStreamEvent::ThreadRunInProgress,
              OpenAI::Beta::RunStreamEvent::ThreadRunRequiresAction,
              OpenAI::Beta::RunStreamEvent::ThreadRunCompleted,
              OpenAI::Beta::RunStreamEvent::ThreadRunIncomplete,
              OpenAI::Beta::RunStreamEvent::ThreadRunFailed,
              OpenAI::Beta::RunStreamEvent::ThreadRunCancelling,
              OpenAI::Beta::RunStreamEvent::ThreadRunCancelled,
              OpenAI::Beta::RunStreamEvent::ThreadRunExpired
            )
          end
        end
      end
    end
  end
end
