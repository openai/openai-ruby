# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::WebhookEndpointWithSecretTest < Minitest::Test
  def test_redaction_preserves_method_ownership_and_subclass_super
    model = OpenAI::Models::Webhooks::WebhookEndpointWithSecret
    [:to_s, :inspect].each do |method|
      assert_equal(model, model.instance_method(method).owner)
      assert_empty(model.instance_method(method).parameters)
      assert_includes(model.public_instance_methods(false), method)
    end

    subclass = Class.new(model) do
      def to_s = "consumer: #{super}"
      def inspect = "consumer: #{super}"
    end

    secret = "whsec_fake_subclass_secret"
    webhook = subclass.new(
      id: "whe_subclass",
      created_at: 0,
      event_types: ["response.completed"],
      name: "Test webhook",
      signing_secret: secret,
      signing_secret_hint: nil,
      url: "https://example.com/webhook"
    )
    original = webhook.deep_to_h

    [webhook.to_s, webhook.inspect, {endpoint: webhook}.inspect].each do |diagnostic|
      assert_includes(diagnostic, "consumer: ")
      assert_includes(diagnostic, "[REDACTED]")
      refute_includes(diagnostic, secret)
    end

    assert_equal(original, webhook.deep_to_h)
    assert_equal(secret, webhook.signing_secret)
    webhook.signing_secret = "whsec_fake_replacement"
    assert_equal("whsec_fake_replacement", webhook.deep_to_h.fetch(:signing_secret))
    refute_includes(webhook.inspect, "whsec_fake_replacement")
  end

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
