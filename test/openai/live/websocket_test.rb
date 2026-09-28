# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../responses_websocket/connection_test_support"
require "open3"
require "timeout"

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

  def test_required_nullable_append_fields_must_be_present_but_may_be_nil
    socket = FakeSocket.new
    client.live.connect(transport: FakeTransport.new(socket)) do |connection|
      %w[instructions thinking commentary].each do |kind|
        type = "session.#{kind}.append"
        error = assert_raises(ArgumentError) { connection.send_event(type: type, content: "private-payload") }
        refute_includes(error.full_message, "private-payload")
        connection.send_event({"type" => type, "content" => "valid", "delegation_id" => nil})
        connection.send_event(type: type, content: "valid", delegation_id: "del_1")
      end
    end

    assert_equal([nil, "del_1"] * 3, socket.writes.map { JSON.parse(_1).fetch("delegation_id") })
  end

  def test_required_nullable_fields_in_selected_nested_models
    socket = FakeSocket.new
    client.live.connect(transport: FakeTransport.new(socket)) do |connection|
      tool = {type: "function", name: "lookup"}
      event = {type: "response.item.create", item: {type: "additional_tools", role: "developer", tools: [tool]}}
      error = assert_raises(ArgumentError) { connection.send_event(event) }
      refute_includes(error.full_message, "lookup")
      assert_empty(socket.writes)
      tool[:parameters] = nil
      tool[:strict] = nil
      connection.send_event(event)
      sent_tool = JSON.parse(socket.writes.fetch(0)).fetch("item").fetch("tools").first
      assert_nil(sent_tool.fetch("parameters"))
      assert_nil(sent_tool.fetch("strict"))
    end
  end

  def test_duplicate_string_and_symbol_keys_cannot_change_the_command_or_nested_data
    socket = FakeSocket.new
    client.live.connect(transport: FakeTransport.new(socket)) do |connection|
      [
        {:type => "session.close", "type" => "session.start", "session" => {"model" => "gpt-live-1"}},
        {type: "session.start", session: {:model => "gpt-live-1", "model" => "different-model"}},
        {type: "session.close", extra: [{:secret => "private-payload", "secret" => "other"}]}
      ].each do |event|
        error = assert_raises(ArgumentError) { connection.send_event(event) }
        refute_includes(error.full_message, "private-payload")
        assert_empty(socket.writes)
      end

      connection.send_event({"type" => "session.close"})
      assert_equal("session.close", JSON.parse(socket.writes.first).fetch("type"))
    end
  end

  def test_only_string_or_symbol_types_can_select_a_client_event
    impostor = Object.new
    impostor.define_singleton_method(:to_s) { "session.start" }
    socket = FakeSocket.new
    client.live.connect(transport: FakeTransport.new(socket)) do |connection|
      error = assert_raises(ArgumentError) { connection.send_event(type: impostor, secret: "private-payload") }
      assert_nil(error.cause)
      refute_includes(error.full_message, "private-payload")
      assert_empty(socket.writes)
      connection.send_event(type: :"session.close")
      assert_equal(1, socket.writes.size)
    end
  end

  def test_uncertain_write_cannot_be_replayed_on_later_sends_or_cleanup
    %i[typed raw].product([true, false]).each do |mode, explicit_close|
      socket = FakeSocket.new
      socket.define_singleton_method(:write) do |message|
        super(message)
        raise OpenAI::Errors::LiveConnectionError.new(url: URI("wss://example.com/v1/live/sessions"))
      end

      client.live.connect(transport: FakeTransport.new(socket)) do |connection|
        assert_raises(OpenAI::Errors::LiveConnectionError) do
          mode == :typed ? connection.send_event(type: "session.close") : connection.send_raw("{}")
        end

        assert(connection.closed?)
        assert_raises(OpenAI::Errors::LiveConnectionError) { connection.send_event(type: "session.close") }
        assert_raises(OpenAI::Errors::LiveConnectionError) { connection.send_raw("{}") }
        connection.close if explicit_close
      end

      assert_equal(1, socket.writes.size)
      assert(socket.aborted?)
      assert_nil(socket.close_args)
    end
  end

  def test_bad_utf8_preflight_does_not_poison_a_live_connection
    socket = FakeSocket.new
    client.live.connect(transport: FakeTransport.new(socket)) do |connection|
      assert_raises(ArgumentError) { connection.send_raw("\xFF".b) }
      refute(connection.closed?)
      assert_empty(socket.writes)
      connection.send_event(type: "session.close")
    end

    assert_equal(1, socket.writes.size)
    refute(socket.aborted?)
  end

  def test_custom_read_failures_are_safe_and_terminal_for_typed_or_raw_receive
    %i[receive receive_raw].each do |method|
      socket = FailingReadSocket.new
      client.live.connect(transport: FakeTransport.new(socket)) do |connection|
        error = assert_raises(OpenAI::Errors::LiveConnectionError) { connection.public_send(method) }
        assert_nil(error.cause)
        refute_includes(error.full_message, "sensitive-body")
        assert(connection.closed?)
        assert_raises(OpenAI::Errors::LiveConnectionError) { connection.send_event(type: "session.close") }
        assert_raises(OpenAI::Errors::LiveConnectionError) { connection.send_raw("{}") }
        assert_empty(socket.writes)
      end

      assert(socket.aborted?)
      assert_nil(socket.close_args)
    end
  end

  def test_peer_eof_closes_sends_even_if_the_transport_reports_open
    %i[receive receive_raw].each do |method|
      socket = FakeSocket.new
      client.live.connect(transport: FakeTransport.new(socket)) do |connection|
        assert_nil(connection.public_send(method))
        refute(socket.closed?)
        assert(connection.closed?)
        assert_nil(connection.receive)
        assert_raises(OpenAI::Errors::LiveConnectionError) { connection.send_event(type: "session.close") }
        assert_raises(OpenAI::Errors::LiveConnectionError) { connection.send_raw("{}") }
        assert_empty(socket.writes)
      end
    end
  end

  def test_clean_peer_eof_releases_the_socket_without_graceful_close_writes
    socket = FakeSocket.new
    socket.define_singleton_method(:close) { |**| raise IOError, "cannot write a close after EOF" }
    result = client.live.connect(transport: FakeTransport.new(socket)) do |connection|
      assert_nil(connection.receive)
      :completed
    end

    assert_equal(:completed, result)
    assert_predicate(socket, :closed?)
    assert_predicate(socket, :aborted?)
    assert_nil(socket.close_args)
  end

  def test_custom_socket_state_probe_errors_are_sanitized_before_direct_or_send_use
    socket = FakeSocket.new
    socket.define_singleton_method(:closed?) { raise IOError, "private-payload" }
    transport = FakeTransport.new(socket)
    client.live.connect(transport: transport) do |connection|
      error = assert_raises(OpenAI::Errors::LiveConnectionError) { connection.closed? }
      assert_nil(error.cause)
      refute_includes(error.full_message, "private-payload")
      assert_predicate(connection, :closed?)
      assert_raises(OpenAI::Errors::LiveConnectionError) { connection.send_raw("{}") }
      assert_empty(socket.writes)
      # Cleanup must not replace the caller's error with a raw probe failure.
      raise "caller abort"
    end

  rescue RuntimeError => error
    assert_equal("caller abort", error.message)
  end

  def test_send_probe_failure_has_no_payload_even_when_cleanup_fails_too
    socket = FakeSocket.new
    socket.define_singleton_method(:closed?) { raise IOError, "private-payload" }
    error = assert_raises(OpenAI::Errors::LiveConnectionError) do
      client.live.connect(transport: FakeTransport.new(socket)) { |connection|
        connection.send_event(type: "session.close")
      }
    end

    assert_nil(error.cause)
    refute_includes(error.full_message, "private-payload")
    assert_empty(socket.writes)
  end

  def test_direct_unknown_event_construction_freezes_cyclic_and_prefrozen_containers
    data = {type: "session.future", child: ["private-payload"]}
    array = data.fetch(:child)
    array << data
    array << array
    leaf = ["mutable"]
    data[:prefrozen] = {leaf: leaf}.freeze
    event = Timeout.timeout(2) { OpenAI::Live::UnknownServerEvent.new(data: data) }
    assert_equal(:"session.future", event.type)
    assert_same(data, event.to_h)
    assert_predicate(data, :frozen?)
    assert_predicate(array, :frozen?)
    assert_predicate(leaf, :frozen?)
    assert_predicate(leaf.first, :frozen?)
    refute_includes(event.inspect, "private-payload")
  end

  def test_unknown_event_string_keys_keep_their_original_shape
    source = {"type" => "session.future", "data" => ["private-payload"]}
    event = OpenAI::Live::UnknownServerEvent.new(data: source)
    assert_equal(:"session.future", event.type)
    assert_same(source, event.data)
    assert_equal(["private-payload"], event.to_h.fetch("data"))
    assert_predicate(event.data.fetch("data"), :frozen?)
    refute_includes(event.inspect, "private-payload")
  end

  def test_custom_cleanup_failures_are_sanitized_and_do_not_replace_application_errors
    %i[close abort].each do |method|
      socket = FakeSocket.new
      socket.define_singleton_method(method) { |**| raise IOError, "private-payload" }
      error = assert_raises(OpenAI::Errors::LiveConnectionError) do
        client.live.connect(transport: FakeTransport.new(socket)) do |connection|
          if method == :abort
            socket.define_singleton_method(:write) { |*| raise IOError, "write-private-payload" }
            assert_raises(OpenAI::Errors::LiveConnectionError) { connection.send_event(type: "session.close") }
          end
        end
      end

      assert_nil(error.cause)
      refute_includes(error.full_message, "private-payload")
    end

    socket = FakeSocket.new
    socket.define_singleton_method(:abort) { raise IOError, "private-payload" }
    original = RuntimeError.new("application failure")
    error = assert_raises(RuntimeError) do
      client.live.connect(transport: FakeTransport.new(socket)) { raise original }
    end

    assert_same(original, error)
  end

  def test_cyclic_invalid_events_are_rejected_and_shared_valid_values_are_allowed
    hash = {type: "session.close", content: "private-payload"}
    hash[:extra] = hash
    array = ["private-payload"]
    array << array
    model = OpenAI::Live::SessionCloseEvent.new
    model.to_h[:extra] = model
    shared = {content: ["some text"]}
    socket = FakeSocket.new
    client.live.connect(transport: FakeTransport.new(socket)) do |connection|
      [hash, {type: "session.close", extra: array}, model].each do |invalid|
        error = assert_raises(ArgumentError) { connection.send_event(invalid) }
        assert_nil(error.cause)
        refute_includes(error.full_message, "private-payload")
        assert_empty(socket.writes)
      end

      connection.send_event(type: "session.close", first: shared, second: shared)
      payload = JSON.parse(socket.writes.fetch(0))
      assert_equal(payload.fetch("first"), payload.fetch("second"))
    end

    refute(socket.aborted?)
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

  def test_upgrade_retry_keeps_the_origin_selected_before_the_first_handshake
    configured = workload_identity_client
    base_url = +"wss://first.example/v1"
    socket = FakeSocket.new
    attempts = []
    transport = Object.new
    transport.define_singleton_method(:open) do |url:, headers:, **, &connection_block|
      attempts << {url: url.to_s, auth: headers.fetch("authorization")}
      if attempts.one?
        base_url.replace("wss://other.example/v1")
        raise OpenAI::Errors::LiveConnectionError.new(url: url, http_status: 401)
      end

      connection_block.call(socket)
    end

    tokens = ["stale-fake", "fresh-fake"]
    configured.workload_identity_auth.stub(:get_token, -> (**) { tokens.shift }) do
      configured.workload_identity_auth.stub(:invalidate_token, -> { }) do
        configured.live.connect(websocket_base_url: base_url, transport: transport) { |_connection| nil }
      end
    end

    assert_equal(["wss://first.example/v1/live/sessions"] * 2, attempts.map { _1.fetch(:url) })
    assert_equal(["Bearer stale-fake", "Bearer fresh-fake"], attempts.map { _1.fetch(:auth) })
    assert_equal("wss://other.example/v1", base_url)
  end

  def test_custom_handshake_errors_are_redacted_before_the_socket_is_yielded
    [nil, 403].each do |status|
      transport = Object.new
      transport.define_singleton_method(:open) do |url:, **|
        if status
          raise(
            OpenAI::Errors::LiveConnectionError.new(
              url: url,
              http_status: status,
              message: "private-payload",
              cause: IOError.new("fake-token")
            )
          )
        end

        raise IOError, "private-payload fake-token"
      end

      error = assert_raises(OpenAI::Errors::LiveConnectionError) do
        client.live.connect(transport: transport) { flunk("Handshake was rejected") }
      end

      status ? assert_equal(status, error.http_status) : assert_nil(error.http_status)
      assert_nil(error.cause)
      refute_includes(error.full_message, "private-payload")
      refute_includes(error.full_message, "fake-token")
    end
  end

  def test_custom_transport_errors_after_yield_are_redacted_but_application_errors_survive
    socket = FakeSocket.new
    transport = Object.new
    transport.define_singleton_method(:open) do |**, &connection_block|
      connection_block.call(socket)
      raise IOError, "private-payload fake-token"
    end

    error = assert_raises(OpenAI::Errors::LiveConnectionError) do
      client.live.connect(transport: transport) { |_connection| :returned }
    end

    assert_nil(error.cause)
    refute_includes(error.full_message, "private-payload")
    refute_includes(error.full_message, "fake-token")
    assert_predicate(socket, :closed?)

    original = RuntimeError.new("application failure")
    captured = assert_raises(RuntimeError) do
      client.live.connect(transport: transport) { raise original }
    end

    assert_same(original, captured)
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
