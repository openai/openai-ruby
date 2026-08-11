#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

input_path = ENV.fetch("REALTIME_INPUT_PCM")
output_path = ENV.fetch("REALTIME_OUTPUT_PCM", "realtime-output.pcm")
client = OpenAI::Client.new

File.open(output_path, "wb") do |output|
  client.realtime.connect(model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1")) do |connection|
    File.open(input_path, "rb") do |input|
      while (chunk = input.read(4_800))
        connection.input_audio_buffer.append_bytes(chunk)
      end
    end
    connection.input_audio_buffer.commit
    connection.response.create

    connection.each do |event|
      case event
      when OpenAI::Realtime::ResponseAudioDeltaEvent
        output.write(Base64.strict_decode64(event.delta))
      when OpenAI::Realtime::ResponseDoneEvent
        raise "Response ended with #{event.response.status}" unless event.response.status == :completed
        break
      when OpenAI::Realtime::RealtimeErrorEvent
        raise event.error.message
      end
    end
  end
end

warn("Wrote raw PCM16 audio to #{output_path}")
