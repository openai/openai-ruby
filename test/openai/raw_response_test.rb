# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::RawResponseTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
  end

  def teardown
    WebMock.reset!
    super
  end

  def after_all
    WebMock.disable!
    super
  end

  def test_resource_modifier_preserves_endpoint_names_and_parses_models
    body = '{"id":"gpt-test","created":1,"object":"model","owned_by":"openai"}'
    stub_request(:get, "http://localhost/models/gpt-test").to_return(
      status: 200,
      headers: {
        "Content-Type" => "application/json",
        "OpenAI-Processing-Ms" => "42",
        "X-Request-ID" => "req_raw_model"
      },
      body: body
    )

    response = client.models.with_raw_response.retrieve("gpt-test")

    assert_instance_of(OpenAI::RawResponse, response)
    assert_equal(200, response.status)
    assert_equal("42", response.headers["openai-processing-ms"])
    assert_equal("req_raw_model", response.request_id)
    assert_equal(body, response.read)
    assert_equal(body, response.read)
    assert_predicate(response.headers, :frozen?)

    model = response.parse
    assert_instance_of(OpenAI::Model, model)
    assert_equal("gpt-test", model.id)
    assert_equal(response.request_id, model._request_id)
    refute_respond_to(model, :response_headers)
  end

  def test_resource_modifier_parses_pages_without_copying_full_headers_to_the_page
    body = '{"data":[],"object":"list"}'
    stub_request(:get, "http://localhost/models").to_return(
      status: 200,
      headers: {"Content-Type" => "application/json", "X-Request-ID" => "req_raw_page"},
      body: body
    )

    response = client.models.with_raw_response.list
    page = response.parse

    assert_instance_of(OpenAI::RawResponse, response)
    assert_instance_of(OpenAI::Internal::Page, page)
    assert_equal("req_raw_page", response.request_id)
    assert_equal(response.request_id, page._request_id)
    refute_respond_to(page, :response_headers)
  end

  def test_resource_modifier_parses_non_model_responses
    body = "raw file contents\n".b
    stub_request(:get, "http://localhost/files/file-123/content").to_return(
      status: 200,
      headers: {"Content-Type" => "application/octet-stream", "X-Request-ID" => "req_raw_file"},
      body: body
    )

    response = client.files.with_raw_response.content("file-123")
    content = response.parse

    assert_instance_of(OpenAI::RawResponse, response)
    assert_instance_of(StringIO, content)
    assert_equal(body, content.read)
    assert_equal(body, response.read)
  end

  def test_resource_modifier_preserves_nested_resource_navigation
    beta = client.beta.with_raw_response
    vector_stores = client.vector_stores.with_raw_response

    assert_instance_of(OpenAI::Resources::Beta::WithRawResponse, beta)
    assert_instance_of(OpenAI::Resources::Beta::Responses::WithRawResponse, beta.responses)
    assert_instance_of(
      OpenAI::Resources::VectorStores::Files::WithRawResponse,
      vector_stores.files
    )
    assert_respond_to(beta.responses, :create)
    assert_respond_to(vector_stores, :create)
    assert_respond_to(vector_stores.files, :list)
    assert_respond_to(client.responses.with_raw_response, :stream_raw)
    refute_respond_to(client.responses.with_raw_response, :stream)
  end

  def test_all_generated_resource_modifiers_have_isolated_constants_and_navigation
    resources = client.instance_variables.filter_map do |name|
      value = client.instance_variable_get(name)
      value if value.class.name&.start_with?("OpenAI::Resources::")
    end
    visited = {}.compare_by_identity

    until resources.empty?
      resource = resources.shift
      next if visited[resource]
      visited[resource] = true

      children = resource.instance_variables.filter_map do |name|
        value = resource.instance_variable_get(name)
        [name.to_s.delete_prefix("@").to_sym, value] if value.class.name&.start_with?("OpenAI::Resources::")
      end
      resources.concat(children.map(&:last))
      next unless resource.respond_to?(:with_raw_response)

      wrapper = resource.with_raw_response
      expected_class = resource.class.const_get(:WithRawResponse, false)
      assert_instance_of(expected_class, wrapper, resource.class.name)

      wrapper.class.public_instance_methods(false).each do |name|
        assert_respond_to(resource, name, resource.class.name)
        assert_equal(
          resource.method(name).parameters,
          wrapper.method(name).parameters,
          "#{resource.class.name}##{name}"
        )
      end

      children.each do |name, child|
        next unless child.respond_to?(:with_raw_response)

        assert_respond_to(wrapper, name, resource.class.name)
        assert_instance_of(
          child.class.const_get(:WithRawResponse, false),
          wrapper.public_send(name),
          "#{resource.class.name}##{name}"
        )
      end
    end

    assert_operator(visited.length, :>=, 90)
  end

  def test_resource_modifier_uses_the_ordinary_responses_create_contract
    body = JSON.generate(
      id: "resp-123",
      created_at: 1_700_000_000.0,
      error: nil,
      incomplete_details: nil,
      instructions: nil,
      metadata: nil,
      model: "gpt-5.4",
      object: "response",
      output: [],
      parallel_tool_calls: false,
      temperature: nil,
      tool_choice: "auto",
      tools: [],
      top_p: nil
    )
    stub_request(:post, "http://localhost/responses").to_return(
      status: 200,
      headers: {"Content-Type" => "application/json", "X-Request-ID" => "req_raw_response"},
      body: body
    )

    response = client.responses.with_raw_response.create(
      model: :"gpt-5.4",
      input: "Hello"
    )
    parsed = response.parse

    assert_instance_of(OpenAI::RawResponse, response)
    assert_instance_of(OpenAI::Responses::Response, parsed)
    assert_equal("resp-123", parsed.id)
    assert_equal("req_raw_response", response.request_id)
    assert_equal(response.request_id, parsed._request_id)
  end

  def test_resource_modifier_preserves_nil_responses
    stub_request(:delete, "http://localhost/responses/resp-123").to_return(
      status: 200,
      headers: {"Content-Type" => "application/json", "X-Request-ID" => "req_raw_delete"},
      body: "null"
    )

    response = client.responses.with_raw_response.delete("resp-123")

    assert_instance_of(OpenAI::RawResponse, response)
    assert_equal("req_raw_delete", response.request_id)
    assert_nil(response.parse)
    assert_nil(response.parse)
  end

  def test_response_metadata_and_body_are_immutable_snapshots
    headers = {"X-Request-ID" => +"req_snapshot", "X-Trace" => +"trace"}
    body = +"payload"
    parse_count = 0
    response = OpenAI::RawResponse.new(
      status: "201",
      headers: headers,
      body: body,
      parser: -> do
        parse_count += 1
        Object.new
      end
    )

    headers["X-Request-ID"].replace("changed")
    headers["X-New"] = "new"
    body.replace("changed")

    assert_equal(201, response.status)
    assert_equal({"x-request-id" => "req_snapshot", "x-trace" => "trace"}, response.headers)
    assert_equal("req_snapshot", response.request_id)
    assert_equal("payload", response.body)
    parsed = response.parse
    assert_same(parsed, response.parse)
    assert_equal(1, parse_count)
    assert_match(/\A#<OpenAI::RawResponse:0x[0-9a-f]+ status=201 body_bytes=7>\z/, response.inspect)
    refute_includes(response.inspect, "payload")
    assert_predicate(response.body, :frozen?)
    assert(response.headers.all? { |key, value| key.frozen? && value.frozen? })

    copy = response.read
    refute_predicate(copy, :frozen?)
    copy.replace("caller-owned")
    assert_equal("payload", response.read)
  end

  def test_parse_is_cached_only_after_success
    attempts = 0
    parsed = Object.new
    response = OpenAI::RawResponse.new(
      status: 200,
      headers: {},
      body: "payload",
      parser: -> do
        attempts += 1
        raise "parse failed" if attempts == 1

        parsed
      end
    )

    error = assert_raises(RuntimeError) { response.parse }
    assert_equal("parse failed", error.message)
    assert_same(parsed, response.parse)
    assert_same(parsed, response.parse)
    assert_equal(2, attempts)
  end

  private def client
    OpenAI::Client.new(
      base_url: "http://localhost",
      api_key: "My API Key",
      admin_api_key: "My Admin API Key"
    )
  end
end
