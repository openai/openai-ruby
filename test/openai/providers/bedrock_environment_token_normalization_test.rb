# frozen_string_literal: true

require_relative "bedrock_test_helper"

class OpenAI::Test::BedrockEnvironmentTokenNormalizationTest < Minitest::Test
  extend Minitest::Serial
  include OpenAI::Test::BedrockTestHelper

  MODEL_URL = "https://bedrock-mantle.us-east-1.api.aws/v1/models"

  def test_environment_bearer_token_is_normalized_like_explicit_api_key
    padded_token = "\nfake-bedrock-token\n"
    observed_headers = []
    stub_request(:get, MODEL_URL).to_return do |request|
      observed_headers << request.headers.fetch("Authorization")
      {status: 200, headers: {"Content-Type" => "application/json"}, body: "{\"object\":\"list\",\"data\":[]}"}
    end

    ENV["AWS_BEARER_TOKEN_BEDROCK"] = padded_token
    request_models
    request_models(api_key: padded_token)

    assert_equal(["Bearer fake-bedrock-token", "Bearer fake-bedrock-token"], observed_headers)
  end

  def test_environment_bearer_token_refreshes_and_normalizes_each_request
    observed_headers = []
    stub_request(:get, MODEL_URL).to_return do |request|
      observed_headers << request.headers.fetch("Authorization")
      {status: 200, headers: {"Content-Type" => "application/json"}, body: "{\"object\":\"list\",\"data\":[]}"}
    end

    ENV["AWS_BEARER_TOKEN_BEDROCK"] = "\nfirst-token\n"
    with_bedrock_client do |client|
      client.models.list
      ENV["AWS_BEARER_TOKEN_BEDROCK"] = "\nsecond-token\n"
      client.models.list
    end

    assert_equal(["Bearer first-token", "Bearer second-token"], observed_headers)
  end

  def test_environment_bearer_token_refresh_keeps_blank_and_removed_values_failing
    ENV["AWS_BEARER_TOKEN_BEDROCK"] = "initial-token"

    with_bedrock_client do |client|
      ENV["AWS_BEARER_TOKEN_BEDROCK"] = " \n "
      assert_raises(OpenAI::Errors::Error) { client.models.list }
      ENV.delete("AWS_BEARER_TOKEN_BEDROCK")
      assert_raises(OpenAI::Errors::Error) { client.models.list }
    end

    assert_not_requested(:get, MODEL_URL)
  end

  private def request_models(api_key: OpenAI::Internal::OMIT)
    with_bedrock_client(api_key: api_key) { |client| client.models.list }
  end

  private def with_bedrock_client(api_key: OpenAI::Internal::OMIT)
    options = {region: "us-east-1"}
    options[:api_key] = api_key unless api_key.equal?(OpenAI::Internal::OMIT)
    http_client = OpenAI::NetHTTPClient.new
    client = OpenAI::Client.new(
      provider: OpenAI::Providers.bedrock(**options),
      max_retries: 0,
      http_client: http_client
    )
    yield client
  ensure
    http_client&.close
  end
end
