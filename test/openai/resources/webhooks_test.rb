# frozen_string_literal: true

require_relative "../test_helper"
require "base64"
require "openssl"

class OpenAI::Test::Resources::WebhooksTest < OpenAI::Test::ResourceTest
  def setup
    super
    @client = OpenAI::Client.new(
      api_key: "test-api-key",
      webhook_secret: "whsec_RdvaYFYUXuIFuEbvZHwMfYFhUf7aMYjYcmM24+Aj40c="
    )
    @webhook_service = @client.webhooks

    # Standardized test data matching TypeScript
    @test_payload = '{"id": "evt_685c059ae3a481909bdc86819b066fb6", "object": "event", "created_at": 1750861210, "type": "response.completed", "data": {"id": "resp_123"}}'
    @test_secret = "whsec_RdvaYFYUXuIFuEbvZHwMfYFhUf7aMYjYcmM24+Aj40c="

    @fixed_timestamp = "1750861210"
    @webhook_id = "wh_685c059ae39c8190af8c71ed1022a24d"
    @webhook_signature = "v1,gUAg4R2hWouRZqRQG4uJypNS8YK885G838+EHb4nKBY="

    # Mock Time.now to return our fixed timestamp using the SDK's built-in mechanism
    Thread.current.thread_variable_set(:time_now, Time.at(1_750_861_210))
  end

  def teardown
    super
    # Restore original time
    Thread.current.thread_variable_set(:time_now, nil)
  end

  def test_verify_signature_with_invalid_secret
    headers = {
      "webhook-signature" => "v1,invalid_signature",
      "webhook-timestamp" => @fixed_timestamp,
      "webhook-id" => @webhook_id
    }

    assert_raises(ArgumentError) do
      @webhook_service.verify_signature(@test_payload, headers, "invalid_secret")
    end
  end

  def test_verify_signature_with_missing_headers
    headers = {}

    assert_raises(ArgumentError) do
      @webhook_service.verify_signature(@test_payload, headers, @test_secret)
    end
  end

  def test_verify_signature_with_old_timestamp
    # Use a timestamp that's older than 5 minutes (300 seconds)
    old_timestamp = (1_750_861_210 - 400).to_s
    headers = {
      "webhook-signature" => "v1,signature",
      "webhook-timestamp" => old_timestamp,
      "webhook-id" => @webhook_id
    }

    assert_raises(ArgumentError) do
      @webhook_service.verify_signature(@test_payload, headers, @test_secret)
    end
  end

  def test_unwrap_with_valid_signature_verification
    headers = {
      "webhook-signature" => @webhook_signature,
      "webhook-timestamp" => @fixed_timestamp,
      "webhook-id" => @webhook_id
    }

    event = @webhook_service.unwrap(@test_payload, headers, @test_secret)

    assert_kind_of(OpenAI::Models::Webhooks::ResponseCompletedWebhookEvent, event)
    assert_equal("evt_685c059ae3a481909bdc86819b066fb6", event.id)
    assert_equal("resp_123", event.data.id)
  end

  def test_verify_signature_with_custom_tolerance
    # Use a timestamp that's very old (should fail with default tolerance)
    old_timestamp = (1_750_861_210 - 400).to_s

    headers = {
      "webhook-signature" => @webhook_signature, # This won't match old timestamp but we're testing time validation
      "webhook-timestamp" => old_timestamp,
      "webhook-id" => @webhook_id
    }

    # Should fail due to old timestamp
    assert_raises(ArgumentError) do
      @webhook_service.verify_signature(@test_payload, headers, @test_secret, 300)
    end
  end

  def test_unwrap_without_secret_throws_error
    # Create a client without webhook secret configured
    client_without_secret = OpenAI::Client.new(api_key: "test-api-key")
    webhook_service = client_without_secret.webhooks

    headers = {
      "webhook-signature" => @webhook_signature,
      "webhook-timestamp" => @fixed_timestamp,
      "webhook-id" => @webhook_id
    }

    # Should throw error when no secret is provided (not in client or environment)
    assert_raises(ArgumentError) do
      webhook_service.unwrap(@test_payload, headers, nil)
    end
  end

  def test_verify_signature_with_multiple_signatures_one_valid
    # Test multiple signatures: one invalid, one valid
    multiple_signatures = "v1,invalid_signature #{@webhook_signature}"
    headers = {
      "webhook-signature" => multiple_signatures,
      "webhook-timestamp" => @fixed_timestamp,
      "webhook-id" => @webhook_id
    }

    # Should not raise when at least one signature is valid

    @webhook_service.verify_signature(@test_payload, headers, @test_secret)
    assert(true)
  end

  def test_verify_signature_with_multiple_signatures_all_invalid
    # Test multiple invalid signatures
    multiple_invalid_signatures = "v1,invalid_signature1 v1,invalid_signature2"
    headers = {
      "webhook-signature" => multiple_invalid_signatures,
      "webhook-timestamp" => @fixed_timestamp,
      "webhook-id" => @webhook_id
    }

    assert_raises(ArgumentError) do
      @webhook_service.verify_signature(@test_payload, headers, @test_secret)
    end
  end
end
