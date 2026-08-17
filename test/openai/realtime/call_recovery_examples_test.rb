# frozen_string_literal: true

require_relative "examples_test_case"
require_relative "../../../examples/realtime/sip"
require_relative "../../../examples/realtime/webrtc_conversation"

class OpenAI::Test::RealtimeCallRecoveryExamplesTest < OpenAI::Test::RealtimeExamplesTestCase
  WEBRTC_HEADERS = {
    "host" => "127.0.0.1:4567",
    "origin" => "http://127.0.0.1:4567"
  }.freeze

  def test_webrtc_conversation_requires_a_call_id_before_returning_sdp
    calls = RecordingWebRTCCalls.new
    calls.call_ids = [nil]
    app = OpenAI::Examples::Realtime::WebRTCConversation::App.new(
      client: RecordingClient.new(Data.define(:calls).new(calls)),
      html: "test"
    )
    response = HTTPResponse.new

    _stdout, _stderr = capture_io do
      app.handle(
        HTTPRequest.new(
          request_method: "POST",
          path: "/session",
          body: "v=0\r\nt=0 0\r\n",
          headers: {**WEBRTC_HEADERS, "content-type" => "application/sdp"}
        ),
        response
      )
    end

    assert_equal(502, response.status)
    assert_equal("Realtime request failed\n", response.body)
    refute(response.headers.key?("X-OpenAI-Call-ID"))
    assert_empty(calls.hangups)
  end

  def test_webrtc_conversation_repeats_completed_hangups_idempotently
    calls = RecordingWebRTCCalls.new
    app = OpenAI::Examples::Realtime::WebRTCConversation::App.new(
      client: RecordingClient.new(Data.define(:calls).new(calls)),
      html: "test"
    )
    app.handle(
      HTTPRequest.new(
        request_method: "POST",
        path: "/session",
        body: "v=0\r\nt=0 0\r\n",
        headers: {**WEBRTC_HEADERS, "content-type" => "application/sdp"}
      ),
      HTTPResponse.new
    )

    2.times do
      response = HTTPResponse.new
      app.handle(
        HTTPRequest.new(
          request_method: "POST",
          path: "/hangup",
          body: "rtc_example",
          headers: WEBRTC_HEADERS
        ),
        response
      )
      assert_equal(204, response.status)
    end

    assert_equal(["rtc_example"], calls.hangups)
  end

  def test_sip_example_hangs_up_after_an_ambiguous_accept_failure
    realtime = RecordingRealtime.new(RecordingConnection.new)
    realtime.calls.accept_error = IOError.new("accept response lost")
    realtime.calls.hangup_error = RuntimeError.new("hangup failed")

    error = assert_raises(IOError) do
      OpenAI::Examples::Realtime::SIP.run(
        client: RecordingClient.new(realtime: realtime),
        call_id: "rtc_123",
        model: "gpt-realtime-2.1",
        output: StringIO.new
      )
    end

    assert_equal("accept response lost", error.message)
    assert_equal(["rtc_123"], realtime.calls.hangups)
  end
end
