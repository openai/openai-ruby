# Responses WebSocket workflows

Install `openai` and the optional `async-websocket` gem. The `multiplex` workflow
uses `OpenAI::Responses::Session`; versions with only `client.responses.connect`
can use the raw connection patterns below.

```ruby
gem "openai"
gem "async-websocket"
```

Responses WebSocket mode connects to `/v1/responses`. It uses Responses events;
it is distinct from [Realtime sessions](realtime.md). See the
[platform guide](https://developers.openai.com/api/docs/guides/websocket-mode)
for the service contract.

## Run the examples

The [workflow example](examples/responses/websocket_workflows.rb) demonstrates
four patterns with one reader and no background worker threads. Keep
`OPENAI_API_KEY` in your environment. These commands make real API calls:

```sh
bundle exec ruby examples/responses/websocket_workflows.rb tools
bundle exec ruby examples/responses/websocket_workflows.rb multiplex
bundle exec ruby examples/responses/websocket_workflows.rb stored
bundle exec ruby examples/responses/websocket_workflows.rb stateless
```

Set `OPENAI_RESPONSES_MODEL` to override `gpt-5.2` and
`OPENAI_RESPONSES_TIMEOUT` to change the 60-second overall deadline. The example
prints only a completion marker, not prompts, model output, or server errors.
The default workflow is `multiplex`. The `stored` workflow requires an account
that allows response storage; use `stateless` with `store=false`/ZDR.

## Connect, send, and receive

```ruby
client.responses.connect do |connection|
  connection.response.create(model: "gpt-5.2", input: "Say hello.")
  connection.each do |event|
    case event.type.to_s
    when "response.completed"
      # Save event.response.id and handle event.response.output here.
      break
    when "response.failed", "response.incomplete", "error"
      raise "Responses operation did not complete."
    end
  end
end
```

Use the complete example for EOF detection: a connection ending before every
expected terminal event is not success. `connect` requires a block and closes
on block exit. Connection options belong in `connect`; model/input fields belong
in `connection.response.create`.

Known events are decoded into generated models on a best-effort basis. New
event types arrive as `OpenAI::Responses::UnknownServerEvent`. Preserve or handle
them explicitly where your application needs them. Do not assume every event
has a response, text delta, or lane ID.

## Managed sessions

`OpenAI::Responses::Session.open` adds routed lanes and final-response collection
using the same authentication, custom headers, and connection options as
`client.responses.connect`. With `OPENAI_API_KEY` set, this complete example
opens a session and closes its reader and transport when the block exits:

```ruby
require "openai"

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
  lane.send_event(type: "response.create", model: "gpt-5.2", input: "Say hello.")
  response = lane.get_final_response
  puts response.status
  # Supply previous_response_id: response.id explicitly for continuation.
end
```

These required budgets are application choices, not service limits or changes
to raw connection defaults. The default and all detached lane IDs count toward `max_lanes` until reconnect. Queue
budgets apply per lane and across the session; byte counts measure serialized
event data, not total process memory. `max_response_bytes` bounds cumulative
compatible event bytes retained for collection. Choose budgets for legitimate
large output, including images and tool results. Queue overflow closes the
session's connection; collection overflow leaves raw events and other lanes usable.

Register lanes before sending and consume each response before creating another
on that lane. One Async task reads the physical connection; each lane has one
consumer, and all session operations use the owning Ruby thread. `lane.receive`
returns original typed or unknown events. `lane.get_final_response` consumes
remaining events and returns the current completed, failed, or incomplete response;
inspect its status. Collect a parent's final response before receiving its successor's
`response.created`, which starts accumulation for the successor. The helper does not
retain a history of completed responses; callers can retain the raw terminal events. Protocol errors raise `OpenAI::Responses::RequestError` with the
original event in `error.event`. Raw commands other than `response.create` leave
subsequent unsequenced, unscoped errors uncorrelated until explicit reconnect. Consuming
such an error during an active default response fails that lane; named lanes remain
usable. Errors received before the first raw submission retain ordinary create-retry
behavior, regardless of later commands sent before consuming them. Observe `session.default` for connection-level
errors and events with no registered lane. Closing a named lane discards its
queue and routes future events for that ID to the default lane. Closing a lane
does not cancel its server work. Its ID remains reserved until reconnect,
including after terminal events: steering can create automatic successors.
Continue using the same open lane for sequential responses. Closing the default
lane opts out of unclaimed events; it cannot be replaced before reconnect.

Recovery is explicit: `session.reconnect(client: fresh_client,
request_options: fresh_options, restore: callback)` re-evaluates authentication
and custom headers. Old lane handles raise `StateLostError`; the callback
registers fresh lanes and sends application-selected restoration state. No
previous create is replayed. Choose stored IDs or full history as described in
[reconnect guidance](#reconnect-without-replaying-uncertain-work).

## Sequential tool turns

The `tools` workflow forces a call to one known, harmless application function.
After the response completes, it checks the function name and sends its output
using the original `call_id`. The next create uses `previous_response_id` and
only the new `function_call_output` item. It does not resend the previous input
on the same connection.

Tool execution belongs to your application. Validate arguments against your
tool's contract and authorize effects before execution. Never execute generated
code or dispatch arbitrary method names from a tool event. The example uses a
fixed result and does not execute model-provided code.

## Multiplexing and continuation

`stream_id` routes events to a lane; `previous_response_id` selects conversation
history. They are independent. Reusing a lane without a previous response ID
starts a new response rather than continuing that lane's conversation.

The `multiplex` workflow writes two creates, then drains both lanes with one
reader. Events may interleave and the first terminal event does not finish the
whole operation. Keep a pending-lane set and retain each completed response ID.
Omitting `stream_id` uses the default lane; its events omit the field as well.

The example fails the whole operation on any error. Production applications can
route a lane-scoped error to just that lane, while treating a connection-scoped
error as affecting the connection. Track separate response IDs when multiple
requests are outstanding within a lane; a lane alone is not a request ID.

The server executes same-lane requests in FIFO order without overlap. Named IDs
contain 1–256 ASCII letters, digits, underscores, hyphens or periods; an empty string
is invalid. The raw connection forwards IDs without enforcing this grammar.
The optional [session helper](#managed-sessions)
routes events into local queues and allows one consumed response at a time per
lane; it does not schedule server work. Named-lane terminal events and request
errors echo the ID; default-lane events omit it.

The service allows 16 active responses and queues additional creates. It accepts
32 distinct named IDs per connection; the default lane does not count. These
are separate from the session's application budgets. Detaching a local lane
does not reset the server's distinct-ID count.

To fork, send an existing response ID on a different lane. With `store=false` or ZDR,
wait for the fork's `response.in_progress` before advancing the source lane so
its parent remains available in the connection-local cache.

The server keeps recent response state in a connection-local cache. With
`store=true`, an older response may be loaded from persisted state. With
`store=false` or ZDR, an uncached ID returns `previous_response_not_found`.
A same-lane continuation returning a 4xx or 5xx evicts its referenced cached
parent; an errored cross-lane fork preserves the shared parent for the source
lane. Do not blindly retry the same parent after a cache miss; use the explicit
context-restoration approach below when needed.

## Warmup and compaction

For optional warmup, send `connection.response.create(..., generate: false)`,
consume the terminal response, and save its ID. A later create can use that ID
as `previous_response_id` with new input. Warmup prepares state without model
output; the existing create helper forwards `generate` as an extra field.

With automatic compaction configured through `context_management`, continue
using the latest response ID and only new input items. Standalone
`client.responses.compact(...)` instead returns a compacted input window. Send
its complete `output` as input to a new WebSocket chain, omitting or nulling
`previous_response_id`; do not use the compaction object's ID as a response ID
or prune items from its output.

## Reconnect without replaying uncertain work

Both reconnect examples intentionally close a healthy connection **after** a
completed turn, then open another connection. They do not catch a failed write
and retry it.

- **Stored:** send only the new input plus the stored `previous_response_id`.
  If the service cannot retrieve that response, the application must decide
  whether to reconstruct context and start a new chain.
- **Stateless:** connection-local state is lost on reconnect. Retain the original
  inputs and every output item, including reasoning and tool items. Request
  `include: ["reasoning.encrypted_content"]` for reasoning-model replay. Send the
  retained history plus new input, omitting `previous_response_id` on the new
  connection. Do not reduce history to displayed assistant text.

Retained history can contain sensitive data. Apply your application's retention
policy; neither the SDK nor this example writes a recovery log. A full-context
replay starts a new chain and is not an exactly-once retry of a failed turn.

Connections have a finite service lifetime (currently up to 60 minutes). Plan
rotation and persistence at completed-turn boundaries. There is no automatic
reconnect, rollover, or replay in this SDK connection.

## Deadlines and shutdown

An SDK request timeout bounds connection negotiation, not an established
session's idle lifetime. The example wraps the complete workflow in an Async
deadline on the owning thread:

```ruby
require "async"

Sync do |task|
  task.with_timeout(60) do
    client.responses.connect do |connection|
      # Send and read on this thread, inside the deadline.
    end
  end
end
```

Connections enforce one owning thread and one active reader. Do not call close
from another thread or nest `receive` inside an active `each`. The Async deadline
can interrupt an idle network read on the owning thread; the SDK then aborts and
cleans up the connection. A timeout inside a transport operation can surface as
`ResponsesConnectionError`, rather than `Async::TimeoutError`. Application code
that does CPU-bound work without yielding needs its own cancellation strategy.

Exiting the block normally performs a close. An exception or poisoned connection
causes an abort, avoiding a flush of uncertain buffered output. The peer may see
an abrupt disconnect. This is local shutdown, not a server-side cancellation
acknowledgment, and it does not guarantee that a response stopped executing.

## Error and compatibility boundaries

- `ResponsesSendError#outcome` is `:unknown`: the server may have accepted the
  event. Stop using that connection; do not automatically resend it.
- A transport read failure poisons the connection. A server `error` event is
  delivered as an event and does not by itself poison it.
  Handle `previous_response_not_found`, `invalid_stream_id`,
  `websocket_stream_limit_reached`, and `websocket_connection_limit_reached`
  through the original error event. Observe `session.default` when using named
  session lanes so connection-scoped errors are not left unread.
- Malformed JSON raises `ResponsesProtocolError` without exposing the payload;
  the connection permits later reads. Decide whether continuing is appropriate
  for your application.
- Raw `send_event` supports generated client models or hashes, including
  `response.steer`. There is no `connection.response.steer` convenience method.
  Steering accepts only `type`, `previous_response_id`, and `input`, without
  `stream_id`. Accepted input is committed at the successor's `response.created`.
  If `response.steer.pending` requires tool output or approval, fill its
  `required_input` stubs and send one create on the parent's lane with that
  parent ID. Reuse saved results; do not rerun tools or resend accepted input.
- Follow the platform contract; do not send HTTP-only `stream` or `background`
  flags just because generated models expose them.
- X.509 workload identity and provider runtimes are not supported by this
  entry point. A nonempty `request_options.extra_query` or nonzero
  `request_options.max_retries` is rejected. Supported workload identity has a
  narrow pre-handshake 401 refresh; that is not live-session recovery.
- Large events are valid. Plan memory and application backpressure for your
  workload without treating a fixed payload size as a protocol maximum.

## Offline verification

```sh
bundle exec ruby -Itest test/openai/responses_websocket/workflows_test.rb
```

The tests use real loopback WebSockets and synthetic data, exercise the default
Responses transport, and make no live API requests. They cover the four example
patterns, interleaved terminal events, fragmented text, premature EOF, failures,
idle-read deadlines, and a large event exceeding 32 MiB.
