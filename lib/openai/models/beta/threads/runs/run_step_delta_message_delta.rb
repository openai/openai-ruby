# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class RunStepDeltaMessageDelta < OpenAI::Internal::Type::BaseModel
            # @!attribute type
            #   Always `message_creation`.
            #
            #   @return [Symbol, :message_creation]
            required :type, const: :message_creation

            # @!attribute [r] message_creation
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation, nil]
            optional :message_creation,
                     -> { OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation }

            # @!parse
            #   # @return [OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation]
            #   attr_writer :message_creation

            # @!method initialize(message_creation: nil, type: :message_creation)
            #   Details of the message creation by the run step.
            #
            #   @param message_creation [OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation]
            #   @param type [Symbol, :message_creation]

            # @see OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta#message_creation
            class MessageCreation < OpenAI::Internal::Type::BaseModel
              # @!attribute [r] message_id
              #   The ID of the message that was created by this run step.
              #
              #   @return [String, nil]
              optional :message_id, String

              # @!parse
              #   # @return [String]
              #   attr_writer :message_id

              # @!method initialize(message_id: nil)
              #   @param message_id [String]
            end
          end
        end

        RunStepDeltaMessageDelta = Runs::RunStepDeltaMessageDelta
      end
    end
  end
end
