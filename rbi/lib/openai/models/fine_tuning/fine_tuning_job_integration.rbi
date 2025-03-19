# typed: strong

module OpenAI
  module Models
    FineTuningJobIntegration = T.type_alias { FineTuning::FineTuningJobIntegration }

    module FineTuning
      FineTuningJobIntegration =
        T.type_alias { OpenAI::Models::FineTuning::FineTuningJobWandbIntegrationObject }
    end
  end
end
