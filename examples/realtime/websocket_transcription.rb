#!/usr/bin/env ruby
# frozen_string_literal: true

require "timeout"
require_relative "../../lib/openai"
require_relative "event_stream"

module OpenAI
  module Examples
    module Realtime
      module WebSocketTranscription
        module_function

        def configure(connection, transcription_model:)
          connection.session.update(
            audio: {
              input: {
                format: {type: :"audio/pcm", rate: 24_000},
                transcription: {model: transcription_model},
                turn_detection: nil
              }
            }
          )
        end

        def wait_until_ready(connection)
          loop do
            event = connection.receive
            raise "Realtime connection closed before session.updated" if event.nil?
            raise event.error.message if event.is_a?(OpenAI::Realtime::RealtimeErrorEvent)

            return if event.is_a?(OpenAI::Realtime::SessionUpdatedEvent)
          end
        end

        def upload(connection, input_path:)
          File.open(input_path, "rb") do |input|
            while (chunk = input.read(4_800))
              connection.input_audio_buffer.append_bytes(chunk)
            end
          end
          connection.input_audio_buffer.commit
        end

        def print_transcript(connection, output: $stdout)
          EventStream.each_until(
            connection,
            stop_after: "conversation.item.input_audio_transcription.completed",
            closed_message: "Realtime connection closed before transcription completed"
          ) do |event|
            case event
            when OpenAI::Realtime::ConversationItemInputAudioTranscriptionDeltaEvent
              output.print(event.delta)
              output.flush
            when OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent
              output.puts("\n[#{event.item_id}] #{event.transcript}")
            when OpenAI::Realtime::RealtimeErrorEvent
              raise event.error.message
            end
          end
        end

        def run(client:, input_path:, transcription_model:, output: $stdout)
          client.realtime.connect_transcription do |connection|
            configure(connection, transcription_model: transcription_model)
            wait_until_ready(connection)
            upload(connection, input_path: input_path)
            print_transcript(connection, output: output)
          end
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  Timeout.timeout(Integer(ENV.fetch("OPENAI_REALTIME_TIMEOUT", "30"))) do
    OpenAI::Examples::Realtime::WebSocketTranscription.run(
      client: OpenAI::Client.new,
      input_path: ENV.fetch("REALTIME_INPUT_PCM"),
      transcription_model: ENV.fetch(
        "OPENAI_REALTIME_TRANSCRIPTION_MODEL",
        "gpt-live-transcribe"
      )
    )
  end
end
