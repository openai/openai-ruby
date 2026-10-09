# frozen_string_literal: true

require_relative "test_helper"

class OpenAI::Test::PrewarmRequestHeadersTest < Minitest::Test
  extend Minitest::Serial
  include WebMock::API

  def before_all
    super
    WebMock.enable!
  end

  def after_all
    WebMock.disable!
    super
  end

  def teardown
    WebMock.reset!
    super
  end

  def test_create_preserves_defaults_and_caller_header_precedence
    assert_request_headers(:post)
  end

  def test_list_preserves_defaults_and_caller_header_precedence
    assert_request_headers(:get)
  end

  private

  def assert_request_headers(method)
    client = OpenAI::Client.new(base_url: "http://localhost", api_key: "synthetic", max_retries: 0)
    [{}, {"X-Request-ID" => "synthetic-request"}, {"openai-beta" => "caller-override"}].each do |extra_headers|
      captured = nil
      payload = if method == :post
        {id: "env_test", object: "agent.environment", type: "openai_hosted", status: "ready"}
      else
        {object: "list", data: [], has_more: false, first_id: nil, last_id: nil}
      end

      request = stub_request(method, "http://localhost/agents/environments").to_return do |outgoing|
        captured = outgoing.headers.transform_keys(&:downcase)
        {
          status: method == :post ? 201 : 200,
          headers: {"content-type" => "application/json"},
          body: JSON.generate(payload)
        }
      end

      options = extra_headers.empty? ? {} : {extra_headers: extra_headers}
      if method == :post
        client.beta.agents.environments.create(
          environment: {type: :openai_hosted},
          idempotency_key: "synthetic-idempotency",
          request_options: options
        )
      else
        client.beta.agents.environments.list(request_options: options)
      end

      assert_requested(request, times: 1)
      assert_equal(extra_headers.fetch("openai-beta", "agents=v1"), captured.fetch("openai-beta"))
      assert_equal("synthetic-request", captured.fetch("x-request-id")) if extra_headers.key?("X-Request-ID")
      assert_equal("synthetic-idempotency", captured.fetch("idempotency-key")) if method == :post
      WebMock.reset!
    end
  end
end
