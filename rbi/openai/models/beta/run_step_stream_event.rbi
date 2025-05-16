# typed: strong

module OpenAI
  module Models
    module Beta
      # Occurs when a
      # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
      # is created.
      module RunStepStreamEvent
        extend OpenAI::Internal::Type::Union

        Variants =
          T.type_alias do
            T.any(
              OpenAI::Beta::RunStepStreamEvent::ThreadRunStepCreated,
              OpenAI::Beta::RunStepStreamEvent::ThreadRunStepInProgress,
              OpenAI::Beta::RunStepStreamEvent::ThreadRunStepDelta,
              OpenAI::Beta::RunStepStreamEvent::ThreadRunStepCompleted,
              OpenAI::Beta::RunStepStreamEvent::ThreadRunStepFailed,
              OpenAI::Beta::RunStepStreamEvent::ThreadRunStepCancelled,
              OpenAI::Beta::RunStepStreamEvent::ThreadRunStepExpired
            )
          end

        class ThreadRunStepCreated < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::RunStepStreamEvent::ThreadRunStepCreated,
                OpenAI::Internal::AnyHash
              )
            end

          # Represents a step in execution of a run.
          sig { returns(OpenAI::Beta::Threads::Runs::RunStep) }
          attr_reader :data

          sig do
            params(data: OpenAI::Beta::Threads::Runs::RunStep::OrHash).void
          end
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          # is created.
          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStep::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a step in execution of a run.
            data:,
            event: :"thread.run.step.created"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Runs::RunStep, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunStepInProgress < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::RunStepStreamEvent::ThreadRunStepInProgress,
                OpenAI::Internal::AnyHash
              )
            end

          # Represents a step in execution of a run.
          sig { returns(OpenAI::Beta::Threads::Runs::RunStep) }
          attr_reader :data

          sig do
            params(data: OpenAI::Beta::Threads::Runs::RunStep::OrHash).void
          end
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          # moves to an `in_progress` state.
          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStep::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a step in execution of a run.
            data:,
            event: :"thread.run.step.in_progress"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Runs::RunStep, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunStepDelta < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::RunStepStreamEvent::ThreadRunStepDelta,
                OpenAI::Internal::AnyHash
              )
            end

          # Represents a run step delta i.e. any changed fields on a run step during
          # streaming.
          sig { returns(OpenAI::Beta::Threads::Runs::RunStepDeltaEvent) }
          attr_reader :data

          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStepDeltaEvent::OrHash
            ).void
          end
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when parts of a
          # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          # are being streamed.
          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStepDeltaEvent::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a run step delta i.e. any changed fields on a run step during
            # streaming.
            data:,
            event: :"thread.run.step.delta"
          )
          end

          sig do
            override.returns(
              {
                data: OpenAI::Beta::Threads::Runs::RunStepDeltaEvent,
                event: Symbol
              }
            )
          end
          def to_hash
          end
        end

        class ThreadRunStepCompleted < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::RunStepStreamEvent::ThreadRunStepCompleted,
                OpenAI::Internal::AnyHash
              )
            end

          # Represents a step in execution of a run.
          sig { returns(OpenAI::Beta::Threads::Runs::RunStep) }
          attr_reader :data

          sig do
            params(data: OpenAI::Beta::Threads::Runs::RunStep::OrHash).void
          end
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          # is completed.
          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStep::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a step in execution of a run.
            data:,
            event: :"thread.run.step.completed"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Runs::RunStep, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunStepFailed < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::RunStepStreamEvent::ThreadRunStepFailed,
                OpenAI::Internal::AnyHash
              )
            end

          # Represents a step in execution of a run.
          sig { returns(OpenAI::Beta::Threads::Runs::RunStep) }
          attr_reader :data

          sig do
            params(data: OpenAI::Beta::Threads::Runs::RunStep::OrHash).void
          end
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          # fails.
          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStep::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a step in execution of a run.
            data:,
            event: :"thread.run.step.failed"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Runs::RunStep, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunStepCancelled < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::RunStepStreamEvent::ThreadRunStepCancelled,
                OpenAI::Internal::AnyHash
              )
            end

          # Represents a step in execution of a run.
          sig { returns(OpenAI::Beta::Threads::Runs::RunStep) }
          attr_reader :data

          sig do
            params(data: OpenAI::Beta::Threads::Runs::RunStep::OrHash).void
          end
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          # is cancelled.
          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStep::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a step in execution of a run.
            data:,
            event: :"thread.run.step.cancelled"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Runs::RunStep, event: Symbol }
            )
          end
          def to_hash
          end
        end

        class ThreadRunStepExpired < OpenAI::Internal::Type::BaseModel
          OrHash =
            T.type_alias do
              T.any(
                OpenAI::Beta::RunStepStreamEvent::ThreadRunStepExpired,
                OpenAI::Internal::AnyHash
              )
            end

          # Represents a step in execution of a run.
          sig { returns(OpenAI::Beta::Threads::Runs::RunStep) }
          attr_reader :data

          sig do
            params(data: OpenAI::Beta::Threads::Runs::RunStep::OrHash).void
          end
          attr_writer :data

          sig { returns(Symbol) }
          attr_accessor :event

          # Occurs when a
          # [run step](https://platform.openai.com/docs/api-reference/run-steps/step-object)
          # expires.
          sig do
            params(
              data: OpenAI::Beta::Threads::Runs::RunStep::OrHash,
              event: Symbol
            ).returns(T.attached_class)
          end
          def self.new(
            # Represents a step in execution of a run.
            data:,
            event: :"thread.run.step.expired"
          )
          end

          sig do
            override.returns(
              { data: OpenAI::Beta::Threads::Runs::RunStep, event: Symbol }
            )
          end
          def to_hash
          end
        end

        sig do
          override.returns(T::Array[OpenAI::Beta::RunStepStreamEvent::Variants])
        end
        def self.variants
        end
      end
    end
  end
end
