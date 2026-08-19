# frozen_string_literal: true

require "logger"
require "minitest/mock"

require_relative "test_helper"

class OpenAI::Test::ErrorsTest < Minitest::Test
  def test_nested_api_errors_include_safe_diagnostics_without_disclosing_the_response
    url = URI("https://example.com/v1/responses")
    headers = {"x-request-id" => "req_nested", "set-cookie" => "fake-session-cookie"}
    body = {
      error: {message: "The requested model is unavailable"},
      prompt: "private customer prompt",
      response: {output_text: "private model response"},
      access_token: "fake-response-access-token"
    }

    error = status_error(url: url, headers: headers, body: body)

    assert_instance_of(OpenAI::Errors::BadRequestError, error)
    assert_includes(error.message, "status=400")
    assert_includes(error.message, "url=https://example.com/v1/responses")
    assert_includes(error.message, "request_id=req_nested")
    assert_includes(error.message, "The requested model is unavailable")
    refute_includes(error.message, "private customer prompt")
    refute_includes(error.message, "private model response")
    refute_includes(error.message, "fake-response-access-token")
    refute_includes(error.message, "fake-session-cookie")
    assert_same(url, error.url)
    assert_same(headers, error.headers)
    assert_same(body, error.body)
    assert_equal("req_nested", error.request_id)
  end

  def test_fallback_sanitizes_url_userinfo_and_signed_query_parameters
    url = URI(
      "https://fake-user:fake-password@example.com/v1/responses?" \
        "X-Amz-Signature=fake-signature&accessToken=fake-access-token&safe=visible"
    )

    error = status_error(url: url, body: {unexpected: "private response"})

    assert_includes(error.message, "url=https://example.com/v1/responses")
    refute_includes(error.message, "?")
    refute_includes(error.message, "safe=visible")
    refute_includes(error.message, "fake-user")
    refute_includes(error.message, "fake-password")
    refute_includes(error.message, "fake-signature")
    refute_includes(error.message, "fake-access-token")
    refute_includes(error.message, "private response")
    assert_includes(error.url.to_s, "fake-user:fake-password@")
    assert_includes(error.url.to_s, "fake-signature")
    assert_includes(error.url.to_s, "safe=visible")
  end

  def test_fallback_omits_customer_content_and_unknown_sensitive_query_values
    query = URI.encode_www_form(
      prompt: "private customer prompt",
      input: "private customer input",
      response: "private model response",
      messages: "private conversation content",
      custom_provider_field: "private provider credential"
    )
    url = URI("https://example.com/v1/responses?#{query}")

    error = status_error(url: url, body: {error: {message: "Provider rejected the request"}})

    assert_includes(error.message, "url=https://example.com/v1/responses")
    assert_includes(error.message, "Provider rejected the request")
    refute_includes(error.message, "?")
    refute_includes(error.message, "private")
    assert_same(url, error.url)
    assert_includes(error.url.to_s, "custom_provider_field")
  end

  def test_unrecognized_and_non_string_error_shapes_never_stringify_raw_bodies
    bodies = [
      {prompt: "private customer prompt", token: "fake-body-token"},
      {message: {content: "private nested model response"}},
      {error: {message: {access_token: "fake-nested-token"}}},
      {error_description: {secret: "fake-description-secret"}},
      ["private array response", {token: "fake-array-token"}],
      "private plaintext response with fake-plaintext-token",
      nil
    ]

    bodies.each do |body|
      error = status_error(body: body)

      assert_includes(error.message, "status=400")
      assert_includes(error.message, "url=https://example.com/v1/responses")
      refute_includes(error.message, "private")
      refute_includes(error.message, "fake-")
      assert_same(body, error.body)
    end
  end

  def test_recognized_provider_error_descriptions_remain_meaningful
    bodies = {
      "Nested provider error" => {error: {message: "Nested provider error"}},
      "Nested OAuth provider error" => {error: {error_description: "Nested OAuth provider error"}},
      "OAuth provider rejected the request" => {error_description: "OAuth provider rejected the request"},
      "invalid_client" => {error: "invalid_client"},
      "invalid bearer token" => {error: {message: "invalid bearer token"}},
      "Invalid access token" => {error: {message: "Invalid access token"}},
      "Basic authentication failed" => {error: {message: "Basic authentication failed"}},
      "The access token is expired" => {error: {message: "The access token is expired"}},
      "The access token is expired. Please sign in again." => {
        error: {message: "The access token is expired. Please sign in again."}
      },
      "The token is invalid" => {error: {message: "The token is invalid"}},
      "The token is invalid or has expired." => {error: {message: "The token is invalid or has expired."}},
      "The API key is missing" => {error: {message: "The API key is missing"}},
      "The API key is missing. Add one to your account settings." => {
        error: {message: "The API key is missing. Add one to your account settings."}
      },
      "The client secret is invalid" => {error: {message: "The client secret is invalid"}},
      "The signature is invalid" => {error: {message: "The signature is invalid"}},
      "The request input is invalid" => {error: {message: "The request input is invalid"}},
      "The request input is invalid: expected a string." => {
        error: {message: "The request input is invalid: expected a string."}
      },
      "The input is required" => {error: {message: "The input is required"}},
      "The input is required for this operation." => {
        error: {message: "The input is required for this operation."}
      },
      "The response is malformed" => {error: {message: "The response is malformed"}},
      "The response is malformed and could not be processed." => {
        error: {message: "The response is malformed and could not be processed."}
      },
      "The output is too long" => {error: {message: "The output is too long"}},
      "The output is too long for the selected model." => {
        error: {message: "The output is too long for the selected model."}
      },
      "Message is required" => {error: {message: "Message is required"}},
      "Content is required" => {error: {message: "Content is required"}},
      "Expected input: string" => {error: {message: "Expected input: string"}},
      "Maximum output: 2048 tokens" => {error: {message: "Maximum output: 2048 tokens"}}
    }

    bodies.each do |expected, body|
      assert_includes(status_error(body: body).message, expected)
    end
  end

  def test_fallback_omits_upstream_descriptions_with_credentials_or_customer_content
    descriptions = [
      "Provider rejected https://example.com/upload?X-Amz-Signature=fake-upstream-signature",
      "Provider rejected bearer fake-upstream-bearer-token",
      "Provider rejected bearer abc123",
      "Provider rejected bearer token fake-upstream-opaque-token",
      "Provider rejected bearer credentials fake-upstream-opaque-credential",
      "Provider rejected access token fake-upstream-opaque-token",
      "Provider rejected access_token=fake-upstream-access-token",
      "Provider rejected refresh_token=fake-upstream-refresh-token",
      "Provider rejected id_token=fake-upstream-id-token",
      "Provider rejected session_token=fake-upstream-session-token",
      "Provider rejected private_key=fake-upstream-private-key",
      "Provider rejected API key: fake-upstream-api-key",
      "Provider rejected {\"access_token\":\"fake-upstream-quoted-token\"}",
      "Provider rejected Authorization: Basic fake-upstream-basic-credentials",
      "Provider rejected Basic ZmFrZS11c2VyOmZha2UtcGFzc3dvcmQ=",
      "Provider rejected client_assertion=eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJmYWtlIn0.fake-signature",
      "Provider rejected sk-abcdefghijklmnopqrstuvwxyz0123456789",
      "Provider rejected rk-abcdefghijklmnopqrstuvwxyz0123456789",
      "Provider rejected ek-abcdefghijklmnopqrstuvwxyz0123456789",
      "Provider rejected AWSAccessKeyId=AKIAIOSFODNN7EXAMPLE",
      "Provider rejected Cookie: fake-upstream-cookie",
      "Provider rejected token is fake-upstream-prose-token",
      "Provider rejected sk-proj-fake-upstream-unlabeled-token",
      "The access token is invalid: oauthopaqueabcdefghijklmnopqrstuvwxyz",
      "The API key is invalid: opaqueproviderkeyabcdefghijklmnopqrstuvwxyz",
      "The client secret is missing: opaqueclientsecretabcdefghijklmnopqrstuvwxyz",
      "Provider rejected prompt: private upstream customer prompt",
      "Provider rejected prompt is private upstream customer prompt",
      "Provider rejected user_prompt=private upstream customer prompt",
      "Provider rejected system_prompt=private upstream system prompt",
      "Provider rejected user_input[0]: private upstream customer prompt",
      "Provider rejected input[0]: private upstream customer input",
      "Provider rejected prompt[0]: private upstream customer prompt",
      "Provider rejected content[0]: private upstream customer content",
      "Provider rejected input_text=private upstream customer input",
      "Provider rejected output_text=private upstream model response",
      "The request input is invalid: private upstream customer prompt",
      "Provider rejected response=private upstream model response"
    ]

    descriptions.each do |description|
      error = status_error(body: {error: {message: description}})

      assert_includes(error.message, "status=400")
      assert_includes(error.message, "url=https://example.com/v1/responses")
      refute_includes(error.message, "message=")
      refute_includes(error.message, "fake-upstream")
      refute_includes(error.message, "private upstream")
      assert_same(description, error.body.dig(:error, :message))
    end
  end

  def test_upstream_error_descriptions_are_bounded_and_log_safe
    description = "Provider failure\nforged log entry " + ("x" * 600) + " private trailing prompt"

    error = status_error(body: {error: {message: description}})

    assert_includes(error.message, "Provider failure\\nforged log entry")
    assert_includes(error.message, "...")
    assert_operator(error.message.bytesize, :<, 700)
    refute_includes(error.message, "\n")
    refute_includes(error.message, "private trailing prompt")
  end

  def test_upstream_error_descriptions_remain_byte_bounded_after_escaping
    descriptions = ["😀" * 600, "\n" * 600, "\\" * 600]

    descriptions.each do |description|
      error = status_error(body: {error: {message: description}})
      rendered = error.message.split("message=", 2).last

      assert_operator(rendered.bytesize, :<=, 515)
      assert(rendered.end_with?("..."))
      refute_includes(rendered, "\n")
      assert_same(description, error.body.dig(:error, :message))
    end
  end

  def test_existing_top_level_provider_messages_are_not_truncated
    message = "Existing top-level provider message " + ("x" * 600)
    body = {message: message}

    error = status_error(body: body)

    assert_equal(message, error.message)
    assert_same(body, error.body)
  end

  def test_request_ids_are_log_safe_without_altering_raw_headers
    request_id = "req_safe\nforged log entry"
    headers = {"x-request-id" => request_id}

    error = status_error(headers: headers)

    assert_includes(error.message, "request_id=req_safe\\nforged log entry")
    refute_includes(error.message, "\n")
    assert_same(request_id, error.request_id)
    assert_same(headers, error.headers)
  end

  def test_request_ids_are_bounded_without_altering_raw_headers
    request_id = "req_" + ("😀" * 600)
    headers = {"x-request-id" => request_id}

    error = status_error(headers: headers)
    rendered = error.message.split("request_id=", 2).last

    assert_operator(rendered.bytesize, :<=, 131)
    assert(rendered.end_with?("..."))
    assert_same(request_id, error.request_id)
    assert_same(headers, error.headers)
  end

  def test_existing_top_level_and_explicit_messages_remain_unchanged
    body = {message: "Existing top-level provider message", token: "fake-body-token"}
    explicit_message = "Explicit streaming or OAuth message " + ("x" * 600)

    assert_equal("Existing top-level provider message", status_error(body: body).message)
    assert_equal(explicit_message, status_error(body: body, message: explicit_message).message)
    assert_equal("", status_error(body: {message: ""}).message)
  end

  def test_existing_top_level_scalar_messages_remain_unchanged
    [true, false, 123, 1.25, :provider_code].each do |message|
      body = {message: message}
      error = status_error(body: body)

      assert_equal(message.to_s, error.message)
      assert_same(body, error.body)
    end
  end

  def test_documented_status_exception_classes_and_inheritance_are_preserved
    expected_classes = {
      400 => OpenAI::Errors::BadRequestError,
      401 => OpenAI::Errors::AuthenticationError,
      403 => OpenAI::Errors::PermissionDeniedError,
      404 => OpenAI::Errors::NotFoundError,
      409 => OpenAI::Errors::ConflictError,
      422 => OpenAI::Errors::UnprocessableEntityError,
      429 => OpenAI::Errors::RateLimitError,
      418 => OpenAI::Errors::APIStatusError,
      500 => OpenAI::Errors::InternalServerError,
      599 => OpenAI::Errors::InternalServerError
    }

    expected_classes.each do |status, expected_class|
      error = status_error(status: status, body: {error: {message: "Provider rejected the request"}})

      assert_instance_of(expected_class, error)
      assert_kind_of(OpenAI::Errors::APIStatusError, error)
      assert_kind_of(OpenAI::Errors::APIError, error)
      assert_equal(status, error.status)
    end
  end

  def test_constructor_keywords_and_helper_visibility_preserve_the_typed_public_interface
    expected_parameters = [
      [:keyreq, :url],
      [:keyreq, :status],
      [:keyreq, :headers],
      [:keyreq, :body],
      [:keyreq, :request],
      [:keyreq, :response],
      [:key, :message]
    ]

    assert_equal(expected_parameters, OpenAI::Errors::APIStatusError.method(:for).parameters)
    assert_equal(expected_parameters, OpenAI::Errors::APIStatusError.instance_method(:initialize).parameters)
    assert(OpenAI::Errors::APIStatusError.private_method_defined?(:safe_status_message))
    refute(OpenAI::Errors::APIStatusError.public_method_defined?(:safe_status_message))
  end

  def test_structured_error_metadata_and_writable_raw_accessors_are_preserved
    url = URI("https://example.com/v1/responses")
    headers = {"x-request-id" => "req_original"}
    body = {
      error: {message: "Provider rejected the request", code: "nested_only"},
      code: "invalid_request",
      param: "model",
      type: "invalid_request_error"
    }

    error = status_error(url: url, status: 422, headers: headers, body: body)

    assert_equal("invalid_request", error.code)
    assert_equal("model", error.param)
    assert_equal("invalid_request_error", error.type)
    assert_same(url, error.url)
    assert_same(headers, error.headers)
    assert_same(body, error.body)
    assert_equal("req_original", error.request_id)

    replacement_url = URI("https://example.com/v1/replacement")
    replacement_headers = {"x-request-id" => "req_replacement"}
    replacement_body = {raw: "still available to the caller"}
    error.url = replacement_url
    error.status = 400
    error.headers = replacement_headers
    error.body = replacement_body
    error.code = "replacement_code"
    error.param = "replacement_param"
    error.type = "replacement_type"

    assert_same(replacement_url, error.url)
    assert_equal(400, error.status)
    assert_same(replacement_headers, error.headers)
    assert_same(replacement_body, error.body)
    assert_equal("req_replacement", error.request_id)
    assert_equal("replacement_code", error.code)
    assert_equal("replacement_param", error.param)
    assert_equal("replacement_type", error.type)
  end

  def test_nil_headers_and_absent_request_ids_remain_supported
    error = status_error(headers: nil, body: {error: {message: "Provider rejected the request"}})

    assert_nil(error.headers)
    assert_nil(error.request_id)
    assert_includes(error.message, "Provider rejected the request")
    refute_includes(error.message, "request_id=")
  end

  def test_oauth_errors_preserve_descriptions_and_raw_response_data
    headers = {"x-request-id" => "req_oauth"}
    body = {error: "invalid_grant", error_description: "OAuth credentials were rejected"}

    error = OpenAI::Errors::OAuthError.new(status: 401, body: body, headers: headers)

    assert_equal("OAuth credentials were rejected", error.message)
    assert_equal(:invalid_grant, error.error_code)
    assert_same(body, error.body)
    assert_same(headers, error.headers)
  end

  def test_oauth_error_code_and_default_message_fallbacks_remain_unchanged
    code_only = OpenAI::Errors::OAuthError.new(status: 401, body: {error: "invalid_client"}, headers: nil)
    no_description = OpenAI::Errors::OAuthError.new(status: 401, body: nil, headers: nil)

    assert_equal("invalid_client", code_only.message)
    assert_equal("invalid_client", code_only.error_code)
    assert_nil(code_only.request_id)
    assert_equal("OAuth2 authentication error", no_description.message)
    assert_nil(no_description.error_code)
  end

  def test_transport_errors_remain_safe_when_callers_log_exception_messages
    response_body = {
      error: {message: "Provider rejected the request"},
      prompt: "private logged prompt",
      response: "private logged model response",
      access_token: "fake-logged-response-token"
    }
    response = OpenAI::HTTPClient::Response.new(
      status: 400,
      headers: {"content-type" => "application/json", "x-request-id" => "req_logged"},
      body: JSON.generate(response_body)
    )
    http_client = Minitest::Mock.new(OpenAI::HTTPClient.new)
    http_client.expect(:execute, response, [OpenAI::HTTPClient::Request])
    client = OpenAI::Client.new(
      api_key: "fake-api-key",
      base_url: "https://fake-user:fake-password@example.com/v1",
      http_client: http_client,
      max_retries: 0
    )

    error = assert_raises(OpenAI::Errors::BadRequestError) do
      client.request(method: :get, path: "responses", query: {signature: "fake-query-signature"})
    end

    output = StringIO.new
    Logger.new(output).error(error)
    logged = output.string

    assert_mock(http_client)
    assert_equal(response_body, error.body)
    assert_equal("req_logged", error.request_id)
    assert_includes(logged, "status=400")
    assert_includes(logged, "request_id=req_logged")
    assert_includes(logged, "Provider rejected the request")
    refute_includes(logged, "fake-user")
    refute_includes(logged, "fake-password")
    refute_includes(logged, "fake-query-signature")
    refute_includes(logged, "private logged prompt")
    refute_includes(logged, "private logged model response")
    refute_includes(logged, "fake-logged-response-token")
  end

  private def status_error(
    url: URI("https://example.com/v1/responses"),
    status: 400,
    headers: {},
    body: nil,
    message: nil
  )
    OpenAI::Errors::APIStatusError.for(
      url: url,
      status: status,
      headers: headers,
      body: body,
      request: nil,
      response: nil,
      message: message
    )
  end
end
