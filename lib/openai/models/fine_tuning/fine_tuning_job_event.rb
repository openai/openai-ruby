# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      # @see OpenAI::Resources::FineTuning::Jobs#list_events
      class FineTuningJobEvent < OpenAI::Internal::Type::BaseModel
        # @!attribute id
        #   The object identifier.
        #
        #   @return [String]
        required :id, String

        # @!attribute created_at
        #   The Unix timestamp (in seconds) for when the fine-tuning job was created.
        #
        #   @return [Integer]
        required :created_at, Integer

        # @!attribute level
        #   The log level of the event.
        #
        #   @return [Symbol, OpenAI::Models::FineTuning::FineTuningJobEvent::Level]
        required :level, enum: -> { OpenAI::Models::FineTuning::FineTuningJobEvent::Level }

        # @!attribute message
        #   The message of the event.
        #
        #   @return [String]
        required :message, String

        # @!attribute object
        #   The object type, which is always "fine_tuning.job.event".
        #
        #   @return [Symbol, :"fine_tuning.job.event"]
        required :object, const: :"fine_tuning.job.event"

        # @!attribute data
        #   The data associated with the event.
        #
        #   @return [Object, nil]
        optional :data, OpenAI::Internal::Type::Unknown

        # @!attribute type
        #   The type of event.
        #
        #   @return [Symbol, OpenAI::Models::FineTuning::FineTuningJobEvent::Type, nil]
        optional :type, enum: -> { OpenAI::Models::FineTuning::FineTuningJobEvent::Type }

        # @!method initialize(id:, created_at:, level:, message:, data: nil, type: nil, object: :"fine_tuning.job.event")
        #   Fine-tuning job event object
        #
        #   @param id [String] The object identifier.
        #
        #   @param created_at [Integer] The Unix timestamp (in seconds) for when the fine-tuning job was created.
        #
        #   @param level [Symbol, OpenAI::Models::FineTuning::FineTuningJobEvent::Level] The log level of the event.
        #
        #   @param message [String] The message of the event.
        #
        #   @param data [Object] The data associated with the event.
        #
        #   @param type [Symbol, OpenAI::Models::FineTuning::FineTuningJobEvent::Type] The type of event.
        #
        #   @param object [Symbol, :"fine_tuning.job.event"] The object type, which is always "fine_tuning.job.event".

        # The log level of the event.
        #
        # @see OpenAI::Models::FineTuning::FineTuningJobEvent#level
        module Level
          extend OpenAI::Internal::Type::Enum

          INFO = :info
          WARN = :warn
          ERROR = :error

          # @!method self.values
          #   @return [Array<Symbol>]
        end

        # The type of event.
        #
        # @see OpenAI::Models::FineTuning::FineTuningJobEvent#type
        module Type
          extend OpenAI::Internal::Type::Enum

          MESSAGE = :message
          METRICS = :metrics

          # @!method self.values
          #   @return [Array<Symbol>]
        end
      end
    end

    FineTuningJobEvent = FineTuning::FineTuningJobEvent
  end
end
