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

    def initialize(request_error:)
      @request_error = request_error
      @request_count = 0
      @started = false
    end

    def finish = (@started = false)
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
