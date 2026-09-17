# frozen_string_literal: true

require "async/http/server"
require "async/websocket/adapters/http"
require "async/websocket/server"
require "io/endpoint/bound_endpoint"

require_relative "../test_helper"

class OpenAI::Test::ResponsesWebSocketContractTest < Minitest::Test
  extend Minitest::Serial

  SCENARIOS = JSON.parse(File.read(File.join(__dir__, "fixtures/websocket_scenarios.json"))).fetch("scenarios")
  EVENT_TYPES = {
    "response.created" => OpenAI::Responses::ResponsesServerEvent::ResponseWsCreated,
    "response.completed" => OpenAI::Responses::ResponsesServerEvent::ResponseWsCompleted,
    "response.failed" => OpenAI::Responses::ResponsesServerEvent::ResponseWsFailed,
    "response.incomplete" => OpenAI::Responses::ResponsesServerEvent::ResponseWsIncomplete,
    "response.output_text.delta" => OpenAI::Responses::ResponsesServerEvent::ResponseTextWsDelta,
    "error" => OpenAI::Responses::ResponsesServerEvent::ResponseWsError
  }.freeze

  SCENARIOS.each do |scenario|
    define_method("test_#{scenario.fetch("id")}") do
      with_server(scenario) do |client|
        client.responses.connect(request_options: {extra_headers: {"X-Contract-Test" => "synthetic"}}) do |connection|
          scenario.fetch("turns").each do |turn|
            request = turn.fetch("request").reject { |key, _| key == "type" }
            connection.response.create(**request)
            turn.fetch("frames").each do |frame|
              if frame.is_a?(String)
                assert_raises(OpenAI::Errors::ResponsesProtocolError) { connection.receive }
              else
                event = connection.receive
                expected_type = EVENT_TYPES.fetch(frame.fetch("type"), OpenAI::Responses::UnknownServerEvent)
                assert_instance_of(expected_type, event)
                assert_equal(frame, JSON.parse(JSON.generate(event.to_h)))
              end
            end
          end

          case scenario["close_code"]
          when 1000
            assert_nil(connection.receive)
          when 1011
            assert_raises(OpenAI::Errors::ResponsesConnectionError) { connection.receive }
          end

          connection.close
          connection.close
        end
      end
    end
  end

  private def with_server(scenario)
    Sync do |task|
      task.with_timeout(10) do
        endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:0")
        bound = endpoint.bound
        port = bound.sockets.first.local_address.ip_port
        failures = []
        connections = 0
        requests = 0
        handler = lambda do |request|
          connections += 1
          assert_equal("/v1/responses", request.path)
          assert_equal("Bearer fake-contract-key", request.headers["authorization"])
          assert_equal(["synthetic"], request.headers["x-contract-test"])
          Async::WebSocket::Adapters::HTTP.open(request) do |socket|
            scenario.fetch("turns").each do |turn|
              assert_equal(turn.fetch("request"), JSON.parse(socket.read.to_str))
              requests += 1
              turn.fetch("frames").each do |frame|
                socket.write(Protocol::WebSocket::TextMessage.new(frame.is_a?(String) ? frame : JSON.generate(frame)))
                socket.flush
              end
            end

            if scenario.key?("close_code")
              socket.close(scenario.fetch("close_code"), "synthetic close")
            else
              assert_nil(socket.read)
            end

          rescue StandardError, Minitest::Assertion => error
            failures << error
          end
        end

        server = Async::HTTP::Server.new(handler, bound, protocol: endpoint.protocol, scheme: endpoint.scheme)
        server_task = server.run
        client = OpenAI::Client.new(api_key: "fake-contract-key", base_url: "http://127.0.0.1:#{port}/v1")
        yield(client)
        assert_empty(failures)
        assert_equal(1, connections)
        assert_equal(scenario.fetch("turns").length, requests)
      ensure
        server_task&.stop
        bound&.close
      end
    end
  end
end
