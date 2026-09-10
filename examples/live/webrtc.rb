#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"

require_relative "../../lib/openai"

module OpenAI
  module Examples
    module Live
      module WebRTC
        module_function

        # Run on your backend, after authenticating the browser's request. Keep the
        # API key on the backend. The browser creates the peer connection, adds its
        # audio track and data channel, and sends its local SDP offer here.
        def create(client:, offer_sdp:, model: "gpt-live-1")
          client.live.create(
            session: {model: model},
            transport: {type: :webrtc, sdp: offer_sdp}
          )
        end
      end
    end
  end
end

if $PROGRAM_NAME == __FILE__
  # Usage: OPENAI_API_KEY=... ruby examples/live/webrtc.rb < offer.sdp > answer.json
  # Return transport.sdp to the browser and apply it with setRemoteDescription.
  # Wait for session.started on the data channel before sending commands. Keep
  # session.id on your backend to associate a sideband connection with this user.
  result = OpenAI::Examples::Live::WebRTC.create(
    client: OpenAI::Client.new,
    offer_sdp: $stdin.read,
    model: ENV.fetch("OPENAI_LIVE_MODEL", "gpt-live-1")
  )
  puts(JSON.generate({session: {id: result.session.id}, transport: {type: "webrtc", sdp: result.transport.sdp}}))
end
