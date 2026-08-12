#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"
require_relative "event_stream"
require "timeout"

module OpenAI
  module Examples
    module Realtime
      module SIP
        module_function

        def stream(connection, output: $stdout, stop_after: nil)
          EventStream.each_until(connection, stop_after: stop_after) do |event|
            case event
            when OpenAI::Realtime::ResponseAudioTranscriptDeltaEvent
              output.print(event.delta)
              output.flush
            when OpenAI::Realtime::RealtimeErrorEvent
              raise event.error.message
            end
          end
        end

        def run(client:, call_id:, model:, output: $stdout, stop_after: nil)
          accepted = false
          client.realtime.calls.accept(
            call_id,
            type: :realtime,
            model: model,
            instructions: "You are answering a phone call. Be warm and concise."
          )
          accepted = true

          client.realtime.connect_to_call(call_id: call_id) do |connection|
            stream(connection, output: output, stop_after: stop_after)
          end
        ensure
          hangup(client, call_id, active_error: $ERROR_INFO) if accepted
        end

        def hangup(client, call_id, active_error:)
          client.realtime.calls.hangup(call_id)
        rescue OpenAI::Errors::NotFoundError
          nil
        rescue StandardError
          raise unless active_error
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  # Obtain the call ID from a verified realtime.call.incoming webhook via
  # client.webhooks.unwrap(payload, headers).
  run = lambda do
    OpenAI::Examples::Realtime::SIP.run(
      client: OpenAI::Client.new,
      call_id: ENV.fetch("OPENAI_REALTIME_CALL_ID"),
      model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
      stop_after: ENV["OPENAI_REALTIME_STOP_AFTER"]
    )
  end

  timeout = ENV["OPENAI_REALTIME_TIMEOUT"]
  timeout ? Timeout.timeout(Integer(timeout)) { run.call } : run.call
end
