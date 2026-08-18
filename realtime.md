# Realtime WebSockets

The Ruby SDK provides a typed, block-scoped WebSocket client for server-side
Realtime text sessions. The first phase deliberately stays at one cohesive
boundary: authenticated WebSocket connection setup, protocol event validation,
and deterministic connection cleanup.

## Installation

WebSocket support uses an optional adapter so applications that only use HTTP
do not acquire an event-loop dependency:

```ruby
gem "openai"
gem "async-websocket"
```

The adapter works inside or outside an existing Async reactor. Applications may
also inject a compatible transport, as described below.

## Start a text session

`connect` requires a block. The connection is valid only inside that block:

```ruby
require "openai"

client = OpenAI::Client.new

client.realtime.connect(model: "gpt-realtime-2.1") do |connection|
  connection.session.update(
    type: :realtime,
    output_modalities: [:text],
    instructions: "Be concise."
  )

  connection.conversation.items.create(
    type: :message,
    role: :user,
    content: [{type: :input_text, text: "Hello"}]
  )
  connection.response.create

  connection.each do |event|
    case event
    when OpenAI::Realtime::ResponseTextDeltaEvent
      print(event.delta)
    when OpenAI::Realtime::ResponseDoneEvent
      unless event.response.status == :completed
        raise "Response ended with #{event.response.status.inspect}"
      end
      break
    when OpenAI::Realtime::RealtimeErrorEvent
      raise event.error.message
    end
  end
end
```

The resource helpers accept Ruby keyword arguments and add protocol envelopes
internally:

- `session.update(type:, output_modalities:, instructions:, ...)`
- `conversation.items.create(type:, role:, content:, ...)`
- `conversation.items.retrieve(item_id:)` and `delete(item_id:)`
- `response.create(...)` and `response.cancel(...)`

For lower-level protocol work, `send_event` accepts a generated client-event
shape, while `receive`, `each`, and `parse_event` return generated server-event
types. `send_raw` and `receive_raw` are text-frame escape hatches.

## Event compatibility

Known events are validated against the SDK's generated Realtime event unions.
Malformed known events raise `OpenAI::Errors::RealtimeProtocolError`. A valid
JSON object with a newer, unknown event discriminator is returned as
`OpenAI::Realtime::UnknownServerEvent`, preserving its deeply frozen payload so
an additive service event does not terminate an otherwise healthy session.

```ruby
connection.each do |event|
  case event
  when OpenAI::Realtime::ResponseTextDeltaEvent
    print(event.delta)
  when OpenAI::Realtime::UnknownServerEvent
    logger.debug("Ignored Realtime event type: #{event.type}")
  end
end
```

## Lifecycle and failures

Normal block exit sends a WebSocket close frame. Exceptional exit aborts the
underlying I/O without trying to flush buffered writes, preserving the original
application exception and avoiding a second blocked network operation during
unwinding. Cleanup failures are raised when the application block itself
succeeded.

Connection and protocol failures use distinct error classes:

- `OpenAI::Errors::RealtimeConnectionError` exposes the target `url`, original
  `cause`, and a failed upgrade's `http_status` when available.
- `OpenAI::Errors::RealtimeProtocolError` exposes the invalid raw `data` and
  original `cause`.

The configured request timeout bounds WebSocket negotiation. It does not become
an idle-session deadline after the connection is established.

## Authentication and endpoint routing

Realtime connections reuse normal SDK authentication and request options. API
keys, Azure API keys, workload identity, organization/project headers, custom
headers, and request query parameters are prepared through the same client
request boundary as HTTP calls. A workload-identity token rejected with a
definitive upgrade `401` is invalidated and retried exactly once.

The WebSocket URL normally derives from `base_url`. A gateway that has a
different WebSocket origin can set a separate, validated endpoint:

```ruby
client = OpenAI::Client.new(base_url: "https://api-gateway.example.test/v1")

client.realtime.connect(
  model: "gpt-realtime-2.1",
  websocket_base_url: "wss://socket-gateway.example.test/v1"
) do |connection|
  # ...
end
```

`websocket_base_url` must be an absolute `http`, `https`, `ws`, or `wss` URL
without user information, query, or fragment. `connect` snapshots the supplied
string before request construction, so later caller mutation cannot change the
validated, credential-bearing origin. Provider-configured clients use their
provider endpoint and reject this override.

## Proxies and TLS

The default adapter honors Ruby's standard `http_proxy`, `https_proxy`, and
`no_proxy` routing. Secure WebSockets use an HTTP `CONNECT` tunnel before TLS.
Proxy credentials are derived only from proxy configuration and are sent only
to the proxy; caller-supplied `Proxy-Authorization` is stripped before the
origin handshake. Sensitive handshake headers are redacted from protocol trace
instrumentation without changing the wire request.

TLS always verifies the peer and hostname and negotiates HTTP/1.1. For a private
CA or mutual TLS, configure the native `OpenSSL::SSL::SSLContext`:

```ruby
transport = OpenAI::Realtime::Transports::AsyncWebSocket.new do |context|
  context.cert_store = private_ca_store
  context.cert = client_certificate
  context.key = client_private_key
end

client.realtime.connect(
  model: "gpt-realtime-2.1",
  transport: transport
) do |connection|
  # ...
end
```

The adapter restores peer and hostname verification after configuration and
rejects verification callbacks or TLS configuration for a plaintext `ws://`
endpoint.

## Custom transport

Pass `transport:` to integrate another WebSocket implementation. It must expose
this block-scoped contract:

```ruby
transport.open(url:, headers:, timeout:, **options) do |socket|
  # socket.read                         -> text-like message or nil
  # socket.write(utf8_string)           -> sends one text message
  # socket.close(code:, reason:)        -> graceful close
  # socket.abort                        -> immediate exceptional close
  # socket.closed?                      -> boolean
end
```

The SDK owns the authenticated `url`, `headers`, timeout, TLS, and protocol
settings. `transport_options` therefore cannot override those fields.

## Current scope

This phase does not add WebRTC/SDP lifecycle helpers, SIP or sideband helpers,
transcription or translation connections, audio/file/microphone flows, image
input, function calling helpers, or MCP helpers. Existing generated HTTP
resources remain generated-code-owned. New convenience APIs and examples for
those workflows have different media, ownership, security, and lifecycle
contracts and should be reviewed as separate follow-ups after the core
WebSocket boundary is stable.
