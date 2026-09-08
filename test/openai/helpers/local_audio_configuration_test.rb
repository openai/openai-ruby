# frozen_string_literal: true

require_relative "../test_helper"
require_relative "../../../lib/openai/helpers/local_audio"
require_relative "../../../lib/openai/helpers/realtime_audio/configuration"

class OpenAI::Test::LocalAudioConfigurationTest < Minitest::Test
  def configuration(**options)
    OpenAI::Realtime::AudioConfiguration.new(
      voice: "marin",
      mode: :server_vad,
      playback_policy: :duplex,
      turn_detection: {},
      session: {},
      audio_options: {},
      **options
    )
  end

  def test_owned_session_fields_preserve_custom_instructions
    config = configuration(session: {instructions: "test", audio: {input: {noise_reduction: {type: "near_field"}}}})
    assert_equal("test", config.session[:instructions])
    assert_equal(false, config.session.dig(:audio, :input, :turn_detection, :create_response))
    assert_equal(24_000, config.session.dig(:audio, :output, :format, :rate))
    assert(config.compatible?(config.session))
  end

  def test_conflicting_owned_fields_and_unknown_options
    assert_raises(ArgumentError) { configuration(session: {audio: {output: {voice: "other"}}}) }
    assert_raises(ArgumentError) { configuration(turn_detection: {idle_timeout_ms: 5000}) }
    assert_raises(ArgumentError) do
      configuration(session: {audio: {input: {turn_detection: {idle_timeout_ms: 5000}}}})
    end

    assert_raises(ArgumentError) { configuration(audio_options: {unknown: true}) }
    assert_raises(ArgumentError) { configuration(audio_options: {frame_duration: 0.00001}) }
    assert_raises(ArgumentError) { configuration(audio_options: {event_queue_capacity: 0}) }
    assert_raises(ArgumentError) { configuration(audio_options: {cleanup_timeout: Float::INFINITY}) }
  end

  def test_push_to_talk_and_semantic_vad
    assert_nil(configuration(mode: :push_to_talk).session.dig(:audio, :input, :turn_detection))
    config = configuration(mode: :semantic_vad, turn_detection: {eagerness: "low"})
    assert_equal("semantic_vad", config.session.dig(:audio, :input, :turn_detection, :type))
    assert_equal("low", config.session.dig(:audio, :input, :turn_detection, :eagerness))
  end
end
