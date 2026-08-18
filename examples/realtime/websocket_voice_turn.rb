#!/usr/bin/env ruby
# frozen_string_literal: true

require "base64"
require "timeout"

require_relative "../../lib/openai"

module OpenAI
  module Examples
    module Realtime
      module WebSocketVoiceTurn
        # 200 ms of 24 kHz mono PCM16 audio.
        CHUNK_BYTES = 9_600

        module_function

        def stream_response(connection, audio_output:, output: $stdout)
          audio_bytes = 0
          transcript = +""
          started_transcript = false
          completed = false

          connection.each do |event|
            case event
            when OpenAI::Realtime::SessionCreatedEvent
              output.puts("[realtime] session.created")
            when OpenAI::Realtime::SessionUpdatedEvent
              output.puts("[realtime] session.updated")
            when OpenAI::Realtime::InputAudioBufferCommittedEvent
              output.puts("[realtime] input_audio_buffer.committed item=#{event.item_id}")
            when OpenAI::Realtime::ResponseAudioTranscriptDeltaEvent
              next if event.delta.empty?

              output.print("[assistant] ") unless started_transcript
              started_transcript = true
              transcript << event.delta
              output.print(event.delta)
              output.flush
            when OpenAI::Realtime::ResponseAudioTranscriptDoneEvent
              next if event.transcript.empty? || event.transcript == transcript

              if started_transcript
                output.puts
                output.puts("[realtime] final transcript: #{event.transcript}")
              else
                output.puts("[assistant] #{event.transcript}")
              end

              started_transcript = false
              transcript.replace(event.transcript)
            when OpenAI::Realtime::ResponseAudioDeltaEvent
              begin
                bytes = Base64.strict_decode64(event.delta)
              rescue ArgumentError
                raise "Realtime returned invalid audio data."
              end

              audio_output.write(bytes)
              audio_output.flush
              audio_bytes += bytes.bytesize
            when OpenAI::Realtime::ResponseDoneEvent
              output.puts if started_transcript
              status = event.response.status
              raise "Realtime response did not complete." unless status == :completed
              raise "Realtime response completed without audio output" if audio_bytes.zero?
              raise "Realtime response completed without an audio transcript" if transcript.empty?

              output.puts("[realtime] response.done status=completed audio_bytes=#{audio_bytes}")
              completed = true
              break
            when OpenAI::Realtime::RealtimeErrorEvent
              raise "Realtime API error."
            end
          end

          raise "Realtime connection closed before response.done" unless completed

          transcript
        end

        def run(client:, input:, audio_output:, model:, voice:, chunk_bytes: CHUNK_BYTES, output: $stdout)
          unless chunk_bytes.is_a?(Integer) && chunk_bytes.positive?
            raise ArgumentError, "chunk_bytes must be a positive integer"
          end

          input.binmode if input.respond_to?(:binmode)
          audio_output.binmode if audio_output.respond_to?(:binmode)
          first_chunk = input.read(chunk_bytes)
          raise ArgumentError, "PCM input is empty" if first_chunk.nil? || first_chunk.empty?

          session = {
            type: :realtime,
            output_modalities: [:audio],
            instructions: "Respond briefly in a natural speaking voice.",
            audio: {
              input: {
                format: {type: :"audio/pcm", rate: 24_000},
                turn_detection: nil
              },
              output: {
                format: {type: :"audio/pcm", rate: 24_000},
                voice: voice
              }
            }
          }

          output.puts("[realtime] connecting with #{model}")
          transcript = client.realtime.connect(model: model) do |connection|
            connection.session.update(**session)
            connection.input_audio_buffer.append_bytes(first_chunk)
            while (chunk = input.read(chunk_bytes))
              break if chunk.empty?

              connection.input_audio_buffer.append_bytes(chunk)
            end

            connection.input_audio_buffer.commit
            connection.response.create
            stream_response(connection, audio_output: audio_output, output: output)
          end

          output.puts("[realtime] voice turn smoke test passed")
          transcript
        end

        def open_output(path)
          file = begin
            File.open(path, File::WRONLY | File::CREAT | File::EXCL | File::BINARY, 0o600)
          rescue Errno::EEXIST
            raise ArgumentError, "output path must not already exist"
          end

          begin
            yield(file)
          ensure
            file.close
          end
        end

      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  input_path = ARGV.fetch(0) do
    abort(
      "Usage: bundle exec ruby examples/realtime/websocket_voice_turn.rb INPUT.pcm OUTPUT.pcm"
    )
  end

  output_path = ARGV.fetch(1) do
    abort(
      "Usage: bundle exec ruby examples/realtime/websocket_voice_turn.rb INPUT.pcm OUTPUT.pcm"
    )
  end

  File.open(input_path, "rb") do |input|
    OpenAI::Examples::Realtime::WebSocketVoiceTurn.open_output(output_path) do |audio_output|
      Timeout.timeout(Integer(ENV.fetch("OPENAI_REALTIME_TIMEOUT", "60"))) do
        OpenAI::Examples::Realtime::WebSocketVoiceTurn.run(
          client: OpenAI::Client.new,
          input: input,
          audio_output: audio_output,
          model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
          voice: ENV.fetch("OPENAI_REALTIME_VOICE", "marin")
        )
      end
    end
  end
end
