# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class RunStepDeltaMessageDelta < OpenAI::BaseModel
            # Always `message_creation`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig { returns(T.nilable(OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation)) }
            attr_reader :message_creation

            sig do
              params(
                message_creation: T.any(
                  OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation,
                  OpenAI::Internal::Util::AnyHash
                )
              )
                .void
            end
            attr_writer :message_creation

            # Details of the message creation by the run step.
            sig do
              params(
                message_creation: T.any(
                  OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation,
                  OpenAI::Internal::Util::AnyHash
                ),
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
              attr_reader :message_id

              sig { params(message_id: String).void }
              attr_writer :message_id

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
