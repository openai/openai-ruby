# frozen_string_literal: true

require_relative "../responses_websocket/connection_test_support"

class OpenAI::Test::WebSocketBindingTest < Minitest::Test
  include OpenAI::Test::ResponsesWebSocketConnectionTestSupport

  class Resource
    include OpenAI::WebSocket::Resource

    def initialize(client:) = @client = client

    def __websocket_request(workspace, query: {})
      {method: :get, path: ["telemetry/%1$s", workspace], query: query, security: {bearer_auth: true}}
    end

    def __websocket_client_event = OpenAI::Realtime::RealtimeClientEvent
    def __websocket_server_event = OpenAI::Realtime::RealtimeServerEvent
  end

  class HookClient < OpenAI::Client
    attr_reader :prepared

    private def prepare_request(request, **options)
      @prepared = (@prepared || 0) + 1
      super.merge(headers: request.fetch(:headers).merge("x-request-hook" => "called"))
    end
  end

  class SingleEventResource < Resource
    def __websocket_client_event = OpenAI::Realtime::RealtimeTranslationSessionCloseEvent
  end

  class OpenClientEvent < OpenAI::Internal::Type::BaseModel
    required :type, String
  end

  def test_open_and_absent_client_codecs_preserve_unknown_outbound_events
    [nil, OpenClientEvent].each do |client_event|
      socket = FakeSocket.new
      connection = OpenAI::WebSocket::TypedConnection.new(
        socket: socket,
        url: URI("wss://example.test"),
        client_event: client_event,
        server_event: nil
      )
      connection.send_event(type: "future.command")
      connection.close
      assert_equal([{"type" => "future.command"}], socket.writes.map { JSON.parse(_1) })
      assert(socket.closed?)
    end
  end

  def test_all_generated_bindings_resolve_their_event_codecs
    resources = [
      client.responses,
      client.realtime,
      client.realtime.translations,
      client.live,
      client.live.sideband,
      client.live.forks
    ]
    resources.each do |resource|
      socket = FakeSocket.new("{\"type\":\"future.event\"}")
      connection = OpenAI::WebSocket::TypedConnection.new(
        socket: socket,
        url: URI("wss://example.test"),
        client_event: resource.__websocket_client_event,
        server_event: resource.__websocket_server_event
      )
      assert_equal({type: "future.event"}, connection.receive)
      connection.close
      assert(socket.closed?)
    end
  end

  def test_invalid_discriminators_do_not_write_or_poison_union_and_single_model_connections
    resources = [client.realtime.translations, SingleEventResource.new(client: client)]
    resources.each do |resource|
      socket = FakeSocket.new
      arguments = resource.is_a?(SingleEventResource) ? ["one"] : []
      resource.connect(*arguments, transport: FakeTransport.new(socket)) do |connection|
        invalid_events = [
          {},
          {type: nil},
          {type: 123},
          {"type" => false},
          {type: []},
          {type: "session.clsoe"},
          {type: :future_command},
          {:type => "future.event", "type" => 123},
          {"type" => "session.close", :type => nil}
        ]
        invalid_events.each do |event|
          error = assert_raises(ArgumentError) { connection.send_event(event) }
          assert_nil(error.cause)
          assert_empty(socket.writes)
        end

        connection.send_event("type" => "session.close")
        connection.send_event(type: :"session.close")
        connection.send_event(OpenAI::Realtime::RealtimeTranslationSessionCloseEvent.new)
      end

      assert_equal([{type: "session.close"}] * 3, socket.writes.map { JSON.parse(_1, symbolize_names: true) })
      assert(socket.closed?)
    end
  end

  def test_generic_connection_supports_no_block_iteration
    socket = FakeSocket.new("{\"type\":\"future.one\"}", "{\"type\":\"future.two\"}")
    Resource.new(client: client).connect("one", transport: FakeTransport.new(socket)) do |connection|
      assert_instance_of(Enumerator, connection.each)
      assert_equal(["future.one", "future.two"], connection.map { _1.fetch(:type) })
    end

    assert(socket.closed?)
  end

  def test_generated_binding_uses_client_policy_and_shared_lifecycle
    client = HookClient.new(api_key: "synthetic-key", base_url: "https://example.test/v1")
    socket = FakeSocket.new(
      "{\"type\":\"rate_limits.updated\",\"event_id\":\"synthetic-event\",\"rate_limits\":[]}",
      "{\"type\":\"future.event\",\"value\":1}"
    )
    transport = FakeTransport.new(socket)
    Resource.new(client: client).connect("space/one", query: {mode: "sample"}, transport: transport) do |connection|
      connection.send_event(type: "response.cancel")
      assert_equal(:"rate_limits.updated", connection.receive.type)
      assert_equal({type: "future.event", value: 1}, connection.receive)
      refute(connection.closed?)
    end

    assert_equal("wss://example.test/v1/telemetry/space%2Fone?mode=sample", transport.open_args.fetch(:url).to_s)
    assert_equal("Bearer synthetic-key", transport.open_args.dig(:headers, "authorization"))
    assert_equal("called", transport.open_args.dig(:headers, "x-request-hook"))
    assert_equal(1, client.prepared)
    assert_equal([{type: "response.cancel"}], socket.writes.map { JSON.parse(_1, symbolize_names: true) })
    assert(socket.closed?)
  end

  def test_uncertain_write_is_not_replayed_and_failed_socket_is_aborted
    client = OpenAI::Client.new(api_key: "synthetic-key")
    socket = FailingWriteSocket.new
    Resource.new(client: client).connect("one", transport: FakeTransport.new(socket)) do |connection|
      error = assert_raises(OpenAI::Errors::WebSocketConnectionError) do
        connection.send_event(type: "response.cancel")
      end

      refute_includes(error.full_message, "sensitive-body")
      assert_raises(OpenAI::Errors::WebSocketConnectionError) do
        connection.send_event(type: "response.cancel")
      end
    end

    assert(socket.aborted?)
  end

  def test_block_exception_wins_and_aborts_the_connection
    client = OpenAI::Client.new(api_key: "synthetic-key")
    socket = FakeSocket.new
    error = assert_raises(RuntimeError) do
      Resource.new(client: client).connect("one", transport: FakeTransport.new(socket)) { raise "caller error" }
    end

    assert_equal("caller error", error.message)
    assert(socket.aborted?)
  end

  def test_custom_transport_failure_is_sanitized
    transport = FakeTransport.new(FakeSocket.new)
    failure = -> (**_options) { raise IOError, "synthetic-sensitive-request" }
    error = transport.stub(:open, failure) do
      assert_raises(OpenAI::WebSocket::BindingConnectionError) do
        Resource.new(client: client).connect("one", transport: transport) { flunk("unexpected connection") }
      end
    end

    assert_nil(error.cause)
    refute_includes(error.full_message, "synthetic-sensitive-request")
  end

  def test_custom_transport_failure_preserves_status_for_credential_refresh
    configured = workload_identity_client
    transport = RejectOnceTransport.new
    tokens = ["synthetic-stale", "synthetic-fresh"]
    invalidations = 0
    get_token = -> (deadline:) {
      refute_nil(deadline)
      tokens.shift
    }
    configured.workload_identity_auth.stub(:get_token, get_token) do
      configured.workload_identity_auth.stub(:invalidate_token, -> { invalidations += 1 }) do
        Resource.new(client: configured).connect("one", transport: transport) { |_connection| nil }
      end
    end

    assert_equal(1, invalidations)
    assert_equal(2, transport.attempts.length)
    assert_equal("Bearer synthetic-stale", transport.attempts.first.dig(:headers, "authorization"))
    assert_equal("Bearer synthetic-fresh", transport.attempts.last.dig(:headers, "authorization"))
  end

  def test_cyclic_event_is_rejected_without_writing_or_poisoning_the_connection
    socket = FakeSocket.new
    extension = {}
    event = OpenAI::Realtime::ResponseCancelEvent.new(extension: extension)
    extension[:cycle] = event
    Resource.new(client: client).connect("one", transport: FakeTransport.new(socket)) do |connection|
      error = assert_raises(ArgumentError) { connection.send_event(event) }
      assert_nil(error.cause)
      assert_empty(socket.writes)
      connection.send_event(type: "response.cancel")
    end

    assert_equal([{type: "response.cancel"}], socket.writes.map { JSON.parse(_1, symbolize_names: true) })
  end

  def test_deep_event_extensions_preserve_the_existing_json_nesting_policy
    extension = 120.times.reduce("leaf") { |value, _| {nested: value} }
    server_event = {type: "future.event", extension: extension}
    socket = FakeSocket.new(JSON.generate(server_event, max_nesting: false))
    Resource.new(client: client).connect("one", transport: FakeTransport.new(socket)) do |connection|
      connection.send_event(OpenAI::Realtime::ResponseCancelEvent.new(extension: extension))
      assert_equal(server_event, connection.receive)
    end

    assert_equal(
      [{type: "response.cancel", extension: extension}],
      socket.writes.map { JSON.parse(_1, symbolize_names: true, max_nesting: false) }
    )
    assert(socket.closed?)
  end

  class SingleServerEventResource < Resource
    def __websocket_server_event = OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent
  end

  def test_inbound_native_parser_stack_failure_is_sanitized_without_poisoning_connection
    levels = 100_000
    json = "{\"type\":\"future.event\",\"data\":" + ("[" * levels) + "\"private-payload\"" + ("]" * levels) + "}"
    socket = FakeSocket.new(json, "{\"type\":\"future.forced\"}", "{\"type\":\"future.next\"}")
    Resource.new(client: client).connect("one", transport: FakeTransport.new(socket)) do |connection|
      begin
        event = connection.receive
        data = event.fetch(:data)
        levels.times { data = data.first }
        assert_equal("private-payload", data)
      rescue OpenAI::Errors::WebSocketProtocolError => error
        assert_nil(error.cause)
        refute_includes(error.full_message, "private-payload")
      end

      JSON.stub(:parse, -> (*) { raise SystemStackError, "private-payload" }) do
        error = assert_raises(OpenAI::Errors::WebSocketProtocolError) { connection.receive }
        assert_nil(error.cause)
        refute_includes(error.full_message, "private-payload")
      end

      assert_equal({type: "future.next"}, connection.receive)
    end

    assert(socket.closed?)
  end

  def test_inbound_renamed_field_collisions_cannot_overwrite_typed_values
    resources = [client.realtime.translations, SingleServerEventResource.new(client: client)]
    resources.each do |resource|
      audio = {type: "session.output_audio.delta", event_id: "a1", delta: "AA==", format: "pcm16"}
      socket = FakeSocket.new(
        JSON.generate(audio.merge(format_: "private-payload")),
        JSON.generate(audio.merge(format_: "pcm16")),
        JSON.generate(audio.merge(future_audio_field: "keep")),
        JSON.generate(type: "future.event", format_: "keep")
      )
      arguments = resource.is_a?(SingleServerEventResource) ? ["one"] : []
      resource.connect(*arguments, transport: FakeTransport.new(socket)) do |connection|
        2.times do
          error = assert_raises(OpenAI::Errors::WebSocketProtocolError) { connection.receive }
          assert_nil(error.cause)
          refute_includes(error.full_message, "private-payload")
        end

        event = connection.receive
        assert_equal(:pcm16, event.format_)
        assert_equal("keep", event.to_h.fetch(:future_audio_field))
        assert_equal({type: "future.event", format_: "keep"}, connection.receive)
      end

      assert(socket.closed?)
    end
  end
end
