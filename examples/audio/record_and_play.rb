#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strict

require "openai"
require "openai/helpers/local_audio"

# Running this example explicitly records five seconds from the selected local
# microphone and sends that recording to OpenAI. FFmpeg and FFplay are required.
client = OpenAI::Client.new
clip = OpenAI::LocalAudio.record(duration: 5, device: ENV["AUDIO_INPUT_DEVICE"], timeout: 10)
transcription = client.audio.transcriptions.create(model: "gpt-4o-mini-transcribe", file: clip)
puts(transcription.text)
speech = client.audio.speech.create(model: "gpt-4o-mini-tts", voice: "marin", input: "Recording complete.")
OpenAI::LocalAudio.play(speech, timeout: 30)
