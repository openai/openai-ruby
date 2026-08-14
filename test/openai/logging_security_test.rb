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

  def test_debug_logs_redact_signed_urls_in_nested_json_request_and_response_bodies
    body = JSON.generate(
      input: [
        {
          content: [
            {image_url: "https://azure.example.test/image.png?sv=2025-01-01&sig=azure-signature-secret"},
            {
              file_url: "https://aws.example.test/file.pdf?" \
                        "X-Amz-Credential=aws-credential-secret&" \
                        "X-Amz-Signature=aws-signature-secret&safe=visible"
            },
            {
              url: "https://google.example.test/image.png?" \
                   "X-Goog-Credential=google-credential-secret&X-Goog-Signature=google-signature-secret"
            },
            [
              "HTTP://user:password@storage.example.test/nested?" \
              "s%69g=nested-signature-secret&sig=repeated-signature-secret&monkey=harmless"
            ]
          ]
        }
      ]
    )
    headers = {"content-type" => "application/json"}
    formatted_bodies = [
      OpenAI::Internal::Logging.format_body(body, headers: headers),
      OpenAI::Internal::Logging.format_observed_body(
        body,
        headers: headers,
        complete: true,
        total_bytes: body.bytesize
      )
    ]

    formatted_bodies.each do |formatted|
      assert_includes(formatted, "azure.example.test/image.png?sv=2025-01-01")
      assert_includes(formatted, "aws.example.test/file.pdf")
      assert_includes(formatted, "google.example.test/image.png")
      assert_includes(formatted, "safe=visible")
      assert_includes(formatted, "monkey=harmless")
      assert_includes(formatted, "%5BREDACTED%5D")
      refute_includes(formatted, "user:password@")

      %w[
        azure-signature-secret
        aws-credential-secret
        aws-signature-secret
        google-credential-secret
        google-signature-secret
        nested-signature-secret
        repeated-signature-secret
      ].each { |secret| refute_includes(formatted, secret) }
    end

    assert_includes(body, "azure-signature-secret")
    assert_includes(body, "aws-credential-secret")
    assert_includes(body, "google-signature-secret")
  end

  def test_debug_logs_recursively_redact_signed_urls_embedded_in_query_values
    storage_url =
      "https://user:password@storage.example.test/private.png?" \
      "sig=proxy-signature-secret&X-Amz-Credential=proxy-credential-secret&safe=inner-visible"
    resize_url = "https://resize.example.test/image?#{URI.encode_www_form(source: storage_url, width: 640)}"
    proxy_url = "https://proxy.example.test/load?#{URI.encode_www_form(url: resize_url, mode: 'resize')}"
    body = JSON.generate(image_url: proxy_url)
    headers = {"content-type" => "application/json"}
    form = URI.encode_www_form(redirect: proxy_url, safe: "outer-visible")
    formatted = [
      OpenAI::Internal::Logging.safe_url(URI(proxy_url)),
      OpenAI::Internal::Logging.safe_path(URI(proxy_url)),
      OpenAI::Internal::Logging.format_headers("Location" => proxy_url),
      OpenAI::Internal::Logging.format_body(body, headers: headers),
      OpenAI::Internal::Logging.format_observed_body(
        body,
        headers: headers,
        complete: true,
        total_bytes: body.bytesize
      ),
      OpenAI::Internal::Logging.format_body(
        form,
        headers: {"content-type" => "application/x-www-form-urlencoded"}
      )
    ]

    formatted.each do |value|
      assert_includes(value, "resize.example.test")
      assert_includes(value, "storage.example.test")
      assert_includes(value, "inner-visible")
      assert_includes(value, "640")
      refute_includes(value, "proxy-signature-secret")
      refute_includes(value, "proxy-credential-secret")
      refute_includes(value, "password")
    end

    assert_includes(body, "proxy-signature-secret")
    assert_includes(form, "proxy-credential-secret")
  end

  def test_debug_logs_omit_malformed_signed_urls_embedded_in_query_values
    malformed = "https://storage.example.test/private image.png?sig=malformed-proxy-secret"
    proxy_url = "https://proxy.example.test/load?#{URI.encode_www_form(url: malformed, mode: 'resize')}"
    formatted = OpenAI::Internal::Logging.format_body(
      JSON.generate(image_url: proxy_url),
      headers: {"content-type" => "application/json"}
    )

    assert_includes(formatted, "proxy.example.test/load")
    assert_includes(formatted, "mode=resize")
    assert_includes(formatted, "url=%5BURL+OMITTED%5D")
    refute_includes(formatted, "malformed-proxy-secret")
  end

  def test_debug_logs_bound_recursively_nested_url_values
    deep_url = "#{'https://a/x?u=' * 500}https://storage.example.test/file?sig=deep-signature-secret"
    body = JSON.generate(image_url: deep_url)
    formatted = OpenAI::Internal::Logging.format_body(
      body,
      headers: {"content-type" => "application/json"}
    )

    assert_operator(body.bytesize, :<, OpenAI::Internal::Logging::MAX_BODY_BYTES)
    assert_operator(formatted.bytesize, :<=, OpenAI::Internal::Logging::MAX_BODY_BYTES)
    assert_includes(formatted, "https://a/x?u=")
    refute_includes(formatted, "deep-signature-secret")
    assert_includes(body, "deep-signature-secret")
  end

  def test_debug_logs_omit_signed_urls_with_leading_whitespace
    values = {
      image_url: " https://storage.example.test/image.png?sig=leading-space-secret",
      file_url: "\thttp://storage.example.test/file.pdf?X-Amz-Signature=leading-tab-secret",
      url: "\nhttps://storage.example.test/output.png?X-Goog-Signature=leading-newline-secret",
      unicode_url: "\u00a0https://storage.example.test/unicode.png?sig=leading-unicode-secret",
      description: " ordinary text",
      preview_url: " data:image/png;base64,YWJj"
    }
    body = JSON.generate(values)
    headers = {"content-type" => "application/json"}
    formatted = [
      OpenAI::Internal::Logging.format_body(body, headers: headers),
      OpenAI::Internal::Logging.format_observed_body(
        body,
        headers: headers,
        complete: true,
        total_bytes: body.bytesize
      )
    ]

    formatted.each do |value|
      assert_equal(
        {
          "image_url" => "[URL OMITTED]",
          "file_url" => "[URL OMITTED]",
          "url" => "[URL OMITTED]",
          "unicode_url" => "[URL OMITTED]",
          "description" => " ordinary text",
          "preview_url" => " data:image/png;base64,YWJj"
        },
        JSON.parse(value)
      )
      refute_includes(value, "leading-space-secret")
      refute_includes(value, "leading-tab-secret")
      refute_includes(value, "leading-newline-secret")
      refute_includes(value, "leading-unicode-secret")
    end
  end

  def test_debug_logs_omit_nested_signed_urls_with_leading_whitespace
    nested_url = " https://storage.example.test/file?sig=nested-leading-space-secret"
    proxy_url = "https://proxy.example.test/load?#{URI.encode_www_form(url: nested_url, mode: 'resize')}"
    formatted = OpenAI::Internal::Logging.format_body(
      JSON.generate(image_url: proxy_url),
      headers: {"content-type" => "application/json"}
    )

    assert_includes(formatted, "proxy.example.test/load")
    assert_includes(formatted, "mode=resize")
    assert_includes(formatted, "url=%5BURL+OMITTED%5D")
    refute_includes(formatted, "nested-leading-space-secret")
  end

  def test_debug_logs_preserve_harmless_urls_and_omit_malformed_signed_urls
    harmless = "https://storage.example.test/public/image.png?version=1&format=png"
    without_query = "https://storage.example.test/public/image.png"
    data_url = "data:image/png;base64,YWJj"
    malformed = "https://storage.example.test/private image.png?sig=malformed-signature-secret"
    malformed_percent = "https://storage.example.test/%ZZ?sig=malformed-percent-secret"
    formatted = OpenAI::Internal::Logging.format_body(
      JSON.generate(
        url: harmless,
        image_url: malformed,
        file_url: malformed_percent,
        preview_url: data_url,
        public_url: without_query,
        description: "ordinary text"
      ),
      headers: {"content-type" => "application/json"}
    )

    assert_equal(
      {
        "url" => harmless,
        "image_url" => "[URL OMITTED]",
        "file_url" => "[URL OMITTED]",
        "preview_url" => data_url,
        "public_url" => without_query,
        "description" => "ordinary text"
      },
      JSON.parse(formatted)
    )
    refute_includes(formatted, "malformed-signature-secret")
    refute_includes(formatted, "malformed-percent-secret")
  end

  def test_responses_create_redacts_signed_urls_without_changing_request_or_response
    image_url = "https://storage.example.test/private/image.png?sv=2025-01-01&sig=request-signature-secret"
    response_url = "https://storage.example.test/private/output.png?sig=response-signature-secret"
    output = StringIO.new
    response = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json", "x-request-id" => "req_signed_url"},
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
    assert_includes(output.string, "storage.example.test/private/image.png?sv=2025-01-01")
    assert_includes(output.string, "storage.example.test/private/output.png")
    assert_includes(output.string, "%5BREDACTED%5D")
    refute_includes(output.string, "request-signature-secret")
    refute_includes(output.string, "response-signature-secret")
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
