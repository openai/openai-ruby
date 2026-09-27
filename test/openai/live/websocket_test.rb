# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../responses_websocket/connection_test_support"
require "open3"

class OpenAI::Test::LiveWebSocketTest < Minitest::Test
  include OpenAI::Test::ResponsesWebSocketConnectionTestSupport

  def test_primary_enters_without_sending_or_waiting_and_cleans_up
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)
    returned = client.live.connect(transport: transport) do |connection|
      assert_instance_of(OpenAI::Live::Connection, connection)
      assert_empty(socket.writes)
      refute(connection.closed?)
      :result
    end

    assert_equal(:result, returned)
    assert_equal({code: 1000, reason: ""}, socket.close_args)
    refute(socket.aborted?)
    assert_equal("wss://example.com/v1/live/sessions", transport.open_args.fetch(:url).to_s)
    assert_equal("Bearer test-key", transport.open_args.fetch(:headers).fetch("authorization"))
  end

  def test_typed_startup_and_session_terminal_are_visible
    socket = FakeSocket.new(
      JSON.generate(
        type: "session.started",
        event_id: "evt_started",
        session: {id: "sess_1", model: "gpt-live-1", expires_at: 2000000000, status: "active"}
      ),
      JSON.generate(
        type: "error",
        event_id: "evt_error",
        error: {type: "server_error", code: "session_storage_failed", message: "not stored"}
      ),
      JSON.generate(
        type: "session.closed",
        event_id: "evt_closed",
        reason: "close_requested",
        session: {id: "sess_1", model: "gpt-live-1", expires_at: 2000000000, status: "active"},
        usage: {seconds: 0}
      )
    )
    client.live.connect(transport: FakeTransport.new(socket)) do |connection|
      connection.send_event(OpenAI::Live::SessionStartEvent.new(session: {model: "gpt-live-1", store: false}))
      assert_equal(
        {"type" => "session.start", "session" => {"model" => "gpt-live-1", "store" => false}},
        JSON.parse(socket.writes.fetch(0))
      )
      started = connection.receive
      assert_instance_of(OpenAI::Live::SessionStartedEvent, started)
      assert_equal("sess_1", started.session.id)
      connection.send_event(type: "session.close")
      observed = connection.each.to_a
      assert_equal([OpenAI::Live::ErrorEvent, OpenAI::Live::SessionClosedEvent], observed.map(&:class))
      assert_equal("session_storage_failed", observed.fetch(0).error.code)
    end

    assert_equal(2, socket.writes.size)
  end

  def test_raw_future_events_and_nested_future_response_are_preserved
    socket = FakeSocket.new(
      JSON.generate(type: "session.future", opaque: {payload: ["private value"]}),
      JSON.generate(
        type: "response.event",
        event_id: "event_1",
        delegation_id: "delegation_1",
        event: {type: "response.future", sequence_number: 1, delta: "future text"}
      ),
      JSON.generate(
        type: "session.input_transcript.delta",
        event_id: "transcript_1",
        delta: "Hello",
        start_ms: 0,
        end_ms: 150,
        extra_field: "kept"
      )
    )
    client.live.connect(transport: FakeTransport.new(socket)) do |connection|
      future = connection.receive
      assert_instance_of(OpenAI::Live::UnknownServerEvent, future)
      assert_equal(:"session.future", future.type)
      assert_equal(["private value"], future.data.fetch(:opaque).fetch(:payload))
      assert(future.data.fetch(:opaque).fetch(:payload).frozen?)
      refute_includes(future.inspect, "private value")
      nested = connection.receive
      assert_instance_of(OpenAI::Live::ResponseEvent, nested)
      assert_equal("delegation_1", nested.delegation_id)
      assert_equal("response.future", nested.to_h.fetch(:event).fetch(:type).to_s)
      transcript = connection.receive
      assert_instance_of(OpenAI::Live::InputTranscriptDeltaEvent, transcript)
      assert_equal("kept", transcript.to_h.fetch(:extra_field))
    end
  end

  def test_invalid_envelopes_fail_without_leaking_payload
    [
      "{\"private\":\"payload\"}",
      "[\"private-payload\"]",
      "{\"type\":true,\"secret\":\"private-payload\"}",
      "invalid private-payload"
    ].each do |data|
      socket = FakeSocket.new(data)
      error = assert_raises(OpenAI::Errors::LiveProtocolError) do
        client.live.connect(transport: FakeTransport.new(socket), &:receive)
      end

      refute_includes(error.full_message, "private-payload")
      assert(socket.aborted?)
    end
  end

  def test_known_events_need_required_fields_before_they_can_confirm_startup
    [
      {type: "session.started"},
      {type: "session.started", event_id: "evt_1", session: {id: "private-payload"}},
      {type: "session.input_transcript.delta", event_id: "evt_1", delta: "private-payload"}
    ].each do |payload|
      socket = FakeSocket.new(JSON.generate(payload))
      error = assert_raises(OpenAI::Errors::LiveProtocolError) do
        client.live.connect(transport: FakeTransport.new(socket), &:receive)
      end

      assert_nil(error.cause)
      refute_includes(error.full_message, "private-payload")
      assert(socket.aborted?)
    end
  end

  def test_invalid_typed_sends_never_reach_the_wire_but_the_connection_remains_usable
    socket = FakeSocket.new
    client.live.connect(transport: FakeTransport.new(socket)) do |connection|
      [
        {type: "future.unknown", secret: "private-payload"},
        {"type" => "future.unknown", "secret" => "private-payload"},
        {type: "session.start", session: {instructions: "private-payload"}},
        OpenAI::Live::SessionStartEvent.new(session: {instructions: "private-payload"})
      ].each do |invalid|
        error = assert_raises(ArgumentError) { connection.send_event(invalid) }
        assert_nil(error.cause)
        refute_includes(error.full_message, "private-payload")
        assert_empty(socket.writes)
      end

      connection.send_event({"type" => "session.start", "session" => {"model" => "gpt-live-1"}})
      assert_equal("gpt-live-1", JSON.parse(socket.writes.fetch(0)).dig("session", "model"))
    end
  end

  def test_client_credentials_headers_and_transport_options_follow_existing_request_pipeline
    api = client(organization: "org_fake", project: "proj_fake")
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)
    api
      .live
      .connect(
        transport: transport,
        websocket_base_url: "https://local.example/custom",
        request_options: {
          extra_headers: {"Authorization" => "Bearer sk-test-override", "X-Custom" => "client-demo"},
          timeout: 7
        },
        transport_options: {some_option: 1}
      ) { |connection| connection.send_raw("{\"type\":\"session.start\",\"session\":{\"model\":\"gpt-live-1\"}}") }
    request = transport.open_args
    assert_equal("wss://local.example/custom/live/sessions", request.fetch(:url).to_s)
    assert_equal("Bearer sk-test-override", request.fetch(:headers).fetch("authorization"))
    assert_equal("client-demo", request.fetch(:headers).fetch("x-custom"))
    assert_equal("org_fake", request.fetch(:headers).fetch("openai-organization"))
    assert_equal("proj_fake", request.fetch(:headers).fetch("openai-project"))
    assert_equal(7, request.fetch(:timeout))
    assert_equal({some_option: 1}, request.fetch(:options))
  end

  def test_missing_block_and_reserved_transport_fields_rejected_before_opening
    transport = FakeTransport.new(FakeSocket.new)
    assert_raises(ArgumentError) { client.live.connect(transport: transport) }
    %i[headers hostname port protocol scheme ssl_context timeout url alpn_protocols].each do |reserved|
      assert_raises(ArgumentError) do
        client.live.connect(transport: transport, transport_options: {reserved => "no"}) { flunk }
      end
    end

    assert_nil(transport.open_args)
  end

  def test_url_must_not_embed_credentials_or_select_a_model_in_query
    transport = FakeTransport.new(FakeSocket.new)
    [
      "https://user:private-value@example.com",
      "wss://example.com/ws?model=gpt-live-1",
      "wss://example.com/#secret",
      "file:///tmp/private"
    ].each do |url|
      assert_raises(ArgumentError) do
        client.live.connect(transport: transport, websocket_base_url: url) { flunk }
      end
    end

    assert_raises(ArgumentError) do
      client.live.connect(transport: transport, request_options: {extra_query: {model: "gpt-live-1"}}) { flunk }
    end

    assert_nil(transport.open_args)
  end

  def test_abort_on_exception_preserves_original_error_and_early_exit_closes
    socket = FakeSocket.new
    error = RuntimeError.new("application failure")
    assert_same(
      error,
      assert_raises(RuntimeError) do
        client.live.connect(transport: FakeTransport.new(socket)) { raise error }
      end
    )
    assert(socket.aborted?)
    other = FakeSocket.new
    result = client.live.connect(transport: FakeTransport.new(other)) { break :early }
    assert_equal(:early, result)
    assert_equal({code: 1000, reason: ""}, other.close_args)
  end

  def test_rest_import_does_not_load_optional_websocket_gems
    code = <<~RUBY
      require "openai"
      abort "loaded async websocket" if $LOADED_FEATURES.any? { |name| name.include?("async/websocket") }
      client = OpenAI::Client.new(api_key: "fake")
      abort "existing REST lost" unless client.live.respond_to?(:create) && client.live.sessions.respond_to?(:fork)
      abort "missing connect" unless client.live.respond_to?(:connect)
    RUBY
    output, status = Open3.capture2e(RbConfig.ruby, "-Ilib", "-e", code)
    assert(status.success?, output)
  end

  def test_unsupported_provider_fails_before_using_its_credentials
    azure = OpenAI::Client.new(
      provider: OpenAI::Providers.azure(endpoint: "https://resource.openai.azure.com", api_key: "azure-test-key")
    )
    transport = FakeTransport.new(FakeSocket.new)
    error = assert_raises(OpenAI::Errors::Error) do
      azure.live.connect(transport: transport) { flunk }
    end

    assert_equal("Live WebSocket connections are not supported by providers.", error.message)
    assert_nil(transport.open_args)
  end

  def test_workload_token_refresh_is_limited_to_a_rejected_upgrade
    configured = workload_identity_client
    socket = FakeSocket.new
    attempts = []
    transport = Object.new
    transport.define_singleton_method(:open) do |url:, headers:, timeout:, **, &connection_block|
      attempts << {url: url, headers: headers, timeout: timeout}
      if attempts.one?
        raise OpenAI::Errors::LiveConnectionError.new(url: url, http_status: 401)
      end

      connection_block.call(socket)
    end

    tokens = ["stale-fake", "fresh-fake"]
    invalidations = 0
    configured.workload_identity_auth.stub(
      :get_token,
      -> (deadline:) {
        refute_nil(deadline)
        tokens.shift
      }
    ) do
      configured.workload_identity_auth.stub(:invalidate_token, -> { invalidations += 1 }) do
        configured.live.connect(transport: transport) { |_connection| nil }
      end
    end

    assert_equal(1, invalidations)
    assert_equal(
      ["Bearer stale-fake", "Bearer fresh-fake"],
      attempts.map { |request| request.fetch(:headers).fetch("authorization") }
    )
    assert(socket.closed?)
  end

  def test_post_upgrade_401_and_early_eof_never_reconnect_or_report_readiness
    configured = workload_identity_client
    socket = FakeSocket.new
    transport = FakeTransport.new(socket)
    invalidations = 0
    configured.workload_identity_auth.stub(
      :get_token,
      -> (deadline:) {
        refute_nil(deadline)
        "not-real-token"
      }
    ) do
      configured.workload_identity_auth.stub(:invalidate_token, -> { invalidations += 1 }) do
        assert_raises(OpenAI::Errors::LiveConnectionError) do
          configured.live.connect(transport: transport) do |connection|
            connection.send_event(type: "session.start", session: {model: "gpt-live-1"})
            assert_nil(connection.receive)
            raise OpenAI::Errors::LiveConnectionError.new(url: connection.url, http_status: 401)
          end
        end
      end
    end

    assert_equal(0, invalidations)
    assert_equal(1, socket.writes.size)
    assert(socket.aborted?)
  end
end
