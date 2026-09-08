# Responses WebSocket workflows

Requires `openai` 0.86.0 or later and the optional `async-websocket` gem:

```ruby
gem "openai", ">= 0.86.0"
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

The server executes same-lane requests in FIFO order. The SDK does not enforce
lane grammar, schedule lanes, or manage a per-lane queue. Consult the platform
guide for the current concurrent-response and named-lane limits.

To fork, send an existing response ID on a different lane. With `store=false`,
wait for the fork's `response.in_progress` before advancing the source lane so
its parent remains available in the connection-local cache.

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
- Malformed JSON raises `ResponsesProtocolError` without exposing the payload;
  the connection permits later reads. Decide whether continuing is appropriate
  for your application.
- Raw `send_event` supports generated client models or hashes, including
  `response.steer`. There is no `connection.response.steer` convenience method.
- The platform documents `generate: false` warmup. It can be forwarded through
  create's keyword rest even though 0.86.0 has no named generated `generate`
  keyword. Follow the platform contract; do not send HTTP-only `stream` or
  `background` flags just because generated models expose them.
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
