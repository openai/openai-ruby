# frozen_string_literal: true

require_relative "connection_test_support"

class OpenAI::Test::RealtimeSidebandConnectionTest < Minitest::Test
  include OpenAI::Test::RealtimeConnectionTestSupport

  def test_connect_to_call_opens_an_authenticated_sideband_connection
    socket = FakeSocket.new(text_delta("hello"))
    transport = FakeTransport.new(socket)

    result = client
      .realtime
      .connect_to_call(
        call_id: "rtc_123",
        request_options: {
          extra_headers: {"X-Trace-ID" => "trace_1"},
          timeout: 12
        },
        transport: transport,
        transport_options: {max_frame_size: 1_024}
      ) do |connection|
        assert_instance_of(OpenAI::Realtime::SidebandConnection, connection)
        assert_instance_of(OpenAI::Realtime::ResponseTextDeltaEvent, connection.receive)
        :sideband_result
      end

    assert_equal(:sideband_result, result)
    assert_equal("wss://example.com/v1/realtime?call_id=rtc_123", transport.open_args[:url].to_s)
    assert_equal("Bearer test-key", transport.open_args[:headers].fetch("authorization"))
    assert_equal("trace_1", transport.open_args[:headers].fetch("x-trace-id"))
    assert_equal(12.0, transport.open_args[:timeout])
    assert_equal({max_frame_size: 1_024}, transport.open_args[:options])
    assert_predicate(socket, :closed?)
  end

  def test_connect_to_call_requires_a_block
    error = assert_raises(ArgumentError) do
      client.realtime.connect_to_call(call_id: "rtc_123")
    end

    assert_equal("A block is required to open a Realtime WebSocket.", error.message)
  end

  def test_connect_to_call_rejects_missing_or_non_string_call_ids
    [nil, "", 123].each do |call_id|
      transport = FakeTransport.new(FakeSocket.new)

      error = assert_raises(ArgumentError) do
        client.realtime.connect_to_call(call_id: call_id, transport: transport) { |_connection| nil }
      end

      assert_equal("`call_id` must be a non-empty String.", error.message)
      assert_nil(transport.open_args)
    end
  end

  def test_connect_to_call_snapshots_and_encodes_the_call_id
    call_id = +"rtc_123&model=attacker#fragment"
    transport = FakeTransport.new(FakeSocket.new)

    client.realtime.connect_to_call(call_id: call_id, transport: transport) do |_connection|
      call_id.replace("attacker-controlled-call")
      nil
    end

    assert_equal(
      [["call_id", "rtc_123&model=attacker#fragment"]],
      URI.decode_www_form(transport.open_args.fetch(:url).query)
    )
    assert_nil(transport.open_args.fetch(:url).fragment)
  end

  def test_connect_to_call_supports_an_explicit_websocket_base_url
    transport = FakeTransport.new(FakeSocket.new)

    client
      .realtime
      .connect_to_call(
        call_id: "rtc_123",
        websocket_base_url: "wss://socket.example.test/custom/v2",
        transport: transport
      ) { |_connection| nil }

    assert_equal(
      "wss://socket.example.test/custom/v2/realtime?call_id=rtc_123",
      transport.open_args.fetch(:url).to_s
    )
  end

  def test_connect_to_call_rejects_caller_controlled_query_parameters
    transport = FakeTransport.new(FakeSocket.new)

    error = assert_raises(ArgumentError) do
      client
        .realtime
        .connect_to_call(
          call_id: "rtc_123",
          request_options: {extra_query: {"call_id" => "attacker-controlled-call"}},
          transport: transport
        ) { |_connection| nil }
    end

    assert_equal(
      "`request_options[:extra_query]` is not supported for Realtime WebSocket connections; " \
        "omit it",
      error.message
    )
    assert_nil(transport.open_args)
  end

  def test_connect_to_call_rejects_transport_options_that_override_authenticated_inputs
    transport = FakeTransport.new(FakeSocket.new)

    error = assert_raises(ArgumentError) do
      client
        .realtime
        .connect_to_call(
          call_id: "rtc_123",
          transport: transport,
          transport_options: {headers: {"authorization" => "Bearer attacker"}}
        ) { |_connection| nil }
    end

    assert_includes(error.message, ":headers")
    assert_nil(transport.open_args)
  end

  def test_connect_to_call_never_forwards_proxy_credentials_to_the_origin
    transport = FakeTransport.new(FakeSocket.new)
    configured = client(default_headers: {"Proxy-Authorization" => "Basic configured-secret"})

    configured
      .realtime
      .connect_to_call(
        call_id: "rtc_123",
        request_options: {extra_headers: {"proxy-authorization" => "Basic request-secret"}},
        transport: transport
      ) { |_connection| nil }

    refute(transport.open_args.fetch(:headers).key?("proxy-authorization"))
  end

  def test_only_sideband_connections_expose_output_audio_buffer_controls
    client.realtime.connect(
      model: "gpt-realtime-2.1",
      transport: FakeTransport.new(FakeSocket.new)
    ) do |connection|
      refute_respond_to(connection, :output_audio_buffer)
    end

    client.realtime.connect_transcription(transport: FakeTransport.new(FakeSocket.new)) do |connection|
      refute_respond_to(connection, :output_audio_buffer)
    end

    client.realtime.connect_to_call(
      call_id: "rtc_123",
      transport: FakeTransport.new(FakeSocket.new)
    ) do |connection|
      assert_respond_to(connection, :output_audio_buffer)
    end
  end

  def test_sideband_output_audio_buffer_emits_a_typed_clear_event
    socket = FakeSocket.new

    client.realtime.connect_to_call(call_id: "rtc_123", transport: FakeTransport.new(socket)) do |connection|
      connection.output_audio_buffer.clear(event_id: "clear_1")
    end

    assert_equal(
      {"type" => "output_audio_buffer.clear", "event_id" => "clear_1"},
      JSON.parse(socket.writes.fetch(0))
    )
  end

  def test_sideband_interruption_preserves_cancel_truncate_clear_order
    socket = FakeSocket.new

    client.realtime.connect_to_call(call_id: "rtc_123", transport: FakeTransport.new(socket)) do |connection|
      connection.response.cancel
      connection.conversation.items.truncate(item_id: "item_1", content_index: 0, audio_end_ms: 640)
      connection.output_audio_buffer.clear
    end

    assert_equal(
      %w[response.cancel conversation.item.truncate output_audio_buffer.clear],
      socket.writes.map { JSON.parse(_1).fetch("type") }
    )
  end

  def test_connect_to_call_aborts_on_application_failure_without_masking_it
    socket = FakeSocket.new
    failure = RuntimeError.new("application failed")

    error = assert_raises(RuntimeError) do
      client.realtime.connect_to_call(call_id: "rtc_123", transport: FakeTransport.new(socket)) do |_connection|
        raise failure
      end
    end

    assert_same(failure, error)
    assert_predicate(socket, :aborted?)
  end

  def test_closed_sideband_connections_redact_call_ids_from_connection_errors
    socket = FakeSocket.new

    client.realtime.connect_to_call(call_id: "rtc_sensitive", transport: FakeTransport.new(socket)) do |connection|
      connection.close

      error = assert_raises(OpenAI::Errors::RealtimeConnectionError) do
        connection.send_raw("{}")
      end

      assert_equal("call_id=[REDACTED]", error.url.query)
      refute_includes(error.url.to_s, "rtc_sensitive")
      assert_includes(connection.url.to_s, "rtc_sensitive")
    end
  end
end
