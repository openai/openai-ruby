# frozen_string_literal: true

module OpenAI
  module Models
    module FineTuning
      class FineTuningJobEvent < OpenAI::BaseModel
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

        # @!attribute [r] data
        #   The data associated with the event.
        #
        #   @return [Object, nil]
        optional :data, OpenAI::Unknown

        # @!parse
        #   # @return [Object]
        #   attr_writer :data

        # @!attribute [r] type
        #   The type of event.
        #
        #   @return [Symbol, OpenAI::Models::FineTuning::FineTuningJobEvent::Type, nil]
        optional :type, enum: -> { OpenAI::Models::FineTuning::FineTuningJobEvent::Type }

        # @!parse
        #   # @return [Symbol, OpenAI::Models::FineTuning::FineTuningJobEvent::Type]
        #   attr_writer :type

        # @!parse
        #   # Fine-tuning job event object
        #   #
        #   # @param id [String]
        #   # @param created_at [Integer]
        #   # @param level [Symbol, OpenAI::Models::FineTuning::FineTuningJobEvent::Level]
        #   # @param message [String]
        #   # @param data [Object]
        #   # @param type [Symbol, OpenAI::Models::FineTuning::FineTuningJobEvent::Type]
        #   # @param object [Symbol, :"fine_tuning.job.event"]
        #   #
        #   def initialize(id:, created_at:, level:, message:, data: nil, type: nil, object: :"fine_tuning.job.event", **) = super

        # def initialize: (Hash | OpenAI::BaseModel) -> void

        # The log level of the event.
        module Level
          extend OpenAI::Enum

          INFO = :info
          WARN = :warn
          ERROR = :error

          finalize!
        end

        # The type of event.
        module Type
          extend OpenAI::Enum

          MESSAGE = :message
          METRICS = :metrics

          finalize!
        end
      end
    end

    FineTuningJobEvent = FineTuning::FineTuningJobEvent
  end
end
