#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"
require_relative "audio_files"
require_relative "event_stream"

module OpenAI
  module Examples
    module Realtime
      module WebSocketAudio
        module_function

        def configure(connection)
          connection.session.update(
            type: :realtime,
            output_modalities: [:audio],
            audio: {input: {turn_detection: nil}}
          )
        end

        def stream_response(connection, output:)
          audio_bytes = 0
          EventStream.each_until(connection, stop_after: "response.done") do |event|
            case event
            when OpenAI::Realtime::ResponseAudioDeltaEvent
              audio = Base64.strict_decode64(event.delta)
              output.write(audio)
              audio_bytes += audio.bytesize
            when OpenAI::Realtime::ResponseDoneEvent
              status = event.response.status
              raise "Response ended with #{status}" unless status == :completed
              raise "Response completed without audio output" if audio_bytes.zero?
            when OpenAI::Realtime::RealtimeErrorEvent
              raise event.error.message
            end
          end
        end

        def run(client:, model:, input_path:, output_path:)
          AudioFiles.open(input_path: input_path, output_path: output_path) do |input, output|
            client.realtime.connect(model: model) do |connection|
              configure(connection)
              EventStream.wait_for(
                connection,
                OpenAI::Realtime::SessionUpdatedEvent,
                closed_message: "Realtime connection closed before session.updated"
              )
              while (chunk = input.read(4_800))
                connection.input_audio_buffer.append_bytes(chunk)
              end
              connection.input_audio_buffer.commit
              connection.response.create
              stream_response(connection, output: output)
            end
          end

          warn("Wrote raw PCM16 audio to #{output_path}")
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  OpenAI::Examples::Realtime::WebSocketAudio.run(
    client: OpenAI::Client.new,
    model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
    input_path: ENV.fetch("REALTIME_INPUT_PCM"),
    output_path: ENV.fetch("REALTIME_OUTPUT_PCM", "realtime-output.pcm")
  )
end
