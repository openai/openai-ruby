# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        RunStepDeltaMessageDelta = Runs::RunStepDeltaMessageDelta

        module Runs
          class RunStepDeltaMessageDelta < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::Runs::RunStepDeltaMessageDelta,
                  OpenAI::Internal::AnyHash
                )
              end

            # Always `message_creation`.
            sig { returns(Symbol) }
            attr_accessor :type

            sig do
              returns(
                T.nilable(
                  OpenAI::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation
                )
              )
            end
            attr_reader :message_creation

            sig do
              params(
                message_creation:
                  OpenAI::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation::OrHash
              ).void
            end
            attr_writer :message_creation

            # Details of the message creation by the run step.
            sig do
              params(
                message_creation:
                  OpenAI::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation::OrHash,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              message_creation: nil,
              # Always `message_creation`.
              type: :message_creation
            )
            end

            sig do
              override.returns(
                {
                  type: Symbol,
                  message_creation:
                    OpenAI::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation
                }
              )
            end
            def to_hash
            end

            class MessageCreation < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The ID of the message that was created by this run step.
              sig { returns(T.nilable(String)) }
              attr_reader :message_id

              sig { params(message_id: String).void }
              attr_writer :message_id

              sig { params(message_id: String).returns(T.attached_class) }
              def self.new(
                # The ID of the message that was created by this run step.
                message_id: nil
              )
              end

              sig { override.returns({ message_id: String }) }
              def to_hash
              end
            end
          end
        end
      end
    end
  end
end
