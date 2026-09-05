# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::APIErrorMetadataTest < Minitest::Test
  def test_standard_rate_limit_envelope_populates_metadata
    body = {
      error: {
        message: "Synthetic quota error",
        code: "insufficient_quota",
        type: "insufficient_quota",
        param: "model"
      }
    }

    error = response_error(status: 429, body: body)

    assert_instance_of(OpenAI::Errors::RateLimitError, error)
    assert_equal("insufficient_quota", error.code)
    assert_equal("insufficient_quota", error.type)
    assert_equal("model", error.param)
    assert_equal("req_synthetic", error.request_id)
    assert_equal(body, error.body)
  end

  def test_standard_bad_parameter_envelope_populates_metadata
    body = {
      error: {
        message: "Synthetic invalid parameter",
        code: "invalid_value",
        type: "invalid_request_error",
        param: "input"
      }
    }

    error = response_error(status: 400, body: body)

    assert_instance_of(OpenAI::Errors::BadRequestError, error)
    assert_equal("invalid_value", error.code)
    assert_equal("invalid_request_error", error.type)
    assert_equal("input", error.param)
  end

  def test_top_level_metadata_remains_authoritative_and_malformed_envelopes_are_safe
    body = {
      code: "top_level_code",
      type: nil,
      param: false,
      error: {code: "nested_code", type: "nested_type", param: "nested_param"}
    }

    error = response_error(status: 400, body: body)

    assert_equal("top_level_code", error.code)
    assert_nil(error.type)
    assert_equal(false, error.param)

    malformed = response_error(status: 400, body: {error: "not an envelope"})
    assert_nil(malformed.code)
    assert_nil(malformed.type)
    assert_nil(malformed.param)
  end

  private def response_error(status:, body:)
    response = OpenAI::HTTPClient::Response.new(
      status: status,
      headers: {"content-type" => "application/json", "x-request-id" => "req_synthetic"},
      body: JSON.generate(body)
    )
    http_client = OpenAI::HTTPClient.new

    http_client.stub(:execute, response) do
      client = OpenAI::Client.new(
        api_key: "synthetic-api-key",
        base_url: "https://sdk.example.test",
        http_client: http_client,
        max_retries: 0
      )

      assert_raises(OpenAI::Errors::APIStatusError) do
        client.responses.create(model: "gpt-4o-mini", input: "Synthetic")
      end
    end
  end
end
