# frozen_string_literal: true

require "stringio"

require_relative "../test_helper"
require_relative "../../../examples/realtime/websocket_voice_turn"

class OpenAI::Test::RealtimeWebSocketVoiceTurnExampleTest < Minitest::Test
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

  class RecordingResponse
    attr_reader :creates

    def initialize = @creates = []
    def create(**params) = @creates << params
  end

  class RecordingConnection
    attr_reader :input_audio_buffer, :response, :session

    def initialize(events)
      @events = events
      @input_audio_buffer = RecordingInputAudioBuffer.new
      @response = RecordingResponse.new
      @session = RecordingSession.new
    end

    def each(&block) = @events.each(&block)
  end

  class ProtocolFailureConnection < RecordingConnection
    def initialize(error)
      super([])
      @error = error
    end

    def each
      raise @error
    end
  end

  class BlockingInput
    def binmode = self
    def read(_bytes) = sleep(60)
  end

  class SystemCallFailureInput
    def binmode = self

    def read(_bytes)
      raise Errno::ENOENT, "private-customer-audio.pcm"
    end
  end

  class RecordingRealtime
    attr_reader :models

    def initialize(connection)
      @connection = connection
      @models = []
    end

    def connect(model:)
      @models << model
      yield(@connection)
    end
  end

  RecordingClient = Data.define(:realtime)

  def test_example_streams_one_committed_voice_turn
    connection = RecordingConnection.new(successful_events)
    realtime = RecordingRealtime.new(connection)
    audio_output = StringIO.new("".b)
    diagnostics = StringIO.new

    transcript = OpenAI::Examples::Realtime::WebSocketVoiceTurn.run(
      client: RecordingClient.new(realtime: realtime),
      input: StringIO.new("abcdef".b),
      audio_output: audio_output,
      model: "gpt-realtime-2.1",
      voice: :marin,
      chunk_bytes: 2,
      output: diagnostics
    )

    assert_equal("Hello from Ruby.", transcript)
    assert_equal("voice-response".b, audio_output.string)
    assert_equal(["gpt-realtime-2.1"], realtime.models)
    assert_equal(%w[ab cd ef], connection.input_audio_buffer.appends.map { _1.fetch(:bytes) })
    assert_equal([{event_id: nil}], connection.input_audio_buffer.commits)
    assert_equal([{}], connection.response.creates)

    session = connection.session.updates.fetch(0)
    assert_equal(:realtime, session.fetch(:type))
    assert_equal([:audio], session.fetch(:output_modalities))
    assert_equal(
      {type: :"audio/pcm", rate: 24_000},
      session.dig(:audio, :input, :format)
    )
    assert_nil(session.dig(:audio, :input, :turn_detection))
    assert_equal(
      {type: :"audio/pcm", rate: 24_000},
      session.dig(:audio, :output, :format)
    )
    assert_equal(:marin, session.dig(:audio, :output, :voice))
    refute_includes(diagnostics.string, "Hello from Ruby.")
    assert_includes(diagnostics.string, "response.done status=completed")
    refute_includes(diagnostics.string, "voice turn smoke test passed")
  end

  def test_example_rejects_empty_input_before_connecting
    realtime = RecordingRealtime.new(RecordingConnection.new([]))

    error = assert_raises(ArgumentError) do
      OpenAI::Examples::Realtime::WebSocketVoiceTurn.run(
        client: RecordingClient.new(realtime: realtime),
        input: StringIO.new("".b),
        audio_output: StringIO.new("".b),
        model: "gpt-realtime-2.1",
        voice: :marin,
        output: StringIO.new
      )
    end

    assert_equal("PCM input is empty", error.message)
    assert_empty(realtime.models)
  end

  def test_example_requires_a_completed_response
    error = assert_raises(RuntimeError) do
      run_with_events([audio_delta("audio"), response_done(status: :cancelled)])
    end

    assert_equal("Realtime response did not complete.", error.message)
  end

  def test_example_requires_audio_output
    error = assert_raises(RuntimeError) do
      run_with_events([transcript_delta("Hello"), response_done])
    end

    assert_equal("Realtime response completed without audio output", error.message)
  end

  def test_example_requires_an_audio_transcript
    error = assert_raises(RuntimeError) do
      run_with_events([audio_delta("audio"), response_done])
    end

    assert_equal(
      "Realtime response completed without an audio transcript",
      error.message
    )
  end

  def test_example_requires_response_done
    error = assert_raises(RuntimeError) do
      run_with_events([audio_delta("audio")])
    end

    assert_equal("Realtime connection closed before response.done", error.message)
  end

  def test_example_uses_the_final_transcript_when_no_deltas_arrive
    diagnostics = StringIO.new
    transcript = OpenAI::Examples::Realtime::WebSocketVoiceTurn.run(
      client: RecordingClient.new(
        realtime: RecordingRealtime.new(
          RecordingConnection.new([audio_delta("audio"), transcript_done("Final words."), response_done])
        )
      ),
      input: StringIO.new("pcm".b),
      audio_output: StringIO.new("".b),
      model: "gpt-realtime-2.1",
      voice: :marin,
      output: diagnostics
    )

    assert_equal("Final words.", transcript)
    refute_includes(diagnostics.string, "Final words.")
  end

  def test_stream_boundary_rejects_an_empty_authoritative_transcript
    events = [
      transcript_delta("Stale streamed words."),
      transcript_done(""),
      audio_delta("audio"),
      response_done
    ]
    diagnostics = StringIO.new

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::WebSocketVoiceTurn.run_with_timeout(
        client: RecordingClient.new(
          realtime: RecordingRealtime.new(RecordingConnection.new(events))
        ),
        input: StringIO.new("pcm".b),
        audio_output: StringIO.new("".b),
        model: "gpt-realtime-2.1",
        voice: :marin,
        timeout_seconds: 1,
        output: diagnostics
      )
    end

    assert_equal("Realtime response completed without an audio transcript", error.message)
    refute_includes(diagnostics.string, "voice turn smoke test passed")
  end

  def test_example_keeps_service_error_details_out_of_the_exception_message
    customer_text = "private audio content echoed by the service"
    event = OpenAI::Realtime::RealtimeErrorEvent.new(
      event_id: "event_error",
      error: OpenAI::Realtime::RealtimeError.new(
        message: customer_text,
        type: "invalid_request_error"
      )
    )

    error = assert_raises(RuntimeError) { run_with_events([event]) }

    assert_equal("Realtime API error.", error.message)
    refute_includes(error.message, customer_text)
  end

  def test_example_rejects_invalid_base64_audio
    event = OpenAI::Realtime::ResponseAudioDeltaEvent.new(
      content_index: 0,
      delta: "not base64!",
      event_id: "event_audio",
      item_id: "item_1",
      output_index: 0,
      response_id: "response_1"
    )

    error = assert_raises(RuntimeError) { run_with_events([event]) }

    assert_equal("Realtime returned invalid audio data.", error.message)
  end

  def test_stream_boundary_streams_audio_and_returns_transcript
    realtime = RecordingRealtime.new(RecordingConnection.new(successful_events))
    audio_output = StringIO.new("".b)
    transcript = nil

    stdout, stderr = capture_io do
      transcript = OpenAI::Examples::Realtime::WebSocketVoiceTurn.run_with_timeout(
        client: RecordingClient.new(realtime: realtime),
        input: StringIO.new("pcm".b),
        audio_output: audio_output,
        model: "gpt-realtime-2.1",
        voice: :marin,
        timeout_seconds: 1
      )
    end

    assert_equal("Hello from Ruby.", transcript)
    assert_equal("voice-response".b, audio_output.string)
    assert_empty(stdout)
    assert_equal("[realtime] voice turn smoke test passed\n", stderr.lines.last)
    refute_includes(stderr, transcript)
  end

  def test_stream_boundary_deadline_covers_the_initial_input_read
    realtime = RecordingRealtime.new(RecordingConnection.new(successful_events))
    diagnostics = StringIO.new

    assert_raises(Timeout::Error) do
      OpenAI::Examples::Realtime::WebSocketVoiceTurn.run_with_timeout(
        client: RecordingClient.new(realtime: realtime),
        input: BlockingInput.new,
        audio_output: StringIO.new("".b),
        model: "gpt-realtime-2.1",
        voice: :marin,
        timeout_seconds: 0.05,
        output: diagnostics
      )
    end

    assert_empty(realtime.models)
    refute_includes(diagnostics.string, "voice turn smoke test passed")
  end

  def test_stream_boundary_suppresses_protocol_error_data_and_cause
    customer_data = "private malformed frame content"
    protocol_error = OpenAI::Errors::RealtimeProtocolError.new(
      data: customer_data,
      cause: JSON::ParserError.new(customer_data)
    )
    realtime = RecordingRealtime.new(ProtocolFailureConnection.new(protocol_error))
    diagnostics = StringIO.new

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::WebSocketVoiceTurn.run_with_timeout(
        client: RecordingClient.new(realtime: realtime),
        input: StringIO.new("pcm".b),
        audio_output: StringIO.new("".b),
        model: "gpt-realtime-2.1",
        voice: :marin,
        timeout_seconds: 1,
        output: diagnostics
      )
    end

    assert_instance_of(RuntimeError, error)
    assert_equal("Realtime protocol error.", error.message)
    assert_nil(error.cause)
    refute_includes(error.full_message, customer_data)
    refute_includes(diagnostics.string, customer_data)
  end

  def test_stream_boundary_suppresses_system_call_error_details
    customer_path = "private-customer-audio.pcm"
    realtime = RecordingRealtime.new(RecordingConnection.new(successful_events))

    error = assert_raises(RuntimeError) do
      OpenAI::Examples::Realtime::WebSocketVoiceTurn.run_with_timeout(
        client: RecordingClient.new(realtime: realtime),
        input: SystemCallFailureInput.new,
        audio_output: StringIO.new("".b),
        model: "gpt-realtime-2.1",
        voice: :marin,
        timeout_seconds: 1,
        output: StringIO.new
      )
    end

    assert_equal("Realtime stream I/O error.", error.message)
    assert_nil(error.cause)
    refute_includes(error.full_message, customer_path)
    assert_empty(realtime.models)
  end

  private def run_with_events(events)
    OpenAI::Examples::Realtime::WebSocketVoiceTurn.run(
      client: RecordingClient.new(realtime: RecordingRealtime.new(RecordingConnection.new(events))),
      input: StringIO.new("pcm".b),
      audio_output: StringIO.new("".b),
      model: "gpt-realtime-2.1",
      voice: :marin,
      output: StringIO.new
    )
  end

  private def successful_events
    [
      OpenAI::Realtime::SessionCreatedEvent.new(
        event_id: "event_created",
        session: {type: :realtime}
      ),
      OpenAI::Realtime::SessionUpdatedEvent.new(
        event_id: "event_updated",
        session: {type: :realtime, output_modalities: [:audio]}
      ),
      OpenAI::Realtime::InputAudioBufferCommittedEvent.new(
        event_id: "event_committed",
        item_id: "item_1"
      ),
      transcript_delta("Hello from Ruby."),
      audio_delta("voice-"),
      audio_delta("response"),
      response_done
    ]
  end

  private def audio_delta(bytes)
    OpenAI::Realtime::ResponseAudioDeltaEvent.new(
      content_index: 0,
      delta: [bytes].pack("m0"),
      event_id: "event_audio",
      item_id: "item_1",
      output_index: 0,
      response_id: "response_1"
    )
  end

  private def transcript_delta(text)
    OpenAI::Realtime::ResponseAudioTranscriptDeltaEvent.new(
      content_index: 0,
      delta: text,
      event_id: "event_transcript",
      item_id: "item_1",
      output_index: 0,
      response_id: "response_1"
    )
  end

  private def transcript_done(text)
    OpenAI::Realtime::ResponseAudioTranscriptDoneEvent.new(
      content_index: 0,
      event_id: "event_transcript_done",
      item_id: "item_1",
      output_index: 0,
      response_id: "response_1",
      transcript: text
    )
  end

  private def response_done(status: :completed)
    OpenAI::Realtime::ResponseDoneEvent.new(
      event_id: "event_done",
      response: OpenAI::Realtime::RealtimeResponse.new(
        id: "response_1",
        status: status,
        output: []
      )
    )
  end
end
