# typed: strong

module OpenAI
  module Models
    FineTuningJobIntegration = FineTuning::FineTuningJobIntegration

    module FineTuning
      FineTuningJobIntegration = OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject
    end
  end
end
