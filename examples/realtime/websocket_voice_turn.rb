#!/usr/bin/env ruby
# frozen_string_literal: true

require "tempfile"
require "tmpdir"
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

              transcript << event.delta
            when OpenAI::Realtime::ResponseAudioTranscriptDoneEvent
              next if event.transcript.empty? || event.transcript == transcript

              transcript.replace(event.transcript)
            when OpenAI::Realtime::ResponseAudioDeltaEvent
              begin
                bytes = event.delta.unpack1("m0")
              rescue ArgumentError
                raise "Realtime returned invalid audio data."
              end

              audio_output.write(bytes)
              audio_output.flush
              audio_bytes += bytes.bytesize
            when OpenAI::Realtime::ResponseDoneEvent
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
          client.realtime.connect(model: model) do |connection|
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
        end

        def run_to_file(
          client:,
          input_path:,
          output_path:,
          model:,
          voice:,
          timeout_seconds:,
          output: $stdout
        )
          transcript = File.open(input_path, "rb") do |input|
            open_output(output_path) do |audio_output|
              Timeout.timeout(timeout_seconds) do
                run(
                  client: client,
                  input: input,
                  audio_output: audio_output,
                  model: model,
                  voice: voice,
                  output: output
                )
              end
            end
          end

          output.puts("[realtime] voice turn smoke test passed")
          transcript
        rescue OpenAI::Errors::RealtimeProtocolError
          raise RuntimeError, "Realtime protocol error.", cause: nil
        end

        def open_output(path)
          directory = File.realpath(File.dirname(path))
          directory_stat = File.stat(directory)
          if (directory_stat.mode & 0o022).positive? && !directory_stat.sticky?
            raise(
              ArgumentError,
              "output directory must not be writable by other users unless it has the sticky bit set"
            )
          end

          output_path = File.join(directory, File.basename(path))
          begin
            File.lstat(output_path)
          rescue Errno::ENOENT
            # The destination is available.
          else
            raise ArgumentError, "output path must not already exist"
          end

          Dir.mktmpdir(".openai-realtime-", directory) do |staging_directory|
            File.chmod(0o700, staging_directory)
            Tempfile.create(["response-", ".tmp"], staging_directory, mode: File::BINARY, perm: 0o600) do |file|
              result = yield(file)
              file.flush
              file.fsync
              raise "staged output changed before publication" unless File.identical?(file.path, file)

              begin
                File.link(file.path, output_path)
              rescue Errno::EEXIST
                raise ArgumentError, "output path must not already exist"
              end

              result
            end
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

  OpenAI::Examples::Realtime::WebSocketVoiceTurn.run_to_file(
    client: OpenAI::Client.new,
    input_path: input_path,
    output_path: output_path,
    model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
    voice: ENV.fetch("OPENAI_REALTIME_VOICE", "marin"),
    timeout_seconds: Integer(ENV.fetch("OPENAI_REALTIME_TIMEOUT", "60"))
  )
end
