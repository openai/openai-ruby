# frozen_string_literal: true

require_relative "../test_helper"

class WorkloadIdentityErrorHeadersTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
    WebMock.disable_net_connect!
  end

  def teardown
    WebMock.reset!
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def test_oauth_exchange_errors_expose_string_headers_and_request_ids
    [400, 401, 403].each do |status|
      error = exchange_error(
        status,
        headers: {
          "Content-Type" => "application/json",
          "X-Request-ID" => "req_synthetic_#{status}",
          "Retry-After" => "2"
        }
      )

      assert_instance_of(OpenAI::Errors::OAuthError, error)
      assert_equal(status, error.status)
      assert_equal(:invalid_grant, error.error_code)
      assert_equal("req_synthetic_#{status}", error.request_id)
      assert_equal("2", error.headers.fetch("retry-after"))
      assert(error.headers.all? { |name, value| name.is_a?(String) && name == name.downcase && value.is_a?(String) })
    end
  end

  def test_non_oauth_exchange_errors_expose_string_headers_and_request_ids
    error = exchange_error(
      500,
      headers: {
        "Content-Type" => "application/json",
        "X-Request-ID" => "req_synthetic_500",
        "Retry-After" => "2"
      }
    )

    assert_instance_of(OpenAI::Errors::APIError, error)
    assert_equal(500, error.status)
    assert_equal("req_synthetic_500", error.request_id)
    assert_equal("2", error.headers.fetch("retry-after"))
    assert(error.headers.all? { |name, value| name.is_a?(String) && name == name.downcase && value.is_a?(String) })
  end

  def test_exchange_errors_without_request_ids_keep_nil_request_ids
    error = exchange_error(401, headers: {"Content-Type" => "application/json"})

    assert_nil(error.request_id)
  end

  private def exchange_error(status, headers:)
    WebMock.reset!
    stub_request(:post, "https://auth.openai.com/oauth/token")
      .to_return(
        status: status,
        headers: headers,
        body: JSON.generate(error: "invalid_grant", error_description: "Synthetic token exchange failure")
      )
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new
    identity = OpenAI::Auth::WorkloadIdentity.new(
      provider: provider,
      identity_provider_id: "ip_synthetic",
      service_account_id: "sa_synthetic"
    )
    client = OpenAI::Client.new(
      api_key: nil,
      workload_identity: identity,
      organization: "org_synthetic",
      max_retries: 0
    )
    calls = 0
    get_token = -> {
      calls += 1
      "synthetic-subject-token"
    }

    error = provider.stub(:get_token, get_token) do
      assert_raises(OpenAI::Errors::APIError) do
        client.responses.create(model: "gpt-4o-mini", input: "Synthetic")
      end
    end

    assert_equal(1, calls)
    assert_requested(:post, "https://auth.openai.com/oauth/token", times: 1)
    assert_not_requested(:post, "https://api.openai.com/v1/responses")
    error
  end
end
