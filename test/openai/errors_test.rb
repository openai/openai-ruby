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

  def test_fallback_omits_url_fragments_without_changing_the_original_url
    urls = [
      URI("https://example.com/v1/responses#access_token=fake-fragment-token"),
      URI("https://example.com/v1/responses?safe=visible#prompt=private-customer-prompt"),
      URI("https://example.com/v1/responses#response=private-model-response?included=yes")
    ]

    urls.each do |url|
      error = status_error(url: url, body: {error: {message: "Provider rejected the request"}})

      assert_includes(error.message, "url=https://example.com/v1/responses")
      refute_includes(error.message, "#")
      refute_includes(error.message, "?")
      refute_includes(error.message, "fake-fragment")
      refute_includes(error.message, "private-")
      assert_same(url, error.url)
      refute_nil(error.url.fragment)
    end
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
      if body.nil?
        assert_nil(error.body)
      else
        assert_same(body, error.body)
      end
    end
  end

  def test_recognized_provider_error_descriptions_remain_meaningful
    bodies = {
      "Nested provider error" => {error: {message: "Nested provider error"}},
      "Nested OAuth provider error" => {error: {error_description: "Nested OAuth provider error"}},
      "OAuth provider rejected the request" => {error_description: "OAuth provider rejected the request"},
      "invalid_client" => {error: "invalid_client"},
      "invalid_grant" => {error: "invalid_grant"},
      "invalid_token" => {error: "invalid_token"},
      "invalid_subject_token" => {error: "invalid_subject_token"},
      "unauthorized_client" => {error: "unauthorized_client"},
      "unsupported_grant_type" => {error: "unsupported_grant_type"},
      "access_denied" => {error: "access_denied"},
      "insufficient_scope" => {error: "insufficient_scope"},
      "server_error" => {error: "server_error"},
      "temporarily_unavailable" => {error: "temporarily_unavailable"},
      "rate_limit_exceeded" => {error: "rate_limit_exceeded"},
      "invalid_prompt" => {error: "invalid_prompt"},
      "invalid_base64_image" => {error: "invalid_base64_image"},
      "Rate limit reached. Please try again later." => {
        error: {message: "Rate limit reached. Please try again later."}
      },
      "You exceeded your current quota, please check your plan and billing details." => {
        error: {message: "You exceeded your current quota, please check your plan and billing details."}
      },
      "The requested model was not found" => {error: {message: "The requested model was not found"}},
      "Internal server error" => {error: {message: "Internal server error"}},
      "Service temporarily unavailable" => {error: {message: "Service temporarily unavailable"}},
      "Error 500" => {error: {message: "Error 500"}},
      "HTTP status: 429" => {error: {message: "HTTP status: 429"}},
      "invalid bearer token" => {error: {message: "invalid bearer token"}},
      "Invalid access token" => {error: {message: "Invalid access token"}},
      "Invalid token 'expired'" => {error: {message: "Invalid token 'expired'"}},
      "API key 'missing'" => {error: {message: "API key 'missing'"}},
      "Basic authentication failed" => {error: {message: "Basic authentication failed"}},
      "The access token is expired" => {error: {message: "The access token is expired"}},
      "The access token is expired. Please sign in again." => {
        error: {message: "The access token is expired. Please sign in again."}
      },
      "The token is invalid" => {error: {message: "The token is invalid"}},
      "The token is invalid or has expired." => {error: {message: "The token is invalid or has expired."}},
      "The API key is missing" => {error: {message: "The API key is missing"}},
      "API key required" => {error: {message: "API key required"}},
      "API key required for this operation" => {error: {message: "API key required for this operation"}},
      "API key format is invalid" => {error: {message: "API key format is invalid"}},
      "API key authentication failed" => {error: {message: "API key authentication failed"}},
      "API key cannot be empty" => {error: {message: "API key cannot be empty"}},
      "API key has expired" => {error: {message: "API key has expired"}},
      "API key does not exist" => {error: {message: "API key does not exist"}},
      "Client secret missing" => {error: {message: "Client secret missing"}},
      "Client secret does not match" => {error: {message: "Client secret does not match"}},
      "Password too short" => {error: {message: "Password too short"}},
      "Password cannot be blank" => {error: {message: "Password cannot be blank"}},
      "The API key is missing. Add one to your account settings." => {
        error: {message: "The API key is missing. Add one to your account settings."}
      },
      "The API key is valid but does not have permission to access this resource" => {
        error: {message: "The API key is valid but does not have permission to access this resource"}
      },
      "The client secret is invalid" => {error: {message: "The client secret is invalid"}},
      "The access token does not contain the required scopes" => {
        error: {message: "The access token does not contain the required scopes"}
      },
      "The signature is invalid" => {error: {message: "The signature is invalid"}},
      "The request input is invalid" => {error: {message: "The request input is invalid"}},
      "The input exceeds the maximum context length" => {
        error: {message: "The input exceeds the maximum context length"}
      },
      "The input exceeds the maximum context length of 8192 tokens" => {
        error: {message: "The input exceeds the maximum context length of 8192 tokens"}
      },
      "Your request contains too many input tokens" => {
        error: {message: "Your request contains too many input tokens"}
      },
      "Your request contains 8192 input tokens" => {
        error: {message: "Your request contains 8192 input tokens"}
      },
      "The request input is invalid: expected a string." => {
        error: {message: "The request input is invalid: expected a string."}
      },
      "The input is invalid (expected a string)." => {
        error: {message: "The input is invalid (expected a string)."}
      },
      "The input is invalid; expected a string." => {
        error: {message: "The input is invalid; expected a string."}
      },
      "The input is required" => {error: {message: "The input is required"}},
      "The input is required for this operation." => {
        error: {message: "The input is required for this operation."}
      },
      "The response is malformed" => {error: {message: "The response is malformed"}},
      "The response is malformed and could not be processed." => {
        error: {message: "The response is malformed and could not be processed."}
      },
      "The response could not be parsed as JSON" => {
        error: {message: "The response could not be parsed as JSON"}
      },
      "The response is malformed (expected an object)." => {
        error: {message: "The response is malformed (expected an object)."}
      },
      "The output is too long" => {error: {message: "The output is too long"}},
      "The output is too long for the selected model." => {
        error: {message: "The output is too long for the selected model."}
      },
      "The output was truncated because it exceeded the maximum token limit" => {
        error: {message: "The output was truncated because it exceeded the maximum token limit"}
      },
      "The maximum output length is 4096 tokens" => {
        error: {message: "The maximum output length is 4096 tokens"}
      },
      "The output is too long - maximum is 2048 tokens." => {
        error: {message: "The output is too long - maximum is 2048 tokens."}
      },
      "The API key is invalid (check your credentials)." => {
        error: {message: "The API key is invalid (check your credentials)."}
      },
      "Message is required" => {error: {message: "Message is required"}},
      "Content is required" => {error: {message: "Content is required"}},
      "Data URL is invalid" => {error: {message: "Data URL is invalid"}},
      "Invalid data: expected a string" => {error: {message: "Invalid data: expected a string"}},
      "Expected input: string" => {error: {message: "Expected input: string"}},
      "Maximum output: 2048 tokens" => {error: {message: "Maximum output: 2048 tokens"}}
    }

    bodies.each do |expected, body|
      assert_includes(status_error(body: body).message, expected)
    end
  end

  def test_blank_provider_messages_do_not_hide_useful_fallback_descriptions
    bodies = [
      {error: {message: "", error_description: "Nested provider explanation"}},
      {error: {message: " \t\n ", error_description: "Nested provider explanation"}},
      {error: {message: "", error_description: "   "}, error_description: "Top-level explanation"},
      {error: {message: "\n", error_description: "\t"}}
    ]

    bodies.each do |body|
      error = status_error(body: body)
      expected = body[:error_description] || body.dig(:error, :error_description)

      if expected.strip.empty?
        refute_includes(error.message, "message=")
      else
        assert_includes(error.message, "message=#{expected}")
      end

      assert_same(body, error.body)
    end
  end

  def test_provider_validation_words_do_not_allow_sensitive_suffixes
    descriptions = [
      "The input is invalid (private customer prompt)",
      "The response is malformed [private model response]",
      "The output is too long {private customer content}",
      "The access token is expired (fake-upstream-credential)",
      "The access token is expired, fake-upstream-credential",
      "The access token is expired\nfake-upstream-credential",
      "The input is invalid - private customer prompt",
      "The input is invalid, private customer prompt",
      "The input is invalid / private customer prompt",
      "The input is invalid – private customer prompt",
      "The input is invalid... private customer prompt",
      "The prompt is invalid; private customer prompt",
      "The input is invalid because private customer content was provided",
      "The input is invalid due to private customer prompt",
      "The input is invalid\nprivate customer prompt",
      "The response is malformed. private model response",
      "The response is malformed, private model response"
    ]

    descriptions.each do |description|
      error = status_error(body: {error: {message: description}})

      assert_includes(error.message, "status=400")
      refute_includes(error.message, "message=")
      refute_includes(error.message, "private")
      refute_includes(error.message, "fake-upstream")
      assert_same(description, error.body.dig(:error, :message))
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

  def test_provider_messages_do_not_disclose_quoted_credential_values
    descriptions = [
      "Invalid token 'opaqueprovidercredential123'",
      "Invalid API key 'opaqueprovidercredential123'",
      "Invalid access token \"opaqueprovidercredential123\"",
      "Rejected client secret 'opaqueprovidercredential123'",
      "Rejected credentials 'opaqueprovidercredential123'",
      "Invalid API key ‘opaqueprovidercredential123’",
      "Invalid token “opaqueprovidercredential123”",
      "Invalid token 'expired.opaqueprovidercredential123'",
      "Invalid token 'expired opaqueprovidercredential123'",
      "Invalid token 'expired-opaqueprovidercredential123'",
      "Invalid token 'required+opaqueprovidercredential123'",
      "Invalid token 'empty@opaqueprovidercredential123'",
      "API key 'missing opaqueprovidercredential123'",
      "Invalid token \xFF'opaqueprovidercredential123'".b
    ]

    descriptions.each do |description|
      error = status_error(body: {error: {message: description}})

      assert_includes(error.message, "status=400")
      refute_includes(error.message, "message=")
      refute_includes(error.message, "opaqueprovidercredential")
      assert_same(description, error.body.dig(:error, :message))
    end
  end

  def test_provider_messages_reject_unclassified_credential_shapes
    github_credential = "ghp_" + ("a" * 36)
    github_pat = ["github", "pat", "11fakeToken", "abcdefghijklmnopqrstuvwxyz"].join("_")
    slack_credential = ["xoxb", "123456789012", "123456789012", "fakeSlackCredential"].join("-")
    descriptions = [
      "Authentication failed: #{github_credential}",
      "please sign again",
      "please check your account",
      "sign in again",
      "your billing details",
      "the user and the account",
      "provider please sign again",
      "provider error please sign again",
      "request failed please sign again",
      "request error please check your account",
      "input required please sign again",
      "response failed your billing details",
      "output error please add one to your account settings",
      "message required please sign again",
      "content invalid please check your account",
      "service error please sign again",
      "api key missing please sign again",
      "token expired please check your account",
      "password invalid please sign again",
      "error please sign again",
      "rate limit reached please sign again",
      "requested model unavailable please check your account",
      "request please sign again failed",
      "request your account",
      "please add one to your account settings",
      "Authentication failed: ghp_fakecredential",
      "Authentication failed: xoxb_fakecredential",
      "Provider rejected #{github_credential}",
      "Authentication failed: #{github_pat}",
      "Service rejected #{slack_credential}",
      "Validation failed: opaqueprovidercredential1234567890",
      "12345678901234567890",
      "4111111111111111",
      "123456",
      "Authentication failed: 12345678901234567890",
      "Provider rejected: 12345678901234567890",
      "User ID 12345678901234567890",
      "Account 1234567890123456",
      "Request 12345678901234567890",
      "Your request contains 8192 input tokens: 4111111111111111",
      "Maximum output: 2048 tokens 1234567890123456",
      "The maximum output length is 4096 tokens: 4111111111111111",
      "Your request contains 8192 input tokens: user 1234567890123456",
      "Account 12345678 input tokens",
      "User ID 12345678 input tokens",
      "Your account 12345678 output tokens",
      "Billing details 12345678 input tokens",
      "The user account number 12345678 input tokens",
      "The user value 12345678 output tokens",
      "Provider prefix #{github_credential} suffix",
      "Provider rejected req_#{github_credential}",
      "Provider failure \xFF#{github_credential}".b,
      "Authentication failed:\n#{slack_credential}"
    ]

    descriptions.each do |description|
      body = {error: {message: description}}
      error = status_error(body: body)

      assert_instance_of(OpenAI::Errors::BadRequestError, error)
      assert_includes(error.message, "status=400")
      refute_includes(error.message, "message=")
      assert_same(body, error.body)
      assert_same(description, error.body.dig(:error, :message))
    end
  end

  def test_status_diagnostics_handle_long_whitespace_without_exposing_trailing_values
    safe_description = "error" + (" " * 480) + "500"
    unsafe_description = "error" + (" " * 480) + "999"

    safe_error = status_error(body: {error: {message: safe_description}})
    unsafe_error = status_error(body: {error: {message: unsafe_description}})

    assert_includes(safe_error.message, "500")
    assert_same(safe_description, safe_error.body.dig(:error, :message))
    refute_includes(unsafe_error.message, "message=")
    assert_same(unsafe_description, unsafe_error.body.dig(:error, :message))
  end

  def test_provider_messages_do_not_disclose_space_delimited_credential_values
    descriptions = [
      "Invalid API key opaqueprovidercredential123",
      "Invalid client secret opaqueprovidercredential123",
      "Rejected private key opaqueprovidercredential123",
      "Rejected password opaqueprovidercredential123",
      "Invalid API key missing-opaqueprovidercredential123",
      "Invalid client secret expired opaqueprovidercredential123",
      "Invalid API key required for opaqueprovidercredential123",
      "Invalid client secret missing for opaqueprovidercredential123",
      "Invalid API key not opaqueprovidercredential123",
      "Invalid API key format opaqueprovidercredential123",
      "Rejected password !P@ssw0rd123",
      "Rejected password $uperSecret123",
      "Rejected password #opaqueprovidercredential123",
      "Rejected client secret +opaqueprovidercredential123",
      "Rejected client secret /opaqueprovidercredential123",
      "Invalid API key -opaqueprovidercredential123",
      "Rejected private key .opaqueprovidercredential123",
      "Rejected assertion %opaqueprovidercredential123",
      "Rejected password \xFFopaqueprovidercredential123".b,
      "Rejected api_key_value opaqueprovidercredential123",
      "Rejected apiKeyValue opaqueprovidercredential123",
      "Rejected client_secret_value opaqueprovidercredential123",
      "Rejected clientSecretValue opaqueprovidercredential123",
      "Rejected private_key_pem opaqueprovidercredential123",
      "Rejected privateKeyPem opaqueprovidercredential123",
      "Rejected access_token_value opaqueprovidercredential123",
      "Rejected accessTokenValue opaqueprovidercredential123",
      "Rejected refresh_token_value opaqueprovidercredential123",
      "Rejected password_hash opaqueprovidercredential123",
      "Rejected user_prompt opaqueprovidercredential123",
      "Rejected input_text opaqueprovidercredential123",
      "Rejected output_text opaqueprovidercredential123",
      "API key 123456 request input",
      "Password 123456 content",
      "Client secret 123456 response",
      "Maximum output: 2048 tokens API key 123456",
      "4096 output tokens client secret 123456"
    ]

    descriptions.each do |description|
      error = status_error(body: {error: {message: description}})

      assert_includes(error.message, "status=400")
      refute_includes(error.message, "message=")
      refute_includes(error.message, "opaqueprovidercredential")
      assert_same(description, error.body.dig(:error, :message))
    end
  end

  def test_provider_messages_do_not_disclose_data_url_payloads
    descriptions = [
      "Invalid image URL: data:image/png;base64,cHJpdmF0ZS1jdXN0b21lci1pbWFnZQ==",
      "Invalid document URL: DATA:application/pdf;base64,cHJpdmF0ZS1kb2N1bWVudA==",
      "Invalid content data:text/plain,private%20customer%20prompt",
      "Invalid inline response data:,private-customer-response",
      "Invalid image data:image/svg+xml;charset=utf-8,%3Csvg%3Eprivate%3C/svg%3E",
      "Invalid image URL: data: image/png;base64,cHJpdmF0ZS1jdXN0b21lcg==",
      "Invalid image URL: data:\timage/png;base64,cHJpdmF0ZS1jdXN0b21lcg==",
      "Invalid image URL: data:image/png; base64,cHJpdmF0ZS1jdXN0b21lcg=="
    ]

    descriptions.each do |description|
      error = status_error(body: {error: {message: description}})

      assert_includes(error.message, "status=400")
      refute_includes(error.message, "message=")
      refute_includes(error.message.downcase, "data:")
      assert_same(description, error.body.dig(:error, :message))
    end
  end

  def test_malformed_provider_message_encodings_preserve_api_status_and_raw_response
    malformed_json_body = JSON.parse("{\"error\":{\"message\":\"\\udcff\"}}", symbolize_names: true)
    bodies = [
      malformed_json_body,
      {error: {message: "Provider failure \xFF".b}},
      {error: {message: "Provider failure \xFF".dup.force_encoding(Encoding::UTF_8)}}
    ]

    bodies.each do |body|
      original_message = body.dig(:error, :message)
      error = status_error(body: body)

      assert_instance_of(OpenAI::Errors::BadRequestError, error)
      assert_equal(400, error.status)
      assert_includes(error.message, "status=400")
      assert(error.message.valid_encoding?)
      assert_same(body, error.body)
      assert_same(original_message, error.body.dig(:error, :message))
    end
  end

  def test_upstream_error_descriptions_are_bounded_and_log_safe
    description = "Provider failure\n".ljust(512) + " private trailing prompt"

    error = status_error(body: {error: {message: description}})

    assert_includes(error.message, "Provider failure\\n")
    assert_includes(error.message, "...")
    assert_operator(error.message.bytesize, :<, 700)
    refute_includes(error.message, "\n")
    refute_includes(error.message, "private trailing prompt")
  end

  def test_upstream_error_descriptions_remain_byte_bounded_after_escaping
    descriptions = ["Provider failure ".ljust(513), "Provider\nfailure ".ljust(513), "'Provider failure' ".ljust(513)]

    descriptions.each do |description|
      error = status_error(body: {error: {message: description}})
      rendered = error.message.split("message=", 2).last

      assert_operator(rendered.bytesize, :<=, 515)
      assert(rendered.end_with?("..."))
      refute_includes(rendered, "\n")
      assert_same(description, error.body.dig(:error, :message))
    end
  end

  def test_non_diagnostic_provider_payloads_are_omitted_without_changing_raw_messages
    ["😀" * 600, "\\" * 600].each do |description|
      body = {error: {message: description}}
      error = status_error(body: body)

      refute_includes(error.message, "message=")
      assert_same(body, error.body)
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

  def test_request_ids_with_control_characters_are_omitted_without_altering_raw_headers
    request_id = "req_safe\nforged log entry"
    headers = {"x-request-id" => request_id}

    error = status_error(headers: headers)

    refute_includes(error.message, "request_id=")
    refute_includes(error.message, "\n")
    assert_same(request_id, error.request_id)
    assert_same(headers, error.headers)
  end

  def test_sensitive_request_ids_are_omitted_without_altering_raw_headers
    slack_credential = ["xoxb", "123456789012", "123456789012", "fakeSlackCredential"].join("-")
    request_ids = [
      "req_4111111111111111",
      "req_378282246310005",
      "req_4222222222222",
      "req_6011111111111111111",
      "req_12345678901234567890",
      "req_a4111111111111111",
      "req_4111111111111111a",
      "req-prod-4111111111111111",
      "trace.4111111111111111",
      "service-req-4111111111111111",
      "req_41111111_11111111",
      "req_4111_111111111111",
      "req_378282_246310005",
      "req-4111-111111111111",
      "req-41111111-11111111",
      "trace.4111.1111.1111.1111",
      "trace.3782.822463.10005",
      "trace.4222.2222.22222",
      "card-4111-1111-req-11111111",
      "service-41111111-req-11111111",
      "4111-1111-1111-req-1111",
      "41111111-1111-1111-1111-111111111111",
      "41111111-1111-4111-8111-111111111111",
      "12345678-1234-1234-1234-123456789012",
      "550e8400-e29b-41d4-a716-446655440000",
      "ghp_abcdefghijklmnopqrstuvwxyz0123456789",
      "github_pat_11fakeToken_abcdefghijklmnopqrstuvwxyz",
      slack_credential,
      "opaqueprovidercredential1234567890",
      "req_ghp_abcdefghijklmnopqrstuvwxyz0123456789",
      "req_github_pat_11fakeToken_abcdefghijklmnopqrstuvwxyz",
      "req_#{slack_credential}",
      "trace.#{slack_credential}",
      "req_AKIAIOSFODNN7EXAMPLE",
      "req_sk-proj-fakeprovidercredential123",
      "trace.eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJmYWtlIn0.fakesignature",
      "#{slack_credential}-request",
      "req_opaqueprovidercredential1234567890",
      "opaqueprovidercredential1234567890-request",
      "access_token=fake-request-access-token",
      "Bearer fake-request-bearer-token",
      "sk-proj-fake-request-api-key",
      "AWSAccessKeyId=AKIAIOSFODNN7EXAMPLE",
      "customer_id=fake-customer-identifier",
      "user_identifier=fake-user-identifier",
      "email=fake-customer@example.test",
      "fake-customer@example.test",
      "fake-customer+tag@example.test",
      "emailAddress=fake-customer@example.test",
      "e-mail=fake-customer@example.test",
      "e_mail=fake-customer@example.test",
      "mail=fake-customer@example.test",
      "prompt=private customer prompt",
      "Invalid API key opaqueprovidercredential123",
      "Rejected client secret +opaqueprovidercredential123",
      "Rejected password !P@ssw0rd123",
      "Rejected private key opaqueprovidercredential123",
      "Invalid client secret expired opaqueprovidercredential123",
      "Invalid token 'expired.opaqueprovidercredential123'",
      "Rejected api_key_value opaqueprovidercredential123",
      "Rejected apiKeyValue opaqueprovidercredential123",
      "Rejected clientSecretValue opaqueprovidercredential123",
      "Rejected privateKeyPem opaqueprovidercredential123",
      "Rejected accessTokenValue opaqueprovidercredential123",
      "Rejected password_hash opaqueprovidercredential123",
      "Rejected user_prompt opaqueprovidercredential123",
      "Rejected input_text opaqueprovidercredential123",
      "Rejected output_text opaqueprovidercredential123",
      "data:image/png;base64,cHJpdmF0ZS1jdXN0b21lcg=="
    ]

    request_ids.each do |request_id|
      headers = {"x-request-id" => request_id}
      body = {error: {message: "Provider rejected the request"}}

      error = status_error(headers: headers, body: body)

      assert_includes(error.message, "status=400")
      assert_includes(error.message, "Provider rejected the request")
      refute_includes(error.message, "request_id=")
      refute_includes(error.message, "fake-")
      refute_includes(error.message, "private customer")
      assert_same(request_id, error.request_id)
      assert_same(headers, error.headers)
      assert_same(body, error.body)
    end
  end

  def test_ordinary_request_id_formats_remain_visible
    request_ids = [
      "req_1234567890abcdef",
      "req_signed_url",
      "req-prod-1234567890",
      "4c37c3c3-e770-4b3d-8d2e-b5e0e6de6e03",
      "trace_1",
      "trace.1234abcd.5678efgh",
      "email-delivery-req-123",
      "customer-support-req-123",
      "data-center-req-123",
      "response-service-trace-123",
      "input-validator-req-123",
      "runtime-chat-request",
      "runtime-response-request"
    ]

    request_ids.each do |request_id|
      error = status_error(headers: {"x-request-id" => request_id})

      assert_includes(error.message, "request_id=#{request_id}")
      assert_same(request_id, error.request_id)
    end
  end

  def test_non_utf8_request_ids_are_omitted_without_altering_raw_headers
    request_ids = ["req_\xFF".b, "req_\xFF".dup.force_encoding(Encoding::UTF_8)]

    request_ids.each do |request_id|
      headers = {"x-request-id" => request_id}

      error = status_error(headers: headers)

      assert_instance_of(OpenAI::Errors::BadRequestError, error)
      refute_includes(error.message, "request_id=")
      assert_same(request_id, error.request_id)
      assert_same(headers, error.headers)
    end
  end

  def test_request_ids_require_a_bounded_ascii_identifier_without_altering_raw_headers
    allowed_request_id = "req_" + ("a" * 124)
    allowed_error = status_error(headers: {"x-request-id" => allowed_request_id})

    assert_includes(allowed_error.message, "request_id=#{allowed_request_id}")
    assert_same(allowed_request_id, allowed_error.request_id)

    ["req_" + ("a" * 125), "req_" + ("😀" * 600)].each do |request_id|
      headers = {"x-request-id" => request_id}
      error = status_error(headers: headers)

      refute_includes(error.message, "request_id=")
      assert_same(request_id, error.request_id)
      assert_same(headers, error.headers)
    end
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
