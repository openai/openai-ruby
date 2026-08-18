#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

module OpenAI
  module Examples
    module Realtime
      module WebRTCCall
        module_function

        def run(client:, input:, output:, error_output:, model:)
          offer = input.read
          raise "Expected an SDP offer on stdin" if offer.empty?

          call = client.realtime.calls.create(
            sdp: offer,
            session: {
              type: :realtime,
              model: model,
              audio: {output: {voice: :marin}}
            }
          )
          handed_off = false
          begin
            error_output.puts("Created Realtime call #{call.call_id || 'without a Location header'}")
            output.write(call.sdp)
            output.flush
            handed_off = true
          ensure
            release(client, call.call_id, active_error: $ERROR_INFO) if !handed_off && call.call_id
          end
        end

        def release(client, call_id, active_error:)
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
  OpenAI::Examples::Realtime::WebRTCCall.run(
    client: OpenAI::Client.new,
    input: $stdin,
    output: $stdout,
    error_output: $stderr,
    model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1")
  )
end
