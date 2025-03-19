# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class RunStepDeltaMessageDelta < OpenAI::BaseModel
            # Always `message_creation`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation)) }
            def message_creation
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation)
                .returns(OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation)
            end
            def message_creation=(_)
            end

            # Details of the message creation by the run step.
            sig do
              params(
                message_creation: OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation,
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(message_creation: nil, type: :message_creation)
            end

            sig do
              override
                .returns(
                  {
                    type: Symbol,
                    message_creation: OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation
                  }
                )
            end
            def to_hash
            end

            class MessageCreation < OpenAI::BaseModel
              # The ID of the message that was created by this run step.
              sig { returns(T.nilable(String)) }
              def message_id
              end

              sig { params(_: String).returns(String) }
              def message_id=(_)
              end

              sig { params(message_id: String).returns(T.attached_class) }
              def self.new(message_id: nil)
              end

              sig { override.returns({message_id: String}) }
              def to_hash
              end
            end
          end
        end

        RunStepDeltaMessageDelta = Runs::RunStepDeltaMessageDelta
      end
    end
  end
end
