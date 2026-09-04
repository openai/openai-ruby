# frozen_string_literal: true

require_relative "test_helper"

class OpenAITest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
  end

  def setup
    super
    @openai_custom_headers = ENV["OPENAI_CUSTOM_HEADERS"]
    ENV.delete("OPENAI_CUSTOM_HEADERS")
    Thread.current.thread_variable_set(:mock_sleep, [])
  end

  def teardown
    Thread.current.thread_variable_set(:mock_sleep, nil)
    if @openai_custom_headers.nil?
      ENV.delete("OPENAI_CUSTOM_HEADERS")
    else
      ENV["OPENAI_CUSTOM_HEADERS"] = @openai_custom_headers
    end

    WebMock.reset!
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def test_client_auth_with_normal_api_key
    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    headers = openai.send(:auth_headers, security: {bearer_auth: true})

    assert_equal("Bearer My API Key", headers["authorization"])
  end

  def test_client_auth_uses_route_specific_api_key
    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    bearer_headers = openai.send(:auth_headers, security: {bearer_auth: true})
    admin_headers = openai.send(:auth_headers, security: {admin_api_key_auth: true})

    assert_equal("Bearer My API Key", bearer_headers["authorization"])
    assert_equal("Bearer My Admin API Key", admin_headers["authorization"])
  end

  def test_client_auth_ignores_disabled_security_schemes
    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    bearer_headers = openai.send(:auth_headers, security: {bearer_auth: true, admin_api_key_auth: false})
    admin_headers = openai.send(:auth_headers, security: {bearer_auth: false, admin_api_key_auth: true})
    disabled_headers = openai.send(:auth_headers, security: {bearer_auth: false, admin_api_key_auth: false})

    assert_equal("Bearer My API Key", bearer_headers["authorization"])
    assert_equal("Bearer My Admin API Key", admin_headers["authorization"])
    assert_empty(disabled_headers)
  end

  def test_client_auth_allows_admin_api_key_only
    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: nil,
      admin_api_key: "My Admin API Key"
    )

    admin_headers = openai.send(:auth_headers, security: {admin_api_key_auth: true})

    assert_equal("Bearer My Admin API Key", admin_headers["authorization"])
    error = assert_raises(ArgumentError) do
      openai.send(:auth_headers, security: {bearer_auth: true})
    end

    assert_match(/Could not resolve authentication method/, error.message)
  end

  def test_client_auth_requires_at_least_one_credential
    error = assert_raises(ArgumentError) do
      OpenAI::Client.new(base_url: "http://localhost", api_key: nil, admin_api_key: nil)
    end

    assert_match(/Missing credentials/, error.message)
  end

  def test_client_default_headers_are_sent_with_requests
    stub_request(:get, "http://localhost/models").to_return_json(status: 200, body: {})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      default_headers: {"X-Cost-Center" => "ignored", :"x-cost-center" => "finance"}
    )
    openai.request({method: :get, path: "models"})

    assert_requested(:get, "http://localhost/models") do |request|
      assert_equal("finance", request.headers.transform_keys(&:downcase)["x-cost-center"])
    end
  end

  def test_client_default_headers_are_sent_with_streaming_requests
    stub_request(:post, "http://localhost/chat/completions")
      .with(headers: {"x-cost-center" => "finance"})
      .to_return(status: 200, body: "data: [DONE]\n\n", headers: {"Content-Type" => "text/event-stream"})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      default_headers: {"x-cost-center" => "finance"}
    )
    openai.chat.completions.stream(
      messages: [{content: "string", role: :developer}],
      model: :"gpt-5.4"
    )

    assert_requested(:post, "http://localhost/chat/completions", times: 1) do |request|
      assert_equal("finance", request.headers.transform_keys(&:downcase)["x-cost-center"])
    end
  end

  def test_client_default_headers_are_isolated_between_clients
    cost_centers = []
    stub_request(:get, "http://localhost/models").to_return do |request|
      cost_centers << request.headers.transform_keys(&:downcase).fetch("x-cost-center")
      {status: 200, body: "{}"}
    end

    finance = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      default_headers: {"x-cost-center" => "finance"}
    )
    research = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      default_headers: {"x-cost-center" => "research"}
    )
    finance.request({method: :get, path: "models"})
    research.request({method: :get, path: "models"})

    assert_equal(%w[finance research], cost_centers)
  end

  def test_explicit_default_headers_override_or_remove_environment_headers
    ENV["OPENAI_CUSTOM_HEADERS"] = <<~HEADERS
      x-cost-center: stale
      X-Cost-Center: environment
      x-remove-me: stale
      X-Remove-Me: environment
      X-Ambient: retained
      openai-organization: stale
      OpenAI-Organization: injected-organization
      openai-project: stale
      OpenAI-Project: injected-project
    HEADERS
    stub_request(:get, "http://localhost/models").to_return_json(status: 200, body: {})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      organization: "explicit-organization",
      project: "explicit-project",
      default_headers: {"x-cost-center" => "explicit", "x-remove-me" => nil}
    )
    openai.request({method: :get, path: "models"})

    assert_requested(:get, "http://localhost/models") do |request|
      headers = request.headers.transform_keys(&:downcase)
      assert_equal("explicit", headers["x-cost-center"])
      assert_equal("retained", headers["x-ambient"])
      assert_equal("explicit-organization", headers["openai-organization"])
      assert_equal("explicit-project", headers["openai-project"])
      refute_includes(headers, "x-remove-me")
    end
  end

  def test_request_headers_override_or_remove_client_default_headers
    requests = []
    stub_request(:get, "http://localhost/models").to_return do |request|
      requests << request.headers.transform_keys(&:downcase)
      {status: 200, body: "{}"}
    end

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      default_headers: {"x-cost-center" => "finance"}
    )

    openai.request(
      {
        method: :get,
        path: "models",
        options: {extra_headers: {"X-Cost-Center": "research"}}
      }
    )
    openai.request(
      {
        method: :get,
        path: "models",
        options: {extra_headers: {"x-cost-center": nil}}
      }
    )

    assert_equal("research", requests.fetch(0).fetch("x-cost-center"))
    refute_includes(requests.fetch(1), "x-cost-center")
  end

  def test_client_default_headers_do_not_override_authentication_or_request_headers
    stub_request(:get, "http://localhost/models").to_return_json(status: 200, body: {})
    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      default_headers: {"authorization" => "Bearer custom", "x-endpoint" => "client"}
    )

    openai.request(
      {
        method: :get,
        path: "models",
        headers: {"X-Endpoint" => "generated"},
        security: {bearer_auth: true}
      }
    )

    assert_requested(:get, "http://localhost/models") do |request|
      assert_equal("Bearer My API Key", request.headers["Authorization"])
      assert_equal("generated", request.headers["X-Endpoint"])
    end
  end

  def test_chat_completion_stream_uses_bearer_auth
    stub_request(:post, "http://localhost/chat/completions")
      .with(headers: {"Authorization" => "Bearer My API Key"})
      .to_return(status: 200, body: "data: [DONE]\n\n", headers: {"Content-Type" => "text/event-stream"})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    stream = openai.chat.completions.stream(
      messages: [{content: "string", role: :developer}],
      model: :"gpt-5.4"
    )

    assert_instance_of(OpenAI::Streaming::ChatCompletionStream, stream)
    assert_requested(:post, "http://localhost/chat/completions", times: 1)
  end

  def test_response_stream_create_uses_bearer_auth
    stub_request(:post, "http://localhost/responses")
      .with(headers: {"Authorization" => "Bearer My API Key"})
      .to_return(status: 200, body: "data: [DONE]\n\n", headers: {"Content-Type" => "text/event-stream"})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    stream = openai.responses.stream({})

    assert_instance_of(OpenAI::Streaming::ResponseStream, stream)
    assert_requested(:post, "http://localhost/responses", times: 1)
  end

  def test_response_stream_retrieve_uses_bearer_auth
    stub_request(:get, "http://localhost/responses/resp_123")
      .with(headers: {"Authorization" => "Bearer My API Key"}, query: {"stream" => "true"})
      .to_return(status: 200, body: "data: [DONE]\n\n", headers: {"Content-Type" => "text/event-stream"})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    stream = openai.responses.stream(response_id: "resp_123")

    assert_instance_of(OpenAI::Streaming::ResponseStream, stream)
    assert_requested(:get, "http://localhost/responses/resp_123?stream=true", times: 1)
  end

  def test_response_web_search_statuses
    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key")

    assert_web_search_statuses(openai.responses, "http://localhost/responses")
  end

  def test_beta_response_web_search_statuses
    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key")

    assert_web_search_statuses(openai.beta.responses, "http://localhost/responses?beta=true")
  end

  def test_request_id_on_successful_response
    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 200,
      headers: {"x-request-id" => "req_success"},
      body: {
        id: "chatcmpl_123",
        choices: [
          {
            finish_reason: "stop",
            index: 0,
            logprobs: nil,
            message: {content: "Hello", refusal: nil, role: "assistant"}
          }
        ],
        created: 1_700_000_000,
        model: "gpt-5.4",
        object: "chat.completion"
      }
    )

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    response = openai.chat.completions.create(
      messages: [{content: "string", role: :developer}],
      model: :"gpt-5.4"
    )

    assert_equal("req_success", response._request_id)
    assert_instance_of(OpenAI::ResponseMetadata, response.last_response)
    assert_equal(200, response.last_response.status)
    assert_equal("req_success", response.last_response.request_id)
    assert_equal("req_success", response.last_response.headers["x-request-id"])
    assert_nil(response.last_response.body)
    assert_nil(response.choices.first.last_response)
    refute_includes(response.to_h, :_request_id)
    refute_includes(response.to_h, :last_response)
    refute_includes(response.to_json, "_request_id")
    refute_includes(response.to_json, "last_response")
    refute_includes(response.to_yaml, "_request_id")
    refute_includes(response.to_yaml, "last_response")
    serialized = YAML.dump(response)
    refute_includes(serialized, "@_request_id")
    refute_includes(serialized, "@last_response")

    yaml_copy = YAML.unsafe_load(serialized)
    assert_equal(response, yaml_copy)
    assert_nil(yaml_copy.last_response)

    [response.dup, response.clone].each do |copy|
      assert_equal(response, copy)
      assert_equal("req_success", copy._request_id)
      assert_same(response.last_response, copy.last_response)
    end
  end

  def test_request_id_on_paginated_response
    stub_request(:get, "http://localhost/models").to_return_json(
      status: 200,
      headers: {"x-request-id" => "req_page"},
      body: {data: [], object: "list"}
    )

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    response = openai.models.list

    assert_equal("req_page", response._request_id)
    assert_equal(200, response.last_response.status)
    assert_equal("req_page", response.last_response.request_id)
    assert_nil(response.last_response.body)
  end

  def test_raw_response_body_is_opt_in_and_preserves_exact_bytes
    body = "{\n  \"id\": \"model_123\", \"object\": \"model\", " \
      "\"created\": 123, \"owned_by\": \"sensitive-owner\"\n}\n"
    stub_request(:get, "http://localhost/models/model_123").to_return(
      status: 200,
      headers: {"content-type" => "application/json", "x-request-id" => "req_raw"},
      body: body
    )

    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key")
    response = openai.models.retrieve("model_123", request_options: {include_raw_body: true})

    assert_instance_of(OpenAI::Model, response)
    assert_equal(body, response.last_response.body)
    assert_equal("req_raw", response.last_response.request_id)
    assert_predicate(response.last_response.body, :frozen?)
    refute_includes(response.last_response.inspect, "sensitive-owner")
    refute_includes(YAML.dump(response), "@last_response")
    refute_includes(Marshal.dump(response), body)
  end

  def test_raw_response_body_accepts_request_options_objects
    body = "{\"id\":\"model_123\",\"object\":\"model\",\"created\":123,\"owned_by\":\"openai\"}"
    stub_request(:get, "http://localhost/models/model_123").to_return(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: body
    )

    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key")
    options = OpenAI::RequestOptions.new(include_raw_body: true)
    response = openai.models.retrieve("model_123", request_options: options)

    assert_equal(body, response.last_response.body)
  end

  def test_raw_response_body_captures_only_the_final_successful_attempt
    error_body = "{\"error\":{\"message\":\"sensitive retry body\"}}"
    successful_body = "{ \"id\": \"model_123\", \"object\": \"model\", " \
      "\"created\": 123, \"owned_by\": \"openai\" }\n"
    stub_request(:get, "http://localhost/models/model_123").to_return(
      {status: 500, headers: {"content-type" => "application/json"}, body: error_body},
      {status: 200, headers: {"content-type" => "application/json"}, body: successful_body}
    )

    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key", max_retries: 1)
    response = openai.models.retrieve("model_123", request_options: {include_raw_body: true})

    assert_equal(successful_body, response.last_response.body)
    refute_includes(response.last_response.body, "sensitive retry body")
    assert_requested(:get, "http://localhost/models/model_123", times: 2)
  end

  def test_raw_response_body_is_available_on_union_backed_models
    body = "{\n  \"text\": \"transcribed audio\"\n}\n"
    stub_request(:post, "http://localhost/audio/transcriptions").to_return(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: body
    )

    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key")
    response = openai.audio.transcriptions.create(
      file: StringIO.new("synthetic audio"),
      model: "gpt-4o-transcribe",
      request_options: {include_raw_body: true}
    )

    assert_instance_of(OpenAI::Models::Audio::Transcription, response)
    assert_equal(body, response.last_response.body)
  end

  def test_raw_response_body_requires_an_explicit_boolean_true
    body = "{\"id\":\"model_123\",\"object\":\"model\",\"created\":123,\"owned_by\":\"openai\"}"
    stub_request(:get, "http://localhost/models/model_123").to_return(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: body
    )

    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key")

    ["false", 0, false, nil].each do |value|
      response = openai.models.retrieve("model_123", request_options: {include_raw_body: value})

      assert_nil(response.last_response.body)
    end
  end

  def test_union_backed_text_responses_remain_plain_string_io
    stub_request(:post, "http://localhost/audio/transcriptions").to_return(
      status: 200,
      headers: {"content-type" => "text/plain", "x-request-id" => "req_text"},
      body: "transcribed audio"
    )

    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key")
    response = openai.audio.transcriptions.create(
      file: StringIO.new("synthetic audio"),
      model: "gpt-4o-transcribe",
      response_format: :text,
      request_options: {include_raw_body: true}
    )

    assert_instance_of(StringIO, response)
    assert_equal("transcribed audio", response.read)
    assert_equal(1, response.write("!"))
    refute_respond_to(response, :_request_id)
    refute_respond_to(response, :last_response)
  end

  def test_raw_response_body_is_available_on_paginated_responses
    body = "{\n  \"data\": [],\n  \"object\": \"list\", " \
      "\"ignored_secret\": \"raw-page-only-secret\"\n}\n"
    stub_request(:get, "http://localhost/models").to_return(
      status: 200,
      headers: {"content-type" => "application/json", "x-request-id" => "req_page_raw"},
      body: body
    )

    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key")
    response = openai.models.list(request_options: {include_raw_body: true})

    assert_equal(body, response.last_response.body)
    assert_equal("req_page_raw", response.last_response.request_id)
    refute_includes(YAML.dump(response), "raw-page-only-secret")
  end

  def test_raw_response_body_rejects_streaming_without_starting_a_request
    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key")

    error = assert_raises(ArgumentError) do
      openai.responses.stream_raw(
        model: "gpt-4.1",
        input: "hello",
        request_options: {include_raw_body: true}
      )
    end

    assert_match(/include_raw_body.*streaming/, error.message)
    assert_not_requested(:post, "http://localhost/responses")
  end

  def test_each_paginated_response_has_its_own_metadata
    first_page_body = {
      data: [
        {
          id: "chatcmpl_123",
          choices: [],
          created: 1_700_000_000,
          model: "gpt-5.4",
          object: "chat.completion"
        }
      ],
      has_more: true,
      object: "list"
    }
    stub_request(:get, "http://localhost/chat/completions")
      .to_return_json(status: 200, headers: {"X-Request-ID" => "req_page_1"}, body: first_page_body)
    stub_request(:get, "http://localhost/chat/completions?after=chatcmpl_123")
      .to_return_json(
        status: 200,
        headers: {"X-Request-ID" => "req_page_2"},
        body: {data: [], has_more: false, object: "list"}
      )

    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key")
    first_page = openai.chat.completions.list
    second_page = first_page.next_page

    assert_equal("req_page_1", first_page.last_response.request_id)
    assert_nil(first_page.data.first.last_response)
    assert_equal("req_page_2", second_page.last_response.request_id)
    refute_same(first_page.last_response, second_page.last_response)
  end

  def test_request_id_on_error_response
    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 400,
      headers: {"x-request-id" => "req_error"},
      body: {error: {message: "Invalid request"}}
    )

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    error = assert_raises(OpenAI::Errors::BadRequestError) do
      openai.chat.completions.create(
        messages: [{content: "string", role: :developer}],
        model: :"gpt-5.4"
      )
    end

    assert_equal("req_error", error.request_id)
  end

  def test_binary_results_preserve_string_io_behavior_and_expose_response_metadata
    stub_request(:get, "http://localhost/files/file_123/content")
      .to_return(
        status: 200,
        headers: {"X-Request-ID" => "req_binary"},
        body: "file contents"
      )
    stub_request(:delete, "http://localhost/responses/resp_123")
      .to_return(status: 204, headers: {"X-Request-ID" => "req_nil"}, body: "")

    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key")

    content = openai.files.content("file_123")
    result = openai.responses.delete("resp_123")

    assert_instance_of(StringIO, content)
    assert_equal("file contents", content.read)
    assert_equal("req_binary", content._request_id)
    assert_equal(200, content.last_response.status)
    assert_equal("req_binary", content.last_response.request_id)
    assert_equal(1, content.write("!"))
    assert_nil(content.last_response.body)
    refute_respond_to(StringIO.new, :last_response)
    assert_nil(result)
  end

  def test_speech_results_expose_response_metadata
    stub_request(:post, "http://localhost/audio/speech").to_return(
      status: 200,
      headers: {"X-Request-ID" => "req_speech"},
      body: "synthetic audio"
    )

    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key")
    audio = openai.audio.speech.create(input: "hello", model: "tts-1", voice: "alloy")

    assert_instance_of(StringIO, audio)
    assert_equal("synthetic audio", audio.read)
    assert_equal("req_speech", audio._request_id)
    assert_equal("req_speech", audio.last_response.request_id)
  end

  def test_binary_results_ignore_json_content_type
    stub_request(:get, "http://localhost/files/file_123/content").to_return(
      status: 200,
      headers: {"content-type" => "application/json", "x-request-id" => "req_json_binary"},
      body: "{\"payload\":true}"
    )

    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key")
    content = openai.files.content("file_123")

    assert_instance_of(StringIO, content)
    assert_equal("{\"payload\":true}", content.read)
    assert_equal("req_json_binary", content._request_id)
  end

  def test_raw_response_body_is_available_on_binary_results
    stub_request(:get, "http://localhost/files/file_123/content")
      .to_return(status: 200, headers: {"X-Request-ID" => "req_binary_raw"}, body: "file contents")

    openai = OpenAI::Client.new(base_url: "http://localhost", api_key: "My API Key")

    content = openai.files.content("file_123", request_options: {include_raw_body: true})
    assert_instance_of(StringIO, content)
    assert_equal("file contents", content.read)
    assert_equal(1, content.write("!"))
    assert_equal("req_binary_raw", content._request_id)
    assert_equal("file contents", content.last_response.body)
    assert_predicate(content.last_response.body, :frozen?)
    serialized = YAML.dump(content)
    refute_includes(serialized, "last_response")
    refute_includes(serialized, "req_binary_raw")
    refute_includes(serialized, "file contents")
  end

  def test_client_default_request_default_retry_attempts
    stub_request(:post, "http://localhost/chat/completions").to_return_json(status: 500, body: {})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    assert_raises(OpenAI::Errors::InternalServerError) do
      openai.chat.completions.create(messages: [{content: "string", role: :developer}], model: :"gpt-5.4")
    end

    assert_requested(:any, /./, times: 3)
  end

  def test_client_given_request_default_retry_attempts
    stub_request(:post, "http://localhost/chat/completions").to_return_json(status: 500, body: {})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key",
      max_retries: 3
    )

    assert_raises(OpenAI::Errors::InternalServerError) do
      openai.chat.completions.create(messages: [{content: "string", role: :developer}], model: :"gpt-5.4")
    end

    assert_requested(:any, /./, times: 4)
  end

  def test_client_default_request_given_retry_attempts
    stub_request(:post, "http://localhost/chat/completions").to_return_json(status: 500, body: {})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    assert_raises(OpenAI::Errors::InternalServerError) do
      openai.chat.completions.create(
        messages: [{content: "string", role: :developer}],
        model: :"gpt-5.4",
        request_options: {max_retries: 3}
      )
    end

    assert_requested(:any, /./, times: 4)
  end

  def test_client_given_request_given_retry_attempts
    stub_request(:post, "http://localhost/chat/completions").to_return_json(status: 500, body: {})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key",
      max_retries: 3
    )

    assert_raises(OpenAI::Errors::InternalServerError) do
      openai.chat.completions.create(
        messages: [{content: "string", role: :developer}],
        model: :"gpt-5.4",
        request_options: {max_retries: 4}
      )
    end

    assert_requested(:any, /./, times: 5)
  end

  def test_client_retry_after_seconds
    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 500,
      headers: {"retry-after" => "1.3"},
      body: {}
    )

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key",
      max_retries: 1
    )

    assert_raises(OpenAI::Errors::InternalServerError) do
      openai.chat.completions.create(messages: [{content: "string", role: :developer}], model: :"gpt-5.4")
    end

    assert_requested(:any, /./, times: 2)
    assert_equal(1.3, Thread.current.thread_variable_get(:mock_sleep).last)
  end

  def test_client_retry_after_date
    now = Time.at(1_700_000_000)
    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 500,
      headers: {"retry-after" => (now + 10).httpdate},
      body: {}
    )

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key",
      max_retries: 1
    )

    begin
      Thread.current.thread_variable_set(:time_now, now)
      assert_raises(OpenAI::Errors::InternalServerError) do
        openai.chat.completions.create(messages: [{content: "string", role: :developer}], model: :"gpt-5.4")
      end

    ensure
      Thread.current.thread_variable_set(:time_now, nil)
    end

    assert_requested(:any, /./, times: 2)
    assert_equal(8.0, Thread.current.thread_variable_get(:mock_sleep).last)
  end

  def test_client_retry_after_ms
    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 500,
      headers: {"retry-after-ms" => "1300"},
      body: {}
    )

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key",
      max_retries: 1
    )

    assert_raises(OpenAI::Errors::InternalServerError) do
      openai.chat.completions.create(messages: [{content: "string", role: :developer}], model: :"gpt-5.4")
    end

    assert_requested(:any, /./, times: 2)
    assert_equal(1.3, Thread.current.thread_variable_get(:mock_sleep).last)
  end

  def test_retry_count_header
    stub_request(:post, "http://localhost/chat/completions").to_return_json(status: 500, body: {})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    assert_raises(OpenAI::Errors::InternalServerError) do
      openai.chat.completions.create(messages: [{content: "string", role: :developer}], model: :"gpt-5.4")
    end

    3.times do
      assert_requested(:any, /./, headers: {"x-stainless-retry-count" => _1})
    end
  end

  def test_omit_retry_count_header
    stub_request(:post, "http://localhost/chat/completions").to_return_json(status: 500, body: {})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    assert_raises(OpenAI::Errors::InternalServerError) do
      openai.chat.completions.create(
        messages: [{content: "string", role: :developer}],
        model: :"gpt-5.4",
        request_options: {extra_headers: {"x-stainless-retry-count" => nil}}
      )
    end

    assert_requested(:any, /./, times: 3) do
      refute_includes(_1.headers.keys.map(&:downcase), "x-stainless-retry-count")
    end
  end

  def test_overwrite_retry_count_header
    stub_request(:post, "http://localhost/chat/completions").to_return_json(status: 500, body: {})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    assert_raises(OpenAI::Errors::InternalServerError) do
      openai.chat.completions.create(
        messages: [{content: "string", role: :developer}],
        model: :"gpt-5.4",
        request_options: {extra_headers: {"x-stainless-retry-count" => "42"}}
      )
    end

    assert_requested(:any, /./, headers: {"x-stainless-retry-count" => "42"}, times: 3)
  end

  def test_client_redirect_307
    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 307,
      headers: {"location" => "/redirected"},
      body: {}
    )
    stub_request(:any, "http://localhost/redirected").to_return(
      status: 307,
      headers: {"location" => "/redirected"}
    )

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    assert_raises(OpenAI::Errors::APIConnectionError) do
      openai.chat.completions.create(
        messages: [{content: "string", role: :developer}],
        model: :"gpt-5.4",
        request_options: {extra_headers: {}}
      )
    end

    recorded, = WebMock::RequestRegistry.instance.requested_signatures.hash.first

    assert_requested(:any, "http://localhost/redirected", times: OpenAI::Client::MAX_REDIRECTS) do
      assert_equal(recorded.method, _1.method)
      assert_equal(recorded.body, _1.body)
      assert_equal(
        recorded.headers.transform_keys(&:downcase)["content-type"],
        _1.headers.transform_keys(&:downcase)["content-type"]
      )
    end
  end

  def test_client_redirect_303
    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 303,
      headers: {"location" => "/redirected"},
      body: {}
    )
    stub_request(:get, "http://localhost/redirected").to_return(
      status: 303,
      headers: {"location" => "/redirected"}
    )

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    assert_raises(OpenAI::Errors::APIConnectionError) do
      openai.chat.completions.create(
        messages: [{content: "string", role: :developer}],
        model: :"gpt-5.4",
        request_options: {extra_headers: {}}
      )
    end

    assert_requested(:get, "http://localhost/redirected", times: OpenAI::Client::MAX_REDIRECTS) do
      headers = _1.headers.keys.map(&:downcase)
      refute_includes(headers, "content-type")
      assert_nil(_1.body)
    end
  end

  def test_client_redirect_auth_keep_same_origin
    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 307,
      headers: {"location" => "/redirected"},
      body: {}
    )
    stub_request(:any, "http://localhost/redirected").to_return(
      status: 307,
      headers: {"location" => "/redirected"}
    )

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key",
      default_headers: {
        "api-key" => "custom-api-key",
        :"X-API-Key" => "custom-x-api-key",
        "X-Amz-Security-Token" => "custom-session-token"
      }
    )

    assert_raises(OpenAI::Errors::APIConnectionError) do
      openai.chat.completions.create(
        messages: [{content: "string", role: :developer}],
        model: :"gpt-5.4",
        request_options: {extra_headers: {"authorization" => "Bearer xyz"}}
      )
    end

    recorded, = WebMock::RequestRegistry.instance.requested_signatures.hash.first
    auth_header = recorded.headers.transform_keys(&:downcase).fetch("authorization")

    assert_equal("Bearer xyz", auth_header)
    assert_requested(:any, "http://localhost/redirected", times: OpenAI::Client::MAX_REDIRECTS) do
      headers = _1.headers.transform_keys(&:downcase)
      assert_equal("Bearer xyz", headers.fetch("authorization"))
      assert_equal("custom-api-key", headers.fetch("api-key"))
      assert_equal("custom-x-api-key", headers.fetch("x-api-key"))
      assert_equal("custom-session-token", headers.fetch("x-amz-security-token"))
    end
  end

  def test_client_rejects_cross_origin_307_redirect_with_sensitive_body
    source = "http://localhost/chat/completions"
    destination = "https://example.com/redirected"
    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 307,
      headers: {"location" => destination},
      body: {}
    )
    stub_request(:post, destination).to_return_json(status: 200, body: {})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    error = assert_raises(OpenAI::Errors::APIConnectionError) do
      openai.chat.completions.create(
        messages: [{content: "fake-private-customer-prompt", role: :developer}],
        model: :"gpt-5.4",
        request_options: {
          extra_body: {tools: [{type: "mcp", authorization: "fake-mcp-oauth-token"}]},
          extra_headers: {"authorization" => "Bearer xyz"}
        }
      )
    end

    assert_equal("https://example.com", error.url.to_s)
    assert_equal("Cannot follow a cross-origin redirect with a request body.", error.message)
    assert_requested(:post, source) do |request|
      assert_includes(request.body, "fake-private-customer-prompt")
      assert_includes(request.body, "fake-mcp-oauth-token")
    end

    assert_not_requested(:any, destination)
  end

  def test_client_redirect_strips_symbol_sensitive_headers_cross_origin
    source = "http://localhost/models"
    destination = "https://example.com/redirected"
    stub_request(:get, source).to_return(status: 307, headers: {"location" => destination})
    stub_request(:get, destination).to_return_json(status: 200, body: {})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      default_headers: {
        Authorization: "Bearer leaked-secret",
        Cookie: "session=private",
        "Proxy-Authorization": "Basic leaked-proxy",
        Host: "spoofed.example"
      }
    )
    openai.request({method: :get, path: "models"})

    assert_requested(:get, source) do |request|
      headers = request.headers.transform_keys(&:downcase)
      assert_equal("Bearer My API Key", headers["authorization"])
      assert_equal("session=private", headers["cookie"])
      assert_equal("Basic leaked-proxy", headers["proxy-authorization"])
      assert_equal("spoofed.example", headers["host"])
    end

    assert_requested(:get, destination) do |request|
      headers = request.headers.transform_keys(&:downcase)
      %w[authorization cookie proxy-authorization].each { refute_includes(headers, _1) }
      assert_equal("example.com", headers["host"])
    end
  end

  def test_client_redirect_strips_credential_default_headers_with_custom_transport
    source = "https://trusted.example/v1/models"
    destination = "https://attacker.example/redirected"
    requests = []
    http_client = Minitest::Mock.new(OpenAI::HTTPClient.new)
    redirect = OpenAI::HTTPClient::Response.new(
      status: 302,
      headers: {"location" => destination},
      body: ""
    )
    success = OpenAI::HTTPClient::Response.new(
      status: 200,
      headers: {"content-type" => "application/json"},
      body: "{}"
    )
    [redirect, success].each do |response|
      http_client.expect(:execute, response) do |request|
        requests << request
        true
      end
    end

    client = OpenAI::Client.new(
      api_key: "standard-client-key",
      base_url: "https://trusted.example/v1",
      http_client: http_client,
      default_headers: {
        "Api-Key" => "custom-api-key",
        :"X-API-Key" => "custom-x-api-key",
        "X-Amz-Security-Token" => "custom-session-token",
        :"X-Auth-Token" => "custom-auth-token",
        "X-Goog-API-Key" => "custom-google-key",
        :"X-Client-Secret" => "custom-client-secret",
        :api_key => "custom-underscore-key",
        "X-Password" => "custom-password",
        "X-Idempotency-Api-Key" => "custom-idempotency-api-key",
        "X-Idempotency-Token" => "custom-idempotency-token",
        "X-Api-Key-Idempotency-Key" => "custom-prefixed-api-key",
        "X-Auth-Token-Idempotency-Key" => "custom-prefixed-token",
        "X-Api-Key-Other-Idempotency-Key" => "custom-embedded-api-key",
        :Vendor_Token_Idempotency_Key => "custom-underscore-prefixed-token",
        "Vendor_Idempotency_Token" => "custom-underscore-suffixed-token",
        "Authorization-Idempotency-Key" => "custom-prefixed-authorization",
        :Cookie => "session=private",
        :"Proxy-Authorization" => "Basic proxy-secret",
        "Set-Cookie" => "session=private-response",
        :Host => "trusted.example",
        "Idempotency-Key" => "retry-safe-id",
        :"X-Idempotency-Key" => "retry-safe-prefixed-id",
        "Vendor_Idempotency_Key" => "retry-safe-underscore-id",
        "X-Trace-Id" => "safe-trace"
      }
    )
    client.request(method: :get, path: "models", security: {bearer_auth: true})

    http_client.verify
    assert_equal([source, destination], requests.map { _1.url.to_s })
    first_headers = requests.fetch(0).headers
    assert_equal("Bearer standard-client-key", first_headers.fetch("authorization"))
    assert_equal("custom-api-key", first_headers.fetch("api-key"))
    assert_equal("custom-x-api-key", first_headers.fetch("x-api-key"))
    assert_equal("custom-session-token", first_headers.fetch("x-amz-security-token"))
    assert_equal("custom-auth-token", first_headers.fetch("x-auth-token"))
    assert_equal("custom-google-key", first_headers.fetch("x-goog-api-key"))
    assert_equal("custom-client-secret", first_headers.fetch("x-client-secret"))
    assert_equal("custom-underscore-key", first_headers.fetch("api_key"))
    assert_equal("custom-password", first_headers.fetch("x-password"))
    assert_equal("custom-idempotency-api-key", first_headers.fetch("x-idempotency-api-key"))
    assert_equal("custom-idempotency-token", first_headers.fetch("x-idempotency-token"))
    assert_equal("custom-prefixed-api-key", first_headers.fetch("x-api-key-idempotency-key"))
    assert_equal("custom-prefixed-token", first_headers.fetch("x-auth-token-idempotency-key"))
    assert_equal("custom-embedded-api-key", first_headers.fetch("x-api-key-other-idempotency-key"))
    assert_equal("custom-underscore-prefixed-token", first_headers.fetch("vendor_token_idempotency_key"))
    assert_equal("custom-underscore-suffixed-token", first_headers.fetch("vendor_idempotency_token"))
    assert_equal("custom-prefixed-authorization", first_headers.fetch("authorization-idempotency-key"))

    redirected_headers = requests.fetch(1).headers
    sensitive_headers = %w[
      api-key
      api_key
      authorization
      authorization-idempotency-key
      cookie
      host
      proxy-authorization
      set-cookie
      vendor_idempotency_token
      vendor_token_idempotency_key
      x-amz-security-token
      x-api-key
      x-api-key-idempotency-key
      x-api-key-other-idempotency-key
      x-auth-token
      x-auth-token-idempotency-key
      x-client-secret
      x-goog-api-key
      x-idempotency-api-key
      x-idempotency-token
      x-password
    ]
    sensitive_headers.each do |header|
      refute_includes(redirected_headers, header)
    end

    assert_equal("retry-safe-id", redirected_headers.fetch("idempotency-key"))
    assert_equal("retry-safe-prefixed-id", redirected_headers.fetch("x-idempotency-key"))
    assert_equal("retry-safe-underscore-id", redirected_headers.fetch("vendor_idempotency_key"))
    assert_equal("safe-trace", redirected_headers.fetch("x-trace-id"))
  end

  def test_default_headers
    stub_request(:post, "http://localhost/chat/completions").to_return_json(status: 200, body: {})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )

    openai.chat.completions.create(messages: [{content: "string", role: :developer}], model: :"gpt-5.4")

    assert_requested(:any, /./) do |req|
      headers = req.headers.transform_keys(&:downcase)
      expected = req.body.nil? ? ["accept"] : %w[accept content-type]
      headers.fetch_values(*expected).each { refute_empty(_1) }
    end
  end

  private

  def assert_web_search_statuses(resource, url)
    wire_statuses = %w[failed incomplete future_web_search_status]
    stub_request(:post, url).to_return_json(
      status: 200,
      body: {
        id: "resp_web_search",
        object: "response",
        created_at: 1_700_000_000,
        model: "gpt-4o",
        output: wire_statuses.map do |status|
          {
            id: "ws_#{status}",
            type: "web_search_call",
            status: status,
            action: {type: "search", query: "synthetic query"}
          }
        end,
        parallel_tool_calls: true,
        tool_choice: "auto",
        tools: []
      }
    )

    response = resource.create(input: "synthetic input", model: "gpt-4o")

    assert_equal([:failed, :incomplete, "future_web_search_status"], response.output.map(&:status))
    assert_equal(wire_statuses, JSON.parse(response.to_json).fetch("output").map { _1.fetch("status") })
  end
end
