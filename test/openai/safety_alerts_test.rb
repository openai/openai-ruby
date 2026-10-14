# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::SafetyAlertsTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
    WebMock.disable_net_connect!
  end

  def after_all
    WebMock.disable!
    super
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_retrieve_preserves_non_null_detailed_explanation
    explanation = "Synthetic explanation: unusual transfer to the test destination."
    url = "http://localhost/safety/alerts/alert_synthetic"
    stub_request(:get, url)
      .with(headers: {"Authorization" => "Bearer fake-project-key"})
      .to_return_json(
        body: {
          id: "alert_synthetic",
          object: "safety.alert",
          created_at: 123,
          error_type: "other",
          model: "model",
          reason: nil,
          request_id: "req_synthetic",
          request_paused: false,
          response_id: "resp_synthetic",
          detailed_explanation: explanation
        }
      )

    client = OpenAI::Client.new(base_url: "http://localhost", api_key: "fake-project-key", max_retries: 0)
    response = client.safety.alerts.retrieve("alert_synthetic")

    assert_requested(:get, url, times: 1)
    assert_instance_of(OpenAI::Safety::SafetyAlert, response)
    assert_equal(explanation, response.detailed_explanation)
  end
end
