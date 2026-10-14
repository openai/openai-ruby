# frozen_string_literal: true

# Test-only device substitution; SDK requests and FFmpeg/FFplay remain real.
require "openai/helpers/local_audio"

module LocalAudioExampleDevices
  module Capture
    def capture_device(_device) = ["wav", ENV.fetch("OPENAI_AUDIO_TEST_WAV")]
  end

  module Environment
    def environment = super.merge("SDL_AUDIODRIVER" => "dummy")
  end
end

OpenAI::LocalAudio.singleton_class.prepend(LocalAudioExampleDevices::Capture)
OpenAI::LocalAudio::MediaProcess.singleton_class.prepend(LocalAudioExampleDevices::Environment)
