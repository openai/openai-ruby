# frozen_string_literal: true

require_relative "../test_helper"
require "openssl"
require "stringio"

class OpenAI::Test::WebhookVerificationTest < OpenAI::Test::ResourceTest
  def setup
    super
    @client = OpenAI::Client.new(
      api_key: "test-api-key",
      webhook_secret: "whsec_RdvaYFYUXuIFuEbvZHwMfYFhUf7aMYjYcmM24+Aj40c="
    )
    @webhook_service = @client.webhooks

    # Standardized test data matching TypeScript
    @test_payload = "{\"id\": \"evt_685c059ae3a481909bdc86819b066fb6\", \"object\": \"event\", \"created_at\": 1750861210, \"type\": \"response.completed\", \"data\": {\"id\": \"resp_123\"}}"
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

    assert_raises(OpenAI::Errors::InvalidWebhookSignatureError) do
      @webhook_service.verify_signature(@test_payload, headers, "invalid_secret")
    end
  end

  def test_unwrap_rejects_forged_signatures_for_invalid_secrets
    invalid_secrets = {
      "" => "",
      " \t\n" => " \t\n",
      "whsec_" => "",
      "whsec_!!!!" => "",
      "whsec_====" => "",
      "whsec_Zm9v!!!!" => "foo"
    }

    invalid_secrets.each do |webhook_secret, signing_key|
      headers = signed_headers(signing_key)

      assert_raises(ArgumentError, "expected #{webhook_secret.inspect} to be rejected") do
        @webhook_service.unwrap(@test_payload, headers, webhook_secret)
      end
    end
  end

  def test_unwrap_accepts_raw_webhook_secrets
    webhook_secret = "raw webhook secret"

    event = @webhook_service.unwrap(@test_payload, signed_headers(webhook_secret), webhook_secret)

    assert_equal("evt_685c059ae3a481909bdc86819b066fb6", event.id)
  end

  def test_unwrap_accepts_base64_encoded_webhook_secrets
    signing_key = "binary\x00\xFF\x80webhook secret".b
    webhook_secret = "whsec_YmluYXJ5AP+Ad2ViaG9vayBzZWNyZXQ="

    event = @webhook_service.unwrap(@test_payload, signed_headers(signing_key), webhook_secret)

    assert_equal("evt_685c059ae3a481909bdc86819b066fb6", event.id)
  end

  def test_unwrap_accepts_padded_base64_encoded_webhook_secrets
    signing_key = "f"
    webhook_secret = "whsec_Zg=="

    event = @webhook_service.unwrap(@test_payload, signed_headers(signing_key), webhook_secret)

    assert_equal("evt_685c059ae3a481909bdc86819b066fb6", event.id)
  end

  def test_unwrap_rejects_malformed_base64_padding
    %w[whsec_Zg= whsec_Zg=== whsec_Zg whsec_Zm9v=].each do |webhook_secret|
      assert_raises(ArgumentError, "expected #{webhook_secret.inspect} to be rejected") do
        @webhook_service.unwrap(@test_payload, signed_headers("f"), webhook_secret)
      end
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

    assert_raises(OpenAI::Errors::InvalidWebhookSignatureError) do
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

  def test_unwrap_with_rack_request_environment
    request_environment = {
      "REQUEST_METHOD" => "POST",
      "PATH_INFO" => "/webhook",
      "CONTENT_TYPE" => "application/json",
      "rack.input" => StringIO.new(@test_payload),
      "HTTP_WEBHOOK_SIGNATURE" => @webhook_signature,
      "HTTP_WEBHOOK_TIMESTAMP" => @fixed_timestamp,
      "HTTP_WEBHOOK_ID" => @webhook_id
    }

    assert_nil(@webhook_service.verify_signature(@test_payload, request_environment))

    event = @webhook_service.unwrap(request_environment.fetch("rack.input").read, request_environment)

    assert_kind_of(OpenAI::Models::Webhooks::ResponseCompletedWebhookEvent, event)
    assert_equal("evt_685c059ae3a481909bdc86819b066fb6", event.id)
  end

  def test_verify_signature_with_title_case_headers
    headers = {
      "Webhook-Signature" => @webhook_signature,
      "Webhook-Timestamp" => @fixed_timestamp,
      "Webhook-Id" => @webhook_id
    }

    assert_nil(@webhook_service.verify_signature(@test_payload, headers))
  end

  def test_verify_signature_with_snake_case_symbol_headers
    headers = {
      webhook_signature: @webhook_signature,
      webhook_timestamp: @fixed_timestamp,
      webhook_id: @webhook_id
    }

    assert_nil(@webhook_service.verify_signature(@test_payload, headers))
  end

  def test_verify_signature_rejects_conflicting_header_aliases
    headers = {
      "webhook-signature" => @webhook_signature,
      "HTTP_WEBHOOK_SIGNATURE" => "v1,attacker-controlled-signature",
      "webhook-timestamp" => @fixed_timestamp,
      "webhook-id" => @webhook_id
    }

    error = assert_raises(ArgumentError) do
      @webhook_service.verify_signature(@test_payload, headers)
    end

    assert_match(/conflicting.*webhook-signature/i, error.message)
  end

  def test_verify_signature_accepts_matching_header_aliases
    headers = {
      "webhook-signature" => @webhook_signature,
      "HTTP_WEBHOOK_SIGNATURE" => @webhook_signature,
      "webhook-timestamp" => @fixed_timestamp,
      "webhook-id" => @webhook_id
    }

    assert_nil(@webhook_service.verify_signature(@test_payload, headers))
  end

  def test_readme_webhook_examples_configure_required_api_credentials
    readme = File.read(File.expand_path("../../../README.md", __dir__))
    webhook_section = readme.split("## Webhook Verification\n", 2).fetch(1)
    webhook_section = webhook_section.split("\n### [Structured outputs]", 2).first
    examples = webhook_section.scan(/```ruby\n(.*?)\n```/m).flatten

    assert_equal(2, examples.length)
    examples.each do |example|
      assert_match(/api_key:\s*ENV\.fetch\(['"]OPENAI_API_KEY['"]\)/, example)
      assert_match(/webhook_secret:\s*ENV\.fetch\(['"]OPENAI_WEBHOOK_SECRET['"]\)/, example)
      assert_includes(example, "request.env")
    end
  end

  def test_verify_signature_with_custom_tolerance
    # Use a timestamp that's very old (should fail with default tolerance)
    old_timestamp = (1_750_861_210 - 400).to_s

    headers = {
      # This won't match old timestamp but we're testing time validation
      "webhook-signature" => @webhook_signature,
      "webhook-timestamp" => old_timestamp,
      "webhook-id" => @webhook_id
    }

    # Should fail due to old timestamp
    assert_raises(OpenAI::Errors::InvalidWebhookSignatureError) do
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

    assert_raises(OpenAI::Errors::InvalidWebhookSignatureError) do
      @webhook_service.verify_signature(@test_payload, headers, @test_secret)
    end
  end

  private

  def signed_headers(signing_key)
    signed_payload = "#{@webhook_id}.#{@fixed_timestamp}.#{@test_payload}"
    signature = encode64(OpenSSL::HMAC.digest("sha256", signing_key, signed_payload))

    {
      "webhook-signature" => "v1,#{signature}",
      "webhook-timestamp" => @fixed_timestamp,
      "webhook-id" => @webhook_id
    }
  end

  def encode64(bytes)
    [bytes].pack("m0")
  end
end
