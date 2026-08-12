#!/usr/bin/env ruby
# frozen_string_literal: true

require "async"
require_relative "../../lib/openai"

module OpenAI
  module Examples
    module Realtime
      module Translation
        module_function

        def stream(connection, audio_output:, transcript_output: $stdout)
          session_closed = false
          connection.each do |event|
            case event
            when OpenAI::Realtime::RealtimeTranslationOutputTranscriptDeltaEvent
              transcript_output.print(event.delta)
              transcript_output.flush
            when OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent
              audio_output.write(Base64.strict_decode64(event.delta))
            when OpenAI::Realtime::RealtimeTranslationSessionClosedEvent
              transcript_output.puts
              session_closed = true
              break
            when OpenAI::Realtime::RealtimeErrorEvent
              raise event.error.message
            end
          end
          return if session_closed

          raise "Realtime translation connection closed before session.closed"
        end

        def write_input(connection, input_path)
          File.open(input_path, "rb") do |input|
            while (chunk = input.read(9_600))
              connection.input_audio_buffer.append_bytes(chunk)
            end
          end
        ensure
          connection.session.close
        end

        def run(client:, model:, input_path:, output_path:, target_language:, transcript_output: $stdout)
          File.open(output_path, "wb") do |audio_output|
            client.realtime.translations.connect(model: model) do |connection|
              connection.session.update(audio: {output: {language: target_language}})
              reader = Async do
                stream(
                  connection,
                  audio_output: audio_output,
                  transcript_output: transcript_output
                )
              end
              write_input(connection, input_path)
              reader.wait
            end
          end
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  OpenAI::Examples::Realtime::Translation.run(
    client: OpenAI::Client.new,
    model: ENV.fetch("OPENAI_REALTIME_TRANSLATION_MODEL", "gpt-realtime-translate"),
    input_path: ENV.fetch("REALTIME_INPUT_PCM"),
    output_path: ENV.fetch("REALTIME_OUTPUT_PCM", "translation-output.pcm"),
    target_language: ENV.fetch("TARGET_LANGUAGE", "es")
  )
end
