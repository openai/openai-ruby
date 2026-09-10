# Agents session helpers

Use `client.beta.agents.sessions.stream` to submit input to an idle session and
iterate through one turn. The helper opens the event connection before submitting
input. During iteration, this caller must be the session's only input writer.
Use the block form to close the connection even if iteration is abandoned:

```ruby
client.beta.agents.sessions.stream("session_id", input: "Summarize the results") do |stream|
  stream.each do |event|
    if event.type == :"agent.session.turn.output_text.delta"
      print event.delta
    end
  end
end
```

Input accepts a string or an array of input messages. The stream yields the
original typed events, including turn failures and cancellations. Protocol errors
with an `error` payload retain the raw event stream's API-exception behavior and
close the connection. Initial idle events
and subagent completions do not end iteration. The stream ends after the selected
coordinator turn completes, fails, or is cancelled and the session becomes idle,
or when the session fails. An unexpected connection end raises `RuntimeError`.
Closing the stream never cancels the backend turn. Without a block, close it in
an `ensure` clause when abandoning iteration.

Pass `tool_handlers: {"lookup" => ->(arguments) { ... }}` to dispatch registered
function calls sequentially after their events are yielded. Each callback receives
a copied JSON object with string keys and may return a string, JSON object,
input-content array, or `nil`. Invalid arguments, callback errors, and invalid
outputs submit a generic failure without exception text. Unregistered tools stay
available for manual handling through the raw events API.

Input and tool-result submissions use separate idempotency keys, stable across
retries. `idempotency_key:` applies only to input; a case-insensitive
`Idempotency-Key` in `request_options[:extra_headers]` overrides it. Request
options such as timeout and maximum retries apply to each HTTP request.
`stream.until_done` consumes the stream without processing events in caller code.
For an active session or an unrestricted event feed, use the existing
`client.beta.agents.sessions.events.stream_streaming` method.

`message.output_text` joins all output-text blocks in an `AgentSessionMessage`.
It returns an empty string when there are none, includes every message phase,
and neither fetches data nor changes the message's serialization.
