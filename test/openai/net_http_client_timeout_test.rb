# frozen_string_literal: true

require_relative "test_helper"

class NetHTTPClientTimeoutTest < Minitest::Test
  class StubNetHTTP
    attr_accessor :continue_timeout,
                  :max_retries,
                  :open_timeout,
                  :read_timeout,
                  :write_timeout

    attr_reader :request_count

    def initialize(request_error:, finish_error: nil)
      @finish_error = finish_error
      @request_error = request_error
      @request_count = 0
      @started = false
    end

    def finish
      @started = false
      raise @finish_error unless @finish_error.nil?
    end

    def start = (@started = true)
    def started? = @started
    def use_ssl? = true

    def request(_request)
      @request_count += 1
      raise @request_error
    end
  end

  def test_nil_timeout_disables_transport_deadlines
    connection = StubNetHTTP.new(request_error: IOError.new("connection closed"))
    connection.open_timeout = 1
    connection.read_timeout = 1
    connection.write_timeout = 1
    connection.continue_timeout = 1

    error = assert_raises(OpenAI::Errors::APIConnectionError) do
      build_client(connection).execute(nil_timeout_request)
    end

    assert_instance_of(OpenAI::Errors::APIConnectionError, error)
    assert_instance_of(IOError, error.cause)
    assert_nil(connection.open_timeout)
    assert_nil(connection.read_timeout)
    assert_nil(connection.write_timeout)
    assert_nil(connection.continue_timeout)
  end

  def test_pool_timeouts_from_request_execution_are_not_retried
    connection = StubNetHTTP.new(
      request_error: ConnectionPool::TimeoutError.new("upstream pool timed out")
    )

    error = assert_raises(OpenAI::Errors::APITimeoutError) do
      build_client(connection).execute(nil_timeout_request)
    end

    assert_instance_of(ConnectionPool::TimeoutError, error.cause)
    assert_equal(1, connection.request_count)
  end

  def test_request_deadline_bounds_connection_configuration
    connection = StubNetHTTP.new(request_error: IOError.new("request should not run"))
    client_class = Class.new(OpenAI::NetHTTPClient) do
      define_method(:connect) { |**| connection }
      private :connect
    end
    configurations = 0
    client = client_class.new do
      configurations += 1
      sleep(2) if configurations == 1
    end
    request = OpenAI::HTTPClient::Request.new(
      method: :get,
      url: URI("https://example.com/v1/probe"),
      headers: {},
      body: nil,
      timeout: 1
    )
    poller = OpenAI::Internal::Poller.new(operation: "connection configuration", timeout: 0.02)
    started_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    assert_raises(OpenAI::Errors::PollingTimeoutError) do
      poller.request({}) { client.execute(request) }
    end

    elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - started_at
    assert_operator(elapsed, :<, 1)
    assert_equal(0, connection.request_count)

    assert_raises(OpenAI::Errors::APIConnectionError) { client.execute(nil_timeout_request) }
    assert_equal(2, configurations)
    assert_equal(1, connection.request_count)
  end

  def test_request_deadline_bounds_connection_construction
    connection = StubNetHTTP.new(request_error: IOError.new("request should not run"))
    connections = 0
    client_class = Class.new(OpenAI::NetHTTPClient) do
      define_method(:connect) do |**|
        connections += 1
        sleep(2) if connections == 1
        connection
      end
      private :connect
    end
    client = client_class.new
    request = OpenAI::HTTPClient::Request.new(
      method: :get,
      url: URI("https://example.com/v1/probe"),
      headers: {},
      body: nil,
      timeout: 1
    )
    poller = OpenAI::Internal::Poller.new(operation: "connection construction", timeout: 0.02)
    started_at = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    assert_raises(OpenAI::Errors::PollingTimeoutError) do
      poller.request({}) { client.execute(request) }
    end

    elapsed = Process.clock_gettime(Process::CLOCK_MONOTONIC) - started_at
    assert_operator(elapsed, :<, 1)
    assert_equal(0, connection.request_count)

    assert_raises(OpenAI::Errors::APIConnectionError) { client.execute(nil_timeout_request) }
    assert_equal(2, connections)
    assert_equal(1, connection.request_count)
  end

  def test_configuration_error_survives_connection_cleanup_failure
    connection = StubNetHTTP.new(
      request_error: IOError.new("request should not run"),
      finish_error: IOError.new("cleanup failed")
    )
    client_class = Class.new(OpenAI::NetHTTPClient) do
      define_method(:connect) { |**| connection }
      private :connect
    end
    client = client_class.new(&:start)

    error = assert_raises(ArgumentError) { client.execute(nil_timeout_request) }

    assert_equal("connection configuration must leave the connection unstarted", error.message)
    assert_equal(0, connection.request_count)
  end

  private def build_client(connection)
    Class.new(OpenAI::NetHTTPClient) do
      define_method(:connect) { |**| connection }
      private :connect
    end.new
  end

  private def nil_timeout_request
    OpenAI::HTTPClient::Request.new(
      method: :get,
      url: URI("https://example.com/v1/probe"),
      headers: {},
      body: nil,
      timeout: nil
    )
  end
end
