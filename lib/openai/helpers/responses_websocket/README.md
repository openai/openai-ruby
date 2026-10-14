# Responses WebSocket sessions

`OpenAI::Responses::Session.open` adds routed lanes and final-response collection
to the existing Responses WebSocket client. It uses the optional Async runtime
and the same transport, authentication, custom headers, and connection options
as `client.responses.connect`. Loading the SDK does not load Async.

```ruby
limits = OpenAI::Responses::SessionLimits.new(
  max_lanes: 8,
  max_events_per_lane: 128,
  max_events: 512,
  max_bytes_per_lane: 16 * 1024 * 1024,
  max_bytes: 32 * 1024 * 1024,
  max_response_bytes: 64 * 1024 * 1024
)

OpenAI::Responses::Session.open(
  client: OpenAI::Client.new,
  limits: limits,
  request_options: {extra_headers: {"X-Application-Request" => "example"}}
) do |session|
  lane = session.lane("conversation")
  lane.send_event(type: "response.create", model: "gpt-4o-mini", input: "Say hello.")
  response = lane.get_final_response
  # Supply previous_response_id explicitly for continuation on this lane.
end
```

Budgets are required application choices, not service limits or changes to
existing connection defaults. Queue budgets apply per lane and across the
session. Byte counts measure serialized event data, not Ruby objects, transport
buffers, or total process memory. `max_response_bytes` bounds the cumulative
compatible event bytes retained for collection. Choose budgets for legitimate
large output, including images and tool results. Queue overflow fails and closes
the owned connection; collection overflow leaves raw events and other lanes
usable. The default and all detached lane IDs count toward `max_lanes` until reconnect.

Register lanes before sending. For `response.create`, `lane.send_event` adds the
lane's `stream_id` and rejects conflicting routing metadata. Steering commands
keep their original fields and route through `previous_response_id`.
One Async task reads the physical connection and
routes each event to one lane. `session.default` receives unclaimed routing IDs
and events without a `stream_id`; observe it for connection-level errors. Each
lane has one consumer, and all session operations use the owning Ruby thread.
Canceling a task waiting on `receive` or `get_final_response` leaves its events
and accumulated state available to a later consumer. Closing a lane discards its
queue without closing the socket. Future events for a detached named lane go to
the default lane. Closing does not cancel server work. Lane IDs remain reserved until reconnect,
including after terminal events: steering can create automatic successors.
Continue using the same open lane for sequential responses. Closing the default lane opts out of unclaimed events. Leaving
the session block stops its reader and closes its owned transport.

`receive` returns original typed or unknown events. `get_final_response` consumes
remaining events and returns the current completed, failed, or incomplete response.
Collect a parent's final response before receiving its successor's `response.created`.
Receiving that event starts the successor's accumulation; previously received raw
terminal events remain available to the caller, but the helper keeps no response history. Final
output items fill omitted terminal output; no tool is executed automatically.
Nested protocol errors raise `OpenAI::Responses::RequestError` with the original
event in `error.event` and a content-free exception message. After sending a raw
command other than `response.create`, an unsequenced, unscoped error cannot reliably
identify its originating command. If such an error arrives while prior raw submissions
leave attribution uncertain and is consumed during an active default response, that
lane fails with the original error and cannot accept another create; named lanes remain
usable. This uncertainty persists across response boundaries until explicit reconnect.
A create rejection received before any raw submission remains retryable, even if a raw
command is sent before the queued error is consumed. A transport ending
before the terminal event raises instead of returning partial output as success.

Recovery is explicit. Call `session.reconnect(client: fresh_client,
request_options: fresh_options, restore: callback)`. The normal client connection
path re-evaluates authentication and custom headers. Old lane handles raise
`StateLostError`; the callback registers fresh lanes and sends whatever state the
application elects to restore. No previous create is replayed. A send failure has
an uncertain outcome and ends that transport. A failed or canceled restoration
closes the replacement connection. A new connection does not inherit the old
connection's response cache, so choose stored response IDs or explicit history
according to the application's state policy.

Run the opt-in live continuation test with `OPENAI_WEBSOCKET_LIVE_TEST=1` and
`OPENAI_API_KEY` supplied through the environment. Optionally select a model with
`OPENAI_WEBSOCKET_TEST_MODEL`; ordinary tests skip all live requests.
