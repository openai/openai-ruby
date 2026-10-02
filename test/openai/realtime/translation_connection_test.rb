# frozen_string_literal: true

require "open3"

require_relative "../test_helper"
require_relative "../responses_websocket/connection_test_support"

class OpenAI::Test::RealtimeTranslationConnectionTest < Minitest::Test
  extend Minitest::Serial

  include OpenAI::Test::ResponsesWebSocketConnectionTestSupport

  def test_finish_waits_for_an_admitted_injected_write_without_losing_its_reader
    release = Async::Condition.new
    socket = FakeSocket.new(
      JSON.generate(type: "session.output_transcript.delta", event_id: "o1", delta: "last"),
      JSON.generate(type: "session.closed", event_id: "s1")
    )
    socket.define_singleton_method(:write) do |message|
      release.wait if JSON.parse(message).fetch("type") == "session.input_audio_buffer.append"
      super(message)
    end

    Sync do |task|
      task.with_timeout(3) do
        client
          .realtime
          .connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(socket)) do |c|
            sender = task.async { c.send_event(type: "session.input_audio_buffer.append", audio: "AA==") }
            events = []
            finisher = task.async { c.finish(timeout: 2) { |event| events << event } }
            assert_raises(OpenAI::Errors::TranslationConnectionError) { c.receive }
            assert_raises(OpenAI::Errors::TranslationConnectionError) { c.receive_raw }
            release.signal
            assert_nil(sender.wait)
            terminal = finisher.wait
            assert_instance_of(OpenAI::Realtime::RealtimeTranslationSessionClosedEvent, terminal)
            assert_equal("last", events.first.delta)
            assert_same(terminal, events.last)
            assert_equal(
              %w[session.input_audio_buffer.append session.close],
              socket.writes.map { |message| JSON.parse(message).fetch("type") }
            )
          end
      end
    end

    assert_predicate(socket, :closed?)
  end

  def test_injected_threaded_reader_and_finish_do_not_steal_each_others_events
    entered = Queue.new
    release = Queue.new
    socket = FakeSocket.new(
      JSON.generate(type: "session.input_transcript.delta", event_id: "i1", delta: "input"),
      JSON.generate(type: "session.output_transcript.delta", event_id: "o1", delta: "last"),
      JSON.generate(type: "session.closed", event_id: "s1")
    )
    socket.define_singleton_method(:read) do
      entered << :reading
      release.pop
      super()
    end

    client.realtime.connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(socket)) do |c|
      reader = Thread.new { c.receive }
      assert_equal(:reading, entered.pop(timeout: 1))
      assert_raises(OpenAI::Errors::TranslationConnectionError) { c.finish(timeout: 2) { flunk } }
      assert_empty(socket.writes, "finish cannot send a close while another reader is in flight")
      release << true
      assert_equal("input", reader.value.delta)

      events = []
      finisher = Thread.new { c.finish(timeout: 2) { |event| events << event } }
      assert_equal(:reading, entered.pop(timeout: 1))
      assert_raises(OpenAI::Errors::TranslationConnectionError) { c.receive }
      assert_raises(OpenAI::Errors::TranslationConnectionError) { c.receive_raw }
      assert_raises(OpenAI::Errors::TranslationConnectionError) { c.finish(timeout: 2) { flunk } }
      release << true
      assert_equal(:reading, entered.pop(timeout: 1))
      release << true
      terminal = finisher.value
      assert_equal("last", events.first.delta)
      assert_same(terminal, events.last)
      assert_same(terminal, c.finish(timeout: 1) { flunk("must not replay") })
      assert_equal([{"type" => "session.close"}], socket.writes.map { |message| JSON.parse(message) })
    ensure
      reader&.kill
      finisher&.kill
      reader&.join
      finisher&.join
    end

    assert_predicate(socket, :closed?)
  end

  def test_translation_drains_final_output_after_the_close_command
    socket = FakeSocket.new(
      JSON.generate(
        type: "session.created",
        event_id: "e1",
        session: {
          id: "rt_fake",
          type: "translation",
          model: "gpt-realtime-translate",
          expires_at: 2_000_000_000,
          audio: {}
        }
      ),
      JSON.generate(type: "session.output_transcript.delta", event_id: "e2", delta: "bon"),
      JSON.generate(type: "session.output_transcript.delta", event_id: "e3", delta: "jour"),
      JSON.generate(type: "session.closed", event_id: "e4")
    )
    transport = FakeTransport.new(socket)
    result = client.realtime.connect_translation(model: "gpt-realtime-translate", transport: transport) do |connection|
      ready = connection.receive
      assert_instance_of(OpenAI::Realtime::RealtimeTranslationSessionCreatedEvent, ready)
      assert_empty(socket.writes)
      connection.send_event(OpenAI::Realtime::RealtimeTranslationInputAudioBufferAppendEvent.new(audio: "AA=="))
      connection.send_event(OpenAI::Realtime::RealtimeTranslationSessionCloseEvent.new)
      text = +""
      connection.each do |event|
        case event
        when OpenAI::Realtime::RealtimeTranslationOutputTranscriptDeltaEvent
          text << event.delta
        when OpenAI::Realtime::RealtimeTranslationSessionClosedEvent
          break
        end
      end

      text
    end

    assert_equal("bonjour", result)
    assert_equal(
      ["session.input_audio_buffer.append", "session.close"],
      socket.writes.map { JSON.parse(_1).fetch("type") }
    )
    assert_equal("/v1/realtime/translations", transport.open_args.fetch(:url).path)
    assert_equal([["model", "gpt-realtime-translate"]], URI.decode_www_form(transport.open_args.fetch(:url).query))
    assert_predicate(socket, :closed?)
  end

  def test_invalid_commands_are_rejected_without_closing_and_errors_stay_nonterminal
    private_text = "fake private transcript"
    socket = FakeSocket.new(
      JSON.generate(type: "error", event_id: "err1", error: {type: "invalid_request_error", message: "bad"}),
      JSON.generate(type: "session.output_transcript.delta", event_id: "d1", delta: "salut"),
      JSON.generate(type: "future.translation", text: private_text)
    )
    client.realtime.connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(socket)) do |c|
      assert_raises(ArgumentError) { c.send_event(type: "response.create", response: {instructions: private_text}) }
      assert_empty(socket.writes)
      assert_instance_of(OpenAI::Realtime::RealtimeErrorEvent, c.receive)
      assert_equal("salut", c.receive.delta)
      unknown = c.receive
      assert_equal(private_text, unknown.data.fetch(:text))
      refute_includes(unknown.inspect, private_text)
      c.send_event(type: "session.close")
    end

    assert_equal(["session.close"], socket.writes.map { JSON.parse(_1).fetch("type") })
  end

  def test_each_connection_uses_current_credentials_and_never_replays_audio
    api = OpenAI::Client.new(api_key: "fake-first", base_url: "https://api.example/v1")
    first = FakeTransport.new(FakeSocket.new)
    api.realtime.connect_translation(model: "gpt-realtime-translate", transport: first) do |c|
      c.send_event(type: "session.input_audio_buffer.append", audio: "AA==")
    end

    second_socket = FakeSocket.new
    second = FakeTransport.new(second_socket)
    api
      .realtime
      .connect_translation(
        model: "gpt-realtime-translate",
        transport: second,
        request_options: {extra_headers: {"Authorization" => "Bearer fake-second"}, timeout: 8}
      ) { |_c| :fresh }
    assert_equal("Bearer fake-first", first.open_args.fetch(:headers).fetch("authorization"))
    assert_equal("Bearer fake-second", second.open_args.fetch(:headers).fetch("authorization"))
    assert_empty(second_socket.writes)
  end

  def test_malformed_frame_does_not_expose_transcript
    private_text = "fake private transcript"
    socket = FakeSocket.new("{\"type\":\"session.output_transcript.delta\",\"delta\":\"#{private_text}\"")
    client.realtime.connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(socket)) do |c|
      error = assert_raises(OpenAI::Errors::WebSocketProtocolError) { c.receive }
      refute_includes(error.full_message, private_text)
      assert_nil(error.cause)
    end
  end

  def test_missing_or_invalid_required_fields_are_safely_rejected
    socket = FakeSocket.new(
      JSON.generate(type: "session.output_transcript.delta", delta: "fake-private-transcript"),
      JSON.generate(
        type: "session.created",
        event_id: "e2",
        session: {type: "translation", model: "fake-private-model"}
      ),
      JSON.generate(type: "session.closed", event_id: "e3")
    )
    client
      .realtime
      .connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(socket)) do |connection|
        [
          {type: "session.input_audio_buffer.append"},
          {type: "session.update", session: {audio: {output: {language: ["fake-private-language"]}}}},
          {type: "response.create", response: {instructions: "fake-private-transcript"}}
        ].each do |invalid|
          error = assert_raises(ArgumentError) { connection.send_event(invalid) }
          assert_nil(error.cause)
          refute_includes(error.full_message, "fake-private")
        end

        2.times do
          error = assert_raises(OpenAI::Errors::TranslationProtocolError) { connection.receive }
          assert_nil(error.cause)
          refute_includes(error.full_message, "fake-private")
        end

        assert_empty(socket.writes)
        assert_instance_of(OpenAI::Realtime::RealtimeTranslationSessionClosedEvent, connection.receive)
      end
  end

  def test_failed_read_never_reconnects_or_leaks_transport_details
    socket = FailingReadSocket.new
    transport = FakeTransport.new(socket)
    client.realtime.connect_translation(model: "gpt-realtime-translate", transport: transport) do |connection|
      error = assert_raises(OpenAI::Errors::TranslationConnectionError) { connection.receive }
      assert_nil(error.cause)
      refute_includes(error.full_message, "sensitive-body")
      assert_predicate(connection, :closed?)
      assert_raises(OpenAI::Errors::TranslationConnectionError) do
        connection.send_event(type: "session.close")
      end
    end

    assert_empty(socket.writes)
    assert_predicate(socket, :aborted?)
  end

  def test_open_failure_suppresses_raw_credentials_and_keeps_the_http_status
    api = OpenAI::Client.new(api_key: "fake-key", base_url: "https://fake-user:fake-password@example.com/v1")
    transport = Object.new
    transport.define_singleton_method(:open) do |url:, **|
      raise(
        OpenAI::Errors::TranslationConnectionError.new(
          url: url,
          message: "fake-private-body",
          cause: IOError.new("fake-private-credential"),
          http_status: 403
        )
      )
    end

    error = assert_raises(OpenAI::Errors::TranslationConnectionError) do
      api.realtime.connect_translation(model: "fake-private-model", transport: transport) { flunk }
    end

    assert_equal(403, error.http_status)
    assert_nil(error.cause)
    assert_nil(error.url.userinfo)
    assert_nil(error.url.query)
    assert_equal("/v1/realtime/translations", error.url.path)
    %w[fake-user fake-password fake-private-body fake-private-credential fake-private-model].each do |private_text|
      refute_includes(error.full_message, private_text)
      refute_includes(error.url.to_s, private_text)
    end
  end

  def test_workload_identity_upgrade_can_refresh_once_but_cannot_replay_after_open
    api = workload_identity_client
    socket = FakeSocket.new
    attempts = []
    transport = Object.new
    transport.define_singleton_method(:open) do |url:, headers:, **, &block|
      attempts << headers.fetch("authorization")
      raise OpenAI::Errors::TranslationConnectionError.new(url: url, http_status: 401) if attempts.one?
      block.call(socket)
    end

    tokens = ["fake-first", "fake-refreshed"]
    invalidations = 0
    api.workload_identity_auth.stub(:get_token, -> (**) { tokens.shift }) do
      api.workload_identity_auth.stub(:invalidate_token, -> { invalidations += 1 }) do
        assert_raises(OpenAI::Errors::TranslationConnectionError) do
          api.realtime.connect_translation(model: "gpt-realtime-translate", transport: transport) do |connection|
            connection.send_event(type: "session.input_audio_buffer.append", audio: "AA==")
            raise OpenAI::Errors::TranslationConnectionError.new(url: connection.url, http_status: 401)
          end
        end
      end
    end

    assert_equal(["Bearer fake-first", "Bearer fake-refreshed"], attempts)
    assert_equal(1, invalidations)
    assert_equal(["session.input_audio_buffer.append"], socket.writes.map { JSON.parse(_1).fetch("type") })
    assert_predicate(socket, :aborted?)
  end

  def test_unsupported_provider_and_conflicting_model_query_never_send_credentials
    transport = FakeTransport.new(FakeSocket.new)
    azure = OpenAI::Client.new(
      provider: OpenAI::Providers.azure(endpoint: "https://resource.openai.azure.com", api_key: "fake-azure-key")
    )
    assert_raises(OpenAI::Errors::Error) do
      azure.realtime.connect_translation(model: "gpt-realtime-translate", transport: transport) { flunk }
    end

    assert_raises(ArgumentError) do
      client
        .realtime
        .connect_translation(
          model: "gpt-realtime-translate",
          transport: transport,
          request_options: {extra_query: {model: "fake-override"}}
        ) { flunk }
    end

    assert_raises(ArgumentError) do
      client.realtime.connect_translation(model: "gpt-realtime-translate", transport: transport)
    end

    assert_nil(transport.open_args)
  end

  def test_early_exit_and_application_error_cleanup_preserve_caller_control
    socket = FakeSocket.new
    result = client
      .realtime
      .connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(socket)) do |_c|
        break :early
      end

    assert_equal(:early, result)
    assert_equal({code: 1000, reason: ""}, socket.close_args)
    other = FakeSocket.new
    original = RuntimeError.new("application error")
    returned = assert_raises(RuntimeError) do
      client.realtime.connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(other)) {
        raise original
      }
    end

    assert_same(original, returned)
    assert_predicate(other, :aborted?)
  end

  def test_rest_require_keeps_websocket_dependency_optional
    code = <<~RUBY
      require "openai"
      abort "loaded websocket dependency" if $LOADED_FEATURES.any? { |name| name.include?("async/websocket") }
      realtime = OpenAI::Client.new(api_key: "fake").realtime
      abort "translation missing" unless realtime.respond_to?(:connect_translation)
      abort "existing API lost" unless realtime.respond_to?(:connect_transcription) && realtime.respond_to?(:calls)
    RUBY
    output, status = Open3.capture2e(RbConfig.ruby, "-Ilib", "-e", code)
    assert_predicate(status, :success?, output)
  end

  def test_cycles_fail_promptly_but_shared_acyclic_extras_remain_valid
    socket = FakeSocket.new
    client
      .realtime
      .connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(socket)) do |connection|
        cycle = {}
        cycle[:next] = cycle
        assert_raises(ArgumentError) do
          # Interrupt bypasses the connection's StandardError handler: a stalled
          # validation must fail this test, not be mistaken for its ArgumentError.
          Timeout.timeout(1, Interrupt) do
            connection.send_event(type: "session.update", session: {audio: {output: {language: "fr", extra: cycle}}})
          end
        end

        assert_empty(socket.writes)
        shared = {tags: ["same", "fake-value"]}
        connection.send_event(type: "session.update", session: {first: shared, second: shared})
        sent = JSON.parse(socket.writes.fetch(0))
        assert_equal({"tags" => ["same", "fake-value"]}, sent.dig("session", "first"))
        assert_equal(sent.dig("session", "first"), sent.dig("session", "second"))
      end
  end

  def test_deep_future_events_preserve_and_freeze_all_data
    raw = +"{\"type\":\"future.translation\",\"value\":"
    raw << ("{\"next\":" * 12_000)
    raw << "{\"value\":\"fake-private-transcript\"}"
    raw << ("}" * 12_001)
    socket = FakeSocket.new(raw)
    client
      .realtime
      .connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(socket)) do |connection|
        event = connection.receive
        assert_instance_of(OpenAI::Realtime::UnknownTranslationServerEvent, event)
        refute_includes(event.inspect, "fake-private-transcript")
        current = event.data.fetch(:value)
        12_000.times do
          assert_predicate(current, :frozen?)
          current = current.fetch(:next)
        end

        assert_predicate(current, :frozen?)
        assert_equal("fake-private-transcript", current.fetch(:value))
      end
  end

  def test_known_events_cannot_contain_a_different_session_type
    session = {id: "rt_fake", type: "realtime", model: "gpt-realtime-translate", expires_at: 2_000_000_000, audio: {}}
    socket = FakeSocket.new(
      JSON.generate(type: "session.created", event_id: "e1", session: session),
      JSON.generate(type: "session.updated", event_id: "e2", session: session.merge(type: "transcription")),
      JSON.generate(type: "session.updated", event_id: "e3", session: session.merge(type: "translation"))
    )
    client.realtime.connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(socket)) do |c|
      2.times do
        error = assert_raises(OpenAI::Errors::TranslationProtocolError) { c.receive }
        assert_nil(error.cause)
      end

      valid = c.receive
      assert_instance_of(OpenAI::Realtime::RealtimeTranslationSessionUpdatedEvent, valid)
      assert_equal(:translation, valid.session.type)
    end
  end

  def test_symbol_overrides_cannot_change_a_different_string_keyed_command
    socket = FakeSocket.new
    client.realtime.connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(socket)) do |c|
      [
        {:type => "session.close", "type" => "session.input_audio_buffer.append", :audio => "AA=="},
        {"type" => "session.input_audio_buffer.append", :audio => "AA==", :type => "session.close"},
        {type: "session.update", session: {audio: {output: {"language" => "fr", :language => "en"}}}},
        {
          :type => "session.update",
          "session" => {audio: {output: {language: "fr"}}},
          :session => {audio: {output: {language: "en"}}}
        }
      ].each do |conflicting|
        assert_raises(ArgumentError) { c.send_event(conflicting) }
      end

      assert_empty(socket.writes)
      c.send_event({"type" => "session.update", "session" => {"audio" => {"output" => {"language" => "fr"}}}})
      assert_equal("fr", JSON.parse(socket.writes.fetch(0)).dig("session", "audio", "output", "language"))
    end
  end

  def test_typed_client_event_cannot_select_another_valid_discriminator
    socket = FakeSocket.new
    client.realtime.connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(socket)) do |c|
      close = OpenAI::Realtime::RealtimeTranslationSessionCloseEvent.new(
        type: :"session.update",
        session: {audio: {output: {language: "fr"}}}
      )
      assert_raises(ArgumentError) { c.send_event(close) }
      assert_empty(socket.writes)
      c.send_event(OpenAI::Realtime::RealtimeTranslationSessionCloseEvent.new)
      assert_equal({"type" => "session.close"}, JSON.parse(socket.writes.fetch(0)))
    end
  end

  def test_custom_json_leaf_cannot_rewrite_an_encoded_command
    socket = FakeSocket.new
    leaf = Object.new
    leaf.define_singleton_method(:to_json) do |*_args|
      "null,\"type\":\"session.input_audio_buffer.append\",\"audio\":\"AA==\""
    end

    client.realtime.connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(socket)) do |c|
      assert_raises(ArgumentError) { c.send_event(type: "session.close", extra: leaf) }
      assert_empty(socket.writes)
      c.send_event(type: "session.close", metadata: {labels: ["valid", nil], numeric: 1})
      assert_equal({"labels" => ["valid", nil], "numeric" => 1}, JSON.parse(socket.writes.fetch(0)).fetch("metadata"))
    end
  end

  def test_only_string_and_symbol_client_event_keys_are_accepted
    socket = FakeSocket.new
    key = Object.new
    key.define_singleton_method(:to_s) { "extra" }
    client.realtime.connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(socket)) do |c|
      assert_raises(ArgumentError) { c.send_event(:type => "session.close", key => "fake-data") }
      assert_raises(ArgumentError) { c.send_event(type: "session.update", session: {metadata: {1 => "fake-data"}}) }
      assert_empty(socket.writes)
    end
  end

  def test_audio_format_cannot_be_overridden_using_the_internal_sdk_field_name
    audio = {type: "session.output_audio.delta", event_id: "a1", delta: "AA==", format: "pcm16"}
    socket = FakeSocket.new(
      JSON.generate(audio.merge(format_: "future")),
      JSON.generate(audio.merge(format_: "pcm16")),
      JSON.generate(audio.merge(future_audio_field: "keep"))
    )
    client.realtime.connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(socket)) do |c|
      2.times { assert_raises(OpenAI::Errors::TranslationProtocolError) { c.receive } }
      event = c.receive
      assert_instance_of(OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent, event)
      assert_equal(:pcm16, event.format_)
      assert_equal("keep", event.to_h.fetch(:future_audio_field))
    end
  end

  def test_string_keyed_typed_constructor_cannot_change_event_discriminator
    socket = FakeSocket.new
    client.realtime.connect_translation(model: "gpt-realtime-translate", transport: FakeTransport.new(socket)) do |c|
      bad = OpenAI::Realtime::RealtimeTranslationSessionCloseEvent.new(
        {"type" => "session.input_audio_buffer.append", "audio" => "AA=="}
      )
      assert_raises(ArgumentError) { c.send_event(bad) }
      assert_empty(socket.writes)
      c.send_event(OpenAI::Realtime::RealtimeTranslationSessionCloseEvent.new({"type" => "session.close"}))
      c.send_event(
        OpenAI::Realtime::RealtimeTranslationInputAudioBufferAppendEvent.new(
          {"type" => "session.input_audio_buffer.append", "audio" => "AA=="}
        )
      )
      assert_equal(
        ["session.close", "session.input_audio_buffer.append"],
        socket.writes.map { JSON.parse(_1).fetch("type") }
      )
    end
  end
end
