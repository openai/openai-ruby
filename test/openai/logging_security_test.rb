# frozen_string_literal: true

require "minitest/mock"
require_relative "test_helper"

class LoggingSecurityTest < Minitest::Test
  def test_info_and_debug_logs_redact_camel_case_and_nested_query_credentials
    credentials = {
      "accessToken" => "camel-access-secret",
      "accessKey" => "camel-access-key-secret",
      "clientSecret" => "camel-client-secret",
      "sessionToken" => "camel-session-secret",
      "bearerToken" => "camel-bearer-secret",
      "access_token[]" => "array-access-secret",
      "clientSecret[]" => "array-client-secret",
      "credentials[accessToken]" => "nested-access-secret",
      "credentials[client_secret]" => "nested-client-secret",
      "credentials[access_token][]" => "nested-array-secret",
      "credentials[value]" => "nested-credential-secret"
    }

    [:info, :debug].each do |level|
      output, request = logged_request(
        log_level: level,
        query: {**credentials, "safe" => "visible", "monkey" => "still-visible"}
      )

      assert_includes(output, "request complete")
      assert_includes(output, "safe=visible")
      assert_includes(output, "monkey=still-visible")
      assert_includes(output, "%5BREDACTED%5D")

      credentials.each_value do |secret|
        assert_includes(request.url.to_s, secret)
        refute_includes(output, secret)
      end

      assert_equal(level == :debug, output.include?("request started"))
    end
  end

  def test_url_sanitization_redacts_percent_encoded_and_nested_credential_keys
    url = URI(
      "https://user:password@example.com/probe?" \
      "access%54oken=encoded-access-secret&" \
      "access%4Bey=encoded-access-key-secret&" \
      "credentials%5Bclient%53ecret%5D=encoded-client-secret&" \
      "access_token%5B%5D=encoded-array-secret&" \
      "credentials%5Bvalue%5D=encoded-credential-secret&" \
      "safe=visible"
    )

    [OpenAI::Internal::Logging.safe_url(url), OpenAI::Internal::Logging.safe_path(url)].each do |formatted|
      assert_includes(formatted, "safe=visible")
      assert_includes(formatted, "%5BREDACTED%5D")
      refute_includes(formatted, "encoded-access-secret")
      refute_includes(formatted, "encoded-access-key-secret")
      refute_includes(formatted, "encoded-client-secret")
      refute_includes(formatted, "encoded-array-secret")
      refute_includes(formatted, "encoded-credential-secret")
      refute_includes(formatted, "user:password@")
    end
  end

  def test_debug_logs_structurally_redact_form_urlencoded_request_bodies
    body =
      "client_secret=client-form-secret&access_token=access-form-secret&" \
      "accessKey=access-key-form-secret&credentials%5Bvalue%5D=credential-form-secret&" \
      "access_token%5B%5D=array-form-secret&" \
      "credentials%5BsessionToken%5D=nested-form-secret&" \
      "safe=hello+world&repeat=one&repeat=two"
    output, request = logged_request(
      log_level: :debug,
      headers: {"content-type" => "application/x-www-form-urlencoded; charset=utf-8"},
      body: body
    )

    assert_equal(body, request.body)
    assert_includes(output, "request started")
    assert_includes(output, "client_secret=%5BREDACTED%5D")
    assert_includes(output, "access_token=%5BREDACTED%5D")
    assert_includes(output, "accessKey=%5BREDACTED%5D")
    assert_includes(output, "credentials%5Bvalue%5D=%5BREDACTED%5D")
    assert_includes(output, "access_token%5B%5D=%5BREDACTED%5D")
    assert_includes(output, "credentials%5BsessionToken%5D=%5BREDACTED%5D")
    assert_includes(output, "safe=hello+world")
    assert_includes(output, "repeat=one&repeat=two")
    refute_includes(output, "client-form-secret")
    refute_includes(output, "access-form-secret")
    refute_includes(output, "access-key-form-secret")
    refute_includes(output, "credential-form-secret")
    refute_includes(output, "array-form-secret")
    refute_includes(output, "nested-form-secret")
  end

  def test_debug_logs_structurally_redact_form_urlencoded_response_bodies
    body =
      "accessToken=response-access-secret&access_token%5B%5D=response-array-secret&" \
      "accessKey=response-access-key-secret&credentials%5Bvalue%5D=response-credential-secret&" \
      "credentials%5Bclient_secret%5D=response-client-secret&safe=visible"
    formatted = OpenAI::Internal::Logging.format_observed_body(
      body,
      headers: {"content-type" => "application/x-www-form-urlencoded"},
      complete: true,
      total_bytes: body.bytesize
    )

    assert_includes(formatted, "accessToken=%5BREDACTED%5D")
    assert_includes(formatted, "accessKey=%5BREDACTED%5D")
    assert_includes(formatted, "credentials%5Bvalue%5D=%5BREDACTED%5D")
    assert_includes(formatted, "access_token%5B%5D=%5BREDACTED%5D")
    assert_includes(formatted, "credentials%5Bclient_secret%5D=%5BREDACTED%5D")
    assert_includes(formatted, "safe=visible")
    refute_includes(formatted, "response-access-secret")
    refute_includes(formatted, "response-access-key-secret")
    refute_includes(formatted, "response-credential-secret")
    refute_includes(formatted, "response-array-secret")
    refute_includes(formatted, "response-client-secret")
  end

  def test_debug_logs_omit_malformed_or_oversized_form_bodies
    headers = {"content-type" => "application/x-www-form-urlencoded"}
    malformed = "access_token=malformed-secret&invalid=\xFF".b
    oversized = "access_token=oversized-secret&padding=#{'x' * OpenAI::Internal::Logging::MAX_BODY_BYTES}"

    [malformed, oversized].each do |body|
      formatted = OpenAI::Internal::Logging.format_body(body, headers: headers)

      assert_includes(formatted, "BODY OMITTED]")
      assert_includes(formatted, "bytes=#{body.bytesize}")
      refute_includes(formatted, "malformed-secret")
      refute_includes(formatted, "oversized-secret")
    end
  end

  def test_debug_logs_omit_unsupported_textual_request_and_response_bodies
    content_types = [
      "application/xml",
      "application/vnd.example+xml; charset=utf-8",
      "text/xml",
      "text/plain",
      "text/html",
      "text/csv",
      ""
    ]

    content_types.each do |content_type|
      body = "<access_token>unsupported-text-secret</access_token>"
      headers = {"content-type" => content_type}
      request_body = OpenAI::Internal::Logging.format_body(body, headers: headers)
      response_body = OpenAI::Internal::Logging.format_observed_body(
        body,
        headers: headers,
        complete: true,
        total_bytes: body.bytesize
      )

      [request_body, response_body].each do |formatted|
        assert_includes(formatted, "BODY OMITTED]")
        assert_includes(formatted, "bytes=#{body.bytesize}")
        refute_includes(formatted, "unsupported-text-secret")
      end
    end
  end

  private def logged_request(log_level:, query: nil, headers: nil, body: nil)
    output = StringIO.new
    logger = Logger.new(output)
    response = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json", "x-request-id" => "req_security"},
      body: '{"ok":true}'
    )
    request = nil
    transport = Minitest::Mock.new(Object.new)
    transport.expect(:execute, response) do |value|
      request = value
      value.is_a?(OpenAI::HTTPClient::Request)
    end
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: transport,
      logger: logger,
      log_level: log_level
    )

    assert_equal(
      true,
      client.request(
        method: body.nil? ? :get : :post,
        path: "probe",
        query: query,
        headers: headers,
        body: body
      )[:ok]
    )
    assert_mock(transport)

    [output.string, request]
  end
end
