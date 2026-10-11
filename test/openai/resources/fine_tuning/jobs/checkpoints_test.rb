# frozen_string_literal: true

require_relative "../../../test_helper"

class OpenAI::Test::Resources::FineTuning::Jobs::CheckpointsTest < OpenAI::Test::ResourceTest
  def test_list
    response = @openai.fine_tuning.jobs.checkpoints.list("ft-AF1WoRqd3aJAHsqc9NY7iL8F")

    assert_pattern do
      response => OpenAI::Internal::CursorPage
    end

    # Validate this response only; pagination is covered with finite fixtures.
    row = response.data&.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::FineTuning::Jobs::FineTuningJobCheckpoint
    end

    assert_pattern do
      row => {
          id: String,
          created_at: Integer,
          fine_tuned_model_checkpoint: String,
          fine_tuning_job_id: String,
          metrics: OpenAI::FineTuning::Jobs::FineTuningJobCheckpoint::Metrics,
          object: Symbol,
          step_number: Integer
        }
    end
  end
end
