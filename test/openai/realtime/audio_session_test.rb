# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../../../lib/openai/helpers/realtime_audio"

class OpenAI::Test::AudioSessionTest < Minitest::Test
  extend Minitest::Serial

  class Socket
    attr_reader :writes
    attr_accessor :cancel_handler, :commit_handler, :append_handler, :clear_handler

    def initialize
      @reads = Queue.new
      @writes = []
      @count = 0
    end

    def write(message)
      event = JSON.parse(message, symbolize_names: true)
      @writes << event
      case event[:type]
      when "session.update"
        emit(type: "session.updated", session: event[:session])
      when "conversation.item.create"
        emit(type: "conversation.item.created", item: event[:item])
      when "response.create"
        @count += 1
        response = {id: "r#{@count}", object: "realtime.response", status: "in_progress", output: []}
        emit(type: "response.created", response: response)
      when "response.cancel"
        if @cancel_handler
          @cancel_handler.call(event, self)
        else
          emit(type: "response.done", response: {id: event[:response_id], status: "cancelled", output: []})
        end

      when "conversation.item.truncate"
        emit(
          type: "conversation.item.truncated",
          item_id: event[:item_id],
          content_index: event[:content_index],
          audio_end_ms: event[:audio_end_ms]
        )
      when "input_audio_buffer.append"
        @append_handler&.call(event, self)
      when "input_audio_buffer.commit"
        if @commit_handler
          @commit_handler.call(event, self)
        else
          emit(type: "input_audio_buffer.committed", item_id: "user_audio")
        end

      when "input_audio_buffer.clear"
        @clear_handler&.call(event, self)
        emit(type: "input_audio_buffer.cleared")
      end
    end

    def emit(**event)
      @reads << JSON.generate({event_id: "event"}.merge(event))
    end

    def read
      loop do
        return nil if @closed
        return @reads.pop(true)
      rescue ThreadError
        Async::Task.current.sleep(0.001)
      end
    end

    def closed? = @closed
    def abort = @closed = true
    def close(**_options) = abort
  end

  class Microphone
    attr_reader :samples, :delivered
    def initialize
      @samples = Queue.new
      @delivered = Queue.new
      @generation = 0
    end

    def started? = @started == true
    def fence = @generation += 1
    def captured_frame(pcm) = [@generation, pcm]
    def capture(pcm) = @samples << captured_frame(pcm)
    def each_frame
      @started = true
      while (sample = @samples.pop)
        yield(*sample)
        @delivered << true
      end
    end

    def stop = @samples.close
  end

  class Output
    attr_reader :keys
    def initialize
      @keys = []
    end

    def append(key, _pcm)
      @keys << key unless @keys.include?(key)
    end

    def finish(_key) = nil
    def interrupt = @keys.to_h { |key| [key, OpenAI::LocalAudio::PlaybackPosition.new(played_frames: 480)] }
    def release(keys) = @keys -= keys
    def close = nil
  end

  def with_audio(output_factory: nil, **options)
    socket = Socket.new
    microphone = Microphone.new
    output = Output.new
    client = OpenAI::Client.new(api_key: "fake-key")
    connect = lambda do |**connection_options, &block|
      assert_equal(false, connection_options[:reconnect])
      block.call(OpenAI::Realtime::Connection.new(socket: socket, url: URI("wss://example.com")))
    end

    client.realtime.stub(:connect, connect) do
      OpenAI::LocalAudio::Microphone.stub(:new, microphone) do
        OpenAI::Realtime::AudioOutput.stub(:new, output_factory || output) do
          client
            .realtime
            .connect_audio(
              model: "test",
              voice: "marin",
              mode: :push_to_talk,
              audio_options: {control_timeout: 2},
              **options
            ) do |audio|
              yield audio, socket, microphone, output
            end
        end
      end
    end
  end

  def test_ready_acknowledgement_and_explicit_start
    with_audio do |audio, socket|
      assert_equal(:ready, audio.state)
      assert_equal(["session.update"], (socket.writes.map { |event| event[:type] }))
      assert_same(audio, audio.start)
      assert_equal(:running, audio.state)
      assert_same(audio, audio.start)
    end
  end

  def test_push_to_talk_commits_once_then_creates_one_response
    with_audio do |audio, socket, microphone|
      audio.start
      turn = audio.start_turn
      microphone.capture("\0" * 960)
      microphone.delivered.pop
      turn.commit
      turn.commit
      types = socket.writes.map { |event| event[:type] }
      assert_equal(1, types.count("input_audio_buffer.commit"))
      assert_equal(1, types.count("response.create"))
      assert_operator(types.index("input_audio_buffer.append"), :<, types.index("input_audio_buffer.commit"))
      assert_raises(OpenAI::Errors::RealtimeAudioStateError) { turn.discard }
    end
  end

  def test_cancel_truncate_acknowledgement_precedes_next_response
    with_audio do |audio, socket, _microphone, output|
      audio.start
      audio.send_text("first")
      socket.emit(
        type: "response.output_audio.delta",
        response_id: "r1",
        item_id: "a1",
        content_index: 0,
        output_index: 0,
        delta: ["\0" * 1920].pack("m0")
      )
      deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + 2
      sleep(0.005) while output.keys.empty? && Process.clock_gettime(Process::CLOCK_MONOTONIC) < deadline
      interruption = audio.interrupt
      assert_equal(480, interruption.items.fetch(0).position.played_frames)
      audio.send_text("second")
      types = socket.writes.map { |event| event[:type] }
      cancel = types.index("response.cancel")
      truncate = types.index("conversation.item.truncate")
      assert_operator(cancel, :<, truncate)
      assert_operator(truncate, :<, types.rindex("response.create"))
      assert_equal(20, socket.writes[truncate][:audio_end_ms])
    end
  end

  def test_break_from_event_consumer_closes_the_session
    with_audio do |audio|
      audio.each { |event| break if event.type == :"session.updated" }
      assert_equal(:closed, audio.state)
    end
  end

  def test_delayed_interrupted_completion_after_retirement_keeps_session_running
    notifications = nil
    output = Output.new
    factory = lambda do |**options|
      notifications = options.fetch(:notifications)
      output
    end

    with_audio(output_factory: factory) do |audio, socket|
      audio.start
      audio.send_text("first")
      key = ["r1", "a1", 0]
      socket.emit(
        type: "response.output_audio.delta",
        response_id: key[0],
        item_id: key[1],
        content_index: key[2],
        output_index: 0,
        delta: ["\0" * 1920].pack("m0")
      )
      deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + 2
      while output.keys.empty?
        raise "Playback did not start" if Process.clock_gettime(Process::CLOCK_MONOTONIC) > deadline
        sleep(0.005)
      end

      audio.interrupt
      until output.keys.empty?
        raise "Playback was not retired" if Process.clock_gettime(Process::CLOCK_MONOTONIC) > deadline
        sleep(0.005)
      end

      notifications << [:playback_finished, key, OpenAI::LocalAudio::PlaybackPosition.new(played_frames: 480), true]
      audio.send_text("second")
      assert_equal(:running, audio.state)
      assert_equal(2, socket.writes.count { |event| event[:type] == "response.create" })
    end
  end

  def test_local_interrupt_retains_completed_response_until_queued_reconciliation
    notifications = nil
    output = Output.new
    factory = lambda do |**options|
      notifications = options.fetch(:notifications)
      output
    end

    with_audio(output_factory: factory) do |audio, socket|
      audio.start
      audio.send_text("first")
      key = ["r1", "a1", 0]
      socket.emit(
        type: "response.output_audio.delta",
        response_id: key[0],
        item_id: key[1],
        content_index: key[2],
        output_index: 0,
        delta: ["\0" * 48_000].pack("m0")
      )
      socket.emit(type: "response.done", response: {id: "r1", status: "completed", output: []})
      clearing = Queue.new
      release_clear = Queue.new
      socket.clear_handler = lambda do |_event, _socket|
        clearing << true
        Async::Task.current.sleep(0.001) while release_clear.empty?
      end
      muting = Thread.new { audio.mute }
      clearing.pop
      interrupted = Queue.new
      position = OpenAI::LocalAudio::PlaybackPosition.new(played_frames: 480)
      output.stub(
        :interrupt,
        lambda {
          interrupted << true
          notifications << [:playback_finished, key, position, true]
          {key => position}
        }
      ) do
        interrupting = Thread.new { audio.interrupt }
        interrupted.pop
        # Let the independent notification consumer run while the control stays blocked.
        sleep(0.03)
        release_clear << true
        assert(muting.join(2))
        assert(interrupting.join(2))
        assert_equal(1, interrupting.value.items.length)
        truncate = socket.writes.find { |event| event[:type] == "conversation.item.truncate" }
        assert_equal(20, truncate.fetch(:audio_end_ms))
      ensure
        release_clear << true
        muting.join(2)
        interrupting&.join(2)
      end
    end
  end

  def test_disconnect_during_vad_speech_is_a_typed_failure
    assert_raises(OpenAI::Errors::RealtimeAudioSessionError) do
      with_audio(mode: :server_vad) do |audio, socket, microphone|
        audio.start
        socket.emit(type: "input_audio_buffer.speech_started", item_id: "speech", audio_start_ms: 0)
        microphone.capture("\0" * 960)
        microphone.delivered.pop
        deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + 2
        until socket.writes.any? { |event| event[:type] == "input_audio_buffer.append" }
          raise "Capture was not sent" if Process.clock_gettime(Process::CLOCK_MONOTONIC) > deadline
          sleep(0.005)
        end

        socket.abort
        audio.wait
      end
    end
  end

  def test_acknowledged_mute_clears_unfinished_vad_speech
    with_audio(mode: :server_vad) do |audio, socket|
      audio.start
      socket.emit(type: "input_audio_buffer.speech_started", item_id: "speech", audio_start_ms: 0)
      audio.mute
      socket.abort
      audio.wait
      assert_equal(:closed, audio.state)
    end
  end

  def test_vad_committed_input_creates_response_without_server_auto_response
    with_audio(mode: :semantic_vad) do |audio, socket|
      audio.start
      assert_equal(false, socket.writes.first.dig(:session, :audio, :input, :turn_detection, :create_response))
      socket.emit(type: "input_audio_buffer.speech_started", item_id: "speech", audio_start_ms: 0)
      socket.emit(type: "input_audio_buffer.committed", item_id: "speech")
      deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + 2
      until socket.writes.any? { |event| event[:type] == "response.create" }
        raise "VAD response did not start" if Process.clock_gettime(Process::CLOCK_MONOTONIC) > deadline
        sleep(0.005)
      end

      assert_equal(1, socket.writes.count { |event| event[:type] == "response.create" })
    end
  end

  def test_empty_turn_can_continue_recording_after_local_rejection
    with_audio do |audio, socket, microphone|
      audio.start
      turn = audio.start_turn
      assert_raises(OpenAI::Errors::RealtimeAudioStateError) { turn.commit }
      microphone.capture("\0" * 960)
      microphone.delivered.pop
      turn.commit
      assert_equal(1, socket.writes.count { |event| event[:type] == "input_audio_buffer.commit" })
    end
  end

  def test_repeated_interrupt_without_response_does_not_send_controls
    with_audio do |audio, socket|
      audio.start
      2.times { assert_empty(audio.interrupt.items) }
      assert_equal(["session.update"], (socket.writes.map { |event| event[:type] }))
    end
  end

  def test_slow_event_consumer_fails_instead_of_dropping_events
    assert_raises(OpenAI::Errors::RealtimeAudioConsumerTooSlowError) do
      with_audio(audio_options: {event_queue_capacity: 1, control_timeout: 2}) do |audio|
        audio.start
      end
    end
  end

  def test_remote_failure_wakes_consumer_and_preserves_typed_failure
    assert_raises(OpenAI::Errors::RealtimeAudioSessionError) do
      with_audio do |audio, socket|
        socket.emit(type: "error", error: {type: "invalid_request_error", code: "bad_request", message: "fake"})
        audio.wait
      end
    end
  end

  def test_tool_output_requires_known_call_and_confirmed_output_is_idempotent
    with_audio do |audio, socket|
      audio.start
      assert_raises(OpenAI::Errors::RealtimeAudioStateError) {
        audio.submit_tool_output(call_id: "unknown", output: "test")
      }
      audio.send_text("first")
      socket.emit(
        type: "response.output_item.done",
        response_id: "r1",
        output_index: 0,
        item: {id: "tool_item", type: "function_call", call_id: "call1", name: "example", arguments: "{}"}
      )
      socket.emit(type: "response.done", response: {id: "r1", status: "completed", output: []})
      # Receiving these public events is the application completion barrier.
      consumer = Thread.new do
        audio.each do |event|
          next unless event.is_a?(OpenAI::Realtime::ResponseDoneEvent)
          audio.submit_tool_output(call_id: "call1", output: "test")
          audio.submit_tool_output(call_id: "call1", output: "test")
          audio.respond
          break
        end
      end

      assert(consumer.join(2), "tool continuation should complete")
      consumer.value
      assert_equal(1, socket.writes.count { |event| event.dig(:item, :type) == "function_call_output" })
      assert_equal(2, socket.writes.count { |event| event[:type] == "response.create" })
    end
  end

  def test_half_duplex_listening_resumes_after_interruption_and_echo_tail
    with_audio(
      mode: :server_vad,
      playback_policy: :half_duplex,
      audio_options: {control_timeout: 2, half_duplex_tail_duration: 0.01}
    ) do |audio, socket, microphone, output|
      audio.start
      audio.send_text("first")
      socket.emit(
        type: "response.output_audio.delta",
        response_id: "r1",
        item_id: "a1",
        content_index: 0,
        output_index: 0,
        delta: ["\0" * 1920].pack("m0")
      )
      deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + 2
      sleep(0.005) while output.keys.empty? && Process.clock_gettime(Process::CLOCK_MONOTONIC) < deadline
      audio.interrupt
      sleep(0.03)
      microphone.capture("\0" * 960)
      microphone.delivered.pop
      sleep(0.02)
      assert_equal(1, socket.writes.count { |event| event[:type] == "input_audio_buffer.append" })
    end
  end

  def test_abandoned_startup_resource_is_closed_after_timeout
    disposed = Queue.new
    delayed = lambda do |**_options|
      sleep(0.06)
      resource = Minitest::Mock.new
      resource.expect(:close, nil) { disposed << true }
      resource
    end

    assert_raises(OpenAI::Errors::RealtimeAudioSessionError) do
      with_audio(output_factory: delayed, audio_options: {control_timeout: 0.02, cleanup_timeout: 0.2}) do |audio|
        audio.start
      end
    end

    assert_equal(true, disposed.pop(true))
  end

  def test_new_speech_invalidates_response_waiting_for_cancellation_ack
    with_audio(mode: :server_vad) do |audio, socket|
      audio.start
      audio.send_text("first")
      socket.cancel_handler = lambda do |event, server|
        server.emit(type: "input_audio_buffer.speech_started", item_id: "new_speech", audio_start_ms: 0)
        server.emit(type: "response.done", response: {id: event[:response_id], status: "cancelled", output: []})
      end
      socket.emit(type: "input_audio_buffer.committed", item_id: "old_speech")
      # A subsequent public command is a dispatcher barrier after the queued VAD control.
      deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + 2
      until socket.writes.any? { |event| event[:type] == "response.cancel" }
        raise "Cancellation did not start" if Process.clock_gettime(Process::CLOCK_MONOTONIC) > deadline
        sleep(0.005)
      end

      audio.interrupt
      assert_equal(1, socket.writes.count { |event| event[:type] == "response.create" })
    end
  end

  def test_pre_gate_capture_is_never_retagged_into_a_new_turn
    with_audio do |audio, socket, microphone|
      audio.start
      old = microphone.captured_frame("old audio")
      turn = audio.start_turn
      microphone.samples << old
      microphone.delivered.pop
      microphone.capture("new audio!")
      microphone.delivered.pop
      turn.commit
      pcm = socket
        .writes
        .select { |event| event[:type] == "input_audio_buffer.append" }
        .map { |event| event[:audio].unpack1("m0") }
        .join
      assert_equal("new audio!", pcm)
    end
  end

  def test_unmute_discards_frames_captured_while_muted
    with_audio(mode: :server_vad) do |audio, socket, microphone|
      audio.start
      audio.mute
      old = microphone.captured_frame("muted audio!")
      audio.unmute
      microphone.samples << old
      microphone.delivered.pop
      microphone.capture("new audio!")
      microphone.delivered.pop
      audio.mute
      pcm = socket
        .writes
        .select { |event| event[:type] == "input_audio_buffer.append" }
        .map { |event| event[:audio].unpack1("m0") }
        .join
      refute_includes(pcm, "muted")
    end
  end

  def test_one_stalled_capture_send_fails_without_waiting_for_overflow
    assert_raises(OpenAI::Errors::RealtimeAudioSessionError) do
      with_audio(audio_options: {control_timeout: 0.05}) do |audio, socket, microphone|
        audio.start
        audio.start_turn
        socket.append_handler = -> (_event, _server) { Async::Task.current.sleep(60) }
        microphone.capture("\0" * 960)
        audio.wait
      end
    end
  end

  def test_confirmed_short_turn_rejection_clears_buffer_and_allows_a_new_turn
    with_audio do |audio, socket, microphone|
      audio.start
      socket.commit_handler = lambda do |event, server|
        server.emit(
          type: "error",
          error: {
            type: "invalid_request_error",
            code: "input_audio_buffer_commit_empty",
            event_id: event[:event_id],
            message: "Buffer too small."
          }
        )
      end
      turn = audio.start_turn
      microphone.capture("\0" * 960)
      microphone.delivered.pop
      error = assert_raises(OpenAI::Errors::RealtimeAudioTurnError) { turn.commit }
      assert_equal("input_audio_buffer_commit_empty", error.event.error.code)
      assert_equal(:running, audio.state)
      assert_same(error, assert_raises(OpenAI::Errors::RealtimeAudioTurnError) { turn.commit })
      assert_equal(0, socket.writes.count { |event| event[:type] == "response.create" })
      assert_equal(1, socket.writes.count { |event| event[:type] == "input_audio_buffer.clear" })
      socket.commit_handler = nil
      next_turn = audio.start_turn
      microphone.capture("\0" * 960)
      microphone.delivered.pop
      next_turn.commit
      assert_equal(1, socket.writes.count { |event| event[:type] == "response.create" })
    end
  end

  def test_invalid_options_do_not_connect
    client = OpenAI::Client.new(api_key: "fake-key")
    assert_raises(ArgumentError) do
      client.realtime.connect_audio(model: "test", voice: "marin", turn_detection: {create_response: true}) { |_audio|
        nil
      }
    end
  end
end
