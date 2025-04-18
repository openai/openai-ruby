# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class RunStepDelta < OpenAI::Internal::Type::BaseModel
            # @!attribute [r] step_details
            #   The details of the run step.
            #
            #   @return [OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta, OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject, nil]
            optional :step_details, union: -> { OpenAI::Models::Beta::Threads::Runs::RunStepDelta::StepDetails }

            # @!parse
            #   # @return [OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta, OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject]
            #   attr_writer :step_details

            # @!method initialize(step_details: nil)
            #   The delta containing the fields that have changed on the run step.
            #
            #   @param step_details [OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta, OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject]

            # The details of the run step.
            #
            # @see OpenAI::Models::Beta::Threads::Runs::RunStepDelta#step_details
            module StepDetails
              extend OpenAI::Internal::Type::Union

              discriminator :type

              # Details of the message creation by the run step.
              variant :message_creation, -> { OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta }

              # Details of the tool call.
              variant :tool_calls, -> { OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject }

              # @!method self.variants
              #   @return [Array(OpenAI::Models::Beta::Threads::Runs::RunStepDeltaMessageDelta, OpenAI::Models::Beta::Threads::Runs::ToolCallDeltaObject)]
            end
          end
        end

        RunStepDelta = Runs::RunStepDelta
      end
    end
  end
end
