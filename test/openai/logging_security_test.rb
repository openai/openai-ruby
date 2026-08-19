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

  def test_url_sanitization_removes_plain_and_percent_encoded_fragments_without_mutating_urls
    urls = {
      "https://user:password@example.com/probe?safe=visible&access_token=fake-query-secret" \
        "#access_token=fake-fragment-secret" => "https://example.com/probe?safe=visible&access_token=%5BREDACTED%5D",
      "https://example.com/probe#access%5Ftoken%3Dfake-percent-encoded-fragment-secret" => "https://example.com/probe"
    }

    urls.each do |original, expected|
      url = URI(original)

      assert_equal(expected, OpenAI::Internal::Logging.safe_url(url))
      assert_equal(original, url.to_s)
      refute_includes(OpenAI::Internal::Logging.safe_path(url), "fragment-secret")
    end

    fragment_only = URI("#access_token=fake-fragment-only-secret")

    assert_equal("", OpenAI::Internal::Logging.safe_url(fragment_only))
    assert_equal("/", OpenAI::Internal::Logging.safe_path(fragment_only))
    assert_equal("#access_token=fake-fragment-only-secret", fragment_only.to_s)
  end

  def test_url_sanitization_preserves_fragment_free_rendering_and_invalid_header_fallbacks
    original = "https://user:password@example.com/probe?access_token=fake-query-secret&safe=hello%20world"
    url = URI(original)

    assert_equal(
      "https://example.com/probe?access_token=%5BREDACTED%5D&safe=hello+world",
      OpenAI::Internal::Logging.safe_url(url)
    )
    assert_equal(
      "/probe?access_token=%5BREDACTED%5D&safe=hello+world",
      OpenAI::Internal::Logging.safe_path(url)
    )
    assert_equal(original, url.to_s)

    invalid = "https://example.com/next path#access_token=fake-invalid-fragment-secret"

    assert_equal(
      "{\"Location\":\"[URL OMITTED]\"}",
      OpenAI::Internal::Logging.format_headers("Location" => invalid)
    )
  end

  def test_debug_response_headers_remove_fragments_from_every_url_valued_header
    response_headers = {
      "Location" => "https://user:password@example.com/files?safe=visible&sig=fake-location-query-secret" \
        "#access_token=fake-location-fragment-secret",
      "Link" => "https://example.com/next#access_token=fake-link-fragment-secret",
      "Refresh" => "https://example.com/refresh#access%5Ftoken%3Dfake-refresh-fragment-secret",
      "X-Download-URL" => "https://example.com/download?token=fake-download-query-secret&safe=still-visible" \
        "#client_secret=fake-download-fragment-secret"
    }
    output, request = logged_request(
      log_level: :debug,
      query: {"access_token" => "fake-request-query-secret", "safe" => "visible"},
      response_headers: response_headers
    )

    assert_includes(output, "response received")
    assert_includes(output, "https://example.com/files?safe=visible&sig=%5BREDACTED%5D")
    assert_includes(output, "https://example.com/next")
    assert_includes(output, "https://example.com/refresh")
    assert_includes(output, "https://example.com/download?token=%5BREDACTED%5D&safe=still-visible")
    assert_includes(output, "access_token=%5BREDACTED%5D")
    assert_includes(request.url.to_s, "fake-request-query-secret")
    refute_includes(output, "fake-location-query-secret")
    refute_includes(output, "fake-download-query-secret")
    refute_includes(output, "fake-request-query-secret")
    refute_includes(output, "fragment-secret")
    refute_includes(output, "user:password@")
  end

  def test_debug_redirect_logs_remove_fragments_without_changing_transport_urls
    location = "/v1/redirected?safe=visible&access_token=fake-redirect-query-secret" \
      "#access%5Ftoken%3Dfake-redirect-fragment-secret"
    output, response, redirected_request = logged_response(
      path: "legacy/issue",
      response_body: {"value" => "ordinary-response-value"},
      redirect: {status: 307, location: location}
    )

    assert_equal("ordinary-response-value", response[:value])
    assert_equal("https://example.com#{location}", redirected_request.url.to_s)
    assert_includes(
      output,
      "redirect=1 method=POST " \
        "url=https://example.com/v1/redirected?safe=visible&access_token=%5BREDACTED%5D "
    )
    assert_includes(output, "\"location\":\"/v1/redirected?safe=visible&access_token=%5BREDACTED%5D\"")
    refute_includes(output, "fake-redirect-query-secret")
    refute_includes(output, "fake-redirect-fragment-secret")
    refute_includes(output, "access%5Ftoken%3D")
  end

  def test_info_logs_preserve_query_redaction_without_exposing_response_header_fragments
    output, request = logged_request(
      log_level: :info,
      query: {"access_token" => "fake-info-query-secret", "safe" => "visible"},
      response_headers: {
        "Location" => "https://example.com/next#access_token=fake-info-fragment-secret"
      }
    )

    assert_includes(output, "request complete")
    assert_includes(output, "path=/v1/probe?access_token=%5BREDACTED%5D&safe=visible")
    assert_includes(request.url.to_s, "fake-info-query-secret")
    refute_includes(output, "request started")
    refute_includes(output, "response received")
    refute_includes(output, "fake-info-query-secret")
    refute_includes(output, "fake-info-fragment-secret")
  end

  def test_debug_logs_never_expose_newly_issued_credential_values
    issuers = {
      "organization/admin_api_keys" => "sk-admin-demo-release-audit",
      "organization/projects/proj_123/service_accounts/acct_123/api_keys" => "service-account-credential",
      "realtime/client_secrets" => "ek_demo-release-audit",
      "realtime/translations/client_secrets" => "translation-client-credential",
      "organization/admin%5fapi%5Fkeys/" => "percent-encoded-admin-credential",
      "realtime/%63lient%5Fsecrets/" => "percent-encoded-realtime-credential"
    }

    issuers.each do |path, value|
      response_body = {"value" => value, "details" => {"value" => "ordinary-nested-value"}}
      output, response = logged_response(path: path, response_body: response_body)

      assert_equal(value, response[:value])
      assert_equal("ordinary-nested-value", response[:details][:value])
      assert_includes(
        output,
        "[JSON BODY] bytes=#{JSON.generate(response_body).bytesize} type=object fields=2"
      )
      refute_includes(output, value)
      refute_includes(output, "ordinary-nested-value")
      refute_includes(output, "ordinary-request-value")
    end
  end

  def test_debug_logs_never_expose_credentials_after_body_preserving_redirects
    redirects = {
      307 => "/v1/realtime/client%5Fsecrets",
      308 => "/v1/organization/projects/proj_123/service_accounts/acct_123/api%5Fkeys"
    }

    redirects.each do |status, location|
      value = "redirected-credential-#{status}"
      output, response = logged_response(
        path: "legacy/issue",
        response_body: {"value" => value},
        redirect: {status: status, location: location}
      )

      assert_equal(value, response[:value])
      assert_includes(output, "redirect=1 method=POST url=https://example.com#{location}")
      assert_includes(output, "type=object fields=1")
      refute_includes(output, value)
    end
  end

  def test_debug_logs_never_expose_nested_service_account_api_key_values
    value = "service-account-creation-credential"
    output, response = logged_response(
      path: "organization/projects/proj_123/service_accounts",
      response_body: {"id" => "acct_123", "api_key" => {"value" => value}}
    )

    assert_equal(value, response[:api_key][:value])
    assert_includes(output, "type=object fields=2")
    refute_includes(output, value)
    refute_includes(output, "api_key")
  end

  def test_debug_logs_summarize_ordinary_response_values_without_changing_payloads
    value = "ordinary-visible-value"
    output, response = logged_response(path: "responses", response_body: {"value" => value})

    assert_equal(value, response[:value])
    assert_includes(output, "type=object fields=1")
    refute_includes(output, value)
  end

  def test_debug_logs_summarize_form_urlencoded_request_bodies_without_fields_or_values
    body = "client_secret=client-form-secret&access_token=access-form-secret&" \
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
    assert_includes(output, "[FORM BODY] bytes=#{body.bytesize} fields=9")
    refute_includes(output, "client_secret")
    refute_includes(output, "safe=hello+world")
    refute_includes(output, "repeat=one")
    refute_includes(output, "client-form-secret")
    refute_includes(output, "access-form-secret")
    refute_includes(output, "access-key-form-secret")
    refute_includes(output, "credential-form-secret")
    refute_includes(output, "array-form-secret")
    refute_includes(output, "nested-form-secret")
  end

  def test_debug_logs_summarize_form_urlencoded_response_bodies_without_fields_or_values
    body = "accessToken=response-access-secret&access_token%5B%5D=response-array-secret&" \
      "accessKey=response-access-key-secret&credentials%5Bvalue%5D=response-credential-secret&" \
      "credentials%5Bclient_secret%5D=response-client-secret&safe=visible"
    formatted = OpenAI::Internal::Logging.format_observed_body(
      body,
      headers: {"content-type" => "application/x-www-form-urlencoded"},
      complete: true,
      total_bytes: body.bytesize
    )

    assert_equal("[FORM BODY] bytes=#{body.bytesize} fields=6", formatted)
    refute_includes(formatted, "response-access-secret")
    refute_includes(formatted, "response-access-key-secret")
    refute_includes(formatted, "response-credential-secret")
    refute_includes(formatted, "response-array-secret")
    refute_includes(formatted, "response-client-secret")
  end

  def test_debug_logs_omit_malformed_or_oversized_form_bodies
    headers = {"content-type" => "application/x-www-form-urlencoded"}
    malformed = "access_token=malformed-secret&invalid=\xFF".b
    oversized = "access_token=oversized-secret&padding=#{"x" * OpenAI::Internal::Logging::MAX_BODY_BYTES}"

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

  def test_debug_json_summaries_never_include_customer_controlled_strings_or_keys
    values = [
      "https://storage.example.test/file?sig=azure-synthetic-credential",
      "https://storage.example.test/file?X-Amz-Credential=aws-synthetic-credential",
      "https://storage.example.test/file?X-Goog-Signature=google-synthetic-credential",
      "fetch https://storage.example.test/files/O'Reilly?sig=apostrophe-synthetic-credential",
      "//storage.example.test/file?sig=relative-synthetic-credential",
      "https&#58;//storage.example.test/file?sig=entity-synthetic-credential",
      "https://storage.example.test/file?download=1;sig=semicolon-synthetic-credential",
      "Download https%3A%2F%2Fstorage.example.test%2Ffile%3Fsig%3Dencoded-synthetic-credential",
      "fetch ht\ttps://storage.example.test/file?sig=control-synthetic-credential",
      "private customer prompt",
      "private model response"
    ]
    signed_key = "https://storage.example.test/file?sig=key-synthetic-credential"
    body = JSON.generate(
      signed_key => values,
      "nested-private-key" => {"inner-private-key" => "private tool argument"}
    )
    headers = {"content-type" => "application/json"}
    request = OpenAI::Internal::Logging.format_body(body, headers: headers)
    response = OpenAI::Internal::Logging.format_observed_body(
      body,
      headers: headers,
      complete: true,
      total_bytes: body.bytesize
    )

    [request, response].each do |summary|
      assert_equal("[JSON BODY] bytes=#{body.bytesize} type=object fields=2", summary)
      refute_includes(summary, "synthetic-credential")
      refute_includes(summary, "private")
      refute_includes(summary, "storage.example.test")
    end

    assert_includes(body, "azure-synthetic-credential")
    assert_includes(body, "key-synthetic-credential")
    assert_includes(body, "private customer prompt")
  end

  def test_debug_json_summaries_report_only_safe_top_level_shape
    examples = {
      {"private-key" => "private-value"} => "object fields=1",
      ["private-value", 7, true] => "array items=3",
      "private-value" => "string",
      42 => "number",
      1.25 => "number",
      true => "boolean",
      false => "boolean",
      nil => "null"
    }
    headers = {"content-type" => "application/json"}

    examples.each do |value, shape|
      body = JSON.generate(value)
      expected = "[JSON BODY] bytes=#{body.bytesize} type=#{shape}"
      request = OpenAI::Internal::Logging.format_body(body, headers: headers)
      response = OpenAI::Internal::Logging.format_observed_body(
        body,
        headers: headers,
        complete: true,
        total_bytes: body.bytesize
      )

      assert_equal(expected, request)
      assert_equal(expected, response)
      refute_includes(request, "private")
    end
  end

  def test_debug_logs_omit_malformed_json_without_emitting_partial_body_content
    body = "{\"private-key\":\"private-signed-url?sig=malformed-synthetic-credential\""
    headers = {"content-type" => "application/json"}

    [
      OpenAI::Internal::Logging.format_body(body, headers: headers),
      OpenAI::Internal::Logging.format_observed_body(
        body,
        headers: headers,
        complete: true,
        total_bytes: body.bytesize
      )
    ].each do |summary|
      assert_equal("[INVALID JSON BODY OMITTED] bytes=#{body.bytesize}", summary)
      refute_includes(summary, "private")
      refute_includes(summary, "synthetic-credential")
    end
  end

  def test_responses_create_never_logs_body_content_or_changes_payloads
    image_url = "https://storage.example.test/private/image.png?sv=2025-01-01&sig=request-synthetic-credential"
    response_url = "https://storage.example.test/private/output.png?sig=response-synthetic-credential"
    response_headers = {
      "location" => "https://download.example.test/location#access_token=location-synthetic-credential",
      "link" => "https://download.example.test/link#access_token=link-synthetic-credential",
      "refresh" => "https://download.example.test/refresh#access%5Ftoken%3Drefresh-synthetic-credential",
      "x-download-url" => "https://download.example.test/download#token=download-synthetic-credential"
    }
    output = StringIO.new
    response = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {
        "content-type" => "application/json",
        "x-request-id" => "req_signed_url",
        **response_headers
      },
      body: JSON.generate(id: "resp_signed_url", output: [], metadata: {download_url: response_url})
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
      logger: Logger.new(output),
      log_level: :debug
    )

    result = client.responses.create(
      model: "gpt-4.1",
      input: [{role: "user", content: [{type: "input_image", image_url: image_url}]}]
    )

    assert_mock(transport)
    assert_equal(image_url, JSON.parse(request.body).dig("input", 0, "content", 0, "image_url"))
    assert_equal(response_url, result.metadata[:download_url])
    assert_equal("req_signed_url", result.last_response.request_id)
    assert_predicate(result.last_response.headers, :frozen?)
    response_headers.each do |name, value|
      assert_equal(value, result.last_response.headers.fetch(name))
    end

    assert_includes(output.string, "[JSON BODY]")
    assert_includes(output.string, "type=object fields=")
    refute_includes(output.string, "synthetic-credential")
    refute_includes(output.string, "storage.example.test")
    refute_includes(output.string, "image_url")
    refute_includes(output.string, "download_url")
  end

  private def logged_response(path:, response_body:, redirect: nil)
    output = StringIO.new
    transport_request = nil
    response = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json", "x-request-id" => "req_credential"},
      body: JSON.generate(response_body)
    )
    transport = Minitest::Mock.new(Object.new)
    if redirect
      redirect_response = OpenAI::HTTPClient::Response.new(
        status: redirect.fetch(:status),
        headers: {"location" => redirect.fetch(:location)},
        body: ""
      )
      transport.expect(:execute, redirect_response) { |request| request.is_a?(OpenAI::HTTPClient::Request) }
    end

    transport.expect(:execute, response) do |request|
      transport_request = request
      request.is_a?(OpenAI::HTTPClient::Request)
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: transport,
      logger: Logger.new(output),
      log_level: :debug
    )

    parsed = client.request(method: :post, path: path, body: {"value" => "ordinary-request-value"})
    assert_mock(transport)

    [output.string, parsed, transport_request]
  end

  private def logged_request(log_level:, query: nil, headers: nil, body: nil, response_headers: {})
    output = StringIO.new
    logger = Logger.new(output)
    response = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json", "x-request-id" => "req_security"}.merge(response_headers),
      body: "{\"ok\":true}"
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
