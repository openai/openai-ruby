# frozen_string_literal: true

module OpenAI
  module Models
    module Beta
      module Threads
        module Runs
          class RunStepDelta < OpenAI::Internal::Type::BaseModel
            # @!attribute step_details
            #   The details of the run step.
            #
            #   @return [OpenAI::Beta::Threads::Runs::RunStepDeltaMessageDelta, OpenAI::Beta::Threads::Runs::ToolCallDeltaObject, nil]
            optional :step_details, union: -> { OpenAI::Beta::Threads::Runs::RunStepDelta::StepDetails }

            # @!method initialize(step_details: nil)
            #   The delta containing the fields that have changed on the run step.
            #
            #   @param step_details [OpenAI::Beta::Threads::Runs::RunStepDeltaMessageDelta, OpenAI::Beta::Threads::Runs::ToolCallDeltaObject] The details of the run step.

            # The details of the run step.
            #
            # @see OpenAI::Beta::Threads::Runs::RunStepDelta#step_details
            module StepDetails
              extend OpenAI::Internal::Type::Union

              discriminator :type

              # Details of the message creation by the run step.
              variant :message_creation, -> { OpenAI::Beta::Threads::Runs::RunStepDeltaMessageDelta }

              # Details of the tool call.
              variant :tool_calls, -> { OpenAI::Beta::Threads::Runs::ToolCallDeltaObject }

              # @!method self.variants
              #   @return [Array(OpenAI::Beta::Threads::Runs::RunStepDeltaMessageDelta, OpenAI::Beta::Threads::Runs::ToolCallDeltaObject)]

              define_sorbet_constant!(:Variants) do
                T.type_alias do
                  T.any(
                    OpenAI::Beta::Threads::Runs::RunStepDeltaMessageDelta,
                    OpenAI::Beta::Threads::Runs::ToolCallDeltaObject
                  )
                end
              end
            end
          end
        end

        RunStepDelta = Runs::RunStepDelta
      end
    end
  end
end
