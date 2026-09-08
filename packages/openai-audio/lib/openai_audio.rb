# frozen_string_literal: true

# This companion contains no credentials or OpenAI client code.
module OpenAIAudio
  VERSION = "0.1.0.pre.1"
  PROTOCOL_VERSION = 1

  def self.worker_path
    suffix = Gem.win_platform? ? ".exe" : ""
    File.expand_path("../bin/openai-audio-worker#{suffix}", __dir__)
  end
end
