#!/usr/bin/env ruby
# frozen_string_literal: true

require "timeout"

require_relative "../../lib/openai"

module OpenAI
  module Examples
    module Realtime
      module Sideband
        module_function

        def stream_until_updated(connection, instructions:, output: $stdout)
          updated = false

          connection.each do |event|
            case event
            when OpenAI::Realtime::SessionCreatedEvent
              output.puts("[realtime] session.created")
            when OpenAI::Realtime::SessionUpdatedEvent
              session = event.session
              next unless session.is_a?(OpenAI::Realtime::RealtimeSessionCreateRequest)
              next unless session.instructions == instructions

              output.puts("[realtime] session.updated")
              updated = true
              break
            when OpenAI::Realtime::RealtimeErrorEvent
              raise "Realtime API error."
            end
          end

          unless updated
            raise "Realtime sideband connection closed before session.updated."
          end
        end

        def run(client:, call_id:, instructions:, output: $stdout)
          client.realtime.connect_to_call(call_id: call_id) do |connection|
            output.puts("[realtime] sideband connected")
            connection.session.update(type: :realtime, instructions: instructions)
            stream_until_updated(connection, instructions: instructions, output: output)
          end

          output.puts("[realtime] sideband smoke test passed")
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  Timeout.timeout(Integer(ENV.fetch("OPENAI_REALTIME_TIMEOUT", "30"))) do
    OpenAI::Examples::Realtime::Sideband.run(
      client: OpenAI::Client.new,
      call_id: ENV.fetch("OPENAI_REALTIME_CALL_ID"),
      instructions: ENV.fetch(
        "OPENAI_REALTIME_INSTRUCTIONS",
        "Apply server-side business rules and keep answers short."
      )
    )
  end
end
