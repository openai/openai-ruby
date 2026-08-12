# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../../../examples/realtime/translation"
require_relative "../../../examples/realtime/websocket_audio"

class OpenAI::Test::RealtimeExampleStreamLifecycleTest < Minitest::Test
  class RecordingConnection
    def initialize(events = [])
      @events = events
    end

    def each(&block)
      @events.each(&block)
    end
  end

  def test_websocket_audio_rejects_a_connection_that_closes_before_response_done
    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::WebSocketAudio.stream_response(
        RecordingConnection.new,
        output: StringIO.new
      )
    end

    assert_equal("Realtime connection closed before response.done", error.message)
  end

  def test_websocket_audio_accepts_only_a_completed_response
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::ResponseDoneEvent.new(
          event_id: "event_1",
          response: OpenAI::Realtime::RealtimeResponse.new(
            id: "response_1",
            status: :completed
          )
        )
      ]
    )

    result = OpenAI::Examples::Realtime::WebSocketAudio.stream_response(
      connection,
      output: StringIO.new
    )

    assert_nil(result)
  end

  def test_translation_rejects_a_connection_that_closes_before_session_closed
    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::Translation.stream(
        RecordingConnection.new,
        audio_output: StringIO.new,
        transcript_output: StringIO.new
      )
    end

    assert_equal(
      "Realtime translation connection closed before session.closed",
      error.message
    )
  end

  def test_translation_accepts_only_a_session_closed_event
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::RealtimeTranslationSessionClosedEvent.new(
          event_id: "event_1"
        )
      ]
    )

    transcript_output = StringIO.new
    result = OpenAI::Examples::Realtime::Translation.stream(
      connection,
      audio_output: StringIO.new,
      transcript_output: transcript_output
    )

    assert_nil(result)
    assert_equal("\n", transcript_output.string)
  end
end
