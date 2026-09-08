# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../../../lib/openai/helpers/local_audio"
require_relative "../../../lib/openai/helpers/realtime_audio/output"
require "tmpdir"

class OpenAI::Test::LocalAudioOutputTest < Minitest::Test
  extend Minitest::Serial

  class BlockedPlayback
    attr_reader :writing
    def initialize
      @writing = Queue.new
      @release = Queue.new
    end

    def write(_pcm)
      @writing << true
      @release.pop
      raise OpenAI::LocalAudio::PlaybackInterruptedError
    end

    def interrupt
      @release << true
      OpenAI::LocalAudio::PlaybackPosition.new(played_frames: 0)
    end
  end

  def test_interruption_removes_queued_spool_files_before_session_close
    Dir.mktmpdir do |directory|
      notifications = Queue.new
      playback = BlockedPlayback.new
      player = Minitest::Mock.new
      player.expect(:begin_playback, playback)
      player.expect(:close, nil)
      OpenAI::LocalAudio::Player.stub(:new, player) do
        output = OpenAI::Realtime::AudioOutput.new(
          device: nil,
          buffer_duration: 0.1,
          directory: directory,
          notifications: notifications
        )
        begin
          output.append(["r", "a", 0], "test")
          playback.writing.pop
          output.append(["r", "b", 0], "queued")
          assert_equal(2, Dir.children(directory).size)
          positions = output.interrupt
          assert_equal(0, positions.fetch(["r", "b", 0]).played_frames)
          assert_operator(Dir.children(directory).size, :<=, 1)
        ensure
          output.close
        end

        assert_empty(Dir.children(directory))
      end

      player.verify
    end
  end

  def test_spooled_playback_is_removed_after_drain
    Dir.mktmpdir do |directory|
      notifications = Queue.new
      playback = Minitest::Mock.new
      player = Minitest::Mock.new
      position = OpenAI::LocalAudio::PlaybackPosition.new(played_frames: 2)
      player.expect(:begin_playback, playback)
      player.expect(:close, nil)
      playback.expect(:write, 4, ["test"])
      playback.expect(:finish, playback)
      playback.expect(:wait, position)
      OpenAI::LocalAudio::Player.stub(:new, player) do
        output = OpenAI::Realtime::AudioOutput.new(
          device: nil,
          buffer_duration: 0.1,
          directory: directory,
          notifications: notifications
        )
        key = ["response", "item", 0]
        output.append(key, "test")
        output.finish(key)
        assert_equal([:playback_started, key], notifications.pop)
        assert_equal([:playback_finished, key, position, false], notifications.pop)
        output.close
        assert_empty(Dir.children(directory))
      end

      playback.verify
      player.verify
    end
  end
end
