# frozen_string_literal: true

require_relative "x509_workload_identity_test_support"

class X509WorkloadIdentityRegressionTest < Minitest::Test
  extend Minitest::Serial
  include X509WorkloadIdentityTestSupport

  def test_same_origin_redirect_cannot_reset_the_single_401_replay_budget
    exchange_count = 0
    api_paths = []
    http_client = StubHTTPClient.new do |request|
      if request.url.host == "mtls.auth.openai.com"
        exchange_count += 1
        http_response(status: 200, body: {"access_token" => "token-#{exchange_count}", "expires_in" => 60})
      else
        api_paths << request.url.path
        if request.url.path == "/v1/start"
          http_response(status: 307, headers: {"location" => "/v1/final"}, body: "redirect")
        else
          http_response(status: 401, body: {"error" => {"message" => "rejected"}})
        end
      end
    end

    error = assert_raises(OpenAI::Errors::AuthenticationError) do
      x509_client(http_client).request(method: :get, path: "start", model: OpenAI::Internal::Type::Unknown)
    end

    assert_equal(401, error.status)
    assert_equal(2, exchange_count)
    assert_equal(["/v1/start", "/v1/final", "/v1/final"], api_paths)
  end

  def test_terminal_token_exchange_transport_errors_do_not_retain_authentication_requests
    [OpenAI::Errors::APIConnectionError, OpenAI::Errors::APITimeoutError].each do |error_class|
      http_client = StubHTTPClient.new do |request|
        raise error_class.new(url: request.url, request: request)
      end

      error = assert_raises(error_class) { x509_auth(http_client).get_token }
      serialized_state = error.instance_variables.to_h { [_1, error.instance_variable_get(_1)] }.inspect

      assert_equal(URI("https://mtls.auth.openai.com/oauth/token"), error.url)
      assert_equal(3, http_client.requests.length)
      assert_nil(error.instance_variable_get(:@request))
      assert_nil(error.cause)
      refute_includes(serialized_state, "idp-123")
      refute_includes(serialized_state, "sa-456")
    end
  end
end
