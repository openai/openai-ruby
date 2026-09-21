# frozen_string_literal: true

require_relative "connection_test_support"

class OpenAI::Test::RealtimeSessionEventValidationTest < Minitest::Test
  include OpenAI::Test::RealtimeConnectionTestSupport

  def test_supported_session_events_remain_typed
    event_classes.each do |type, event_class|
      event = receive({type: type, session: {type: "realtime", model: "gpt-realtime"}})

      assert_instance_of(event_class, event)
      assert_instance_of(OpenAI::Realtime::RealtimeSessionCreateRequest, event.session)
      assert_equal(:realtime, event.session.type)

      event = receive({type: type, session: transcription_session}, transcription: true)

      assert_instance_of(event_class, event)
      assert_instance_of(OpenAI::Realtime::RealtimeTranscriptionSessionCreateRequest, event.session)
      assert_equal(:transcription, event.session.type)
      assert_equal("sess_synthetic", event.session.to_h.fetch(:id))
      refute_includes(event.session.to_h.keys, :client_secret)
      assert_nil(event.session.include)
      assert_nil(event.session.audio.input.transcription)
      assert_nil(event.session.audio.input.noise_reduction)
      assert_nil(event.session.audio.input.turn_detection)
    end
  end

  def test_known_session_events_reject_missing_or_invalid_session_shapes
    invalid_sessions = [nil, [], "transcription", 7, true, {}]
    invalid_sessions.concat(
      [nil, 7, true, {}, [], "unsupported-private-session"].map { {type: _1} }
    )

    event_classes.each_key do |type|
      assert_protocol_error(type: type)
      invalid_sessions.each { |session| assert_protocol_error(type: type, session: session) }
    end
  end

  def test_supported_transcription_tag_still_rejects_malformed_fields
    event_classes.each_key do |type|
      assert_protocol_error(type: type, session: {type: "transcription", include: 7})
    end
  end

  def test_unknown_outer_event_names_remain_observable
    %w[future.unknown.event transcription_session.created transcription_session.updated].each do |type|
      payload = {type: type, event_id: "evt_synthetic", session: {type: "unsupported-private-session"}}
      event = receive(payload)

      assert_instance_of(OpenAI::Realtime::UnknownServerEvent, event)
      assert_equal(type.to_sym, event.type)
      assert_equal(payload, event.to_h)
      assert_predicate(event, :frozen?)
      assert_predicate(event.data.fetch(:session), :frozen?)
    end
  end

  private def event_classes
    {
      "session.created" => OpenAI::Realtime::SessionCreatedEvent,
      "session.updated" => OpenAI::Realtime::SessionUpdatedEvent
    }
  end

  private def transcription_session
    {
      type: "transcription",
      object: "realtime.transcription_session",
      id: "sess_synthetic",
      expires_at: 2_000_000_000,
      include: nil,
      audio: {
        input: {
          format: {type: "audio/pcm", rate: 24_000},
          transcription: nil,
          noise_reduction: nil,
          turn_detection: nil
        }
      }
    }
  end

  private def receive(payload, transcription: false)
    socket = FakeSocket.new(JSON.generate({event_id: "evt_synthetic", **payload}))
    transport = FakeTransport.new(socket)
    if transcription
      client.realtime.connect_transcription(transport: transport, &:receive)
    else
      client.realtime.connect(model: "gpt-realtime", transport: transport, &:receive)
    end

  ensure
    assert_predicate(socket, :closed?)
  end

  private def assert_protocol_error(payload)
    error = assert_raises(OpenAI::Errors::RealtimeProtocolError) { receive(payload) }
    assert_equal("Invalid Realtime WebSocket event.", error.message)
    refute_includes(error.message, "unsupported-private-session")
    refute_includes(error.full_message, "unsupported-private-session")
    refute_includes(error.cause.message, "unsupported-private-session")
  end
end
