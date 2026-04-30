# frozen_string_literal: true

require_relative "../../../../test_helper"

class OpenAI::Test::Resources::Admin::Organization::Projects::RateLimitsTest < OpenAI::Test::ResourceTest
  def test_list_rate_limits
    response = @openai.admin.organization.projects.rate_limits.list_rate_limits("project_id")

    assert_pattern do
      response => OpenAI::Internal::ConversationCursorPage
    end

    row = response.to_enum.first
    return if row.nil?

    assert_pattern do
      row => OpenAI::Admin::Organization::Projects::ProjectRateLimit
    end

    assert_pattern do
      row => {
        id: String,
        max_requests_per_1_minute: Integer,
        max_tokens_per_1_minute: Integer,
        model: String,
        object: Symbol,
        batch_1_day_max_input_tokens: Integer | nil,
        max_audio_megabytes_per_1_minute: Integer | nil,
        max_images_per_1_minute: Integer | nil,
        max_requests_per_1_day: Integer | nil
      }
    end
  end

  def test_update_rate_limit_required_params
    response =
      @openai.admin.organization.projects.rate_limits.update_rate_limit(
        "rate_limit_id",
        project_id: "project_id"
      )

    assert_pattern do
      response => OpenAI::Admin::Organization::Projects::ProjectRateLimit
    end

    assert_pattern do
      response => {
        id: String,
        max_requests_per_1_minute: Integer,
        max_tokens_per_1_minute: Integer,
        model: String,
        object: Symbol,
        batch_1_day_max_input_tokens: Integer | nil,
        max_audio_megabytes_per_1_minute: Integer | nil,
        max_images_per_1_minute: Integer | nil,
        max_requests_per_1_day: Integer | nil
      }
    end
  end
end
