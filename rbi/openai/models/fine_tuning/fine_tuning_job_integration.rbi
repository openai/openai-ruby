# typed: strong

module OpenAI
  module Models
    module FineTuning
      FineTuningJobIntegration = OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject
    end

    FineTuningJobIntegration = FineTuning::FineTuningJobIntegration
  end
end
