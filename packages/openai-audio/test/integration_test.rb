# frozen_string_literal: true

require_relative "../../../test/openai/test_helper"
require_relative "../../../lib/openai/helpers/local_audio"

class NativeAudioIntegrationTest < Minitest::Test
  extend Minitest::Serial

  Audio = OpenAI::LocalAudio
  EXECUTABLE = ARGV.shift or raise("Pass the compiled fake-device worker path")

  def around
    Audio::Worker.stub(:executable, EXECUTABLE) { super }
  end

  def test_device_discovery_and_capture_conversion
    device = Audio.devices.fetch(0)
    assert_equal("Test device", device.name)
    assert(device.frozen?)
    Audio::Microphone.open(device: device) do |microphone|
      frame = microphone.first
      assert_equal(960, frame.bytesize)
      assert(frame.frozen?)
      assert_operator(frame.unpack("s<*").max, :>, 0)
    end
  end

  def test_capture_fences_reach_the_consumer_and_keep_generation_metadata
    Audio::Microphone.open do |microphone|
      frames = Queue.new
      consumer = Thread.new { microphone.each_frame { |generation, pcm| frames << [generation, pcm] } }
      begin
        deadline = Process.clock_gettime(Process::CLOCK_MONOTONIC) + 2
        until microphone.started?
          raise "Capture did not start" if Process.clock_gettime(Process::CLOCK_MONOTONIC) > deadline
          sleep(0.001)
        end

        first = microphone.fence
        generation = 0
        until generation == first
          generation, pcm = frames.pop
        end

        assert_operator(pcm.bytesize, :>, 0)
        assert(pcm.bytesize.even?)
        second = microphone.fence
        assert_operator(second, :>, first)
        until generation == second
          generation, pcm = frames.pop
        end

        assert(pcm.frozen?)
      ensure
        microphone.stop
        consumer.join
      end
    end
  end

  def test_playback_conversion_and_drain
    Audio::Player.open do |player|
      playback = player.begin_playback
      assert_equal(1, playback.write("\0"))
      assert_equal(4799, playback.write("\0" * 4799))
      position = playback.finish.wait
      assert_equal(2400, position.played_frames)
      assert_equal(:device_clock_estimate, position.timing_quality)
      second = player.begin_playback
      second.write("\0" * 960)
      assert_equal(480, second.finish.wait.played_frames)
    end
  end

  def test_interrupt_with_backpressure
    Audio::Player.open do |player|
      playback = player.begin_playback
      writer = Thread.new do
        playback.write("\0" * 480_000)
      rescue Audio::PlaybackInterruptedError => error
        error
      end

      sleep(0.05)
      position = playback.interrupt
      assert_operator(position.played_frames, :<, 240_000)
      assert_same(position, playback.interrupt)
      assert(writer.join(2), "interrupt must release the producer")
      assert_instance_of(Audio::PlaybackInterruptedError, writer.value)
    end
  end

  def test_incoherent_positive_device_timestamps_fail_playback
    Audio.devices.drop(1).each do |device|
      assert_raises(Audio::PlaybackPositionError) do
        Audio::Player.open(device: device) do |player|
          playback = player.begin_playback
          playback.write("\0" * 960)
          playback.finish.wait
        end
      end
    end
  end
end
