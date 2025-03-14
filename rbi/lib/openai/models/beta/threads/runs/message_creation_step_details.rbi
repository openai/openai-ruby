# typed: strong

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class MessageCreationStepDetails < OpenAI::BaseModel
            sig { returns(OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails::MessageCreation) }
            def message_creation
            end

            sig do
              params(_: OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails::MessageCreation)
                .returns(OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails::MessageCreation)
            end
            def message_creation=(_)
            end

            # Always `message_creation`.
            sig { returns(Symbol) }
            def type
            end

            sig { params(_: Symbol).returns(Symbol) }
            def type=(_)
            end

            # Details of the message creation by the run step.
            sig do
              params(
                message_creation: OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails::MessageCreation,
                type: Symbol
              )
                .returns(T.attached_class)
            end
            def self.new(message_creation:, type: :message_creation)
            end

            sig do
              override
                .returns(
                  {
                    message_creation: OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails::MessageCreation,
                    type: Symbol
                  }
                )
            end
            def to_hash
            end

            class MessageCreation < OpenAI::BaseModel
              # The ID of the message that was created by this run step.
              sig { returns(String) }
              def message_id
              end

              sig { params(_: String).returns(String) }
              def message_id=(_)
              end

              sig { params(message_id: String).returns(T.attached_class) }
              def self.new(message_id:)
              end

              sig { override.returns({message_id: String}) }
              def to_hash
              end
            end
          end
        end
      end
    end
  end
end
