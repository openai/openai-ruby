# frozen_string_literal: true

require "socket"

require_relative "test_helper"

class AsyncConcurrencyTest < Minitest::Test
  extend Minitest::Serial

  def test_net_http_client_requests_cooperate_with_a_fiber_scheduler
    server = TCPServer.new("127.0.0.1", 0)
    server_thread = Thread.new do
      # Neither request can finish until both have reached the server. If the
      # first request blocks the scheduler's thread, this test times out.
      connections = 2.times.map { server.accept }
      connections.each do |socket|
        socket.gets
        loop do
          line = socket.gets
          break if line.nil? || line == "\r\n"
        end
      end

      body = "{\"ok\":true}"
      connections.each do |socket|
        socket.write(
          "HTTP/1.1 200 OK\r\nContent-Type: application/json\r\n" \
            "Content-Length: #{body.bytesize}\r\nConnection: close\r\n\r\n#{body}"
        )
      end

    ensure
      connections&.each do |socket|
        socket.close
      rescue IOError
        nil
      end
    end

    http_client = OpenAI::NetHTTPClient.new(size: 2)
    port = server.local_address.ip_port
    client = OpenAI::Client.new(
      api_key: "test-key",
      base_url: "http://127.0.0.1:#{port}",
      timeout: 2,
      max_retries: 0,
      http_client: http_client
    )

    responses = Async do |task|
      2
        .times
        .map do
          task.async { client.request(method: :get, path: "probe") }
        end
        .map(&:wait)
    end
      .wait

    assert_equal([{ok: true}, {ok: true}], responses)
    server_thread.value
  ensure
    http_client&.close
    server&.close
    server_thread&.kill if server_thread&.alive?
  end
end
