# frozen_string_literal: true

require "stringio"

require_relative "../test_helper"
require_relative "../../../examples/realtime/websocket_transcription"

class OpenAI::Test::RealtimeWebSocketTranscriptionExampleTest < Minitest::Test
  class RecordingSession
    attr_reader :updates

    def initialize = @updates = []
    def update(**params) = @updates << params
  end

  class RecordingInputAudioBuffer
    attr_reader :appends, :commits

    def initialize
      @appends = []
      @commits = []
    end

    def append_bytes(bytes, event_id: nil) = @appends << {bytes: bytes, event_id: event_id}
    def commit(event_id: nil) = @commits << {event_id: event_id}
  end

  class RecordingConnection
    attr_reader :input_audio_buffer, :session

    def initialize(events)
      @events = events
      @input_audio_buffer = RecordingInputAudioBuffer.new
      @session = RecordingSession.new
    end

    def each(&block) = @events.each(&block)
  end

  class RecordingRealtime
    attr_reader :connection_count

    def initialize(connection)
      @connection = connection
      @connection_count = 0
    end

    def connect_transcription
      @connection_count += 1
      yield(@connection)
    end
  end

  RecordingClient = Data.define(:realtime)

  def test_example_streams_pcm_and_requires_a_completed_transcript_for_the_committed_item
    connection = RecordingConnection.new(successful_events)
    realtime = RecordingRealtime.new(connection)
    output = StringIO.new

    transcript = OpenAI::Examples::Realtime::WebSocketTranscription.run(
      client: RecordingClient.new(realtime: realtime),
      input: StringIO.new("abcdef".b),
      model: "gpt-transcribe",
      chunk_bytes: 2,
      output: output
    )

    assert_equal("Hello from Ruby.", transcript)
    assert_equal(1, realtime.connection_count)
    assert_equal(%w[ab cd ef], connection.input_audio_buffer.appends.map { _1.fetch(:bytes) })
    assert_equal([{event_id: nil}], connection.input_audio_buffer.commits)
    assert_equal(:transcription, connection.session.updates.fetch(0).fetch(:type))
    assert_equal(
      {type: :"audio/pcm", rate: 24_000},
      connection.session.updates.fetch(0).dig(:audio, :input, :format)
    )
    assert_equal(
      {model: "gpt-transcribe"},
      connection.session.updates.fetch(0).dig(:audio, :input, :transcription)
    )
    assert_nil(connection.session.updates.fetch(0).dig(:audio, :input, :turn_detection))
    assert_includes(output.string, "Hello from Ruby.")
    assert_includes(output.string, "item=item_1")
    assert_includes(output.string, "transcription smoke test passed")
  end

  def test_example_rejects_empty_input_before_opening_a_connection
    realtime = RecordingRealtime.new(RecordingConnection.new([]))

    error = assert_raises(ArgumentError) do
      OpenAI::Examples::Realtime::WebSocketTranscription.run(
        client: RecordingClient.new(realtime: realtime),
        input: StringIO.new("".b),
        model: "gpt-transcribe",
        output: StringIO.new
      )
    end

    assert_equal("PCM input is empty", error.message)
    assert_equal(0, realtime.connection_count)
  end

  def test_example_fails_closed_without_a_matching_completion
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::InputAudioBufferCommittedEvent.new(
          event_id: "event_committed",
          item_id: "item_1"
        ),
        completed_event(item_id: "item_2")
      ]
    )

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::WebSocketTranscription.run(
        client: RecordingClient.new(realtime: RecordingRealtime.new(connection)),
        input: StringIO.new("pcm".b),
        model: "gpt-transcribe",
        output: StringIO.new
      )
    end

    assert_equal("Realtime connection closed before the committed audio was transcribed", error.message)
  end

  def test_example_keeps_transcription_error_details_out_of_the_exception_message
    customer_text = "private audio content in a service error"
    failed = OpenAI::Realtime::ConversationItemInputAudioTranscriptionFailedEvent.new(
      content_index: 0,
      error: {message: customer_text, type: "transcription_error"},
      event_id: "event_failed",
      item_id: "item_1"
    )
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::InputAudioBufferCommittedEvent.new(
          event_id: "event_committed",
          item_id: "item_1"
        ),
        failed
      ]
    )

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::WebSocketTranscription.run(
        client: RecordingClient.new(realtime: RecordingRealtime.new(connection)),
        input: StringIO.new("pcm".b),
        model: "gpt-transcribe",
        output: StringIO.new
      )
    end

    assert_equal("Realtime transcription failed.", error.message)
    refute_includes(error.message, customer_text)
  end

  def test_example_prints_the_final_transcript_when_the_service_sends_no_deltas
    connection = RecordingConnection.new(
      [
        OpenAI::Realtime::InputAudioBufferCommittedEvent.new(
          event_id: "event_committed",
          item_id: "item_1"
        ),
        completed_event(item_id: "item_1")
      ]
    )
    output = StringIO.new

    transcript = OpenAI::Examples::Realtime::WebSocketTranscription.run(
      client: RecordingClient.new(realtime: RecordingRealtime.new(connection)),
      input: StringIO.new("pcm".b),
      model: "gpt-transcribe",
      output: output
    )

    assert_equal("Hello from Ruby.", transcript)
    assert_includes(output.string, "Hello from Ruby.")
  end

  private def successful_events
    [
      OpenAI::Realtime::SessionCreatedEvent.new(
        event_id: "event_created",
        session: {type: :transcription}
      ),
      OpenAI::Realtime::SessionUpdatedEvent.new(
        event_id: "event_updated",
        session: {
          type: :transcription,
          audio: {
            input: {
              format: {type: :"audio/pcm", rate: 24_000},
              transcription: {model: :"gpt-transcribe"},
              turn_detection: nil
            }
          }
        }
      ),
      OpenAI::Realtime::InputAudioBufferCommittedEvent.new(
        event_id: "event_committed",
        item_id: "item_1"
      ),
      OpenAI::Realtime::ConversationItemInputAudioTranscriptionDeltaEvent.new(
        content_index: 0,
        delta: "Hello from Ruby.",
        event_id: "event_delta",
        item_id: "item_1"
      ),
      completed_event(item_id: "item_1")
    ]
  end

  private def completed_event(item_id:)
    OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent.new(
      content_index: 0,
      event_id: "event_completed",
      item_id: item_id,
      transcript: "Hello from Ruby.",
      usage: {type: :duration, seconds: 0.25}
    )
  end
end
