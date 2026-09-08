# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../../../lib/openai/helpers/local_audio"
require "tmpdir"
require "rbconfig"
require "timeout"

class OpenAI::Test::LocalAudioTest < Minitest::Test
  extend Minitest::Serial

  Audio = OpenAI::LocalAudio

  def with_executable(name, body)
    Dir.mktmpdir("openai-audio-test") do |directory|
      path = File.join(directory, name)
      File.write(path, "#!#{RbConfig.ruby}\n#{body}")
      File.chmod(0o700, path)
      Audio::MediaProcess.stub(:environment, {"PATH" => directory}) { yield directory }
    end
  end

  def test_record_returns_finalized_wav_upload
    with_executable("ffmpeg", "STDOUT.binmode.write(\"\\x01\\x02\" * 480)") do
      part = Audio.record(duration: 0.02, timeout: 2)
      assert_equal("audio.wav", part.filename)
      assert_equal("audio/wav", part.content_type)
      bytes = part.content.read
      assert_equal("RIFF", bytes.byteslice(0, 4))
      assert_equal(bytes.bytesize - 8, bytes.byteslice(4, 4).unpack1("V"))
      assert_equal(960, bytes.byteslice(40, 4).unpack1("V"))
      assert_equal("\x01\x02" * 480, bytes.byteslice(44..))
    end
  end

  def test_play_consumes_current_position_and_preserves_source
    with_executable("ffplay", "exit(STDIN.binmode.read == \"audio\" ? 0 : 1)") do
      source = StringIO.new("skipaudio")
      source.pos = 4
      assert_nil(Audio.play(source, timeout: 2))
      refute(source.closed?)
      assert(source.eof?)
    end
  end

  def test_failed_player_and_incomplete_pcm_are_errors
    with_executable("ffplay", "STDIN.read; exit 1") do
      assert_raises(Audio::PlaybackError) { Audio.play(StringIO.new("audio"), timeout: 2) }
      assert_raises(Audio::FormatError) { Audio.play(StringIO.new("odd"), format: :pcm, timeout: 2) }
    end
  end

  def test_record_timeout_terminates_and_reaps_child
    with_executable("ffmpeg", "sleep 30") do
      started = Process.clock_gettime(Process::CLOCK_MONOTONIC)
      assert_raises(Audio::TimeoutError) { Audio.record(duration: 1, timeout: 0.1) }
      assert_operator(Process.clock_gettime(Process::CLOCK_MONOTONIC) - started, :<, 2)
    end
  end

  def test_zero_exit_with_player_error_is_a_sanitized_failure
    with_executable("ffplay", "STDIN.read; STDERR.write('private decoder detail'); exit 0") do
      error = assert_raises(Audio::PlaybackError) { Audio.play(StringIO.new("audio"), timeout: 2) }
      assert_equal("Audio playback failed.", error.message)
    end
  end

  def test_unsupported_term_still_terminates_and_reaps_child
    signals = []
    kill = Process.method(:kill)
    unsupported_term = lambda do |name, pid|
      signals << [name, pid]
      raise Errno::EINVAL if name == "TERM"
      kill.call(name, pid)
    end

    with_executable("ffmpeg", "sleep 30") do
      Process.stub(:kill, unsupported_term) do
        assert_raises(Audio::TimeoutError) { Audio.record(duration: 1, timeout: 0.1) }
      end
    end

    assert_equal(%w[TERM KILL], signals.map(&:first))
    assert_equal(1, signals.map(&:last).uniq.length)
    assert_raises(Errno::ECHILD) { Process.waitpid(signals.last.last, Process::WNOHANG) }
  end

  def test_real_ffplay_rejects_invalid_encoded_audio
    unless ENV["OPENAI_AUDIO_FFPLAY_TEST"] == "1"
      skip("Set OPENAI_AUDIO_FFPLAY_TEST=1 to test installed FFplay with dummy output")
    end

    environment = Audio::MediaProcess.environment.merge("SDL_AUDIODRIVER" => "dummy")
    Audio::MediaProcess.stub(:environment, environment) do
      assert_raises(Audio::PlaybackError) do
        Audio.play(StringIO.new("not encoded audio"), timeout: 5)
      end
    end
  end

  def test_stalled_source_obeys_timeout_without_closing_callers_io
    with_executable("ffplay", "STDIN.read") do
      reader, writer = IO.pipe
      begin
        assert_raises(Audio::TimeoutError) { Audio.play(reader, timeout: 0.1) }
        refute(reader.closed?)
      ensure
        reader.close
        writer.close
      end
    end
  end

  def test_invalid_options_are_rejected_before_starting_a_child
    [0, -1, Float::NAN, Float::INFINITY, "1"].each do |duration|
      assert_raises(ArgumentError) { Audio.record(duration: duration) }
    end

    assert_raises(ArgumentError) { Audio.play("a path") }
    assert_raises(ArgumentError) { Audio.play(StringIO.new, format: :mp3) }
    assert_raises(ArgumentError) { Audio.capture_device("\0") }
    Process.stub(:spawn, -> (*) { flunk("invalid timeout must not spawn a child") }) do
      assert_raises(ArgumentError) { Audio.record(duration: 1, timeout: false) }
      assert_raises(ArgumentError) { Audio.play(StringIO.new("audio"), timeout: false) }
    end
  end

  def test_exited_player_unblocks_an_open_source_without_a_deadline
    with_executable("ffplay", "exit 1") do
      reader, writer = IO.pipe
      begin
        Timeout.timeout(3) do
          assert_raises(Audio::PlaybackError) { Audio.play(reader) }
        end

        refute(reader.closed?)
        refute(writer.closed?)
      ensure
        reader.close
        writer.close
      end
    end
  end

  def test_noisy_player_diagnostics_do_not_block_feeding
    with_executable("ffplay", "128.times { STDERR.write('x' * 65_536) }; STDIN.read") do
      error = assert_raises(Audio::PlaybackError) do
        Audio.play(StringIO.new("audio"), timeout: 10)
      end

      assert_equal("Audio playback failed.", error.message)
    end
  end

  def test_continuous_diagnostics_obey_timeout_and_close_the_pipe
    with_executable("ffplay", "loop { STDERR.write('x' * 65_536) }") do
      pipe_reader = nil
      pipe = IO.method(:pipe)
      capture_pipe = lambda do |**options|
        pair = pipe.call(**options)
        pipe_reader = pair.first
        pair
      end

      IO.stub(:pipe, capture_pipe) do
        assert_raises(Audio::TimeoutError) { Audio.play(StringIO.new("audio"), timeout: 0.1) }
      end

      assert(pipe_reader.closed?)
    end
  end

  def test_platform_selection
    assert_equal(["avfoundation", "none:default"], Audio.capture_device(nil, platform: "arm64-darwin"))
    assert_equal(["alsa", "hw:0"], Audio.capture_device(0, platform: "linux"))
    assert_equal(["dshow", "audio=Microphone"], Audio.capture_device("Microphone", platform: "mingw"))
    assert_raises(ArgumentError) { Audio.capture_device(nil, platform: "mingw") }
    assert_raises(Audio::UnsupportedPlatformError) { Audio.capture_device(nil, platform: "unknown") }
  end

  def test_large_wave_header_uses_rf64_without_allocating_payload
    size = 2 ** 32
    header = Audio.wav_header(size)
    assert_equal(80, header.bytesize)
    assert_equal("RF64", header.byteslice(0, 4))
    assert_equal([size + 72, size, size / 2], header.byteslice(20, 24).unpack("Q<Q<Q<"))
  end

  def test_missing_executable_has_sanitized_error
    Audio::MediaProcess.stub(:environment, {"PATH" => "/nonexistent"}) do
      error = assert_raises(Audio::DependencyError) { Audio.record(duration: 1) }
      assert_nil(error.cause)
    end
  end

  def test_worker_environment_does_not_include_credentials
    refute_includes(Audio::MediaProcess.environment.keys, "OPENAI_API_KEY")
    refute_includes(Audio::MediaProcess.environment.keys, "RUBYOPT")
    refute_includes(Audio::MediaProcess.environment.keys, "LD_PRELOAD")
  end
end
