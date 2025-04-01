# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class RunStepDelta < OpenAI::BaseModel
            # @!attribute [r] step_details
            #   The details of the run step.
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta, OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject, nil]
            optional :step_details, union: -> { OpenAI::Models::Beta::Threads::Runs::RunStepDelta::StepDetails }

            # @!parse
            #   # @return [OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta, OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject]
            #   attr_writer :step_details

            # @!parse
            #   # The delta containing the fields that have changed on the run step.
            #   #
            #   # @param step_details [OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta, OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject]
            #   #
            #   def initialize(step_details: nil, **) = super

            # def initialize: (Hash | OpenAI::BaseModel) -> void

            # The details of the run step.
            #
            # @see OpenAI::Models::Beta::Threads::Runs::RunStepDelta#step_details
            module StepDetails
              extend OpenAI::Union

              discriminator :type

              # Details of the message creation by the run step.
              variant :message_creation, -> { OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta }

              # Details of the tool call.
              variant :tool_calls, -> { OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject }

              # @!parse
              #   # @return [Array(OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta, OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject)]
              #   def self.variants; end
            end
          end
        end

        RunStepDelta = Runs::RunStepDelta
      end
    end
  end
end
