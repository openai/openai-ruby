# frozen_string_literal: true

require_relative "../../test_helper"

class OpenAI::Test::Resources::Safety::AlertsTest < OpenAI::Test::ResourceTest
  def test_retrieve
    response = @openai.safety.alerts.retrieve("id")

    assert_pattern do
      response => OpenAI::Safety::SafetyAlert
    end

    assert_pattern do
      response => {
          id: String,
          created_at: Integer,
          error_type: OpenAI::Safety::SafetyAlert::ErrorType,
          model: String,
          object: Symbol,
          reason: String | nil,
          request_id: String,
          request_paused: OpenAI::Internal::Type::Boolean,
          response_id: String
        }
    end
  end
end
