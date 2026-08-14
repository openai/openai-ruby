#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"
require_relative "event_stream"
require "timeout"

module OpenAI
  module Examples
    module Realtime
      module Sideband
        module_function

        def stream(connection, output: $stdout, stop_after: nil)
          EventStream.each_until(connection, stop_after: stop_after) do |event|
            raise event.error.message if event.is_a?(OpenAI::Realtime::RealtimeErrorEvent)

            output.puts("#{event.type}: #{event.to_h}")
            output.flush
          end
        end

        def run(client:, call_id:, stop_after: nil, output: $stdout)
          client.realtime.connect_to_call(call_id: call_id) do |connection|
            connection.session.update(
              type: :realtime,
              instructions: "Use server-side business rules and keep answers short."
            )
            stream(connection, output: output, stop_after: stop_after)
          end
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  # CALL_ID may come from calls.create.call_id for WebRTC or from a verified
  # realtime.call.incoming webhook for SIP.
  client = OpenAI::Client.new
  run = lambda do
    OpenAI::Examples::Realtime::Sideband.run(
      client: client,
      call_id: ENV.fetch("OPENAI_REALTIME_CALL_ID"),
      stop_after: ENV["OPENAI_REALTIME_STOP_AFTER"]
    )
  end

  timeout = ENV["OPENAI_REALTIME_TIMEOUT"]
  timeout ? Timeout.timeout(Integer(timeout)) { run.call } : run.call
end
