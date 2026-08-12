# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../../../examples/realtime/mcp_approval"
require_relative "../../../examples/realtime/sideband"
require_relative "../../../examples/realtime/sip"
require_relative "../../../examples/realtime/translation"
require_relative "../../../examples/realtime/websocket_audio"
require_relative "../../../examples/realtime/websocket_transcription"

class OpenAI::Test::RealtimeExampleStreamLifecycleTest < Minitest::Test
  class RecordingConnection
    def initialize(events = [])
      @events = events
    end

    def each(&block)
      @events.each(&block)
    end
  end

  class RaisingEndpoint
    attr_reader :calls

    def initialize(error)
      @error = error
      @calls = []
    end

    def append_bytes(bytes)
      @calls << [:append_bytes, bytes]
      raise @error
    end

    def close
      @calls << [:close]
      raise @error
    end
  end

  TranslationConnection = Data.define(:input_audio_buffer, :session)

  Event = Data.define(:type, :data) do
    def to_h = data
  end

  def test_sideband_rejects_eof_before_the_requested_event
    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::Sideband.stream(
        RecordingConnection.new,
        output: StringIO.new,
        stop_after: "session.updated"
      )
    end

    assert_equal("Realtime connection closed before session.updated", error.message)
  end

  def test_sip_rejects_eof_before_the_requested_event
    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::SIP.stream(
        RecordingConnection.new,
        output: StringIO.new,
        stop_after: "response.done"
      )
    end

    assert_equal("Realtime connection closed before response.done", error.message)
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

  def test_websocket_audio_accepts_audio_followed_by_a_completed_response
    audio = "pcm".b
    output = StringIO.new
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::ResponseAudioDeltaEvent.new(
          event_id: "event_1",
          response_id: "response_1",
          item_id: "item_1",
          output_index: 0,
          content_index: 0,
          delta: Base64.strict_encode64(audio)
        ),
        OpenAI::Realtime::ResponseDoneEvent.new(
          event_id: "event_2",
          response: OpenAI::Realtime::RealtimeResponse.new(
            id: "response_1",
            status: :completed
          )
        )
      ]
    )

    result = OpenAI::Examples::Realtime::WebSocketAudio.stream_response(
      connection,
      output: output
    )

    assert_nil(result)
    assert_equal(audio, output.string)
  end

  def test_websocket_audio_rejects_a_completed_response_without_audio
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

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::WebSocketAudio.stream_response(
        connection,
        output: StringIO.new
      )
    end

    assert_equal("Response completed without audio output", error.message)
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

  def test_translation_rejects_session_closed_without_audio
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::RealtimeTranslationSessionClosedEvent.new(
          event_id: "event_1"
        )
      ]
    )

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::Translation.stream(
        connection,
        audio_output: StringIO.new,
        transcript_output: StringIO.new
      )
    end

    assert_equal("Translation session closed without audio output", error.message)
  end

  def test_translation_accepts_audio_followed_by_session_closed
    audio = "translated pcm".b
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent.new(
          event_id: "event_1",
          delta: Base64.strict_encode64(audio)
        ),
        OpenAI::Realtime::RealtimeTranslationSessionClosedEvent.new(
          event_id: "event_2"
        )
      ]
    )
    audio_output = StringIO.new
    transcript_output = StringIO.new

    result = OpenAI::Examples::Realtime::Translation.stream(
      connection,
      audio_output: audio_output,
      transcript_output: transcript_output
    )

    assert_nil(result)
    assert_equal(audio, audio_output.string)
    assert_equal("\n", transcript_output.string)
  end

  def test_transcription_rejects_a_connection_that_closes_before_completion
    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::WebSocketTranscription.print_transcript(
        RecordingConnection.new,
        output: StringIO.new
      )
    end

    assert_equal("Realtime connection closed before transcription completed", error.message)
  end

  def test_transcription_accepts_only_a_completed_event
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent.new(
          content_index: 0,
          event_id: "event_1",
          item_id: "item_1",
          transcript: "Hello",
          usage: {type: :duration, seconds: 0.25}
        )
      ]
    )
    output = StringIO.new

    result = OpenAI::Examples::Realtime::WebSocketTranscription.print_transcript(
      connection,
      output: output
    )

    assert_nil(result)
    assert_equal("\n[item_1] Hello\n", output.string)
  end

  def test_translation_preserves_an_upload_error_when_session_close_also_fails
    upload_error = RuntimeError.new("upload failed")
    input_audio_buffer = RaisingEndpoint.new(upload_error)
    session = RaisingEndpoint.new(RuntimeError.new("close failed"))
    connection = TranslationConnection.new(input_audio_buffer, session)

    Tempfile.create("translation-input") do |input|
      input.write("audio")
      input.flush

      error = assert_raises(RuntimeError) do
        OpenAI::Examples::Realtime::Translation.write_input(connection, input.path)
      end

      assert_same(upload_error, error)
    end
    assert_equal([[:append_bytes, "audio"]], input_audio_buffer.calls)
    assert_equal([[:close]], session.calls)
  end
end
