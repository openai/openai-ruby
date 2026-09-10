# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../../../examples/live/webrtc"

class OpenAI::Test::LiveWebRTCExampleTest < Minitest::Test
  class RecordingClient
    attr_reader :request_params

    def live = OpenAI::Resources::Live.new(client: self)

    def request(**params)
      @request_params = params
      OpenAI::Internal::Type::Converter.coerce(
        OpenAI::Live::LiveCreateResponse,
        {session: {id: "live_session_example"}, transport: {type: :webrtc, sdp: "answer"}}
      )
    end
  end

  def test_backend_sdp_handoff
    client = RecordingClient.new
    result = OpenAI::Examples::Live::WebRTC.create(client: client, offer_sdp: "offer")

    assert_equal(:post, client.request_params[:method])
    assert_equal("live/sessions", client.request_params[:path])
    assert_equal(
      {session: {model: "gpt-live-1"}, transport: {type: :webrtc, sdp: "offer"}},
      client.request_params[:body]
    )
    assert_equal("live_session_example", result.session.id)
    assert_equal("answer", result.transport.sdp)
    assert_empty(client.request_params[:options])
  end

  def test_model_inputs_preserve_explicit_null
    client = RecordingClient.new
    client.live.create(
      session: OpenAI::Live::MediaSessionConfig.new(model: "gpt-live-1", instructions: nil),
      transport: OpenAI::Live::LiveCreateParams::Transport.new(sdp: "offer")
    )

    assert_equal(
      {session: {model: "gpt-live-1", instructions: nil}, transport: {sdp: "offer", type: :webrtc}},
      client.request_params[:body]
    )
  end

  def test_response_selectors_survive_nested_hash_conversion
    selectors = [{type: "session.*"}, {type: "response.event", response_event: "response.output_text.delta"}]
    client = RecordingClient.new
    client.live.create(
      session: {model: "gpt-live-1", client: {data_channel: {allowed_server_events: selectors}}},
      transport: {type: :webrtc, sdp: "offer"}
    )

    assert_equal(selectors, client.request_params[:body].dig(:session, :client, :data_channel, :allowed_server_events))
    refute(client.request_params[:body][:session].key?(:instructions))
  end

  def test_transcript_event_decodes_to_typed_payload
    event = OpenAI::Internal::Type::Converter.coerce(
      OpenAI::Live::ServerEvent,
      {type: "session.input_transcript.delta", event_id: "event_example", delta: "Hello", start_ms: 0, end_ms: 500}
    )

    assert_instance_of(OpenAI::Live::InputTranscriptDeltaEvent, event)
    assert_equal("Hello", event.delta)
    assert_equal(0, event.start_ms)
    assert_equal(500, event.end_ms)
  end
end
