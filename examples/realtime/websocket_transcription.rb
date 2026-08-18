#!/usr/bin/env ruby
# frozen_string_literal: true

require "timeout"
require_relative "../../lib/openai"

module OpenAI
  module Examples
    module Realtime
      module WebSocketTranscription
        # 200 ms of 24 kHz mono PCM16 audio.
        CHUNK_BYTES = 9_600

        module_function

        def stream_transcript(connection, output: $stdout)
          committed_item_id = nil
          completed_transcript = nil
          streamed_transcript = +""

          connection.each do |event|
            case event
            when OpenAI::Realtime::SessionCreatedEvent
              output.puts("[realtime] session.created")
            when OpenAI::Realtime::SessionUpdatedEvent
              output.puts("[realtime] session.updated")
            when OpenAI::Realtime::InputAudioBufferCommittedEvent
              committed_item_id = event.item_id
              output.puts("[realtime] input_audio_buffer.committed item=#{event.item_id}")
            when OpenAI::Realtime::ConversationItemInputAudioTranscriptionDeltaEvent
              next unless committed_item_id == event.item_id

              streamed_transcript << event.delta
              output.print(event.delta)
              output.flush
            when OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent
              next unless committed_item_id == event.item_id

              transcript = event.transcript
              raise "Realtime transcription completed without text" if transcript.empty?

              if streamed_transcript.empty?
                output.puts(transcript)
              elsif streamed_transcript != transcript
                output.puts
                output.puts("[realtime] final transcript: #{transcript}")
              else
                output.puts
              end
              output.puts("[realtime] transcription.completed item=#{event.item_id}")
              completed_transcript = transcript
              break
            when OpenAI::Realtime::ConversationItemInputAudioTranscriptionFailedEvent
              next unless committed_item_id == event.item_id

              raise "Realtime transcription failed."
            when OpenAI::Realtime::RealtimeErrorEvent
              raise "Realtime API error."
            end
          end

          unless completed_transcript
            raise "Realtime connection closed before the committed audio was transcribed"
          end

          completed_transcript
        end

        def run(client:, input:, model:, chunk_bytes: CHUNK_BYTES, output: $stdout)
          unless chunk_bytes.is_a?(Integer) && chunk_bytes.positive?
            raise ArgumentError, "chunk_bytes must be a positive integer"
          end

          input.binmode if input.respond_to?(:binmode)
          first_chunk = input.read(chunk_bytes)
          raise ArgumentError, "PCM input is empty" if first_chunk.nil? || first_chunk.empty?

          session = {
            type: :transcription,
            audio: {
              input: {
                format: {type: :"audio/pcm", rate: 24_000},
                transcription: {model: model},
                turn_detection: nil
              }
            }
          }

          output.puts("[realtime] connecting with #{model}")
          transcript = client.realtime.connect_transcription do |connection|
            connection.session.update(**session)
            connection.input_audio_buffer.append_bytes(first_chunk)
            while (chunk = input.read(chunk_bytes))
              break if chunk.empty?

              connection.input_audio_buffer.append_bytes(chunk)
            end
            connection.input_audio_buffer.commit
            stream_transcript(connection, output: output)
          end
          output.puts("[realtime] transcription smoke test passed")
          transcript
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  input_path = ARGV.fetch(0) do
    abort("Usage: bundle exec ruby examples/realtime/websocket_transcription.rb AUDIO.pcm")
  end

  File.open(input_path, "rb") do |input|
    Timeout.timeout(Integer(ENV.fetch("OPENAI_REALTIME_TIMEOUT", "60"))) do
      OpenAI::Examples::Realtime::WebSocketTranscription.run(
        client: OpenAI::Client.new,
        input: input,
        model: ENV.fetch("OPENAI_REALTIME_TRANSCRIPTION_MODEL", "gpt-transcribe")
      )
    end
  end
end
