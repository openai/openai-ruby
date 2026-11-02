# frozen_string_literal: true

require_relative "reconnect_test"

# Reuse the existing deterministic transport, cleanup, Async and send controls.
class OpenAI::Test::RealtimeReconnectTest
  def test_role_recovery_preserves_transcription_and_existing_call_selection
    [
      [
        :realtime_transcription,
        "intent",
        "transcription",
        -> (**options, &block) { client.realtime.connect_transcription(**options, &block) }
      ],
      [
        :realtime_call,
        "call_id",
        "call_fixture",
        -> (**options, &block) { client.realtime.connect_to_call(call_id: "call_fixture", **options, &block) }
      ]
    ].each do |role, selector, value, connector|
      event = JSON.generate(
        type: "conversation.item.input_audio_transcription.delta",
        event_id: "evt",
        item_id: "item",
        content_index: 0,
        delta: "ready"
      )
      second = Socket.new(event)
      transport = Transport.new(Socket.new(disconnected), second)
      contexts = []
      connector
        .call(
          transport: transport,
          reconnect: true,
          on_reconnecting: -> (context) {
            contexts << context
            nil
          }
        ) do |connection|
          assert_equal("ready", connection.receive.delta)
          if role == :realtime_call
            assert_instance_of(OpenAI::Realtime::SidebandConnection, connection)
            connection.output_audio_buffer.clear
            assert_equal("output_audio_buffer.clear", JSON.parse(second.writes.last).fetch("type"))
          end
        end

      assert_equal([role], contexts.map { _1.fetch(:role) })
      assert_equal(2, transport.requests.length)
      transport.requests.each { assert_equal([[selector, value]], URI.decode_www_form(_1.fetch(:url).query)) }
      assert_equal(1, transport.max_active)
    end
  end

  def test_role_recovery_low_level_translation_keeps_its_codec_without_finish
    ready = JSON.generate(
      type: "session.created",
      event_id: "evt",
      session: {
        id: "translation_fixture",
        type: "translation",
        model: "synthetic-fixture-model",
        expires_at: 2_000_000_000,
        audio: {}
      }
    )
    second = Socket.new(ready)
    transport = Transport.new(Socket.new(EOFError.new), second)
    client
      .realtime
      .translations
      .connect(query: {model: "synthetic-fixture-model"}, reconnect: true, transport: transport) do |connection|
        assert_instance_of(OpenAI::Realtime::TranslationSocketConnection, connection)
        refute_respond_to(connection, :finish)
        assert_instance_of(OpenAI::Realtime::RealtimeTranslationSessionCreatedEvent, connection.receive)
        connection.send_event(type: "session.input_audio_buffer.append", audio: "AA==")
        assert_raises(ArgumentError) { connection.send_event(type: "response.create") }
      end

    assert_equal(2, transport.requests.length)
    transport.requests.each do |request|
      assert_equal("/v1/realtime/translations", request.fetch(:url).path)
      assert_equal([["model", "synthetic-fixture-model"]], URI.decode_www_form(request.fetch(:url).query))
    end

    assert_equal(["session.input_audio_buffer.append"], second.writes.map { JSON.parse(_1).fetch("type") })
  end

  def test_role_recovery_live_primary_restores_startup_before_the_waiting_reader
    first = nil
    second = nil
    first = Socket.new(
      -> {
        assert_equal(1, first.writes.length)
        role_started("live_first")
      },
      EOFError.new
    )
    second = Socket.new(
      -> {
        assert_equal(1, second.writes.length)
        role_started("live_second")
      },
      role_transcript("continued")
    )
    transport = Transport.new(first, second)
    captured = nil
    restored = lambda do |connection|
      assert_same(captured, connection)
      assert_instance_of(OpenAI::Live::Connection, connection)
      assert_empty(second.writes)
      connection.send_event(
        type: "session.start",
        session: {model: "synthetic-fixture-model", instructions: "new explicit state"}
      )
      assert_equal("live_second", connection.receive.session.id)
    end

    client.live.connect(reconnect: true, transport: transport, on_reconnected: restored) do |connection|
      captured = connection
      connection.send_event(type: "session.start", session: {model: "synthetic-fixture-model"})
      assert_equal("live_first", connection.receive.session.id)
      assert_equal("continued", connection.receive.delta)
    end

    assert_equal(2, transport.requests.length)
    assert_equal(1, transport.max_active)
    assert_equal("new explicit state", JSON.parse(second.writes.first).dig("session", "instructions"))
  end

  def test_role_recovery_live_sideband_preserves_escaped_source_close_policy_and_codec
    second = Socket.new(role_transcript("attached"))
    transport = Transport.new(Socket.new(EOFError.new), second)
    client
      .live
      .sideband
      .connect("live_source/part", graceful_close: false, reconnect: true, transport: transport) do |connection|
        assert_instance_of(OpenAI::Live::SidebandConnection, connection)
        assert_equal("attached", connection.receive.delta)
        assert_raises(ArgumentError) {
          connection.send_event(type: "session.start", session: {model: "synthetic-fixture-model"})
        }
        connection.send_event(type: "session.input_audio.mute")
      end

    transport.requests.each do |request|
      assert_equal("/v1/live/sessions/live_source%2Fpart/attach", request.fetch(:url).path)
      assert_equal([["graceful_close", "false"]], URI.decode_www_form(request.fetch(:url).query))
    end

    assert_equal(["session.input_audio.mute"], second.writes.map { JSON.parse(_1).fetch("type") })
  end

  def test_role_recovery_fork_requires_each_explicit_fresh_transport_decision_without_replay
    untouched = Socket.new
    no_policy = Transport.new(untouched)
    assert_raises(ArgumentError) {
      client.live.forks.connect("stored_fixture", reconnect: true, transport: no_policy) {
        flunk("Fork recovery must reject missing consent before opening")
      }
    }
    assert_empty(no_policy.requests)

    first = nil
    second = nil
    first = Socket.new(
      -> {
        assert_equal(1, first.writes.length)
        role_started("fork_first")
      },
      EOFError.new
    )
    second = Socket.new(
      -> {
        assert_equal(1, second.writes.length)
        role_started("fork_second")
      },
      EOFError.new
    )
    transport = Transport.new(first, second, untouched)
    captured = nil
    decisions = []
    before = lambda do |context|
      assert_predicate(context, :frozen?)
      decisions << context
      if context.fetch(:attempt) == 1
        captured.send_event(type: "session.input_audio.append", audio: "AA==")
        {open_new_fork_transport: true}
      else
        false
      end
    end

    after = lambda do |connection|
      assert_same(captured, connection)
      assert_instance_of(OpenAI::Live::ForkConnection, connection)
      assert_empty(second.writes)
      connection.send_event(type: "session.start", session: {instructions: "new fork overrides"})
      assert_equal("fork_second", connection.receive.session.id)
      assert_equal(1, connection.pending_messages.length)
    end

    error = assert_raises(OpenAI::Errors::WebSocketReconnectError) do
      client
        .live
        .forks
        .connect(
          "stored_fixture",
          reconnect: true,
          transport: transport,
          max_queue_bytes: 4096,
          on_reconnecting: before,
          on_reconnected: after
        ) do |connection|
          captured = connection
          connection.send_event(type: "session.start", session: {})
          assert_equal("fork_first", connection.receive.session.id)
          connection.receive
        end
    end

    assert_equal([1, 2], decisions.map { _1.fetch(:attempt) })
    assert_equal([:live_fork, :live_fork], decisions.map { _1.fetch(:role) })
    assert_equal(2, transport.requests.length)
    transport.requests.each { assert_equal("/v1/live/sessions/stored_fixture/fork", _1.fetch(:url).path) }
    assert_equal(["session.start"], second.writes.map { JSON.parse(_1).fetch("type") })
    assert_equal("new fork overrides", JSON.parse(second.writes.first).dig("session", "instructions"))
    assert_equal(
      [{"type" => "session.input_audio.append", "audio" => "AA=="}],
      error.unsent_messages.map { JSON.parse(_1) }
    )
    assert_nil(error.uncertain_message)
    assert_equal(error.unsent_messages, captured.take_pending_messages)
    assert_empty(captured.pending_messages)
  end

  def test_role_recovery_hook_rebuilds_auth_and_ordinary_options_against_initial_state
    token = 0
    configured = OpenAI::Client.new(
      provider: OpenAI::Providers.azure(
        endpoint: "https://fixture.openai.azure.com",
        token_provider: -> { "fixture-token-#{token += 1}" }
      )
    )
    transport = Transport.new(
      Socket.new(disconnected),
      Socket.new(text_delta("first"), disconnected),
      Socket.new(text_delta("second"))
    )
    contexts = []
    before = lambda do |context|
      contexts << context
      assert_predicate(context, :frozen?)
      context.fetch(:attempt) == 1 ? {headers: {"X-Trace" => "temporary"}, query: {trace: "temporary"}} : nil
    end

    configured
      .realtime
      .connect(
        model: "synthetic-fixture-model",
        reconnect: true,
        transport: transport,
        max_reconnect_attempts: 2,
        request_options: {extra_headers: {"X-Trace" => "initial"}},
        on_reconnecting: before
      ) do |connection|
        assert_equal("first", connection.receive.delta)
        assert_equal("temporary", URI.decode_www_form(connection.url.query).to_h.fetch("trace"))
        assert_equal("second", connection.receive.delta)
        assert_equal([["model", "synthetic-fixture-model"]], URI.decode_www_form(connection.url.query))
      end

    assert_equal([1, 2], contexts.map { _1.fetch(:attempt) })
    assert_equal([1, 0], contexts.map { _1.fetch(:remaining_attempts) })
    assert_equal(["initial", "temporary", "initial"], transport.requests.map { _1.fetch(:headers).fetch("x-trace") })
    assert_equal(
      ["Bearer fixture-token-1", "Bearer fixture-token-2", "Bearer fixture-token-3"],
      transport.requests.map { _1.fetch(:headers).fetch("authorization") }
    )
    assert_equal(3, token)
  end

  def test_role_recovery_hook_cannot_override_selectors_or_credentials
    [
      {query: {model: "other"}},
      {query: {access_token: "secret"}},
      {headers: {"Authorization" => "Bearer other"}},
      {headers: {"Sec-WebSocket-Protocol" => "other"}},
      {unknown: true}
    ].each do |decision|
      transport = Transport.new(Socket.new(disconnected), Socket.new(text_delta("must not open")))
      assert_raises(ArgumentError) do
        client
          .realtime
          .connect(
            model: "synthetic-fixture-model",
            transport: transport,
            reconnect: true,
            on_reconnecting: -> (_context) { decision },
            &:receive
          )
      end

      assert_equal(1, transport.requests.length)
    end
  end

  def test_role_recovery_credential_policy_ignores_header_case_but_keeps_auth_scheme
    [["bEaReR fixture-rotated", true], ["Basic fixture-changed", false]].each do |replacement, allowed|
      subclass = Class.new(OpenAI::Client) do
        define_method(:prepare_request) do |request, **options|
          prepared = super(request, **options)
          @preparations = (@preparations || 0) + 1
          prepared.fetch(:headers).delete("authorization")
          prepared.fetch(:headers)["Authorization"] = @preparations == 1 ? "Bearer fixture-initial" : replacement
          prepared
        end
      end

      configured = subclass.new(api_key: "fixture", base_url: "https://example.com/v1")
      transport = Transport.new(Socket.new(disconnected), Socket.new(text_delta("replacement")))
      operation = lambda do
        configured
          .realtime
          .connect(model: "synthetic-fixture-model", transport: transport, reconnect: true) do |connection|
            assert_equal("replacement", connection.receive.delta)
          end
      end

      if allowed
        operation.call
        assert_equal(2, transport.requests.length)
        assert_equal(
          ["Bearer fixture-initial", replacement],
          transport.requests.map { _1.fetch(:headers).fetch("Authorization") }
        )
        transport.requests.each { refute(_1.fetch(:headers).key?("authorization")) }
      else
        assert_raises(OpenAI::Errors::RealtimeReconnectError, &operation)
        assert_equal(1, transport.requests.length)
      end
    end
  end

  def test_role_recovery_live_owns_original_source_and_base_strings_for_the_logical_connection
    source = +"stored_fixture/part"
    base = +"https://example.com/v1"
    first = Socket.new(role_started("fork_initial"), EOFError.new)
    second = Socket.new(role_started("fork_replacement"))
    transport = Transport.new(first, second)
    before = lambda do |_context|
      source.replace("caller_changed_source")
      base.replace("https://other.example/v9")
      {open_new_fork_transport: true}
    end

    restore = -> (connection) { connection.send_event(type: "session.start", session: {instructions: "replacement"}) }
    client
      .live
      .forks
      .connect(
        source,
        websocket_base_url: base,
        transport: transport,
        reconnect: true,
        on_reconnecting: before,
        on_reconnected: restore
      ) do |connection|
        connection.send_event(type: "session.start", session: {})
        assert_equal("fork_initial", connection.receive.session.id)
        assert_equal("fork_replacement", connection.receive.session.id)
      end

    assert_equal("caller_changed_source", source)
    assert_equal("https://other.example/v9", base)
    assert_equal(2, transport.requests.length)
    transport.requests.each do |request|
      assert_equal("example.com", request.fetch(:url).host)
      assert_equal("/v1/live/sessions/stored_fixture%2Fpart/fork", request.fetch(:url).path)
    end

    assert_equal(["session.start"], second.writes.map { JSON.parse(_1).fetch("type") })
  end

  def test_role_recovery_pre_attempt_reads_fail_fast_and_writes_remain_never_attempted
    second = Socket.new(text_delta("ready"))
    transport = Transport.new(Socket.new(disconnected), second)
    captured = nil
    before = lambda do |_context|
      assert_raises(OpenAI::Errors::RealtimeReconnectError) { captured.receive }
      captured.response.create(instructions: "retained before transport")
      assert_equal(1, captured.pending_messages.length)
      nil
    end

    client
      .realtime
      .connect(
        model: "synthetic-fixture-model",
        transport: transport,
        reconnect: true,
        max_queue_bytes: 4096,
        on_reconnecting: before
      ) do |connection|
        captured = connection
        assert_equal("ready", connection.receive.delta)
        assert_empty(second.writes)
        assert_equal(1, connection.take_pending_messages.length)
        assert_empty(connection.pending_messages)
      end
  end

  def test_role_recovery_healthy_progress_resets_only_pacing_and_never_lifetime_budget
    [true, false].each do |healthy|
      frame = healthy ? text_delta("progress") : JSON.generate(
        type: "error",
        event_id: "evt",
        error: {type: "server_error", message: "fixture"}
      )
      transport = Transport.new(
        Socket.new(disconnected),
        Socket.new(frame, disconnected),
        Socket.new(frame, disconnected),
        Socket.new(disconnected)
      )
      delays = []
      assert_raises(OpenAI::Errors::RealtimeReconnectError) do
        client
          .realtime
          .connect(
            model: "synthetic-fixture-model",
            reconnect: true,
            transport: transport,
            max_reconnect_attempts: 3,
            on_reconnecting: -> (context) {
              delays << context.fetch(:delay)
              nil
            }
          ) { _1.each { |_event| nil } }
      end

      assert_equal(4, transport.requests.length)
      assert_equal(3, delays.length)
      delays.zip(healthy ? [0.5, 0.5, 0.5] : [0.5, 1.0, 2.0]).each do |delay, cap|
        assert_operator(delay, :<=, cap)
        assert_operator(delay, :>=, cap * 0.75)
      end
    end
  end

  def test_role_recovery_live_info_unknown_and_nested_errors_do_not_reset_pacing
    frames = [
      JSON.generate(type: "info", event_id: "evt_info", code: "fixture", message: "informational"),
      JSON.generate(type: "session.future", detail: "unknown"),
      JSON.generate(
        type: "response.event",
        event_id: "evt_nested",
        event: {type: "error", code: "fixture", message: "nested failure"}
      ),
      JSON.generate(type: "response.event", event_id: "evt_unknown", event: {type: "response.future"})
    ]
    transport = Transport.new(Socket.new(EOFError.new), Socket.new(*frames, EOFError.new), Socket.new(EOFError.new))
    delays = []
    assert_raises(OpenAI::Errors::WebSocketReconnectError) do
      client
        .live
        .sideband
        .connect(
          "live_fixture",
          reconnect: true,
          transport: transport,
          max_reconnect_attempts: 2,
          on_reconnecting: -> (context) {
            delays << context.fetch(:delay)
            nil
          }
        ) { _1.each { |_event| nil } }
    end

    assert_equal(3, transport.requests.length)
    assert_operator(delays.last, :>=, 0.75)
    assert_operator(delays.last, :<=, 1.0)
  end

  def test_role_recovery_rejects_late_target_changes_before_the_next_upgrade
    [
      -> (request) { request.fetch(:url).host = "other.example" },
      -> (request) { request.fetch(:url).path += "/other" },
      -> (request) { request.fetch(:url).query = "model=other" },
      -> (request) { request.fetch(:headers)["origin"] = "https://other.example" }
    ].each do |change|
      subclass = Class.new(OpenAI::Client) do
        define_method(:prepare_request) do |request, **options|
          prepared = super(request, **options)
          @preparations = (@preparations || 0) + 1
          change.call(prepared) if @preparations > 1
          prepared
        end
      end

      transport = Transport.new(Socket.new(disconnected), Socket.new(text_delta("must not open")))
      configured = subclass.new(api_key: "fixture", base_url: "https://example.com/v1")
      assert_raises(OpenAI::Errors::RealtimeReconnectError) do
        configured.realtime.connect(model: "synthetic-fixture-model", reconnect: true, transport: transport, &:receive)
      end

      assert_equal(1, transport.requests.length)
    end
  end

  def test_role_recovery_before_hook_abort_failure_and_close_stop_without_upgrade
    [false, RuntimeError.new("fixture callback failure"), :close].each do |decision|
      transport = Transport.new(Socket.new(disconnected), Socket.new(text_delta("must not open")))
      captured = nil
      callback = lambda do |_context|
        raise decision if decision.is_a?(Exception)
        if decision == :close
          captured.close
          nil
        else
          decision
        end
      end

      operation = lambda do
        client
          .realtime
          .connect(model: "synthetic-fixture-model", reconnect: true, transport: transport, on_reconnecting: callback) do |
              connection
            |
            captured = connection
            assert_nil(connection.receive) if decision == :close
            connection.receive unless decision == :close
          end
      end

      if decision == :close
        operation.call
      elsif decision.is_a?(Exception)
        assert_same(decision, assert_raises(RuntimeError, &operation))
      else
        assert_raises(OpenAI::Errors::RealtimeReconnectError, &operation)
      end

      assert_equal(1, transport.requests.length)
    end
  end

  def test_role_recovery_translation_retains_only_unsent_frames_and_never_retries_uncertainty
    opening = Queue.new
    gate = Queue.new
    ready = JSON.generate(
      type: "session.created",
      event_id: "evt",
      session: {
        id: "translation_fixture",
        type: "translation",
        model: "synthetic-fixture-model",
        expires_at: 2_000_000_000,
        audio: {}
      }
    )
    second = Socket.new(ready)
    transport = Transport.new(
      Socket.new(EOFError.new),
      -> {
        opening << true
        gate.pop
        second
      }
    )
    error = assert_raises(OpenAI::Errors::WebSocketReconnectError) do
      client
        .realtime
        .translations
        .connect(query: {model: "synthetic-fixture-model"}, transport: transport, reconnect: true, max_queue_bytes: 100) do |
            connection
          |
          receiver = Async::Task.current.async { connection.receive }
          opening.pop
          connection.send_event(type: "session.input_audio_buffer.append", audio: "AA==")
          assert_raises(OpenAI::Errors::WebSocketQueueFullError) {
            connection.send_event(type: "session.input_audio_buffer.append", audio: "A" * 120)
          }
          gate << true
          assert_instance_of(OpenAI::Realtime::RealtimeTranslationSessionCreatedEvent, receiver.wait)
          assert_empty(second.writes)
          connection.flush_pending
          assert_empty(connection.pending_messages)
          assert_equal(1, second.writes.length)
          second.write_action = -> (_message) { raise IOError, "fixture ambiguous write" }
          failure = assert_raises(OpenAI::Errors::WebSocketReconnectError) {
            connection.send_event(type: "session.input_audio_buffer.append", audio: "BB==")
          }
          assert_equal("BB==", JSON.parse(failure.uncertain_message).fetch("audio"))
          assert_empty(failure.unsent_messages)
        end
    end

    assert_equal(2, transport.requests.length)
    assert_equal("BB==", JSON.parse(error.uncertain_message).fetch("audio"))
    assert_equal(["AA=="], second.writes.map { JSON.parse(_1).fetch("audio") })
  end

  def test_role_recovery_stale_decode_and_raw_only_reads_cannot_reset_new_generation_pacing
    decoding = Queue.new
    release = Queue.new
    decoded = Queue.new
    replacements = 0
    delays = []
    raw = text_delta("raw current generation")
    transport = Transport.new(
      Socket.new(disconnected),
      Socket.new(text_delta("old progress"), disconnected),
      Socket.new(raw, disconnected),
      Socket.new(disconnected)
    )
    restore = lambda do |_connection|
      replacements += 1
      if replacements == 2
        release << true
        decoded.pop
      end
    end

    assert_raises(OpenAI::Errors::RealtimeReconnectError) do
      client
        .realtime
        .connect(
          model: "synthetic-fixture-model",
          reconnect: true,
          transport: transport,
          max_reconnect_attempts: 3,
          on_reconnected: restore,
          on_reconnecting: -> (context) {
            delays << context.fetch(:delay)
            nil
          }
        ) do |connection|
          connection.define_singleton_method(:parse_event) do |data|
            event = super(data)
            if event.respond_to?(:delta) && event.delta == "old progress"
              decoding << true
              release.pop
            end

            event
          end

          old_reader = Async::Task.current.async do
            event = connection.receive
            decoded << true
            event
          end

          decoding.pop
          assert_same(raw, connection.receive_raw)
          assert_equal("raw current generation", connection.parse_event(raw).delta)
          assert_equal("old progress", old_reader.wait.delta)
          connection.receive
        end
    end

    assert_equal(4, transport.requests.length)
    assert_operator(delays.last, :>=, 1.5)
    assert_operator(delays.last, :<=, 2.0)
  end

  def test_role_recovery_workload_identity_refresh_stays_separate_from_lifetime_replacements
    provider = OpenAI::Auth::SubjectTokenProviders::K8sServiceAccountTokenProvider.new(
      token_path: "/not-read-by-this-test"
    )
    identity = OpenAI::Auth::WorkloadIdentity.new(
      identity_provider_id: "idp_fixture",
      service_account_id: "sa_fixture",
      provider: provider
    )
    configured = OpenAI::Client.new(
      api_key: nil,
      workload_identity: identity,
      organization: "org_fixture",
      base_url: "https://example.com/v1"
    )
    rejected = OpenAI::Errors::RealtimeConnectionError.new(url: URI("wss://example.com/v1/realtime"), http_status: 401)
    transport = Transport.new(
      rejected,
      Socket.new(text_delta("initial"), disconnected),
      Socket.new(text_delta("replacement"), disconnected),
      Socket.new
    )
    tokens = 0
    invalidations = 0
    attempts = []
    configured.workload_identity_auth.stub(:get_token, -> (**) { "fixture-token-#{tokens += 1}" }) do
      configured.workload_identity_auth.stub(:invalidate_token, -> { invalidations += 1 }) do
        assert_raises(OpenAI::Errors::RealtimeReconnectError) do
          configured
            .realtime
            .connect(
              model: "synthetic-fixture-model",
              transport: transport,
              reconnect: true,
              max_reconnect_attempts: 1,
              on_reconnecting: -> (context) {
                attempts << context.fetch(:attempt)
                nil
              }
            ) do |connection|
              assert_equal("initial", connection.receive.delta)
              assert_equal("replacement", connection.receive.delta)
              connection.receive
            end
        end
      end
    end

    assert_equal([1], attempts)
    assert_equal(3, transport.requests.length)
    assert_equal(3, tokens)
    assert_equal(1, invalidations)
  end

  def test_role_recovery_prepared_wire_values_do_not_alias_retained_middleware_inputs
    subclass = Class.new(OpenAI::Client) do
      attr_reader(:retained)
      def prepare_request(request, **options)
        @retained = super
      end
    end

    configured = subclass.new(api_key: "fixture", base_url: "https://example.com/v1")
    transport = Transport.new(
      -> {
        configured.retained.fetch(:url).host = "other.example"
        configured.retained.fetch(:headers)["authorization"] = "Bearer changed"
        Socket.new(text_delta("owned"))
      }
    )
    configured.realtime.connect(model: "synthetic-fixture-model", transport: transport, reconnect: true) {
      assert_equal("owned", _1.receive.delta)
    }
    request = transport.requests.fetch(0)
    assert_equal("example.com", request.fetch(:url).host)
    assert_equal("Bearer fixture", request.fetch(:headers).fetch("authorization"))
    refute_same(configured.retained.fetch(:url), request.fetch(:url))
    assert_predicate(request.fetch(:headers).fetch("authorization"), :frozen?)
  end

  private def role_started(id)
    JSON.generate(
      type: "session.started",
      event_id: "evt_#{id}",
      session: {id: id, model: "synthetic-fixture-model", expires_at: 2_000_000_000, status: "active"}
    )
  end

  private def role_transcript(delta)
    JSON.generate(type: "session.output_transcript.delta", event_id: "evt", delta: delta, start_ms: 0, end_ms: 20)
  end
end
