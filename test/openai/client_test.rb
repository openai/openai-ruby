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
      default_headers: {"x-cost-center" => "finance"}
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
      X-Cost-Center: environment
      X-Remove-Me: environment
      X-Ambient: retained
    HEADERS
    stub_request(:get, "http://localhost/models").to_return_json(status: 200, body: {})

    openai = OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      default_headers: {"x-cost-center" => "explicit", "x-remove-me" => nil}
    )
    openai.request({method: :get, path: "models"})

    assert_requested(:get, "http://localhost/models") do |request|
      headers = request.headers.transform_keys(&:downcase)
      assert_equal("explicit", headers["x-cost-center"])
      assert_equal("retained", headers["x-ambient"])
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
        options: {extra_headers: {"X-Cost-Center" => "research"}}
      }
    )
    openai.request(
      {
        method: :get,
        path: "models",
        options: {extra_headers: {"x-cost-center" => nil}}
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

    openai =
      OpenAI::Client.new(
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

    openai =
      OpenAI::Client.new(
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

    openai =
      OpenAI::Client.new(
        base_url: "http://localhost",
        api_key: "My API Key",
        admin_api_key: "My Admin API Key"
      )

    stream = openai.responses.stream(response_id: "resp_123")

    assert_instance_of(OpenAI::Streaming::ResponseStream, stream)
    assert_requested(:get, "http://localhost/responses/resp_123?stream=true", times: 1)
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

    openai =
      OpenAI::Client.new(
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

    openai =
      OpenAI::Client.new(
        base_url: "http://localhost",
        api_key: "My API Key",
        admin_api_key: "My Admin API Key"
      )

    response = openai.models.list

    assert_equal("req_page", response._request_id)
    assert_equal(200, response.last_response.status)
    assert_equal("req_page", response.last_response.request_id)
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

    openai =
      OpenAI::Client.new(
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

  def test_non_model_results_are_not_wrapped_in_response_metadata
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
    refute_respond_to(content, :last_response)
    assert_nil(result)
  end

  def test_client_default_request_default_retry_attempts
    stub_request(:post, "http://localhost/chat/completions").to_return_json(status: 500, body: {})

    openai =
      OpenAI::Client.new(
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

    openai =
      OpenAI::Client.new(
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

    openai =
      OpenAI::Client.new(
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

    openai =
      OpenAI::Client.new(
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

    openai =
      OpenAI::Client.new(
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

    openai =
      OpenAI::Client.new(
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
    assert_equal(10, Thread.current.thread_variable_get(:mock_sleep).last)
  end

  def test_client_retry_after_ms
    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 500,
      headers: {"retry-after-ms" => "1300"},
      body: {}
    )

    openai =
      OpenAI::Client.new(
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

    openai =
      OpenAI::Client.new(
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

    openai =
      OpenAI::Client.new(
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

    openai =
      OpenAI::Client.new(
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

    openai =
      OpenAI::Client.new(
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

    openai =
      OpenAI::Client.new(
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

    openai =
      OpenAI::Client.new(
        base_url: "http://localhost",
        api_key: "My API Key",
        admin_api_key: "My Admin API Key"
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
      auth_header = _1.headers.transform_keys(&:downcase).fetch("authorization")
      assert_equal("Bearer xyz", auth_header)
    end
  end

  def test_client_redirect_auth_strip_cross_origin
    stub_request(:post, "http://localhost/chat/completions").to_return_json(
      status: 307,
      headers: {"location" => "https://example.com/redirected"},
      body: {}
    )
    stub_request(:any, "https://example.com/redirected").to_return(
      status: 307,
      headers: {"location" => "https://example.com/redirected"}
    )

    openai =
      OpenAI::Client.new(
        base_url: "http://localhost",
        api_key: "My API Key",
        admin_api_key: "My Admin API Key"
      )

    assert_raises(OpenAI::Errors::APIConnectionError) do
      openai.chat.completions.create(
        messages: [{content: "string", role: :developer}],
        model: :"gpt-5.4",
        request_options: {extra_headers: {"authorization" => "Bearer xyz"}}
      )
    end

    assert_requested(:any, "https://example.com/redirected", times: OpenAI::Client::MAX_REDIRECTS) do
      headers = _1.headers.keys.map(&:downcase)
      refute_includes(headers, "authorization")
    end
  end

  def test_default_headers
    stub_request(:post, "http://localhost/chat/completions").to_return_json(status: 200, body: {})

    openai =
      OpenAI::Client.new(
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
end
