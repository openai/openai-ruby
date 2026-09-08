# frozen_string_literal: true

require_relative "../test_helper"
require "openai/helpers/realtime_audio"

class OpenAI::Test::LocalAudioExampleTest < Minitest::Test
  extend Minitest::Serial

  def test_bounded_example_stops_after_device_playback
    original_limit = ENV["AUDIO_MAX_PLAYBACKS"]
    ENV["AUDIO_MAX_PLAYBACKS"] = "1"
    client = OpenAI::Client.new(api_key: "fake-key")
    audio = Minitest::Mock.new
    audio.expect(:start, nil)
    delivered = 0
    audio.expect(:each, nil) do |&block|
      2.times do
        delivered += 1
        block.call(
          OpenAI::Realtime::AudioSession::PlaybackFinished.new(
            response_id: "response",
            item_id: "item",
            content_index: 0,
            position: OpenAI::LocalAudio::PlaybackPosition.new(played_frames: 2400)
          )
        )
      end

      true
    end

    connect = lambda do |**options, &block|
      assert_equal("marin", options[:voice])
      block.call(audio)
    end

    output, = capture_io do
      OpenAI::Client.stub(:new, client) do
        client.realtime.stub(:connect_audio, connect) do
          load(File.expand_path("../../../examples/realtime/local_audio.rb", __dir__))
        end
      end
    end

    assert_equal("Playback complete.\n", output)
    assert_equal(1, delivered)
    audio.verify
  ensure
    ENV["AUDIO_MAX_PLAYBACKS"] = original_limit
  end
end
