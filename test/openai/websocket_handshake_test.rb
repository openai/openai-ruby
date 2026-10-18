# frozen_string_literal: true

require_relative "test_helper"
require "async/http/server"
require "async/websocket/server"
require "async/websocket/adapters/http"
require "socket"
require "timeout"

class OpenAI::Test::WebSocketHandshakeTest < Minitest::Test
  extend Minitest::Serial

  CONNECTIONS = {
    responses: ->(client, options, &block) do
      client.responses.connect(request_options: options, &block)
    end,
    realtime: ->(client, options, &block) do
      client.realtime.connect(model: "test", request_options: options, &block)
    end,
    translation: ->(client, options, &block) do
      client.realtime.connect_translation(
        model: "test",
        request_options: options,
        &block
      )
    end,
    live: ->(client, options, &block) do
      client.live.connect(request_options: options, &block)
    end,
    fork: ->(client, options, &block) do
      client.live.forks.connect("test", request_options: options, &block)
    end,
    sideband: ->(client, options, &block) do
      client.live.sideband.connect("test", request_options: options, &block)
    end
  }.freeze

  CONNECTIONS.each do |name, connect|
    define_method("test_#{name}_rejects_cross_origin_redirect") do
      source_headers = []
      target_hits = []
      with_server(
        ->(request) do
          target_hits << request
          Protocol::HTTP::Response[400, {}, []]
        end
      ) do |target|
        redirect =
          lambda do |request|
            source_headers << request.headers["authorization"]
            Protocol::HTTP::Response[
              307,
              { "location" => "#{target}/final" },
              []
            ]
          end
        with_server(redirect) do |origin|
          client =
            OpenAI::Client.new(
              api_key: "fake-wire-key",
              base_url: "#{origin}/v1",
              timeout: 2
            )
          assert_raises(OpenAI::Errors::Error) do
            connect.call(client, {}) { flunk("redirect connected") }
          end
        end
      end
      assert_equal(["Bearer fake-wire-key"], source_headers)
      assert_empty(target_hits)
    end

    define_method("test_#{name}_selected_credentials_and_cleanup") do
      headers = []
      closed = Queue.new
      websocket =
        Async::WebSocket::Server.new(
          ->(_) { Protocol::HTTP::Response[404, {}, []] }
        ) do |socket|
          socket.write('{"type":"future.event","marker":42}')
          socket.flush
          socket.read
        rescue EOFError
          # Live cleanup may abort after the caller leaves its block.
        ensure
          closed << true
        end
      app =
        lambda do |request|
          headers << request.headers["authorization"]
          websocket.call(request)
        end
      with_server(app) do |origin|
        client =
          OpenAI::Client.new(
            api_key: "fake-client-key",
            base_url: "#{origin}/v1",
            timeout: 2
          )
        [nil, "Bearer fake-selected"].each do |selected|
          options =
            selected ? { extra_headers: { "Authorization" => selected } } : {}
          connect.call(client, options) do |connection|
            event = connection.receive
            assert_equal("future.event", event.type.to_s)
          end
          assert(Timeout.timeout(5) { closed.pop })
        end
      end
      assert_equal(["Bearer fake-client-key", "Bearer fake-selected"], headers)
    end
  end

  # Realtime and Live support one workload-token refresh after a rejected upgrade.
  %i[realtime live fork sideband].each do |name|
    define_method("test_#{name}_refreshes_after_rejected_wire_handshake") do
      headers = []
      closed = Queue.new
      websocket =
        Async::WebSocket::Server.new(
          ->(_) { Protocol::HTTP::Response[404, {}, []] }
        ) do |socket|
          socket.write('{"type":"future.event"}')
          socket.flush
          socket.read
        rescue EOFError
          # Live cleanup may abort after the caller leaves its block.
        ensure
          closed << true
        end
      app =
        lambda do |request|
          headers << request.headers["authorization"]
          if headers.length == 1
            Protocol::HTTP::Response[401, {}, []]
          else
            websocket.call(request)
          end
        end
      with_server(app) do |origin|
        provider =
          OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
            token_path: "/not-read"
          )
        identity =
          OpenAI::Auth::WorkloadIdentity.new(
            provider: provider,
            identity_provider_id: "fake-idp",
            service_account_id: "fake-service"
          )
        client =
          OpenAI::Client.new(
            api_key: nil,
            workload_identity: identity,
            base_url: "#{origin}/v1",
            timeout: 2
          )
        tokens = %w[fake-expired fake-refreshed]
        invalidations = 0
        client
          .workload_identity_auth
          .stub(
            :get_token,
            ->(deadline:) do
              refute_nil(deadline)
              tokens.shift
            end
          ) do
            client
              .workload_identity_auth
              .stub(:invalidate_token, -> { invalidations += 1 }) do
                CONNECTIONS
                  .fetch(name)
                  .call(client, {}) do |connection|
                    assert_equal("future.event", connection.receive.type.to_s)
                  end
              end
          end
        assert_equal(1, invalidations)
        assert(Timeout.timeout(5) { closed.pop })
      end
      assert_equal(["Bearer fake-expired", "Bearer fake-refreshed"], headers)
    end
  end

  private def with_server(app)
    port = TCPServer.open("127.0.0.1", 0) { |socket| socket.addr[1] }
    origin = "http://127.0.0.1:#{port}"
    endpoint = Async::HTTP::Endpoint.parse(origin)
    server = Async::HTTP::Server.new(app, endpoint)
    Sync do |task|
      serving = task.async { server.run.wait }
      yield origin
    ensure
      serving&.stop
    end
  end
end
