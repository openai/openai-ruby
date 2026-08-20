# Realtime WebSockets

The Ruby SDK provides a typed, block-scoped WebSocket client for server-side
Realtime text sessions, committed-turn transcription, and one-turn voice
workflows. The implementation stays at one cohesive boundary: authenticated
WebSocket connection setup, protocol event validation, deterministic cleanup,
and synchronous event flow.

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
      raise "Realtime API error."
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
- `input_audio_buffer.append(audio:)`, `append_bytes(bytes)`, `commit`, and
  `clear`

For lower-level protocol work, `send_event` accepts a generated client-event
shape, while `receive`, `each`, and `parse_event` return generated server-event
types. Invalid client events raise `ArgumentError` with a generic public
message; the converter error remains available through `cause` for explicit
inspection. `send_raw` and `receive_raw` are text-frame escape hatches.

## Transcribe one committed audio turn

Use `connect_transcription` for the dedicated transcription handshake. Select
the model in a `type: :transcription` session update, append 24 kHz mono PCM16
audio, and explicitly commit the buffered turn:

```ruby
File.open("speech.pcm", "rb") do |input|
  client.realtime.connect_transcription do |connection|
    connection.session.update(
      type: :transcription,
      audio: {
        input: {
          format: {type: :"audio/pcm", rate: 24_000},
          transcription: {model: "gpt-transcribe"},
          turn_detection: nil
        }
      }
    )

    while (chunk = input.read(9_600))
      connection.input_audio_buffer.append_bytes(chunk)
    end
    connection.input_audio_buffer.commit

    committed_item_id = nil
    connection.each do |event|
      case event
      when OpenAI::Realtime::InputAudioBufferCommittedEvent
        committed_item_id = event.item_id
      when OpenAI::Realtime::ConversationItemInputAudioTranscriptionDeltaEvent
        print(event.delta) if event.item_id == committed_item_id
      when OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent
        break if event.item_id == committed_item_id
      when OpenAI::Realtime::ConversationItemInputAudioTranscriptionFailedEvent,
           OpenAI::Realtime::RealtimeErrorEvent
        raise "Realtime transcription failed."
      end
    end
  end
end
```

Correlate delta and completed events by `item_id`; completion ordering across
different input turns is not guaranteed. The runnable
[`websocket_transcription.rb`](examples/realtime/websocket_transcription.rb)
example additionally rejects empty input and requires a matching non-empty
completion. It defaults to `gpt-transcribe`, which is intended for committed
turns over WebSockets.

## Send one voice turn and stream the spoken response

A normal Realtime session can accept an explicitly committed PCM turn and
stream PCM response audio plus its transcript. Disable turn detection when the
client owns the turn boundary, then call `response.create` after `commit`:

```ruby
transcript = +""

client.realtime.connect(model: "gpt-realtime-2.1") do |connection|
  connection.session.update(
    type: :realtime,
    output_modalities: [:audio],
    audio: {
      input: {
        format: {type: :"audio/pcm", rate: 24_000},
        turn_detection: nil
      },
      output: {
        format: {type: :"audio/pcm", rate: 24_000},
        voice: :marin
      }
    }
  )

  while (chunk = input.read(9_600))
    connection.input_audio_buffer.append_bytes(chunk)
  end
  connection.input_audio_buffer.commit
  connection.response.create

  connection.each do |event|
    case event
    when OpenAI::Realtime::ResponseAudioDeltaEvent
      audio_output.write(event.delta.unpack1("m0"))
    when OpenAI::Realtime::ResponseAudioTranscriptDeltaEvent
      transcript << event.delta
    when OpenAI::Realtime::ResponseDoneEvent
      raise "Realtime response failed." unless event.response.status == :completed
      break
    when OpenAI::Realtime::RealtimeErrorEvent
      raise "Realtime API error."
    end
  end
end
```

The runnable
[`websocket_voice_turn.rb`](examples/realtime/websocket_voice_turn.rb) example
checks the complete lifecycle: non-empty input, explicit commit, streamed audio
and transcript, a successful terminal response, and binary output. The
executable reads raw PCM from standard input, writes response PCM to standard
output, and keeps metadata-only diagnostics on standard error. Its single
deadline begins before the initial input read and covers the complete network
turn. Embedded callers receive the transcript as the return value. At the
executable boundary, operating-system I/O errors and malformed protocol events
become generic exceptions without sensitive paths, payloads, or retained
causes. The example deliberately leaves output filenames, overwrite policy,
and filesystem durability to the caller rather than claiming a portable secure
file-publication contract.

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

Realtime connections reuse normal SDK authentication and routing-related
request options. API keys, Azure API keys, workload identity,
organization/project headers, `extra_headers`, and `timeout` are prepared
through the same client request boundary as HTTP calls. The SDK owns Realtime
query construction, including `model` and provider-specific parameters;
non-empty `request_options[:extra_query]` is rejected before authentication or
transport because the HTTP/1 tracing interface cannot separate a wire request
target from its trace value. HTTP body and idempotency options do not apply to a
WebSocket handshake. HTTP retry policy also does not apply: a nonzero
`request_options[:max_retries]` is rejected; omit it or pass `0`. A
workload-identity token rejected with a definitive upgrade `401` is invalidated
and retried exactly once before the connection is yielded. Exceptions from the
application block never trigger a reconnect or block replay.

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
settings. `transport_options` therefore cannot override those fields and are
snapshotted before authentication so later caller mutation cannot alter the
handshake.

## Current scope

This phase does not add continuous microphone capture, concurrent live
captioning, live response-audio playback, WebRTC/SDP lifecycle helpers, SIP or
sideband helpers, translation connections, image input, function calling
helpers, or MCP helpers. Existing generated HTTP resources remain
generated-code-owned. New convenience APIs and examples for those workflows
have different media, ownership, security, and lifecycle contracts and should
be reviewed as separate follow-ups.
