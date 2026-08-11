#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"
require "async"

def read_translation(connection, output)
  Async do
    connection.each do |event|
      case event
      when OpenAI::Realtime::RealtimeTranslationOutputTranscriptDeltaEvent
        print(event.delta)
      when OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent
        output.write(Base64.strict_decode64(event.delta))
      when OpenAI::Realtime::RealtimeTranslationSessionClosedEvent
        puts
        break
      when OpenAI::Realtime::RealtimeErrorEvent
        raise event.error.message
      end
    end
  end
end

def write_translation_input(connection, input_path)
  File.open(input_path, "rb") do |input|
    while (chunk = input.read(9_600))
      connection.input_audio_buffer.append_bytes(chunk)
    end
  end
ensure
  connection.session.close
end

input_path = ENV.fetch("REALTIME_INPUT_PCM")
output_path = ENV.fetch("REALTIME_OUTPUT_PCM", "translation-output.pcm")
model = ENV.fetch("OPENAI_REALTIME_TRANSLATION_MODEL", "gpt-realtime-translate")
client = OpenAI::Client.new

File.open(output_path, "wb") do |output|
  client.realtime.translations.connect(model: model) do |connection|
    connection.session.update(
      audio: {output: {language: ENV.fetch("TARGET_LANGUAGE", "es")}}
    )
    reader = read_translation(connection, output)
    write_translation_input(connection, input_path)
    reader.wait
  end
end
