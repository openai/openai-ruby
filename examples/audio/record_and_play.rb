#!/usr/bin/env ruby
# frozen_string_literal: true
# typed: strict

require "openai"
require "openai/helpers/local_audio"

# Running this example explicitly records five seconds from the selected local
# microphone and sends that recording to OpenAI. FFmpeg and FFplay are required.
TRANSCRIPTION_MODEL = "gpt-transcribe"
SPEECH_MODEL = "gpt-4o-mini-tts"
VOICE = "marin"

client = OpenAI::Client.new
clip = OpenAI::LocalAudio.record(duration: 5, timeout: 10)
transcription = client.audio.transcriptions.create(model: TRANSCRIPTION_MODEL, file: clip)
puts(transcription.text)
speech = client.audio.speech.create(model: SPEECH_MODEL, voice: VOICE, input: "Recording complete.")
OpenAI::LocalAudio.play(speech, timeout: 30)
