# frozen_string_literal: true

require_relative "examples_test_case"
require_relative "../../../examples/realtime/realtime_conversation"
require_relative "../../../examples/realtime/sip"
require_relative "../../../examples/realtime/translation"
require_relative "../../../examples/realtime/webrtc_call"
require_relative "../../../examples/realtime/websocket_audio"
require "tmpdir"

class OpenAI::Test::RealtimeFeedbackRegressionsTest < OpenAI::Test::RealtimeExamplesTestCase
  class RawSocket
    attr_reader :writes

    def initialize
      @writes = []
    end

    def write(message) = @writes << message
    def closed? = false
  end

  class CallCreatingCalls < RecordingCalls
    CreatedCall = Data.define(:call_id, :sdp)

    attr_reader :creates

    def initialize
      super
      @creates = []
    end

    def create(**params)
      @creates << params
      CreatedCall.new(call_id: "rtc_created", sdp: "answer-sdp")
    end
  end

  class BrokenOutput
    def write(_value) = raise(Errno::EPIPE)
  end

  class BackpressuredTerminalConnection < RecordingConnection
    attr_reader :aborted

    def initialize
      event = OpenAI::Realtime::ResponseDoneEvent.new(
        event_id: "event_done",
        response: OpenAI::Realtime::RealtimeResponse.new(id: "response_done", status: :completed)
      )
      session = OpenAI::Realtime::SessionUpdatedEvent.new(
        event_id: "event_session",
        session: OpenAI::Realtime::RealtimeSession.new(type: :realtime)
      )
      super([session, event])
      @write_started = Thread::Queue.new
      @release_write = Thread::Queue.new
      @aborted = false
    end

    def input_audio_buffer
      self
    end

    def append_bytes(_bytes)
      @write_started << true
      @release_write.pop
    end

    def each
      @write_started.pop
      super
    end

    def abort
      @aborted = true
      @release_write << true
    end

    def closed? = @aborted
  end

  def test_send_raw_normalizes_binary_json_to_utf8_text
    socket = RawSocket.new
    connection = OpenAI::Realtime::Connection.new(socket: socket, url: URI("wss://example.com"))

    connection.send_raw(JSON.generate(type: "session.update").b)

    assert_equal(Encoding::UTF_8, socket.writes.fetch(0).encoding)
    assert_predicate(socket.writes.fetch(0), :valid_encoding?)
  end

  def test_send_raw_rejects_invalid_utf8
    socket = RawSocket.new
    connection = OpenAI::Realtime::Connection.new(socket: socket, url: URI("wss://example.com"))

    error = assert_raises(ArgumentError) { connection.send_raw("\xFF".b) }

    assert_includes(error.message, "UTF-8")
    assert_empty(socket.writes)
  end

  def test_sip_conflict_does_not_hang_up_another_owner
    realtime = RecordingRealtime.new(RecordingConnection.new)
    realtime.calls.accept_error = OpenAI::Errors::ConflictError.new(
      url: URI("https://example.com/v1/realtime/calls/rtc_shared/accept"),
      status: 409,
      headers: {},
      body: {},
      request: nil,
      response: nil
    )

    assert_raises(OpenAI::Errors::ConflictError) do
      OpenAI::Examples::Realtime::SIP.run(
        client: RecordingClient.new(realtime: realtime),
        call_id: "rtc_shared",
        model: "gpt-realtime-2.1"
      )
    end

    assert_empty(realtime.calls.hangups)
  end

  def test_webrtc_call_hangs_up_when_sdp_handoff_fails
    calls = CallCreatingCalls.new
    realtime = Data.define(:calls).new(calls)
    client = RecordingClient.new(realtime: realtime)

    error = assert_raises(Errno::EPIPE) do
      OpenAI::Examples::Realtime::WebRTCCall.run(
        client: client,
        input: StringIO.new("offer-sdp"),
        output: BrokenOutput.new,
        error_output: StringIO.new,
        model: "gpt-realtime-2.1"
      )
    end

    assert_instance_of(Errno::EPIPE, error)
    assert_equal(["rtc_created"], calls.hangups)
  end

  def test_audio_examples_reject_identical_input_and_output_before_opening_a_session
    Dir.mktmpdir("realtime-audio") do |directory|
      input_path = File.join(directory, "input.pcm")
      alias_path = File.join(directory, "alias.pcm")
      File.binwrite(input_path, "source-audio")
      File.link(input_path, alias_path)
      realtime = RecordingRealtime.new(RecordingConnection.new)
      client = RecordingClient.new(realtime: realtime)

      assert_raises(ArgumentError) do
        OpenAI::Examples::Realtime::WebSocketAudio.run(
          client: client,
          model: "gpt-realtime-2.1",
          input_path: input_path,
          output_path: alias_path
        )
      end
      assert_equal("source-audio", File.binread(input_path))
      assert_empty(realtime.connections)

      assert_raises(ArgumentError) do
        OpenAI::Examples::Realtime::Translation.run(
          client: client,
          model: "gpt-realtime-translate",
          input_path: input_path,
          output_path: alias_path,
          target_language: "es"
        )
      end
      assert_equal("source-audio", File.binread(input_path))
      assert_empty(realtime.connections)

      assert_raises(ArgumentError) do
        OpenAI::Examples::Realtime::Conversation.run(
          client: client,
          model: "gpt-realtime-2.1",
          microphone: OpenAI::Examples::Realtime::Conversation::PCMFileMicrophone.new(input_path),
          speaker: OpenAI::Examples::Realtime::Conversation::PCMFileSpeaker.new(alias_path),
          voice: :marin,
          instructions: "Speak naturally."
        )
      end
      assert_equal("source-audio", File.binread(input_path))
      assert_empty(realtime.connections)

      File.unlink(alias_path)
      File.symlink(input_path, alias_path)
      assert_raises(ArgumentError) do
        OpenAI::Examples::Realtime::AudioFiles.validate!(
          input_path: input_path,
          output_path: alias_path
        )
      end
      assert_equal("source-audio", File.binread(input_path))
    end
  end

  def test_missing_audio_input_does_not_truncate_an_existing_output_or_open_a_session
    Dir.mktmpdir("realtime-audio") do |directory|
      output_path = File.join(directory, "output.pcm")
      File.binwrite(output_path, "existing-output")
      realtime = RecordingRealtime.new(RecordingConnection.new)

      assert_raises(Errno::ENOENT) do
        OpenAI::Examples::Realtime::WebSocketAudio.run(
          client: RecordingClient.new(realtime: realtime),
          model: "gpt-realtime-2.1",
          input_path: File.join(directory, "missing.pcm"),
          output_path: output_path
        )
      end

      assert_equal("existing-output", File.binread(output_path))
      assert_empty(realtime.connections)
    end
  end

  def test_terminal_receiver_aborts_a_backpressured_conversation
    connection = BackpressuredTerminalConnection.new
    microphone = RecordingMicrophone.new(["first", "second"])

    Sync do |task|
      task.with_timeout(0.5) do
        OpenAI::Examples::Realtime::Conversation.run_session(
          connection,
          microphone: microphone,
          speaker: RecordingSpeaker.new,
          voice: :marin,
          instructions: "Speak naturally.",
          output: StringIO.new,
          stop_after: "response.done"
        )
      end
    end

    assert_predicate(connection, :aborted)
    assert_predicate(microphone, :stopped)
  end
end
