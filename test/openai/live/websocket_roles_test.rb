# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../responses_websocket/connection_test_support"

class OpenAI::Test::LiveWebSocketRolesTest < Minitest::Test
  include OpenAI::Test::ResponsesWebSocketConnectionTestSupport

  def test_sideband_replays_without_startup_and_only_accepts_established_session_commands
    socket = FakeSocket.new(
      JSON.generate(type: "session.input_audio.append", audio: "AA=="),
      JSON.generate(type: "session.future", added: {nested: ["future"]}),
      JSON.generate(
        type: "error",
        event_id: "err_1",
        error: {type: "invalid_request_error", code: "denied", message: "no write scope"}
      )
    )
    returned = client.live.sideband.connect("live_readable", transport: FakeTransport.new(socket)) do |connection|
      assert_empty(socket.writes)
      reflected = connection.receive
      assert_instance_of(OpenAI::Live::ServerEvent::SessionInputAudioAppend, reflected)
      assert_equal("AA==", reflected.audio)
      assert_instance_of(OpenAI::Live::UnknownServerEvent, connection.receive)
      [
        {type: "session.start", session: {model: "gpt-live-1"}},
        OpenAI::Live::SessionStartEvent.new(session: {model: "gpt-live-1"}),
        {type: "session.input_audio.append", audio: "AA=="},
        OpenAI::Live::InputAudioAppendEvent.new(audio: "AA==")
      ].each { |event| assert_raises(ArgumentError) { connection.send_event(event) } }
      assert_empty(socket.writes)
      connection.send_event(type: "session.input_audio.mute")
      assert_instance_of(OpenAI::Live::ErrorEvent, connection.receive)
      :replayed
    end

    assert_equal(:replayed, returned)
    assert_equal(["session.input_audio.mute"], socket.writes.map { JSON.parse(_1).fetch("type") })
    assert_predicate(socket, :closed?)
  end

  def test_fork_uses_overrides_not_new_primary_or_frontend_configuration
    socket = FakeSocket.new(
      JSON.generate(
        type: "session.started",
        event_id: "evt_1",
        session: {id: "live_forked", model: "gpt-live-1", expires_at: 2_000_000_000, status: "active"}
      ),
      JSON.generate(type: "session.input_audio.append", audio: "AA==")
    )
    client.live.forks.connect("live_finalized", transport: FakeTransport.new(socket)) do |connection|
      assert_empty(socket.writes)
      [
        {type: "session.start", session: {model: "gpt-live-1"}},
        OpenAI::Live::SessionStartEvent.new(session: {model: "gpt-live-1"}),
        {type: "session.start", session: {client: {data_channel: {}}}},
        OpenAI::Live::ForkSessionStartEvent.new(session: {"model" => "gpt-live-1"}),
        OpenAI::Live::ForkSessionStartEvent.new(session: {"client" => {data_channel: {}}})
      ].each { |event| assert_raises(ArgumentError) { connection.send_event(event) } }
      assert_empty(socket.writes)
      connection.send_event(OpenAI::Live::ForkSessionStartEvent.new(session: {}))
      assert_equal({"type" => "session.start", "session" => {}}, JSON.parse(socket.writes.first))
      assert_equal("live_forked", connection.receive.session.id)
      assert_instance_of(OpenAI::Live::ForkServerEvent::SessionInputAudioAppend, connection.receive)
      connection.send_event(type: "session.input_audio.append", audio: "AA==")
    end

    assert_equal(["session.start", "session.input_audio.append"], socket.writes.map { JSON.parse(_1).fetch("type") })
  end

  def test_role_request_paths_cannot_escape_the_selected_session_and_use_selected_headers
    [[client.live.sideband, "attach"], [client.live.forks, "fork"]].each do |resource, suffix|
      socket = FakeSocket.new
      transport = FakeTransport.new(socket)
      resource
        .connect(
          "live_safe/../x?model=private#fragment",
          websocket_base_url: "https://other.example/v1",
          request_options: {extra_headers: {"Authorization" => "Bearer fake-observer", "X-Live" => "custom"}},
          transport: transport
        ) { |_connection| nil }
      request = transport.open_args
      assert_equal(
        "/v1/live/sessions/live_safe%2F..%2Fx%3Fmodel=private%23fragment/#{suffix}",
        request.fetch(:url).path
      )
      assert_nil(request.fetch(:url).query)
      assert_nil(request.fetch(:url).fragment)
      assert_equal("Bearer fake-observer", request.fetch(:headers).fetch("authorization"))
      assert_equal("custom", request.fetch(:headers).fetch("x-live"))
    end
  end

  def test_invalid_role_requests_fail_before_connecting
    [[client.live.sideband, "live_a"], [client.live.forks, "live_a"]].each do |resource, session_id|
      transport = FakeTransport.new(FakeSocket.new)
      assert_raises(ArgumentError) { resource.connect(session_id, transport: transport) }
      assert_raises(ArgumentError) do
        resource.connect(session_id, transport: transport, request_options: {extra_query: {model: "gpt-live-1"}}) {
          flunk
        }
      end

      assert_nil(transport.open_args)
    end
  end

  def test_sideband_graceful_close_is_tristate_and_never_moves_to_other_live_roles
    [true, false, nil].each do |setting|
      transport = FakeTransport.new(FakeSocket.new)
      client.live.sideband.connect("live_a", graceful_close: setting, transport: transport) { |_c| nil }
      url = transport.open_args.fetch(:url)
      expected = setting.nil? ? [] : [["graceful_close", setting.to_s]]
      assert_equal(expected, URI.decode_www_form(url.query.to_s))
    end

    [client.live, client.live.forks].each do |resource|
      transport = FakeTransport.new(FakeSocket.new)
      positional = resource == client.live ? [] : ["live_a"]
      assert_raises(ArgumentError) {
        resource.connect(*positional, graceful_close: true, transport: transport) { |_c| nil }
      }
      assert_nil(transport.open_args)
    end

    transport = FakeTransport.new(FakeSocket.new)
    assert_raises(ArgumentError) {
      client.live.sideband.connect("live_a", graceful_close: "false", transport: transport) { |_c| nil }
    }
    assert_nil(transport.open_args)
  end
end
