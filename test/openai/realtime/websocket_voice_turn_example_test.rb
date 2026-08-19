# frozen_string_literal: true

require "stringio"
require "tmpdir"

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

  class RecordingRealtime
    attr_reader :models

    def initialize(connection, after_connect: nil)
      @after_connect = after_connect
      @connection = connection
      @models = []
    end

    def connect(model:)
      @models << model
      result = yield(@connection)
      @after_connect&.call
      result
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

  def test_file_boundary_rejects_an_empty_authoritative_transcript
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      input_path = File.join(directory, "input.pcm")
      output_path = File.join(directory, "response.pcm")
      File.binwrite(input_path, "pcm")
      events = [
        transcript_delta("Stale streamed words."),
        transcript_done(""),
        audio_delta("audio"),
        response_done
      ]
      realtime = RecordingRealtime.new(RecordingConnection.new(events))

      error = assert_raises(RuntimeError) do
        OpenAI::Examples::Realtime::WebSocketVoiceTurn.run_to_file(
          client: RecordingClient.new(realtime: realtime),
          input_path: input_path,
          output_path: output_path,
          model: "gpt-realtime-2.1",
          voice: :marin,
          timeout_seconds: 1,
          output: StringIO.new
        )
      end

      assert_equal("Realtime response completed without an audio transcript", error.message)
      refute_path_exists(output_path)
    end
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

  def test_file_boundary_suppresses_protocol_error_data_and_cause
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      input_path = File.join(directory, "input.pcm")
      output_path = File.join(directory, "response.pcm")
      File.binwrite(input_path, "pcm")
      customer_data = "private malformed frame content"
      protocol_error = OpenAI::Errors::RealtimeProtocolError.new(
        data: customer_data,
        cause: JSON::ParserError.new(customer_data)
      )
      realtime = RecordingRealtime.new(ProtocolFailureConnection.new(protocol_error))
      diagnostics = StringIO.new

      error = assert_raises(RuntimeError) do
        OpenAI::Examples::Realtime::WebSocketVoiceTurn.run_to_file(
          client: RecordingClient.new(realtime: realtime),
          input_path: input_path,
          output_path: output_path,
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
      refute_path_exists(output_path)
    end
  end

  def test_file_boundary_reports_success_only_after_output_publication
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      input_path = File.join(directory, "input.pcm")
      output_path = File.join(directory, "response.pcm")
      File.binwrite(input_path, "pcm")
      realtime = RecordingRealtime.new(
        RecordingConnection.new(successful_events),
        after_connect: -> { File.binwrite(output_path, "other owner") }
      )
      diagnostics = StringIO.new

      error = assert_raises(ArgumentError) do
        OpenAI::Examples::Realtime::WebSocketVoiceTurn.run_to_file(
          client: RecordingClient.new(realtime: realtime),
          input_path: input_path,
          output_path: output_path,
          model: "gpt-realtime-2.1",
          voice: :marin,
          timeout_seconds: 1,
          output: diagnostics
        )
      end

      assert_equal("output path must not already exist", error.message)
      assert_equal("other owner", File.binread(output_path))
      refute_includes(diagnostics.string, "voice turn smoke test passed")
    end
  end

  def test_file_boundary_publishes_output_before_reporting_success
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      input_path = File.join(directory, "input.pcm")
      output_path = File.join(directory, "response.pcm")
      File.binwrite(input_path, "pcm")
      realtime = RecordingRealtime.new(RecordingConnection.new(successful_events))
      diagnostics = StringIO.new

      transcript = OpenAI::Examples::Realtime::WebSocketVoiceTurn.run_to_file(
        client: RecordingClient.new(realtime: realtime),
        input_path: input_path,
        output_path: output_path,
        model: "gpt-realtime-2.1",
        voice: :marin,
        timeout_seconds: 1,
        output: diagnostics
      )

      assert_equal("Hello from Ruby.", transcript)
      assert_equal("voice-response".b, File.binread(output_path))
      assert_equal("[realtime] voice turn smoke test passed\n", diagnostics.string.lines.last)
    end
  end

  def test_file_boundary_rejects_windows_before_connecting
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      input_path = File.join(directory, "input.pcm")
      output_path = File.join(directory, "response.pcm")
      File.binwrite(input_path, "pcm")
      realtime = RecordingRealtime.new(RecordingConnection.new(successful_events))
      test_thread = Thread.current
      win_platform = Gem.method(:win_platform?)
      platform_check = -> { Thread.current.equal?(test_thread) ? true : win_platform.call }

      error = Gem.stub(:win_platform?, platform_check) do
        assert_raises(ArgumentError) do
          OpenAI::Examples::Realtime::WebSocketVoiceTurn.run_to_file(
            client: RecordingClient.new(realtime: realtime),
            input_path: input_path,
            output_path: output_path,
            model: "gpt-realtime-2.1",
            voice: :marin,
            timeout_seconds: 1,
            output: StringIO.new
          )
        end
      end

      assert_equal(
        "secure voice output is unavailable on Windows because Ruby cannot verify owner-only ACLs",
        error.message
      )
      assert_empty(realtime.models)
      refute_path_exists(output_path)
    end
  end

  def test_file_boundary_rejects_filesystems_without_hard_links_before_connecting
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      input_path = File.join(directory, "input.pcm")
      output_path = File.join(directory, "response.pcm")
      File.binwrite(input_path, "pcm")
      realtime = RecordingRealtime.new(RecordingConnection.new(successful_events))
      test_thread = Thread.current
      create_link = File.method(:link)
      unsupported_link = lambda do |*args|
        raise Errno::ENOTSUP if Thread.current.equal?(test_thread)

        create_link.call(*args)
      end

      error = File.stub(:link, unsupported_link) do
        assert_raises(ArgumentError) do
          OpenAI::Examples::Realtime::WebSocketVoiceTurn.run_to_file(
            client: RecordingClient.new(realtime: realtime),
            input_path: input_path,
            output_path: output_path,
            model: "gpt-realtime-2.1",
            voice: :marin,
            timeout_seconds: 1,
            output: StringIO.new
          )
        end
      end

      assert_equal(
        "output filesystem must support atomic no-clobber hard links",
        error.message
      )
      assert_empty(realtime.models)
      refute_path_exists(output_path)
    end
  end

  def test_output_file_must_not_already_exist
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      path = File.join(directory, "response.pcm")
      File.binwrite(path, "keep me")

      error = assert_raises(ArgumentError) do
        OpenAI::Examples::Realtime::WebSocketVoiceTurn.open_output(path) { |_file| nil }
      end

      assert_equal("output path must not already exist", error.message)
      assert_equal("keep me", File.binread(path))
    end
  end

  def test_output_file_rejects_symlink_and_hardlink_destinations
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      target = File.join(directory, "existing.pcm")
      File.binwrite(target, "keep me")
      destinations = [
        File.join(directory, "response-symlink.pcm"),
        File.join(directory, "response-hardlink.pcm")
      ]
      File.symlink(target, destinations.fetch(0))
      File.link(target, destinations.fetch(1))

      destinations.each do |path|
        error = assert_raises(ArgumentError) do
          OpenAI::Examples::Realtime::WebSocketVoiceTurn.open_output(path) { |_file| nil }
        end

        assert_equal("output path must not already exist", error.message)
      end

      assert_equal("keep me", File.binread(target))
      assert_predicate(File.lstat(destinations.fetch(0)), :symlink?)
      assert(File.identical?(target, destinations.fetch(1)))
    end
  end

  def test_output_file_does_not_relabel_errors_from_the_caller_block
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      path = File.join(directory, "response.pcm")

      error = assert_raises(Errno::EEXIST) do
        OpenAI::Examples::Realtime::WebSocketVoiceTurn.open_output(path) do |_file|
          raise Errno::EEXIST, "raised by caller"
        end
      end

      assert_includes(error.message, "raised by caller")
      refute_path_exists(path)
    end
  end

  def test_output_file_is_not_published_when_the_run_fails
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      path = File.join(directory, "response.pcm")

      error = assert_raises(RuntimeError) do
        OpenAI::Examples::Realtime::WebSocketVoiceTurn.open_output(path) do |file|
          file.write("partial audio")
          refute_path_exists(path)
          raise "voice turn failed"
        end
      end

      assert_equal("voice turn failed", error.message)
      refute_path_exists(path)
      assert_empty(Dir.children(directory))
    end
  end

  def test_output_file_is_not_published_when_the_run_times_out
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      path = File.join(directory, "response.pcm")

      assert_raises(Timeout::Error) do
        OpenAI::Examples::Realtime::WebSocketVoiceTurn.open_output(path) do |file|
          file.write("partial audio")
          refute_path_exists(path)
          raise Timeout::Error, "execution expired"
        end
      end

      refute_path_exists(path)
      assert_empty(Dir.children(directory))
    end
  end

  def test_output_file_is_published_after_a_successful_run
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      path = File.join(directory, "response.pcm")

      OpenAI::Examples::Realtime::WebSocketVoiceTurn.open_output(path) do |file|
        file.write("complete audio")
        refute_path_exists(path)

        staging_directory = File.dirname(file.path)
        refute_equal(directory, staging_directory)
        assert_equal(0o700, File.stat(staging_directory).mode & 0o777)
      end

      assert_equal("complete audio", File.binread(path))
      assert_equal(0o600, File.stat(path).mode & 0o777)
      assert_equal(["response.pcm"], Dir.children(directory))
    end
  end

  def test_output_file_rejects_a_replaceable_staging_path
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      File.chmod(0o770, directory)
      path = File.join(directory, "response.pcm")

      error = assert_raises(ArgumentError) do
        OpenAI::Examples::Realtime::WebSocketVoiceTurn.open_output(path) do |file|
          file.write("private audio")
          File.unlink(file.path)
          File.binwrite(file.path, "attacker-controlled audio")
        end
      end

      assert_equal(
        "output directory must not be writable by other users unless it has the sticky bit set",
        error.message
      )
      refute_path_exists(path)
      assert_empty(Dir.children(directory))
    end
  end

  def test_output_file_allows_a_sticky_shared_directory
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      File.chmod(0o1777, directory)
      path = File.join(directory, "response.pcm")

      OpenAI::Examples::Realtime::WebSocketVoiceTurn.open_output(path) do |file|
        file.write("complete audio")
      end

      assert_equal("complete audio", File.binread(path))
      assert_equal(0o600, File.stat(path).mode & 0o777)
    end
  end

  def test_output_file_does_not_publish_a_substituted_private_staging_path
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      path = File.join(directory, "response.pcm")

      error = assert_raises(RuntimeError) do
        OpenAI::Examples::Realtime::WebSocketVoiceTurn.open_output(path) do |file|
          file.write("private audio")
          File.unlink(file.path)
          File.binwrite(file.path, "attacker-controlled audio")
        end
      end

      assert_equal("staged output changed before publication", error.message)
      refute_path_exists(path)
      assert_empty(Dir.children(directory))
    end
  end

  def test_output_file_does_not_replace_a_destination_created_during_the_run
    Dir.mktmpdir("openai-realtime-voice") do |directory|
      path = File.join(directory, "response.pcm")

      error = assert_raises(ArgumentError) do
        OpenAI::Examples::Realtime::WebSocketVoiceTurn.open_output(path) do |file|
          file.write("complete audio")
          File.binwrite(path, "other owner")
        end
      end

      assert_equal("output path must not already exist", error.message)
      assert_equal("other owner", File.binread(path))
      assert_equal(["response.pcm"], Dir.children(directory))
    end
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
