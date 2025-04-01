# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class MessageCreationStepDetails < OpenAI::BaseModel
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

            # @!parse
            #   # Details of the message creation by the run step.
            #   #
            #   # @param message_creation [OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails::MessageCreation]
            #   # @param type [Symbol, :message_creation]
            #   #
            #   def initialize(message_creation:, type: :message_creation, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            # @see OpenAI::Models::Beta::Threads::Runs::MessageCreationStepDetails#message_creation
            class MessageCreation < OpenAI::BaseModel
              # @!attribute message_id
              #   The ID of the message that was created by this run step.
              #
              #   @return [String]
              required :message_id, String

              # @!parse
              #   # @param message_id [String]
              #   #
              #   def initialize(message_id:, **) = super

              # def initialize: (Hash | OpenAI::BaseModel) -> void
            end
          end
        end
      end
    end
  end
end
