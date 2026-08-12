# frozen_string_literal: true
# typed: true

require_relative "../../lib/openai"

# Static contract fixture for the three capability-specific connection methods.
# Defining, but never invoking, this method keeps the fixture inert at runtime.
module OpenAI
  module Examples
    module Realtime
      module SorbetConnectionTypes
        module_function

        def verify
          client = OpenAI::Client.new

          client.realtime.connect(model: "gpt-realtime-2.1") do |connection|
            T.assert_type!(connection, OpenAI::Realtime::Connection)
            connection.response.create
          end

          client.realtime.connect_to_call(call_id: "rtc_123") do |connection|
            T.assert_type!(connection, OpenAI::Realtime::SidebandConnection)
            connection.output_audio_buffer.clear
          end

          client.realtime.connect_transcription do |connection|
            T.assert_type!(connection, OpenAI::Realtime::TranscriptionConnection)
            connection.input_audio_buffer.commit
          end
        end
      end
    end
  end
end
