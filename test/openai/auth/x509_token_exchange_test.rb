# frozen_string_literal: true

require_relative "../test_helper"

class OpenAI::Test::X509TokenExchangeTest < Minitest::Test
  ISSUED_TOKEN_TYPE = "urn:ietf:params:oauth:token-type:access_token"

  def setup
    super
    @http_client = OpenAI::NetHTTPClient.new
    @transport = OpenAI::Auth::X509Transport.new(
      http_client: @http_client,
      certificate_identity: :static
    )
    @identity = OpenAI::Auth::X509WorkloadIdentity.new(
      identity_provider_id: "idp_fake",
      service_account_id: "svc_acct_fake",
      refresh_buffer_seconds: 30
    )
    @exchange = OpenAI::Auth::X509TokenExchange.new(@identity, transport: @transport)
  end

  def teardown
    @http_client.close
    super
  end

  def test_configuration_is_immutable_and_validates_identifiers_and_refresh_buffer
    assert_predicate(@identity, :frozen?)
    assert_predicate(@identity.identity_provider_id, :frozen?)
    assert_predicate(@identity.service_account_id, :frozen?)
    assert_equal(30, @identity.refresh_buffer_seconds)

    [nil, "", "  \t"].each do |blank|
      assert_raises(ArgumentError) do
        OpenAI::Auth::X509WorkloadIdentity.new(identity_provider_id: blank, service_account_id: "fake")
      end

      assert_raises(ArgumentError) do
        OpenAI::Auth::X509WorkloadIdentity.new(identity_provider_id: "fake", service_account_id: blank)
      end
    end

    assert_raises(ArgumentError) do
      OpenAI::Auth::X509WorkloadIdentity.new(
        identity_provider_id: "fake",
        service_account_id: "fake",
        refresh_buffer_seconds: -1
      )
    end
  end

  def test_configuration_rejects_invalid_identifier_encodings_without_exposing_their_contents
    invalid_identifiers = [
      "\xFFfake-sensitive-identifier".b,
      "\xFFfake-sensitive-identifier".b.force_encoding(Encoding::UTF_8)
    ]

    invalid_identifiers.each do |identifier|
      [:identity_provider_id, :service_account_id].each do |field|
        options = {identity_provider_id: "idp_fake", service_account_id: "svc_acct_fake"}
        options[field] = identifier

        error = assert_raises(ArgumentError) { OpenAI::Auth::X509WorkloadIdentity.new(**options) }

        assert_match(/#{field}.*valid UTF-8/, error.message)
        assert_nil(error.cause)
        refute_includes(error.full_message(highlight: false), "fake-sensitive-identifier")
      end
    end

    identity = OpenAI::Auth::X509WorkloadIdentity.new(
      identity_provider_id: "idp_é".encode(Encoding::ISO_8859_1),
      service_account_id: "svc_acct_fake".encode(Encoding::US_ASCII)
    )
    assert_equal(Encoding::UTF_8, identity.identity_provider_id.encoding)
    assert_equal(Encoding::UTF_8, identity.service_account_id.encoding)
    assert_equal("idp_é", identity.identity_provider_id)
  end

  def test_posts_only_the_exact_product_approved_exchange_shape
    observed = nil
    response = token_response

    result = @http_client.stub(
      :execute,
      -> (request) {
        observed = request
        response
      }
    ) do
      @exchange.fetch
    end

    assert_equal(:post, observed.method)
    assert_equal("https://mtls.auth.openai.com/oauth/token", observed.url.to_s)
    assert_equal({"accept" => "application/json", "content-type" => "application/json"}, observed.headers)
    assert_equal(
      {
        "grant_type" => "urn:ietf:params:oauth:grant-type:token-exchange",
        "subject_token_type" => "urn:openai:params:oauth:token-type:x509",
        "identity_provider_id" => "idp_fake",
        "service_account_id" => "svc_acct_fake"
      },
      JSON.parse(observed.body)
    )
    refute_includes(JSON.parse(observed.body), "subject_token")
    assert_equal({id: "fake-valid.token_123", expires_in: 120.0}, result)
  end

  def test_deadline_is_checked_before_dispatch_and_applied_to_the_request
    expired = OpenAI::Internal::Util.monotonic_secs - 1
    @http_client.stub(:execute, -> (_request) { flunk("expired exchange must not dispatch") }) do
      assert_raises(Timeout::Error) { @exchange.fetch(deadline: expired) }
    end

    observed = nil
    response = token_response
    deadline = OpenAI::Internal::Util.monotonic_secs + 2
    @http_client.stub(
      :execute,
      -> (request) {
        observed = request
        response
      }
    ) do
      @exchange.fetch(deadline: deadline)
    end

    assert_operator(observed.timeout, :>, 0)
    assert_operator(observed.timeout, :<=, 2)
  end

  def test_deadline_is_checked_after_json_parsing_and_token_validation
    original_parser = JSON.method(:parse)
    [:parsing, :validation].each do |phase|
      now = 100.0
      response = token_response
      parser = lambda do |source, **options|
        parsed = original_parser.call(source, **options)
        if phase == :parsing
          now = 102.0
        else
          parsed.define_singleton_method(:[]) do |key|
            now = 102.0 if key == :expires_in
            super(key)
          end
        end

        parsed
      end

      OpenAI::Internal::Util.stub(:monotonic_secs, -> { now }) do
        JSON.stub(:parse, parser) do
          @http_client.stub(:execute, -> (_request) { response }) do
            error = assert_raises(Timeout::Error) { @exchange.fetch(deadline: 101.0) }
            assert_match(/timed out during workload identity authentication/, error.message)
          end
        end
      end
    end
  end

  def test_rejects_malformed_bearers_response_shapes_and_token_types
    invalid_bodies = [
      nil,
      [],
      {},
      valid_token.merge(access_token: ""),
      valid_token.merge(access_token: "bad token"),
      valid_token.merge(access_token: "bad\ntoken"),
      valid_token.merge(access_token: "fake=middle"),
      valid_token.merge(access_token: "token-☃"),
      valid_token.merge(token_type: "Basic"),
      valid_token.merge(token_type: nil),
      valid_token.except(:token_type),
      valid_token.merge(issued_token_type: "urn:other"),
      valid_token.except(:issued_token_type)
    ]

    invalid_bodies.each do |body|
      response = token_response(body: body)
      @http_client.stub(:execute, -> (_request) { response }) do
        error = assert_raises(OpenAI::Errors::APIError) { @exchange.fetch }
        assert_match(/Invalid X\.509 token exchange response/, error.message)
        assert_nil(error.body)
      end
    end
  end

  def test_rejects_nonpositive_nonfinite_overflowing_and_overlong_lifetimes
    [nil, "120", 0, -1, 3601, 10 ** 400, 1.0 / 0.0, 0.0 / 0.0].each do |expires_in|
      body = valid_token.merge(expires_in: expires_in)
      json = JSON.generate(body, allow_nan: true)
      response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: json)
      @http_client.stub(:execute, -> (_request) { response }) do
        assert_raises(OpenAI::Errors::APIError) { @exchange.fetch }
      end
    end
  end

  def test_accepts_large_valid_token_responses_without_an_arbitrary_size_limit
    large_token = "a" * (128 * 1024)
    responses = [
      valid_token.merge(access_token: large_token),
      valid_token.merge(additional_metadata: "x" * (128 * 1024))
    ]

    responses.each do |body|
      response = token_response(body: body)
      result = @http_client.stub(:execute, -> (_request) { response }) do
        @exchange.fetch
      end

      assert_equal(body.fetch(:access_token), result.fetch(:id))
      assert_equal(120.0, result.fetch(:expires_in))
    end
  end

  def test_rejects_complete_responses_with_invalid_trailing_content
    body = JSON.generate(valid_token) + (" " * (128 * 1024)) + "x"
    response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: body)

    @http_client.stub(:execute, -> (_request) { response }) do
      error = assert_raises(OpenAI::Errors::APIError) { @exchange.fetch }
      assert_match(/complete JSON object/, error.message)
    end
  end

  def test_invalid_successful_issuer_responses_preserve_only_safe_request_ids
    invalid_bodies = {
      200 => "{fake-sensitive-body",
      201 => JSON.generate(valid_token.merge(token_type: "Basic")),
      202 => "\xFFfake-sensitive-body".b
    }

    invalid_bodies.each do |status, body|
      response = OpenAI::HTTPClient::Response.new(
        status: status,
        headers: {"x-request-id" => "req_fake", "set-cookie" => "session=fake-cookie"},
        body: body
      )

      error = @http_client.stub(:execute, -> (_request) { response }) do
        assert_raises(OpenAI::Errors::APIError) { @exchange.fetch }
      end

      assert_equal(status, error.status)
      assert_equal("req_fake", error.request_id)
      assert_equal({"x-request-id" => "req_fake"}, error.headers)
      assert_nil(error.body)
      refute_match(/fake-sensitive-body|fake-cookie/, error.full_message(highlight: false))
    end
  end

  def test_malformed_token_json_never_exposes_parser_input_through_exception_causes
    sensitive_token = "fake-sensitive-bearer-token"
    malformed = "{\"access_token\":#{sensitive_token}}"
    statuses = {200 => OpenAI::Errors::APIError, 401 => OpenAI::Errors::OAuthError, 503 => OpenAI::Errors::APIError}

    statuses.each do |status, expected_error|
      response = OpenAI::HTTPClient::Response.new(
        status: status,
        headers: {"x-request-id" => "req_fake"},
        body: malformed
      )

      error = @http_client.stub(:execute, -> (_request) { response }) do
        assert_raises(expected_error) { @exchange.fetch }
      end

      assert_equal(status, error.status)
      assert_nil(error.cause)
      assert_nil(error.body)
      refute_includes(error.message.to_s, sensitive_token)
      refute_includes(error.inspect, sensitive_token)
      refute_includes(error.full_message(highlight: false), sensitive_token)
      if status == 200
        assert_match(/complete JSON object/, error.message)
      else
        assert_equal({"x-request-id" => "req_fake"}, error.headers)
      end
    end
  end

  def test_invalid_utf8_response_keys_and_values_raise_sanitized_api_errors
    invalid_fields = [
      [valid_token, valid_token.fetch(:access_token)],
      [valid_token, valid_token.fetch(:token_type)],
      [valid_token, valid_token.fetch(:issued_token_type)],
      [valid_token.merge(metadata: "fake-metadata"), "fake-metadata"],
      [valid_token, "access_token"]
    ]

    invalid_fields.each do |token, marker|
      body = JSON.generate(token).b.sub(marker.b, "\xFF".b)
      response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: body)

      error = @http_client.stub(:execute, -> (_request) { response }) do
        assert_raises(OpenAI::Errors::APIError) { @exchange.fetch }
      end

      assert_equal(200, error.status)
      assert_match(/Invalid X\.509 token exchange response/, error.message)
      assert_nil(error.body)
    end
  end

  def test_oauth_failures_preserve_only_known_codes_and_safe_request_ids
    response = OpenAI::HTTPClient::Response.new(
      status: 401,
      headers: {"x-request-id" => "req_fake", "set-cookie" => "session=fake-secret"},
      body: JSON.generate(error: "invalid_grant", error_description: "customer secret diagnostics")
    )

    error = @http_client.stub(:execute, -> (_request) { response }) do
      assert_raises(OpenAI::Errors::OAuthError) { @exchange.fetch }
    end

    assert_equal("https://mtls.auth.openai.com/oauth/token", error.url.to_s)
    assert_equal(:invalid_grant, error.error_code)
    assert_equal({error: "invalid_grant"}, error.body)
    assert_equal({"x-request-id" => "req_fake"}, error.headers)
    refute_match(/secret|diagnostics/, error.inspect)
  end

  def test_oauth_failures_preserve_only_allowlisted_nested_issuer_error_codes
    codes = {
      "invalid_grant" => :invalid_grant,
      "invalid_subject_token" => :invalid_subject_token,
      "token_exchange_server_error" => "token_exchange_server_error"
    }

    codes.each do |code, expected_error_code|
      response = OpenAI::HTTPClient::Response.new(
        status: 401,
        headers: {"x-request-id" => "req_fake", "set-cookie" => "session=fake-cookie-secret"},
        body: JSON.generate(
          error: {
            code: code,
            message: "fake-sensitive-issuer-message",
            description: "fake-sensitive-issuer-description"
          },
          error_description: "fake-sensitive-top-level-description"
        )
      )

      error = @http_client.stub(:execute, -> (_request) { response }) do
        assert_raises(OpenAI::Errors::OAuthError) { @exchange.fetch }
      end

      assert_equal(expected_error_code, error.error_code)
      assert_equal({error: code}, error.body)
      assert_equal({"x-request-id" => "req_fake"}, error.headers)
      assert_equal(code, error.message)
      refute_includes(error.full_message(highlight: false), "fake-sensitive")
      refute_includes(error.full_message(highlight: false), "fake-cookie-secret")
    end
  end

  def test_oauth_failures_discard_nested_and_unknown_error_details
    error_values = [
      {message: "fake-secret"},
      {code: "fake-secret", description: "fake-secret-details"},
      {code: nil, message: "fake-secret"},
      {code: {nested: "fake-secret"}},
      {code: ["invalid_grant", "fake-secret"]},
      ["fake-secret"],
      "fake-secret"
    ]

    error_values.each do |error_value|
      response = OpenAI::HTTPClient::Response.new(
        status: 400,
        headers: {},
        body: JSON.generate(error: error_value)
      )

      error = @http_client.stub(:execute, -> (_request) { response }) do
        assert_raises(OpenAI::Errors::OAuthError) { @exchange.fetch }
      end

      assert_nil(error.body)
      assert_nil(error.error_code)
      refute_match(/fake-secret/, error.inspect)
    end
  end

  def test_oauth_failures_with_non_json_bodies_preserve_status_and_safe_request_ids
    bodies = [[400, ""], [401, "<html>fake-secret</html>"], [403, "not-json"], [403, "\xFF".b]]

    bodies.each do |status, body|
      response = OpenAI::HTTPClient::Response.new(
        status: status,
        headers: {"x-request-id" => "req_fake", "set-cookie" => "session=fake-secret"},
        body: body
      )

      error = @http_client.stub(:execute, -> (_request) { response }) do
        assert_raises(OpenAI::Errors::OAuthError) { @exchange.fetch }
      end

      assert_equal(status, error.status)
      assert_equal({"x-request-id" => "req_fake"}, error.headers)
      assert_nil(error.body)
      refute_includes(error.inspect, "fake-secret")
    end
  end

  def test_non_json_server_failures_preserve_status_and_safe_request_ids
    response = OpenAI::HTTPClient::Response.new(
      status: 503,
      headers: {"x-request-id" => "req_fake", "set-cookie" => "session=fake-secret"},
      body: "<html>fake-secret upstream unavailable</html>"
    )

    error = @http_client.stub(:execute, -> (_request) { response }) do
      assert_raises(OpenAI::Errors::APIError) { @exchange.fetch }
    end

    assert_equal(503, error.status)
    assert_equal({"x-request-id" => "req_fake"}, error.headers)
    assert_nil(error.body)
    refute_includes(error.inspect, "fake-secret")
  end

  def test_retryable_issuer_failures_preserve_only_safe_retry_metadata
    statuses = [408, 409, 429, 500, 503]
    safe_headers = {
      "x-request-id" => "req_fake",
      "retry-after" => "3",
      "retry-after-ms" => "25",
      "x-should-retry" => "true"
    }

    statuses.each do |status|
      response = OpenAI::HTTPClient::Response.new(
        status: status,
        headers: safe_headers.merge("set-cookie" => "session=fake-secret", "authorization" => "Bearer fake-secret"),
        body: "fake-secret-body"
      )

      error = @http_client.stub(:execute, -> (_request) { response }) do
        assert_raises(OpenAI::Errors::APIError) { @exchange.fetch }
      end

      assert_equal(status, error.status)
      assert_equal(safe_headers, error.headers)
      assert_nil(error.body)
      refute_match(/fake-secret/, error.inspect)
    end
  end

  def test_oauth_failures_do_not_expose_retry_metadata
    response = OpenAI::HTTPClient::Response.new(
      status: 401,
      headers: {"x-request-id" => "req_fake", "retry-after" => "2", "set-cookie" => "fake-secret"},
      body: JSON.generate(error: "invalid_grant")
    )

    error = @http_client.stub(:execute, -> (_request) { response }) do
      assert_raises(OpenAI::Errors::OAuthError) { @exchange.fetch }
    end

    assert_equal({"x-request-id" => "req_fake"}, error.headers)
  end

  def test_nonretryable_issuer_failures_do_not_expose_retry_metadata
    response = OpenAI::HTTPClient::Response.new(
      status: 404,
      headers: {"x-request-id" => "req_fake", "retry-after" => "2", "x-should-retry" => "true"},
      body: "fake-secret-body"
    )

    error = @http_client.stub(:execute, -> (_request) { response }) do
      assert_raises(OpenAI::Errors::APIError) { @exchange.fetch }
    end

    assert_equal({"x-request-id" => "req_fake"}, error.headers)
  end

  def test_large_failure_bodies_preserve_status_without_exposing_content
    response = OpenAI::HTTPClient::Response.new(
      status: 503,
      headers: {"x-request-id" => "req_fake"},
      body: "fake-secret" * (128 * 1024)
    )

    error = @http_client.stub(:execute, -> (_request) { response }) do
      assert_raises(OpenAI::Errors::APIError) { @exchange.fetch }
    end

    assert_equal(503, error.status)
    assert_equal({"x-request-id" => "req_fake"}, error.headers)
    assert_nil(error.body)
    refute_includes(error.inspect, "fake-secret")
  end

  def test_mutating_error_urls_cannot_change_future_token_exchange_destinations
    failures = [
      -> { token_response(body: {}) },
      -> { OpenAI::HTTPClient::Response.new(status: 401, headers: {}, body: "") },
      -> { OpenAI::HTTPClient::Response.new(status: 503, headers: {}, body: "") },
      -> { OpenAI::Errors::APIConnectionError.new(url: URI("https://mtls.auth.openai.com/oauth/token")) }
    ]

    failures.each do |build_failure|
      failure = build_failure.call
      destinations = []
      dispatch = lambda do |request|
        destinations << request.url.to_s
        if destinations.one?
          raise failure if failure.is_a?(OpenAI::Errors::APIError)

          failure
        else
          token_response
        end
      end

      @http_client.stub(:execute, dispatch) do
        error = assert_raises(OpenAI::Errors::APIError) { @exchange.fetch }
        error.url.path.replace("/mutated-token-endpoint")

        assert_equal("fake-valid.token_123", @exchange.fetch.fetch(:id))
      end

      assert_equal(["https://mtls.auth.openai.com/oauth/token"] * 2, destinations)
    end
  end

  private def valid_token
    {
      access_token: "fake-valid.token_123",
      token_type: "Bearer",
      issued_token_type: ISSUED_TOKEN_TYPE,
      expires_in: 120
    }
  end

  private def token_response(body: valid_token)
    OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: JSON.generate(body))
  end
end
