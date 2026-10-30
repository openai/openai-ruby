# frozen_string_literal: true
require "async/http/server"
require "async/websocket/adapters/http"
require "io/endpoint/bound_endpoint"

require_relative "../test_helper"

class OpenAI::Test::WebSocketHTTPPolicyTest < Minitest::Test
  extend Minitest::Serial

  ENTRYPOINTS = {
    realtime: -> (client, options, &block) { client.realtime.connect(model: "gpt-realtime-2.1", **options, &block) },
    transcription: -> (client, options, &block) { client.realtime.connect_transcription(**options, &block) },
    realtime_sideband: -> (client, options, &block) {
      client.realtime.connect_to_call(call_id: "call_test", **options, &block)
    },
    translation: -> (client, options, &block) {
      client.realtime.connect_translation(model: "gpt-realtime-translate", **options, &block)
    },
    generated_translation: -> (client, options, &block) {
      client.realtime.translations.connect(query: {model: "gpt-realtime-translate"}, **options, &block)
    },
    live: -> (client, options, &block) { client.live.connect(**options, &block) },
    live_sideband: -> (client, options, &block) { client.live.sideband.connect("sess_test", **options, &block) },
    live_fork: -> (client, options, &block) { client.live.forks.connect("sess_test", **options, &block) }
  }.freeze

  def test_each_endpoint_rejects_http_only_policy_before_credentials
    with_server do |client, arrivals|
      identity = OpenAI::Auth::WorkloadIdentity.new(
        identity_provider_id: "idp_test",
        service_account_id: "sa_test",
        provider: OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(token_path: "/never-read")
      )
      http = OpenAI::NetHTTPClient.new { |_| flunk("HTTP policy cannot be used by WebSockets") }
      configured = client
        .with_options(api_key: nil, workload_identity: identity, http_client: http)
        .with_options(timeout: 2)
      attempted = []
      token_reads = 0
      configured.workload_identity_auth.stub(
        :get_token,
        -> (**_options) {
          token_reads += 1
          "test_token"
        }
      ) do
        ENTRYPOINTS.each do |name, connect|
          rejection = nil
          begin
            connect.call(configured, {}) { |_connection| nil }
          rescue ArgumentError => error
            rejection = error
          end

          attempted << name unless rejection
        end
      end

      assert_empty(attempted)
      assert_equal(0, token_reads)
      assert_empty(arrivals)
    end
  end

  def test_invalid_explicit_transport_still_rejects_before_credentials
    with_server do |client, arrivals|
      identity = OpenAI::Auth::WorkloadIdentity.new(
        identity_provider_id: "idp_test",
        service_account_id: "sa_test",
        provider: OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(token_path: "/never-read")
      )
      http = OpenAI::NetHTTPClient.new { |_| flunk("unexpected HTTP policy use") }
      configured = client.with_options(api_key: nil, workload_identity: identity, http_client: http)
      configured.workload_identity_auth.stub(:get_token, -> (**_options) { flunk("unexpected token read") }) do
        ENTRYPOINTS.each_value do |connect|
          rejection = assert_raises(ArgumentError) do
            connect.call(configured, {transport: Object.new}) { flunk("invalid transport yielded") }
          end

          assert_match(/transport.*must respond to.*open/, rejection.message)
        end
      end

      assert_empty(arrivals)
    end
  end

  def test_explicit_transport_keeps_separate_http_policy_for_all_endpoints
    with_server do |client, arrivals|
      configured = client.with_options(
        http_client: OpenAI::NetHTTPClient.new { |_| flunk("unexpected HTTP policy use") }
      )
      transport = OpenAI::Realtime::Transports::AsyncWebSocket.new
      reached = []
      ENTRYPOINTS.each do |name, connect|
        connect.call(configured, {transport: transport}) { reached << name }
      end

      assert_equal(ENTRYPOINTS.keys, reached)
      assert_equal(ENTRYPOINTS.length, arrivals.length)
    end
  end

  def test_default_and_reset_copies_keep_default_transport_for_all_endpoints
    with_server do |client, arrivals|
      http = OpenAI::NetHTTPClient.new { |_| flunk("reset client retained HTTP policy") }
      clients = [client.with_options(timeout: 2), client.with_options(http_client: http).with_options(http_client: nil)]
      reached = []
      clients.each do |copy|
        ENTRYPOINTS.each do |name, connect|
          connect.call(copy, {}) { reached << name }
        end
      end

      assert_equal(ENTRYPOINTS.keys * 2, reached)
      assert_equal(ENTRYPOINTS.length * 2, arrivals.length)
    end
  end

  private def with_server
    Sync do |task|
      task.with_timeout(8) do
        endpoint = Async::HTTP::Endpoint.parse("http://127.0.0.1:0")
        bound = endpoint.bound
        arrivals = []
        app = lambda do |request|
          arrivals << request.path
          Async::WebSocket::Adapters::HTTP.open(request) { |socket| socket.read }
        end

        server = Async::HTTP::Server.new(app, bound, protocol: endpoint.protocol, scheme: endpoint.scheme)
        server_task = server.run
        client = OpenAI::Client.new(
          api_key: "test-key",
          base_url: "http://127.0.0.1:#{bound.sockets.first.local_address.ip_port}/v1"
        )
        yield(client, arrivals)
        task.yield
      ensure
        server_task&.stop
        bound&.close
      end
    end
  end
end
