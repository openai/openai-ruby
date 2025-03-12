# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class RunStepDeltaMessageDelta < OpenAI::BaseModel
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

            # @!parse
            #   # Details of the message creation by the run step.
            #   #
            #   # @param message_creation [OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta::MessageCreation]
            #   # @param type [Symbol, :message_creation]
            #   #
            #   def initialize(message_creation: nil, type: :message_creation, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            class MessageCreation < OpenAI::BaseModel
              # @!attribute [r] message_id
              #   The ID of the message that was created by this run step.
              #
              #   @return [String, nil]
              optional :message_id, String

              # @!parse
              #   # @return [String]
              #   attr_writer :message_id

              # @!parse
              #   # @param message_id [String]
              #   #
              #   def initialize(message_id: nil, **) = super

              # def initialize: (Hash | OpenAI::BaseModel) -> void
            end
          end
        end

        RunStepDeltaMessageDelta = Runs::RunStepDeltaMessageDelta
      end
    end
  end
end
