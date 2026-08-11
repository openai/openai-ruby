#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/openai"

# Pipe a browser's SDP offer to this process. The SDP answer is written to stdout,
# which makes this suitable as the core of a Rails, Sinatra, or Rack endpoint.
offer = $stdin.read
raise "Expected an SDP offer on stdin" if offer.empty?

client = OpenAI::Client.new
call = client.realtime.calls.create(
  sdp: offer,
  session: {
    type: :realtime,
    model: ENV.fetch("OPENAI_REALTIME_MODEL", "gpt-realtime-2.1"),
    audio: {output: {voice: :marin}}
  }
)

warn("Created Realtime call #{call.call_id || 'without a Location header'}")
$stdout.write(call.sdp)
