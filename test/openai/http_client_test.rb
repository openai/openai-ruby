# frozen_string_literal: true

require "socket"
require "open3"
require "rbconfig"

require_relative "test_helper"

class HTTPClientTest < Minitest::Test
  extend Minitest::Serial

  class StubHTTPClient < OpenAI::HTTPClient
    def initialize(&execute)
      super()
      @execute = execute
    end

    def execute(request) = @execute.call(request)
  end

  class StubNetHTTP
    attr_accessor(
      :continue_timeout,
      :keep_alive_timeout,
      :max_retries,
      :open_timeout,
      :read_timeout,
      :use_ssl,
      :verify_mode,
      :write_timeout
    )

    def initialize(use_ssl:, request_error: nil)
      @use_ssl = use_ssl
      @request_error = request_error
      @started = false
      @finished = false
    end

    def start = (@started = true)

    def finish
      @started = false
      @finished = true
    end

    def use_ssl? = @use_ssl
    def started? = @started
    def finished? = @finished

    def request(_request)
      raise @request_error if @request_error

      raise NotImplementedError
    end
  end

  class CloseableBody
    include Enumerable

    attr_reader :close_count, :each_count

    def initialize(*chunks)
      @chunks = chunks
      @close_count = 0
      @each_count = 0
    end

    def close = (@close_count += 1)

    def each
      @each_count += 1
      @chunks.each { yield(_1) }
    end
  end

  class OneShotBody
    include Enumerable

    def initialize(*items)
      @items = items.each
    end

    def each(&blk)
      @items.each(&blk)
    end
  end

  def test_http_response_normalizes_buffered_content
    response = OpenAI::HTTPClient::Response.new(
      status: "200",
      headers: {"Content-Type" => :json},
      body: "response body"
    )

    assert_equal(200, response.status)
    assert_equal({"content-type" => "json"}, response.headers)
    assert_equal(["response body"], response.body.to_a)
  end

  def test_http_response_body_is_one_shot_and_closes_its_source
    source = CloseableBody.new("first", "second")
    response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: source)

    assert_equal(%w[first second], response.body.to_a)
    assert_empty(response.body.to_a)
    assert_equal(1, source.each_count)
    assert_equal(1, source.close_count)
  end

  def test_http_response_closes_its_source_when_consumption_stops_early
    source = CloseableBody.new("first", "second")
    response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: source)

    assert_equal("first", response.body.next)
    OpenAI::Internal::Util.close_fused!(response.body)

    assert_equal(1, source.close_count)
  end

  def test_http_response_closes_a_fused_source_when_consumption_stops_early
    closed = false
    source = OpenAI::Internal::Util.fused_enum(%w[first second]) { closed = true }
    response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: source)

    assert_equal("first", response.body.next)
    OpenAI::Internal::Util.close_fused!(response.body)

    assert(closed)
  end

  def test_http_response_does_not_restart_a_completed_plain_enumerator
    runs = 0
    source = Enumerator.new do |yielder|
      runs += 1
      yielder << "response body"
    end

    response = OpenAI::HTTPClient::Response.new(status: 200, headers: {}, body: source)

    assert_equal(["response body"], response.body.to_a)
    assert_equal(1, runs)
  end

  def test_client_uses_the_custom_http_client_to_execute_requests
    requests = []
    http_client = StubHTTPClient.new do |request|
      requests << request
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: ["{\"ok\":true}"]
      )
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client
    )

    response = client.request(method: :get, path: "probe", security: {bearer_auth: true})

    assert_equal(true, response[:ok])
    assert_same(http_client, client.requester)
    assert_equal(1, requests.length)
    request = requests.fetch(0)
    assert_equal(:get, request.method)
    assert_equal("https://example.com/v1/probe", request.url.to_s)
    assert_equal("Bearer test-key", request.headers.fetch("authorization"))
    assert_equal(OpenAI::Client::DEFAULT_TIMEOUT_IN_SECONDS, request.timeout)
  end

  def test_client_preserves_nil_timeout_for_custom_http_client
    requests = []
    http_client = StubHTTPClient.new do |request|
      requests << request
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: ["{\"ok\":true}"]
      )
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      timeout: nil,
      http_client: http_client
    )

    response = client.request(method: :get, path: "probe", security: {bearer_auth: true})

    assert_equal(true, response[:ok])
    assert_nil(client.timeout)
    assert_nil(requests.fetch(0).timeout)
    refute_includes(requests.fetch(0).headers, "x-stainless-timeout")
  end

  def test_net_http_client_configures_pooled_connections
    calls = []
    http_client = OpenAI::NetHTTPClient.new do |http|
      calls << http
      http.keep_alive_timeout = 42
      http.max_retries = 4
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client
    )

    deadline = OpenAI::Internal::Util.monotonic_secs + 10
    pooled_connection = nil
    client.requester.send(:with_pool, client.base_url, deadline: deadline) do |connection|
      pooled_connection = connection
      assert_instance_of(Net::HTTP, connection)
      assert_predicate(connection, :use_ssl?)
      assert_equal(0, connection.max_retries)
    end

    assert_equal(1, calls.length)
    assert_same(calls.fetch(0), pooled_connection)
    assert_equal("example.com", calls.fetch(0).address)
    assert_equal(443, calls.fetch(0).port)
    assert_equal(42, calls.fetch(0).keep_alive_timeout)
  end

  def test_net_http_client_preserves_a_configured_keep_alive_timeout_when_requesting
    connection = StubNetHTTP.new(use_ssl: true, request_error: IOError.new("connection closed"))
    client_class = Class.new(OpenAI::NetHTTPClient) do
      define_method(:connect) { |**| connection }
      private(:connect)
    end

    request = OpenAI::HTTPClient::Request.new(
      method: :get,
      url: URI("https://example.com/v1/probe"),
      headers: {},
      body: nil,
      timeout: 1
    )
    http_client = client_class.new { |http| http.keep_alive_timeout = 42 }

    assert_raises(OpenAI::Errors::APIConnectionError) { http_client.execute(request) }
    assert_equal(42, connection.keep_alive_timeout)
  end

  def test_http_client_contract_fails_fast_for_non_executable_values
    error = assert_raises(ArgumentError) do
      OpenAI::Client.new(api_key: "test-key", http_client: Object.new)
    end

    assert_equal("`http_client` must respond to `execute`", error.message)
  end

  def test_client_accepts_a_structural_http_client
    http_client = Object.new
    http_client.define_singleton_method(:execute) do |_request|
      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: "{\"ok\":true}"
      )
    end

    client = OpenAI::Client.new(api_key: "test-key", http_client: http_client)

    assert_equal(true, client.request(method: :get, path: "probe")[:ok])
    assert_same(http_client, client.requester)
  end

  def test_http_client_must_return_an_http_response
    http_client = StubHTTPClient.new { Object.new }
    client = OpenAI::Client.new(api_key: "test-key", http_client: http_client)

    error = assert_raises(TypeError) do
      client.request(method: :get, path: "probe")
    end

    assert_equal(
      "`http_client#execute` must return an OpenAI::HTTPClient::Response",
      error.message
    )
  end

  def test_sdk_retries_responses_from_a_custom_http_client
    attempts = 0
    http_client = StubHTTPClient.new do
      attempts += 1
      OpenAI::HTTPClient::Response.new(
        status: attempts == 1 ? 500 : 200,
        headers: {"content-type" => "application/json"},
        body: [attempts == 1 ? "{\"error\":\"retry\"}" : "{\"ok\":true}"]
      )
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: http_client,
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0
    )

    response = client.request(method: :get, path: "probe")

    assert_equal(true, response[:ok])
    assert_equal(2, attempts)
  end

  def test_sdk_reencodes_replayable_multipart_bodies_for_each_attempt
    requests = []
    http_client = StubHTTPClient.new do |request|
      requests << [request.headers.fetch("content-type"), request.body.to_a.join]
      OpenAI::HTTPClient::Response.new(
        status: requests.one? ? 500 : 200,
        headers: {"content-type" => "application/json"},
        body: requests.one? ? "{\"error\":\"retry\"}" : "{\"ok\":true}"
      )
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: http_client,
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0
    )
    file = OpenAI::FilePart.new(StringIO.new("payload"), filename: "payload.txt")

    response = client.request(
      method: :post,
      path: "probe",
      headers: {"content-type" => "multipart/form-data"},
      body: {file: file}
    )

    assert_equal(true, response[:ok])
    assert_equal(2, requests.length)
    requests.map(&:last).each { assert_includes(_1, "payload") }
    refute_equal(requests[0][0], requests[1][0])
  end

  def test_sdk_does_not_retry_one_shot_jsonl_bodies
    attempts = 0
    request_body = Enumerator.new { _1 << {value: "payload"} }
    http_client = StubHTTPClient.new do |request|
      attempts += 1
      request.body.to_a
      OpenAI::HTTPClient::Response.new(
        status: 500,
        headers: {"content-type" => "application/json"},
        body: "{\"error\":\"do not retry\"}"
      )
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: http_client,
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0
    )

    assert_raises(OpenAI::Errors::InternalServerError) do
      client.request(
        method: :post,
        path: "probe",
        headers: {"content-type" => "application/jsonl"},
        body: request_body
      )
    end

    assert_equal(1, attempts)
  end

  def test_sdk_does_not_retry_one_shot_jsonl_enumerables
    attempts = 0
    request_body = OneShotBody.new({value: "payload"})
    http_client = StubHTTPClient.new do |request|
      attempts += 1
      request.body.to_a
      OpenAI::HTTPClient::Response.new(
        status: 500,
        headers: {"content-type" => "application/json"},
        body: "{\"error\":\"do not retry\"}"
      )
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: http_client,
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0
    )

    assert_raises(OpenAI::Errors::InternalServerError) do
      client.request(
        method: :post,
        path: "probe",
        headers: {"content-type" => "application/jsonl"},
        body: request_body
      )
    end

    assert_equal(1, attempts)
  end

  def test_sdk_closes_a_custom_response_body_before_retrying
    attempts = 0
    retry_body = CloseableBody.new("{\"error\":\"retry\"}")
    http_client = StubHTTPClient.new do
      attempts += 1
      OpenAI::HTTPClient::Response.new(
        status: attempts == 1 ? 500 : 200,
        headers: {"content-type" => "application/json"},
        body: attempts == 1 ? retry_body : "{\"ok\":true}"
      )
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: http_client,
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0
    )

    assert_equal(true, client.request(method: :get, path: "probe")[:ok])
    assert_equal(0, retry_body.each_count)
    assert_equal(1, retry_body.close_count)
  end

  def test_sdk_retries_connection_errors_from_a_custom_http_client
    attempts = 0
    http_client = StubHTTPClient.new do |request|
      attempts += 1
      raise OpenAI::Errors::APIConnectionError.new(url: request.url) if attempts == 1

      OpenAI::HTTPClient::Response.new(
        status: 200,
        headers: {"content-type" => "application/json"},
        body: "{\"ok\":true}"
      )
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: http_client,
      max_retries: 1,
      initial_retry_delay: 0,
      max_retry_delay: 0
    )

    response = client.request(method: :get, path: "probe")

    assert_equal(true, response[:ok])
    assert_equal(2, attempts)
  end

  def test_sdk_follows_redirects_from_a_custom_http_client
    requests = []
    http_client = StubHTTPClient.new do |request|
      requests << request
      if requests.one?
        OpenAI::HTTPClient::Response.new(
          status: 307,
          headers: {"location" => "https://example.com/v1/redirected"},
          body: ""
        )
      else
        OpenAI::HTTPClient::Response.new(
          status: 200,
          headers: {"content-type" => "application/json"},
          body: "{\"ok\":true}"
        )
      end
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client
    )

    response = client.request(method: :get, path: "probe")

    assert_equal(true, response[:ok])
    assert_equal(
      ["https://example.com/v1/probe", "https://example.com/v1/redirected"],
      requests.map { _1.url.to_s }
    )
  end

  def test_sdk_rejects_307_redirects_for_one_shot_bodies
    assert_one_shot_body_redirect_rejected(307)
  end

  def test_sdk_rejects_308_redirects_for_one_shot_bodies
    assert_one_shot_body_redirect_rejected(308)
  end

  def test_sdk_follows_body_dropping_redirects_for_one_shot_bodies
    requests = []
    http_client = StubHTTPClient.new do |request|
      requests << request
      request.body.to_a if request.body
      OpenAI::HTTPClient::Response.new(
        status: requests.one? ? 303 : 200,
        headers: if requests.one?
          {"location" => "https://example.com/v1/redirected"}
        else
          {"content-type" => "application/json"}
        end,
        body: requests.one? ? "" : "{\"ok\":true}"
      )
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client
    )

    response = client.request(
      method: :post,
      path: "probe",
      headers: {"content-type" => "application/jsonl"},
      body: Enumerator.new { _1 << {value: "payload"} }
    )

    assert_equal(true, response[:ok])
    assert_equal(2, requests.length)
    assert_equal(:get, requests.last.method)
    assert_nil(requests.last.body)
    refute_includes(requests.last.headers, "content-type")
  end

  def test_sdk_loads_without_optional_zlib
    root = File.expand_path("../..", __dir__)
    script = <<~RUBY
      abort "zlib loaded before test setup" if defined?(Zlib)

      module Kernel
        alias_method :require_with_zlib, :require

        def require(feature)
          raise LoadError, "cannot load such file -- zlib" if feature == "zlib"

          require_with_zlib(feature)
        end
      end

      require "openai"
    RUBY
    _, stderr, status = Open3.capture3(
      {"RUBYOPT" => nil},
      RbConfig.ruby,
      "-I#{File.join(root, "lib")}",
      "-e",
      script,
      chdir: root
    )

    assert_predicate(status, :success?, stderr)
  end

  def test_net_http_client_loads_its_sdk_owned_body_adapter
    root = File.expand_path("../..", __dir__)
    script = <<~RUBY
      require "etc"
      require "net/http"
      require "openssl"
      require "connection_pool"
      require "openai/internal/util"
      require "openai/http_client"
      require "openai/net_http_client"

      abort "body adapter was not loaded" unless defined?(OpenAI::Internal::Util::ReadIOAdapter)
    RUBY
    _, stderr, status = Open3.capture3(
      {"RUBYOPT" => nil},
      RbConfig.ruby,
      "-I#{File.join(root, "lib")}",
      "-e",
      script,
      chdir: root
    )

    assert_predicate(status, :success?, stderr)
  end

  def test_http_client_must_leave_the_connection_unstarted
    calls = 0
    http_client = OpenAI::NetHTTPClient.new do |http|
      calls += 1
      http.instance_variable_set(:@started, true)
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client
    )

    error = assert_raises(ArgumentError) do
      client.request(method: :get, path: "probe")
    end

    assert_equal("connection configuration must leave the connection unstarted", error.message)
    assert_equal(1, calls)
  end

  def test_http_client_must_preserve_tls_for_https_urls
    http_client = OpenAI::NetHTTPClient.new { |http| http.use_ssl = false }
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client
    )

    error = assert_raises(ArgumentError) do
      client.request(method: :get, path: "probe")
    end

    assert_equal("connection configuration must preserve TLS for the requested URL", error.message)
  end

  def test_net_http_client_does_not_wrap_configuration_errors
    configuration_errors = [
      Class.new(StandardError).new("invalid local configuration"),
      Errno::ENOENT.new("missing certificate"),
      IOError.new("unreadable certificate"),
      OpenSSL::SSL::SSLError.new("invalid certificate"),
      Timeout::Error.new("configuration timed out")
    ]

    configuration_errors.each do |configuration_error|
      calls = 0
      http_client = OpenAI::NetHTTPClient.new do
        calls += 1
        raise configuration_error
      end

      client = OpenAI::Client.new(
        api_key: "test-key",
        base_url: "https://example.com/v1",
        http_client: http_client,
        max_retries: 1,
        initial_retry_delay: 0,
        max_retry_delay: 0
      )

      raised = assert_raises(configuration_error.class) do
        client.request(method: :get, path: "probe")
      end

      assert_same(configuration_error, raised)
      assert_equal(1, calls)
    end
  end

  def test_net_http_client_closes_a_connection_started_by_a_failing_configurator
    connection = StubNetHTTP.new(use_ssl: true)
    configuration_error = Class.new(StandardError).new("invalid local configuration")
    client_class = Class.new(OpenAI::NetHTTPClient) do
      define_method(:connect) { |**| connection }
      private(:connect)
    end

    http_client = client_class.new do |http|
      http.start
      raise configuration_error
    end

    request = OpenAI::HTTPClient::Request.new(
      method: :get,
      url: URI("https://example.com/v1/probe"),
      headers: {},
      body: nil,
      timeout: 1
    )

    raised = assert_raises(configuration_error.class) do
      http_client.execute(request)
    end

    assert_same(configuration_error, raised)
    assert_predicate(connection, :finished?)
  end

  def test_net_http_client_closes_a_connection_started_by_a_failing_validator
    connection = StubNetHTTP.new(use_ssl: true)
    replacement = StubNetHTTP.new(use_ssl: true)
    available = [connection, replacement]
    validation_error = StandardError.new("connection validation failed")
    client_class = Class.new(OpenAI::NetHTTPClient) do
      define_method(:connect) { |**| available.shift }
      private(:connect)
    end

    http_client = client_class.new
    request = OpenAI::HTTPClient::Request.new(
      method: :get,
      url: URI("https://example.com/v1/probe"),
      headers: {"authorization" => "Bearer fake-sensitive-token"},
      body: nil,
      timeout: 1
    )

    raised = assert_raises(StandardError) do
      http_client.execute(request) do |http|
        assert_same(connection, http)
        http.start
        raise validation_error
      end
    end

    assert_same(validation_error, raised)
    assert_predicate(connection, :finished?)
    refute_predicate(connection, :started?)
    refute_includes(raised.full_message(highlight: false), "fake-sensitive-token")

    follow_up_error = StandardError.new("follow-up validation failed")
    raised = assert_raises(StandardError) do
      http_client.execute(request) do |http|
        assert_same(replacement, http)
        refute_predicate(http, :started?)
        raise follow_up_error
      end
    end

    assert_same(follow_up_error, raised)
  ensure
    http_client&.close
  end

  def test_net_http_client_discards_an_existing_connection_when_validation_fails
    connections = []
    validation_error = StandardError.new("connection validation failed")
    client_class = Class.new(OpenAI::NetHTTPClient) do
      define_method(:connect) { |**| StubNetHTTP.new(use_ssl: true).tap { connections << _1 } }
      private(:connect)
    end

    http_client = client_class.new
    request = OpenAI::HTTPClient::Request.new(
      method: :get,
      url: URI("https://example.com/v1/probe"),
      headers: {},
      body: nil,
      timeout: 1
    )
    connection = checkout_connection(http_client, request.url)

    raised = assert_raises(StandardError) do
      http_client.execute(request) do |http|
        assert_same(connection, http)
        raise validation_error
      end
    end

    assert_same(validation_error, raised)
    refute_predicate(connection, :started?)
    assert_predicate(connection, :finished?)
    replacement = checkout_connection(http_client, request.url)
    refute_same(connection, replacement)
    assert_equal(2, connections.length)
  ensure
    http_client&.close
  end

  def test_net_http_client_discards_tls_settings_after_a_failing_validator
    connections = []
    validation_error = StandardError.new("connection validation failed")
    client_class = Class.new(OpenAI::NetHTTPClient) do
      define_method(:connect) do |**|
        StubNetHTTP.new(use_ssl: true, request_error: IOError.new("safe network probe")).tap do |connection|
          connection.verify_mode = OpenSSL::SSL::VERIFY_PEER
          connections << connection
        end
      end

      private(:connect)
    end

    http_client = client_class.new
    request = OpenAI::HTTPClient::Request.new(
      method: :get,
      url: URI("https://example.com/v1/probe"),
      headers: {"authorization" => "Bearer fake-sensitive-token"},
      body: nil,
      timeout: 1
    )

    raised = assert_raises(StandardError) do
      http_client.execute(request) do |connection|
        connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
        raise validation_error
      end
    end

    assert_same(validation_error, raised)
    assert_equal(OpenSSL::SSL::VERIFY_NONE, connections.fetch(0).verify_mode)
    assert_raises(OpenAI::Errors::APIConnectionError) { http_client.execute(request) }
    assert_equal(2, connections.length)
    assert_equal(OpenSSL::SSL::VERIFY_PEER, connections.fetch(1).verify_mode)
    refute_same(connections.fetch(0), connections.fetch(1))
  ensure
    http_client&.close
  end

  def test_net_http_client_discards_tls_settings_after_an_invalid_returning_validator
    connections = []
    client_class = Class.new(OpenAI::NetHTTPClient) do
      define_method(:connect) do |**|
        StubNetHTTP.new(use_ssl: true, request_error: IOError.new("safe network probe")).tap do |connection|
          connection.verify_mode = OpenSSL::SSL::VERIFY_PEER
          connections << connection
        end
      end

      private(:connect)
    end

    http_client = client_class.new
    request = OpenAI::HTTPClient::Request.new(
      method: :get,
      url: URI("https://example.com/v1/probe"),
      headers: {"authorization" => "Bearer fake-sensitive-token"},
      body: nil,
      timeout: 1
    )

    error = assert_raises(ArgumentError) do
      http_client.execute(request) do |connection|
        connection.verify_mode = OpenSSL::SSL::VERIFY_NONE
        connection.use_ssl = false
      end
    end

    assert_match(/preserve TLS/, error.message)
    assert_raises(OpenAI::Errors::APIConnectionError) { http_client.execute(request) }
    assert_equal(2, connections.length)
    assert_equal(OpenSSL::SSL::VERIFY_PEER, connections.fetch(1).verify_mode)
    assert_predicate(connections.fetch(1), :use_ssl?)
  ensure
    http_client&.close
  end

  def test_net_http_client_wraps_malformed_responses_as_connection_errors
    [Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Zlib::DataError].each do |error_class|
      connection = StubNetHTTP.new(use_ssl: true, request_error: error_class.new("malformed"))
      client_class = Class.new(OpenAI::NetHTTPClient) do
        define_method(:connect) { |**| connection }
        private(:connect)
      end

      request = OpenAI::HTTPClient::Request.new(
        method: :get,
        url: URI("https://example.com/v1/probe"),
        headers: {},
        body: nil,
        timeout: 1
      )

      error = assert_raises(OpenAI::Errors::APIConnectionError) do
        client_class.new.execute(request)
      end

      assert_instance_of(error_class, error.cause)
    end
  end

  def test_net_http_client_wraps_an_expired_deadline_as_a_timeout_error
    request = OpenAI::HTTPClient::Request.new(
      method: :get,
      url: URI("https://example.com/v1/probe"),
      headers: {},
      body: nil,
      timeout: -1
    )

    error = assert_raises(OpenAI::Errors::APITimeoutError) do
      OpenAI::NetHTTPClient.new.execute(request)
    end

    assert_instance_of(Timeout::Error, error.cause)
  end

  def test_net_http_client_close_retires_connections_and_remains_reusable
    connections = []
    client_class = Class.new(OpenAI::NetHTTPClient) do
      define_method(:connect) do |url:|
        StubNetHTTP.new(use_ssl: url.scheme == "https").tap { connections << _1 }
      end

      private(:connect)
    end

    http_client = client_class.new
    url = URI("https://example.com")

    first_connection = checkout_connection(http_client, url)

    assert_nil(http_client.close)
    assert_predicate(first_connection, :finished?)

    second_connection = checkout_connection(http_client, url)

    refute_same(first_connection, second_connection)
    refute_predicate(second_connection, :finished?)
  end

  def test_custom_http_client_does_not_implicitly_change_the_endpoint
    client = OpenAI::Client.new(
      api_key: "test-key",
      http_client: OpenAI::NetHTTPClient.new
    )

    assert_equal("https://api.openai.com/v1", client.base_url.to_s)
  end

  private def checkout_connection(http_client, url)
    deadline = OpenAI::Internal::Util.monotonic_secs + 10
    http_client.send(:with_pool, url, deadline: deadline) do |connection|
      connection.start
      connection
    end
  end

  private def assert_one_shot_body_redirect_rejected(status)
    requests = []
    http_client = StubHTTPClient.new do |request|
      requests << request
      request.body.to_a
      OpenAI::HTTPClient::Response.new(
        status: status,
        headers: {"location" => "https://example.com/v1/redirected"},
        body: ""
      )
    end

    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1",
      http_client: http_client
    )

    error = assert_raises(OpenAI::Errors::APIConnectionError) do
      client.request(
        method: :post,
        path: "probe",
        headers: {"content-type" => "application/jsonl"},
        body: Enumerator.new { _1 << {value: "payload"} }
      )
    end

    assert_equal(1, requests.length)
    assert_equal("https://example.com/v1/redirected", error.url.to_s)
    assert_equal(
      "Cannot follow a body-preserving redirect with a non-replayable request body.",
      error.message
    )
  end

end
