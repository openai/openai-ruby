# frozen_string_literal: true

require "async/websocket/client"
require_relative "../test_helper"

class OpenAI::Test::AsyncWebSocketAbortTest < Minitest::Test
  extend Minitest::Serial

  class Framer
    attr_reader :closed

    def initialize = @closed = false
    def close = @closed = true
  end

  class Connection
    attr_reader :close_count, :framer

    def initialize
      @close_count = 0
      @framer = Framer.new
    end

    def close(*) = @close_count += 1
    def closed? = @framer.closed
  end

  class Client
    attr_reader :closed

    def initialize(connection)
      @connection = connection
      @closed = false
    end

    def connect(*) = @connection
    def close = @closed = true
  end

  def test_default_transport_hard_closes_after_an_application_error
    connection = Connection.new
    transport_client = Client.new(connection)
    sdk_client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "https://example.com/v1"
    )

    error = assert_raises(RuntimeError) do
      Async::WebSocket::Client.stub(:open, transport_client) do
        sdk_client.realtime.connect(model: "gpt-realtime-2.1") do |_realtime|
          raise "application failed"
        end
      end
    end

    assert_equal("application failed", error.message)
    assert_predicate(connection.framer, :closed)
    assert_equal(0, connection.close_count)
    assert_predicate(transport_client, :closed)
  end
end
