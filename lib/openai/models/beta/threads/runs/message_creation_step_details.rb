# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class MessageCreationStepDetails < OpenAI::Internal::Type::BaseModel
            # @!attribute message_creation
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails::MessageCreation]
            required :message_creation,
                     -> { OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails::MessageCreation }

            # @!attribute type
            #   Always `message_creation`.
            #
            #   @return [Symbol, :message_creation]
            required :type, const: :message_creation

            # @!method initialize(message_creation:, type: :message_creation)
            #   Details of the message creation by the run step.
            #
            #   @param message_creation [OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails::MessageCreation]
            #   @param type [Symbol, :message_creation]

            # @see OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails#message_creation
            class MessageCreation < OpenAI::Internal::Type::BaseModel
              # @!attribute message_id
              #   The ID of the message that was created by this run step.
              #
              #   @return [String]
              required :message_id, String

              # @!method initialize(message_id:)
              #   @param message_id [String]
            end
          end
        end
      end
    end
  end
end
