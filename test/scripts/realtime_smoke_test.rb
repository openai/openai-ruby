# frozen_string_literal: true

require "minitest/autorun"
require "minitest/mock"
require "stringio"
require "tmpdir"
require "yaml"

require_relative "../../scripts/realtime-smoke/run"
require_relative "../../scripts/realtime-smoke/audio"
require_relative "../openai/realtime/connection_test_support"

class RealtimeSmokeTest < Minitest::Test
  extend Minitest::Serial
  include OpenAI::Test::RealtimeConnectionTestSupport

  ENABLED = {"OPENAI_REALTIME_LIVE_SMOKE" => "1", "OPENAI_API_KEY" => "sk-fake-smoke"}.freeze

  def test_opt_in_credentials_selection_and_browser_dependency_fail_closed
    [
      [{}, "audio", "skipped"],
      [{"OPENAI_REALTIME_LIVE_SMOKE" => "1"}, "audio", "unavailable"],
      [ENABLED, "browser", "unavailable"],
      [ENABLED, "fake-secret-selection", "unavailable"]
    ].each do |env, selection, status|
      output = StringIO.new
      launcher = RealtimeSmoke::Launcher.new(output: output, environment: env)
      Process.stub(:spawn, -> (*) { flunk("Must not start worker") }) do
        assert_equal(2, launcher.run(selection))
      end

      record = JSON.parse(output.string)
      assert_equal(status, record.fetch("status"))
      assert_equal("none", record.fetch("evidence"))
      refute_includes(output.string, "fake-secret")
    end
  end

  def test_worker_output_and_backtraces_are_discarded_on_success_and_failure
    [0, 1].each do |exit_status|
      with_worker("puts 'FAKE_SDP'; warn 'sk-fake-private'; exit(#{exit_status})") do |worker|
        output = StringIO.new
        launcher = RealtimeSmoke::Launcher.new(output: output, environment: ENABLED, worker: worker)
        stdout, stderr = capture_io { assert_equal(exit_status, launcher.run("audio")) }
        assert_empty(stdout)
        assert_empty(stderr)
        record = JSON.parse(output.string)
        assert_equal(exit_status.zero? ? "passed" : "failed", record.fetch("status"))
        assert_equal(exit_status.zero? ? "live_network" : "none", record.fetch("evidence"))
        refute_includes(output.string, "FAKE_SDP")
        refute_includes(output.string, "sk-fake")
      end
    end
  end

  def test_stalled_worker_is_killed_and_reaped_without_retry
    with_worker("sleep 60") do |worker|
      output = StringIO.new
      launcher = RealtimeSmoke::Launcher.new(output: output, environment: ENABLED, worker: worker, deadline: 0.1)
      started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      assert_equal(1, launcher.run("audio"))
      assert_operator(Process.clock_gettime(Process::CLOCK_MONOTONIC) - started, :<, 5)
      assert_equal("failed", JSON.parse(output.string).fetch("status"))
    end
  end

  def test_audio_uses_one_synthetic_fixture_and_commits_both_sessions_with_bounded_voice
    transcription = FakeSocket.new(*transcription_events)
    voice = FakeSocket.new(*voice_events)
    speech = StringIO.new("\0\0" * 4_800)
    sdk = client(max_retries: 0, timeout: 10, log_level: :off)
    speech_resource = sdk.audio.speech
    transports = [FakeTransport.new(transcription), FakeTransport.new(voice)]
    speech_calls = []
    generate = lambda do |**params|
      speech_calls << params
      speech
    end

    speech_resource.stub(:create, generate) do
      OpenAI::Realtime::Transports::AsyncWebSocket.stub(:new, -> { transports.shift || flunk("Unexpected session") }) do
        assert_nil(RealtimeSmoke::Audio.new(client: sdk).run)
      end
    end

    assert_equal(1, speech_calls.length)
    assert_equal("Say hello.", speech_calls.first.fetch(:input))
    assert_equal(:pcm, speech_calls.first.fetch(:response_format))
    assert_predicate(speech, :closed?)
    assert_predicate(transcription, :closed?)
    assert_predicate(voice, :closed?)
    [transcription, voice].each do |socket|
      events = socket.writes.map { JSON.parse(_1) }
      assert_equal(1, events.count { _1["type"] == "input_audio_buffer.commit" })
      input = events.select { _1["type"] == "input_audio_buffer.append" }.map { _1.fetch("audio").unpack1("m0") }.join
      assert_equal("\0\0" * 4_800, input)
      assert_nil(events.first.dig("session", "audio", "input", "turn_detection"))
    end

    events = voice.writes.map { JSON.parse(_1) }
    assert_equal(128, events.first.dig("session", "max_output_tokens"))
    assert_equal(128, events.last.dig("response", "max_output_tokens"))
    assert_equal("response.create", events.last.fetch("type"))
  end

  def test_failed_transcription_aborts_socket_and_does_not_open_voice
    socket = FakeSocket.new(
      JSON.generate(type: "input_audio_buffer.committed", event_id: "fake", item_id: "fake-item"),
      JSON.generate(
        type: "conversation.item.input_audio_transcription.failed",
        event_id: "fake",
        item_id: "fake-item",
        content_index: 0,
        error: {type: "fake", message: "fake-private"}
      )
    )
    sdk = client(max_retries: 0, log_level: :off)
    transport = Minitest::Mock.new
    transport.expect(:open, nil) { |**_options, &block| block.call(socket) }
    sdk.audio.speech.stub(:create, StringIO.new("\0\0" * 4_800)) do
      OpenAI::Realtime::Transports::AsyncWebSocket.stub(:new, -> { transport }) do
        assert_raises(RuntimeError) { RealtimeSmoke::Audio.new(client: sdk).run }
      end
    end

    assert_predicate(socket, :aborted?)
    transport.verify
  end

  def test_invalid_fixture_cannot_open_paid_realtime_sessions
    ["", "x", "x" * (RealtimeSmoke::Audio::INPUT_BYTES + 2)].each do |pcm|
      sdk = client(max_retries: 0, log_level: :off)
      speech = StringIO.new(pcm)
      sdk.audio.speech.stub(:create, speech) do
        OpenAI::Realtime::Transports::AsyncWebSocket.stub(:new, -> { flunk("Invalid fixture opened session") }) do
          assert_raises(RuntimeError) { RealtimeSmoke::Audio.new(client: sdk).run }
        end
      end

      assert_predicate(speech, :closed?)
    end
  end

  def test_deadline_aborts_stalled_transcription_without_opening_voice
    socket = FakeSocket.new
    socket.define_singleton_method(:read) { sleep(60) }
    sdk = client(max_retries: 0, log_level: :off)
    transports = [FakeTransport.new(socket)]
    sdk.audio.speech.stub(:create, StringIO.new("\0\0" * 4_800)) do
      OpenAI::Realtime::Transports::AsyncWebSocket.stub(:new, -> { transports.shift || flunk("Retried session") }) do
        assert_raises(Timeout::Error) { RealtimeSmoke::Audio.new(client: sdk, deadline: 0.05).run }
      end
    end

    assert_predicate(socket, :aborted?)
  end

  def test_voice_requires_completed_response_audio_and_transcript_and_aborts_on_failure
    [
      [],
      voice_events.take(1),
      voice_events.values_at(0, 3),
      voice_events.map { _1.gsub("\"completed\"", "\"cancelled\"") }
    ].each do |events|
      transcription = FakeSocket.new(*transcription_events)
      voice = FakeSocket.new(*events)
      sdk = client(max_retries: 0, log_level: :off)
      transports = [FakeTransport.new(transcription), FakeTransport.new(voice)]
      sdk.audio.speech.stub(:create, StringIO.new("\0\0" * 4_800)) do
        OpenAI::Realtime::Transports::AsyncWebSocket.stub(:new, -> { transports.shift || flunk("Retried session") }) do
          assert_raises(RuntimeError) { RealtimeSmoke::Audio.new(client: sdk).run }
        end
      end

      assert_predicate(transcription, :closed?)
      assert_predicate(voice, :aborted?)
    end
  end

  def test_voice_cannot_pass_without_commit_acknowledgement_or_create_a_response
    transcription = FakeSocket.new(*transcription_events)
    voice = FakeSocket.new(*voice_events.drop(1))
    sdk = client(max_retries: 0, log_level: :off)
    transports = [FakeTransport.new(transcription), FakeTransport.new(voice)]
    sdk.audio.speech.stub(:create, StringIO.new("\0\0" * 4_800)) do
      OpenAI::Realtime::Transports::AsyncWebSocket.stub(:new, -> { transports.shift || flunk("Retried session") }) do
        assert_raises(RuntimeError) { RealtimeSmoke::Audio.new(client: sdk).run }
      end
    end

    assert_predicate(voice, :aborted?)
    events = voice.writes.map { JSON.parse(_1) }
    refute(events.any? { _1["type"] == "response.create" })
  end

  def test_manifest_matches_fixed_workload_bounds
    manifest = YAML.safe_load_file(File.expand_path("../../scripts/realtime-smoke/manifest.yml", __dir__))
    audio = manifest.fetch("scenarios").fetch("audio")
    assert_equal(1, audio.fetch("attempts"))
    assert_equal(1, audio.fetch("synthetic_speech_requests"))
    assert_equal(RealtimeSmoke::Audio::DEADLINE, audio.fetch("deadline_seconds"))
    assert_equal(RealtimeSmoke::Audio::OUTPUT_TOKENS, audio.fetch("voice_output_tokens_max"))
    assert_equal(RealtimeSmoke::Audio::INPUT_BYTES, audio.fetch("input_seconds_max") * 24_000 * 2)
    assert_equal("unavailable", manifest.fetch("scenarios").fetch("browser").fetch("status"))
  end

  def test_workflow_preserves_manual_protected_branch_and_secret_boundary
    workflow = YAML.safe_load_file(File.expand_path("../../.github/workflows/realtime-live-smoke.yml", __dir__))
    trigger = workflow.fetch("on", workflow[true])
    assert_equal(["workflow_dispatch"], trigger.keys)
    assert_equal({}, workflow.fetch("permissions"))
    assert_equal(false, workflow.fetch("concurrency").fetch("cancel-in-progress"))
    job = workflow.fetch("jobs").fetch("realtime-live-smoke")
    assert_equal("ci", job.fetch("environment"))
    assert_equal({"contents" => "read"}, job.fetch("permissions"))
    assert_includes(job.fetch("if"), "github.ref == 'refs/heads/main'")
    assert_includes(job.fetch("if"), "github.repository == 'openai/openai-ruby'")
    steps = job.fetch("steps")
    assert_equal(false, steps.first.fetch("with").fetch("persist-credentials"))
    assert_equal("${{ github.sha }}", steps.first.fetch("with").fetch("ref"))
    steps.filter_map { _1["uses"] }.each { assert_match(/@[0-9a-f]{40}\z/, _1) }
    assert(steps.none? { _1["uses"].to_s.include?("upload-artifact") })
    assert_equal("1", steps.last.fetch("env").fetch("OPENAI_REALTIME_LIVE_SMOKE"))
    assert_equal("${{ secrets.OPENAI_API_KEY }}", steps.last.fetch("env").fetch("OPENAI_API_KEY"))
  end

  private def with_worker(source)
    Dir.mktmpdir("realtime-offline-test") do |dir|
      worker = File.join(dir, "worker.rb")
      File.write(worker, source)
      yield(worker)
    end
  end

  private def transcription_events
    [
      {type: "input_audio_buffer.committed", event_id: "fake", item_id: "fake-item"},
      {
        type: "conversation.item.input_audio_transcription.completed",
        event_id: "fake",
        item_id: "fake-item",
        content_index: 0,
        transcript: "fake-private-transcript",
        usage: {type: "duration", seconds: 1}
      }
    ].map { JSON.generate(_1) }
  end

  private def voice_events
    [
      {type: "input_audio_buffer.committed", event_id: "fake", item_id: "fake-item"},
      {
        type: "response.output_audio.delta",
        event_id: "fake",
        response_id: "fake-response",
        item_id: "fake-item",
        output_index: 0,
        content_index: 0,
        delta: ["fake-audio"].pack("m0")
      },
      {
        type: "response.output_audio_transcript.done",
        event_id: "fake",
        response_id: "fake-response",
        item_id: "fake-item",
        output_index: 0,
        content_index: 0,
        transcript: "fake-private-transcript"
      },
      {type: "response.done", event_id: "fake", response: {id: "fake-response", status: "completed", output: []}}
    ].map { JSON.generate(_1) }
  end
end
