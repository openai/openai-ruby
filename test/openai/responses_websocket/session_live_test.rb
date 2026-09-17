# frozen_string_literal: true

require_relative "../test_helper"

# Explicit opt-in only; ordinary test runs never make live API requests.
class OpenAI::Test::ResponsesWebSocketSessionLiveTest < Minitest::Test
  extend Minitest::Serial

  def test_live_session_continuation
    unless ENV["OPENAI_WEBSOCKET_LIVE_TEST"] == "1" && ENV["OPENAI_API_KEY"]
      skip("Live WebSocket tests require explicit opt-in and environment credentials.")
    end

    require "async"

    limits = OpenAI::Responses::SessionLimits.new(
      max_lanes: 4,
      max_events_per_lane: 128,
      max_events: 256,
      max_bytes_per_lane: 8 * 1024 * 1024,
      max_bytes: 16 * 1024 * 1024,
      max_response_bytes: 16 * 1024 * 1024
    )
    client = OpenAI::Client.new(default_headers: {"X-SDK-Header-Test" => "client"})
    model = ENV.fetch("OPENAI_WEBSOCKET_TEST_MODEL", "gpt-4o-mini")
    Sync do |task|
      task.with_timeout(60) do
        OpenAI::Responses::Session
          .open(
            client: client,
            limits: limits,
            request_options: {extra_headers: {"X-SDK-Header-Test" => "connection"}}
          ) do |session|
            lane = session.lane("sdk-live-ruby")
            lane.send_event(type: "response.create", model: model, input: "Reply with exactly OK.", store: false)
            first = lane.get_final_response
            assert_equal("completed", first.status.to_s)
            refute_empty(first.output_text)
            lane.send_event(
              type: "response.create",
              model: model,
              previous_response_id: first.id,
              input: "Reply with exactly OK again.",
              store: false
            )
            second = lane.get_final_response
            assert_equal("completed", second.status.to_s)
            refute_equal(first.id, second.id)
            refute_empty(second.output_text)
          end
      end
    end
  end
end
