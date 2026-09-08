# frozen_string_literal: true

# Only the local example E2E runner preloads this file. Replace hardware at the
# device boundary while keeping SDK, network, FFmpeg/FFplay, IPC and resampling real.
require "openai/helpers/local_audio"

module LocalAudioExampleDevices
  module Capture
    def capture_device(_device) = ["wav", ENV.fetch("OPENAI_AUDIO_TEST_WAV")]
  end

  module NativeWorker
    def executable = ENV.fetch("OPENAI_AUDIO_TEST_WORKER")
  end

  module Environment
    def environment
      super.merge("SDL_AUDIODRIVER" => "dummy", "OPENAI_AUDIO_TEST_PCM" => ENV.fetch("OPENAI_AUDIO_TEST_PCM"))
    end
  end
end

OpenAI::LocalAudio.singleton_class.prepend(LocalAudioExampleDevices::Capture)
OpenAI::LocalAudio::Worker.singleton_class.prepend(LocalAudioExampleDevices::NativeWorker)
OpenAI::LocalAudio::MediaProcess.singleton_class.prepend(LocalAudioExampleDevices::Environment)
