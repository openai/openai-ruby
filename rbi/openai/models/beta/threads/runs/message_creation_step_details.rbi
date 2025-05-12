# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class MessageCreationStepDetails < OpenAI::Internal::Type::BaseModel
            OrHash =
              T.type_alias do
                T.any(
                  OpenAI::Beta::Threads::Runs::MessageCreationStepDetails,
                  OpenAI::Internal::AnyHash
                )
              end

            sig do
              returns(
                OpenAI::Beta::Threads::Runs::MessageCreationStepDetails::MessageCreation
              )
            end
            attr_reader :message_creation

            sig do
              params(
                message_creation:
                  OpenAI::Beta::Threads::Runs::MessageCreationStepDetails::MessageCreation::OrHash
              ).void
            end
            attr_writer :message_creation

            # Always `message_creation`.
            sig { returns(Symbol) }
            attr_accessor :type

            # Details of the message creation by the run step.
            sig do
              params(
                message_creation:
                  OpenAI::Beta::Threads::Runs::MessageCreationStepDetails::MessageCreation::OrHash,
                type: Symbol
              ).returns(T.attached_class)
            end
            def self.new(
              message_creation:,
              # Always `message_creation`.
              type: :message_creation
            )
            end

            sig do
              override.returns(
                {
                  message_creation:
                    OpenAI::Beta::Threads::Runs::MessageCreationStepDetails::MessageCreation,
                  type: Symbol
                }
              )
            end
            def to_hash
            end

            class MessageCreation < OpenAI::Internal::Type::BaseModel
              OrHash =
                T.type_alias do
                  T.any(
                    OpenAI::Beta::Threads::Runs::MessageCreationStepDetails::MessageCreation,
                    OpenAI::Internal::AnyHash
                  )
                end

              # The ID of the message that was created by this run step.
              sig { returns(String) }
              attr_accessor :message_id

              sig { params(message_id: String).returns(T.attached_class) }
              def self.new(
                # The ID of the message that was created by this run step.
                message_id:
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
