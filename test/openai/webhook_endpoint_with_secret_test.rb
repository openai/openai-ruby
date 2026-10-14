# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::WebhookEndpointWithSecretTest < Minitest::Test
  def test_signing_secret_is_redacted_from_diagnostics
    secret = "whsec_test_only_do_not_log"
    webhook = OpenAI::Models::Webhooks::WebhookEndpointWithSecret.new(
      id: "whe_test",
      created_at: 0,
      event_types: ["response.completed"],
      name: "Test webhook",
      signing_secret: secret,
      signing_secret_hint: nil,
      url: "https://example.com/webhook"
    )

    [webhook.inspect, webhook.to_s, [webhook].inspect].each do |diagnostic|
      refute_includes(diagnostic, secret)
      assert_includes(diagnostic, "[REDACTED]")
      assert_includes(diagnostic, "whe_test")
    end

    assert_equal(secret, webhook.signing_secret)
    assert_equal(secret, webhook.deep_to_h.fetch(:signing_secret))
  end
end
