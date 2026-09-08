#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strict

require "openai"
require "openai/helpers/realtime_audio"

# Requires optional async-websocket and the built openai-audio companion.
# Running this example records and transmits microphone audio after audio.start.
# Use headphones for duplex listening. Ctrl-C closes the socket and devices.
client = OpenAI::Client.new
max_playbacks = Integer(ENV.fetch("AUDIO_MAX_PLAYBACKS", "0"))
raise ArgumentError, "AUDIO_MAX_PLAYBACKS must be nonnegative" if max_playbacks.negative?
completed_playbacks = 0
begin
  client
    .realtime
    .connect_audio(
      model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
      voice: "marin",
      session: {instructions: "Keep your answers brief."}
    ) do |audio|
      audio.start
      audio.each do |event|
        case event
        when OpenAI::Realtime::ResponseAudioTranscriptDeltaEvent
          print(event.delta)
        when OpenAI::Realtime::ResponseAudioTranscriptDoneEvent
          puts
        when OpenAI::Realtime::AudioSession::PlaybackFinished
          completed_playbacks += 1
          puts("Playback complete.")
          break if max_playbacks.positive? && completed_playbacks >= max_playbacks
        end
      end
    end

rescue Interrupt
  puts("Conversation closed.")
end
