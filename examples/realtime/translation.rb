#!/usr/bin/env ruby
# frozen_string_literal: true

require "async"
require_relative "../../lib/openai"
require_relative "event_stream"

module OpenAI
  module Examples
    module Realtime
      module Translation
        module_function

        def stream(connection, audio_output:, transcript_output: $stdout)
          audio_bytes = 0
          EventStream.each_until(
            connection,
            stop_after: "session.closed",
            closed_message: "Realtime translation connection closed before session.closed"
          ) do |event|
            case event
            when OpenAI::Realtime::RealtimeTranslationOutputTranscriptDeltaEvent
              transcript_output.print(event.delta)
              transcript_output.flush
            when OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent
              audio = Base64.strict_decode64(event.delta)
              audio_output.write(audio)
              audio_bytes += audio.bytesize
            when OpenAI::Realtime::RealtimeTranslationSessionClosedEvent
              raise "Translation session closed without audio output" if audio_bytes.zero?

              transcript_output.puts
            when OpenAI::Realtime::RealtimeErrorEvent
              raise event.error.message
            end
          end
        end

        def write_input(connection, input_path)
          upload_error = nil
          begin
            File.open(input_path, "rb") do |input|
              while (chunk = input.read(9_600))
                connection.input_audio_buffer.append_bytes(chunk)
              end
            end
          rescue StandardError => e
            upload_error = e
            raise
          ensure
            close_session(connection, preserve_error: !upload_error.nil?)
          end
        end

        def close_session(connection, preserve_error:)
          connection.session.close
        rescue StandardError
          raise unless preserve_error
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
