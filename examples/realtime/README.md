# Realtime WebSocket text example

This directory contains one runnable example for the Phase 1 Realtime
WebSocket surface. It creates a typed text session, sends one user message,
streams assistant text, verifies a completed response, and exits.

Add the optional transport dependency and set an API key:

```sh
bundle add async-websocket
export OPENAI_API_KEY="your-key"
```

Run the example from the repository root:

```sh
bundle exec ruby examples/realtime/websocket_text.rb
```

A successful run prints `session.created`, `session.updated`, streamed
assistant text, `response.done status=completed`, and finally
`[realtime] smoke test passed`. Early connection closure, a non-completed
response, or a completed response without text is treated as a failure.

Optional environment variables:

- `OPENAI_REALTIME_MODEL` — defaults to `gpt-realtime-2.1`.
- `OPENAI_REALTIME_PROMPT` — defaults to `Say hello from Ruby.` and is not
  echoed to diagnostic output.
- `OPENAI_REALTIME_TIMEOUT` — overall example deadline in seconds; defaults to
  `30`.

See the repository's [Realtime WebSocket guide](../../realtime.md) for the
public connection API, custom transports, proxy behavior, and TLS setup.
