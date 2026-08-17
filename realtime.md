# Realtime API

The Ruby SDK supports the server-side parts of the Realtime API:

- typed WebSocket sessions for text, images, audio, transcription, function calls, and remote MCP;
- WebRTC SDP negotiation from a trusted Ruby backend;
- sideband WebSocket control for active WebRTC and SIP calls;
- SIP accept, reject, refer, and hangup controls; and
- dedicated WebSocket and client-secret translation endpoints.

Ruby does not provide a broadly deployed, standard WebRTC media stack. The SDK
therefore handles the backend SDP exchange and call controls while browsers or a
specialized media service own `RTCPeerConnection`, microphone capture, codecs,
jitter buffering, echo cancellation, and playback.

## Installation

HTTP and WebRTC session-negotiation methods use the base SDK. WebSockets use an
optional adapter so applications that only use HTTP do not acquire an event-loop
dependency:

```ruby
gem "openai"
gem "async-websocket"
```

The adapter is fiber-scheduler-aware and works both inside and outside an
existing Async reactor. You can instead inject an object implementing the small
transport contract described below.

## Start a WebSocket session

`connect` is block-scoped. This is the safest lifecycle in Rails jobs,
Rack servers, CLI programs, and long-running workers because normal returns and
exceptions both close the socket.

```ruby
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
      raise "Response ended with #{event.response.status}" unless event.response.status == :completed
      break
    when OpenAI::Realtime::RealtimeErrorEvent
      raise event.error.message
    end
  end
end
```

To exercise that flow against the live service with visible lifecycle output,
set `OPENAI_API_KEY` and run:

```console
$ bundle exec ruby examples/realtime/websocket_text.rb
```

Set `OPENAI_REALTIME_MODEL`, `OPENAI_REALTIME_PROMPT`, or
`OPENAI_REALTIME_TIMEOUT` to override the example defaults.

`connect` requires a block. The yielded connection is valid only for the lifetime
of that block and is always closed when the block exits, including exceptional exits.

The connection exposes `receive`, `receive_raw`, `parse_event`, `send_event`,
`send_raw`, `each`, `close`, and `closed?`. The resource
helpers construct and validate the common client events:

- `session.update`;
- `response.create` and `response.cancel`;
- `input_audio_buffer.append`, `append_bytes`, `commit`, and `clear`;
- sideband-only `output_audio_buffer.clear`; and
- conversation item create, retrieve, truncate, delete, function-call output,
  and MCP approval response.

`append` accepts API-ready Base64. `append_bytes` accepts binary audio and uses
strict Base64 encoding. Sending is synchronous, and iteration reads one message
at a time, so the caller naturally applies backpressure instead of filling an
unbounded SDK queue. A connection supports one reader fiber and one writer
fiber at the same time, which is useful for continuous audio. Do not run
multiple readers or multiple writers against the same connection.
The hands-free WebSocket example uses a bounded outbound queue so microphone
audio and interruption-driven truncation events share exactly one writer fiber.

The yielded class reflects the protocol's capabilities:

- `connect(model:)` yields `OpenAI::Realtime::Connection` for ordinary sessions;
- `connect_transcription` yields
  `OpenAI::Realtime::TranscriptionConnection`, exposing only session and input
  audio buffer operations;
- `connect_to_call(call_id:)` yields `OpenAI::Realtime::SidebandConnection`, adding
  `output_audio_buffer`; and
- `translations.connect` yields `OpenAI::Realtime::TranslationConnection`,
  which intentionally has no conversation or response lifecycle.

The resource helpers accept the resource fields directly and add the wire
envelope internally: use `session.update(type: ...)`,
`response.create(instructions: ...)`, and `conversation.items.create(type: ...)`.
Use `send_event` only when an application deliberately needs an exact protocol
event hash.

## Stream transcription

Realtime transcription is a distinct session mode. Configure a transcription
model, append raw mono 24 kHz PCM16 input, and commit the buffer:

```ruby
client.realtime.connect_transcription do |connection|
  connection.session.update(
    audio: {
      input: {
        format: {type: :"audio/pcm", rate: 24_000},
        transcription: {model: "gpt-live-transcribe"},
        turn_detection: nil
      }
    }
  )

  # Wait for SessionUpdatedEvent before streaming input.
  connection.input_audio_buffer.append_bytes(pcm_chunk)
  connection.input_audio_buffer.commit

  connection.each do |event|
    case event
    when OpenAI::Realtime::ConversationItemInputAudioTranscriptionDeltaEvent
      print(event.delta)
    when OpenAI::Realtime::ConversationItemInputAudioTranscriptionCompletedEvent
      puts event.transcript
    end
  end
end
```

Completion events for different turns are not guaranteed to arrive in input
order, so correlate deltas and completions with `item_id`. The dedicated
connection uses the service's `intent=transcription` handshake and adds the
session's `type: :transcription` discriminator internally; the transcription
model belongs under `audio.input.transcription.model`. Run the complete live sample with
`REALTIME_INPUT_PCM=input.pcm bundle exec ruby
examples/realtime/websocket_transcription.rb`.

## Send an image

Realtime conversation items accept PNG and JPEG images as data URIs. The Ruby
helper keeps the message fields at the resource level and creates the protocol
envelope internally:

```ruby
image = Base64.strict_encode64(File.binread("photo.png"))

connection.conversation.items.create(
  type: :message,
  role: :user,
  content: [
    {type: :input_image, image_url: "data:image/png;base64,#{image}"},
    {type: :input_text, text: "What is important in this image?"}
  ]
)
connection.response.create(output_modalities: [:text])
```

Run the complete live sample with `REALTIME_INPUT_IMAGE=photo.png bundle exec
ruby examples/realtime/image_input.rb`. It verifies the PNG or JPEG signature
before opening the WebSocket and requires non-empty model text plus a completed
response.

## Create a WebRTC call

WebRTC media is intentionally not a Ruby SDK responsibility. In a browser or
mobile voice application, the client owns `RTCPeerConnection`, microphone
permissions, audio playback, jitter buffering, and acoustic echo cancellation.
Ruby owns the trusted-server control plane: API credentials, session
configuration, SDP negotiation, sideband tools and policy, and call lifecycle.
The SDK therefore supports WebRTC session negotiation and server controls; it
does not attempt to expose a Ruby WebRTC peer API.

Use `calls.create` in the trusted application server that receives a browser's
SDP offer:

```ruby
call = client.realtime.calls.create(
  sdp: browser_offer,
  session: {
    type: :realtime,
    model: "gpt-realtime-2.1",
    audio: {output: {voice: :marin}}
  },
  request_options: {
    extra_headers: {"OpenAI-Safety-Identifier" => hashed_user_id}
  }
)

render plain: call.sdp, content_type: "application/sdp"
```

The result preserves `sdp`, normalized response `headers`, and `call_id` parsed
from the optional `Location` header. A missing or malformed `Location` leaves
`call_id` as `nil` without discarding an otherwise valid SDP answer. Keep the
call ID if the application will open a server-side sideband connection:

```ruby
client.realtime.connect_to_call(call_id: call.call_id) do |connection|
  connection.session.update(
    type: :realtime,
    instructions: "Apply private server policy."
  )
  connection.each { |event| audit(event) }
end
```

The SDK sends raw `application/sdp` when only an offer is provided; use that
form with a client configured with a previously minted ephemeral session token.
With a standard server API key, provide `session:` and the SDK sends multipart
form data with correctly typed `sdp` and `session` parts. It never exposes a
standard API key to browser code. Call creation defaults to zero retries because
replaying a successful request could allocate a second live call without a known
ID. If reading the SDP answer fails after the service returns a call ID, the SDK
uses the client's configured retry policy for the idempotent hangup cleanup and
preserves the original read error. Request-scoped routing headers and query
parameters are carried into that cleanup request; the create request's
zero-retry safeguard is not, so cleanup can use the configured retry policy.

The repository browser demo treats that Ruby endpoint as a local credentialed
control plane: it binds only to an explicit loopback address, validates `Host`
for every request, and requires the exact browser `Origin` for both session
creation and hangup. Production Rails or Sinatra endpoints need their normal
user authentication and CSRF/origin policy before calling `calls.create`.
Browser cleanup retains the call ID after a failed hangup, prevents a new call
from overwriting it, exposes a retry action, and leaves the page-exit beacon
armed until the backend confirms the call ended. The demo refuses to establish
browser media unless call creation returns a recoverable call ID, and it treats
retries for recently completed, previously owned IDs as successful. Stopping the
Ruby process also attempts to hang up every active call still tracked by the
local control plane.

## SIP calls

Verify incoming webhooks before using their call ID, accept or reject the call,
then use the same sideband connection API:

```ruby
event = client.webhooks.unwrap(raw_body, request_headers)
return unless event.is_a?(OpenAI::Webhooks::RealtimeCallIncomingWebhookEvent)

call_id = event.data.call_id
client.realtime.calls.accept(
  call_id,
  type: :realtime,
  model: "gpt-realtime-2.1",
  instructions: "You are answering a phone call."
)

client.realtime.connect_to_call(call_id: call_id) do |connection|
  connection.each { |realtime_event| handle(realtime_event) }
end
```

`calls.reject`, `calls.refer`, and `calls.hangup` provide the remaining SIP and
call-lifecycle controls. The runnable SIP example assumes cleanup ownership as
soon as it receives the verified incoming call ID, before sending `accept`; an
ambiguous lost accept response therefore still triggers hangup without replacing
the original transport error.

## Translation

Translation has dedicated endpoints and distinct typed event unions:

```ruby
require "async"

client.realtime.translations.connect(model: "gpt-realtime-translate") do |connection|
  connection.session.update(audio: {output: {language: "es"}})

  reader = Async do
    connection.each do |event|
      case event
      when OpenAI::Realtime::RealtimeTranslationOutputTranscriptDeltaEvent
        print(event.delta)
      when OpenAI::Realtime::RealtimeTranslationOutputAudioDeltaEvent
        play(Base64.strict_decode64(event.delta))
      when OpenAI::Realtime::RealtimeTranslationSessionClosedEvent
        break
      end
    end
  end

  while (chunk = pcm16_source.read(9_600))
    connection.input_audio_buffer.append_bytes(chunk)
  end
  connection.session.close
  reader.wait
end
```

Call `session.close` after the last audio chunk and continue reading until the
server sends `session.closed`; closing the socket immediately can discard output
that is still draining. A Ruby server can mint an ephemeral translation secret
with `translations.client_secrets.create`. The SDK intentionally does not expose
translation WebRTC call creation: neither the public OpenAPI contract nor the
public API reference defines that resource yet. Internal service reachability is
not a compatibility guarantee. Add the Ruby resource only after the endpoint is
published, at which point Castiron can own its generated surface. Client-secret
and WebSocket event hashes accept symbol or string keys recursively, including
nested session and expiration configuration, so `JSON.parse` and Rails-derived
hashes follow the same validation path.

## Function calls and MCP approvals

Function call output and MCP approval responses are ordinary conversation items.
The helpers supply the required item shape and generate an MCP response ID when
one is not supplied:

```ruby
connection.conversation.items.create_function_call_output(
  call_id: function_call.call_id,
  output: JSON.generate(result)
)

connection.conversation.items.respond_to_mcp_approval(
  approval_request_id: approval_item.id,
  approve: policy.allows?(approval_item),
  reason: "Evaluated by application policy"
)
```

The runnable local-function example covers the complete two-response lifecycle:
it receives final JSON arguments, executes application code, sends
`function_call_output`, disables tools for the follow-up response, and waits for
non-empty final text:

```console
$ bundle exec ruby examples/realtime/function_calling.rb
```

Remote MCP servers are configured through the typed `tools` field in
`session.update` or `response.create`; all MCP progress, approval, and completion
events decode through `RealtimeServerEvent`. Before a dependent prompt, wait for
both `McpListToolsCompleted` and the `ConversationItemDone` event whose
`RealtimeMcpListTools` item contains the imported tool names. The runnable
example keeps the complete server descriptor on the session and forces the
discovered tool only on the first `response.create`. This avoids replacing the
session's `tools` array with a partial MCP descriptor. If an application changes
`tool_choice` through `session.update` instead, it must preserve a valid MCP
server configuration and wait for `SessionUpdatedEvent` before creating the
response. The single-call example also sets `parallel_tool_calls: false`; an
application that enables parallel calls must track every call independently.

The first completed `ResponseDoneEvent` can finish the MCP argument-generation
phase while approval and tool execution are still pending. Keep reading, answer
the `RealtimeMcpApprovalRequest`, wait for `ResponseMcpCallCompleted`, and create
a follow-up response (usually with `tool_choice: :none`) to turn the tool output
into a final assistant answer. Treat only that follow-up response's completed
`ResponseDoneEvent` with non-empty text as success; clean EOF during discovery,
approval, or tool execution is still an incomplete workflow, a response that
completes before the required MCP call is a failure, and a final response with
no text is not a successful smoke test. The approval helper generates item IDs
within the service's 32-character limit.

## Cross-SDK design position

The Ruby surface aims for protocol parity with the Python and Node SDKs without
copying APIs that fit those runtimes better:

| Concern | Python | Node.js | Ruby decision |
| --- | --- | --- | --- |
| Event consumption | Sync/async iterators and callbacks | Typed `EventEmitter` callbacks | `Enumerable`, `receive`, and pattern matching |
| Connection lifetime | Sync/async context managers | Socket lifecycle events | Required block with ensure-based cleanup |
| Concurrency | Separate sync and async clients | Promise/event-loop APIs | One fiber-aware API inside or outside an Async reactor |
| Reconnect | Opt-in callback, retry, and send queue | No core automatic reconnect | No automatic reconnect or state replay |
| Browser media | Separate client patterns | Native WebSocket plus Agents SDK WebRTC | Ruby backend negotiates SDP; browser owns WebRTC media |
| Transport dependency | Optional Python extra | Optional `ws` peer dependency | Optional `async-websocket` Gemfile dependency |

The callback omission is deliberate: an additional dispatcher would introduce a
second read-loop abstraction and ambiguous ownership. Ruby callers can use
`each`, `find`, `lazy`, ordinary blocks, and class-based `case` matching without
string event names. A sync/async split is also unnecessary because the default
adapter uses Ruby's fiber scheduler while preserving synchronous backpressure.

Automatic reconnect is intentionally not a release gap. A new socket creates a
new stateful session; replaying audio, item creation, function output, or MCP
approval can duplicate work or side effects. Applications that reconnect must
choose which state to rebuild. A future resumable service contract could justify
an SDK abstraction, but transport retries alone are not session recovery.

Node's browser and Agents SDK layers remain out of scope for this gem. Public
OpenAI guidance prefers WebRTC when a browser captures or plays audio, and Ruby
does not have a standard media stack comparable to `RTCPeerConnection`. The
Ruby SDK should own secrets, ephemeral credentials, SDP exchange, sideband
policy, tools, and call lifecycle—not codecs, echo cancellation, or playback.

### Generated and handwritten ownership

Castiron remains responsible for protocol models, event models, discriminated
event unions, generated JSON HTTP controls, RBI, and RBS. Handwritten Realtime
behavior lives under `lib/openai/helpers/realtime`, with matching signatures
under `rbi/openai/helpers/realtime` and `sig/openai/helpers/realtime`. This keeps
the live connection, resource conveniences, transport adapter, raw-SDP response
handling, and translation client-secret bridge out of generated-owned files.
The only generated seams are the root helper require and the
`websocket_base_url:` client-constructor keyword in RBI/RBS.

The handwritten decoder reads the generated event unions at runtime, so newly
generated event variants become typed automatically. A valid event unknown to
an older gem remains an `UnknownServerEvent`. Regeneration review must still
check capability-specific connection types when generated client-event shapes
change. Flattened helper keyword bags intentionally stay open-ended in RBI/RBS;
they do not re-enumerate protocol fields that Castiron already owns. The helper
adds the wire envelope and the generated client-event union performs runtime
validation. Realtime message items are the one nested-union exception: the wire
protocol uses both `type: :message` and `role` to select system, user, or
assistant content, so a handwritten resolver adds that second discriminator
without changing the SDK-wide generated union framework.

`calls.create` remains a focused custom HTTP implementation because the public
WebRTC endpoint returns raw SDP and can accept either raw `application/sdp` or
multipart SDP plus session JSON; ordinary JSON resource generation does not
model that response cleanly. Translation client-secret creation is also a narrow
bridge for a published endpoint that the current generated resource surface does
not emit. Both should migrate to generated ownership when Castiron supports
their response/resource shapes. The SDK does not handwrite unpublished
translation WebRTC call routes.

## Lifecycle and failures

The SDK does not automatically reconnect or replay events. Realtime sessions are
stateful, and replaying audio, item creation, tool output, or approval decisions
can duplicate side effects. Treat an unexpected close as an application-level
decision: terminate, or reconnect and deliberately rebuild the state that is
safe for that use case.

Runnable smoke tests require their protocol-specific terminal event rather than
treating a clean WebSocket EOF as success: completed `response.done` for text,
audio, and MCP; transcription completion for transcription; `session.closed`
for translation; and the requested `OPENAI_REALTIME_STOP_AFTER` checkpoint for
bounded sideband and SIP runs. The deterministic PCM conversation smoke also
requires a completed `response.done`; a cancelled response is a failed bounded
run even though cancellation remains an expected interactive barge-in outcome.
Cleanup must also preserve an active upload or processing error when a graceful
close fails, while surfacing the close failure after an otherwise successful
operation.

Transcription failures use their dedicated
`ConversationItemInputAudioTranscriptionFailedEvent`, not `RealtimeErrorEvent`.
The runnable transcription sample raises the event's error immediately; it does
not wait for a completion that will never arrive or allow a later turn's
completion to masquerade as success.

Terminal status alone is insufficient when a workflow promises an artifact:
the text smoke requires a non-empty text delta, while the raw-audio and
translation smokes require at least one decoded audio byte before their terminal
events. The file-audio smoke disables VAD and waits for the acknowledged session
update before its manual commit. Translation reader failures cancel an in-flight
upload rather than waiting for the input file to drain; an already-buffered
reader failure prevents the uploader from starting at all. Microphone shutdown
is latched before capture starts, so an immediately closed connection cannot
start an orphaned ffmpeg process after cleanup has begun.

The three standard Realtime connection modes use distinct method names rather
than a keyword-discriminated overload: `connect(model:)`, `connect_to_call`, and
`connect_transcription`. This keeps block parameter types precise in both RBS
and RBI; Sorbet does not support overloads that discriminate on keyword
arguments.

Raw WebRTC SDP responses remain lazily consumed. Request observability follows
that body lifecycle: completion is recorded only after the SDP body is fully
drained, and a body read failure records `request failed` without a contradictory
completion event.

- Invalid JSON or a payload that cannot match the selected event union raises
  `OpenAI::Errors::RealtimeProtocolError`, with `data` and `cause`.
- Handshake and socket I/O failures from the default adapter raise
  `OpenAI::Errors::RealtimeConnectionError`, with `url` and `cause`.
- API `error` events remain typed `RealtimeErrorEvent` values in the normal event
  stream so applications can follow the API's recoverability guidance.
- Valid events introduced after the installed SDK version remain observable as
  immutable `UnknownServerEvent` values instead of terminating the session.
- Exceptions raised by the application block propagate unchanged while the
  adapter still attempts both connection and client cleanup. Cleanup does not
  replace an active error; after a successful block, its first cleanup error is
  surfaced.

The request timeout applies only through WebSocket negotiation. It is not left
on the upgraded socket: an established Realtime session may be quiet for longer
than an ordinary HTTP request timeout without being disconnected by the SDK.

Use `request_options` for handshake headers, query parameters, and timeout:

```ruby
client.realtime.connect(
  model: "gpt-realtime-2.1",
  request_options: {
    timeout: 30,
    extra_headers: {"OpenAI-Safety-Identifier" => hashed_user_id},
    extra_query: {trace: "enabled"}
  }
) { |connection| run_session(connection) }
```

`websocket_base_url:` configures a separate gateway for WebSockets. Azure
provider clients derive the WebSocket URL from the configured Azure v1 endpoint
and resolve provider-owned API-key or bearer authentication immediately before
the handshake. Providers without a Realtime WebSocket surface fail before a
credential is sent.

## Custom transport

Pass `transport:` to `connect` to replace the adapter. The object implements:

```ruby
transport.open(url:, headers:, timeout:, **transport_options) do |socket|
  # socket.read                         # String-like message or nil
  # socket.write(json_string)           # synchronous write/backpressure
  # socket.close(code:, reason:)
  # socket.closed?
end
```

`timeout` is `Float?` at the transport boundary because `Client.new(timeout:
nil)` and per-request `timeout: nil` deliberately disable the handshake timeout.
`transport_options` cannot replace the authenticated URL or headers, the
handshake timeout, the destination host or port, or TLS/protocol negotiation.
Those values remain SDK-owned so credentials cannot be redirected or sent over
a caller-supplied downgraded connection.

Advanced mTLS or private-CA WebSocket clients can configure the built-in adapter
without supplying a new transport implementation:

```ruby
websocket_transport = OpenAI::Realtime::Transports::AsyncWebSocket.new do |tls|
  tls.cert = leaf_certificate
  tls.extra_chain_cert = intermediates
  tls.key = private_key
  tls.cert_store = private_ca_store
end

client.realtime.connect(
  model: "gpt-realtime-2.1",
  transport: websocket_transport
) { |connection| run_session(connection) }
```

Every `wss://` connection receives a fresh native
`OpenSSL::SSL::SSLContext`, including default localhost gateways. The optional
block customizes that context for mTLS or private roots. The adapter always
restores peer verification, hostname verification, and HTTP/1.1 ALPN afterward;
it rejects verification callbacks and refuses TLS configuration for a plaintext
`ws://` endpoint. A raw `ssl_context` remains forbidden in
`transport_options`, where it could silently replace those SDK-owned guarantees.

The SDK owns URL construction, authentication, typed JSON encoding/decoding, and
block cleanup. The transport owns the WebSocket handshake, frame I/O, TLS,
proxies, and transport-specific failures. Internal calls use direct methods; the
contract does not require subclassing or reflection.

## Example and developer-site coverage

Repository examples live under `examples/realtime/`; their
[runbook](examples/realtime/README.md) includes prerequisites, commands, bounded
smoke-test controls, and observable pass criteria. They cover a hands-free
full-duplex voice conversation, text, image input, local function calling, raw
PCM audio, streaming transcription, WebRTC SDP exchange, sideband, SIP, MCP
approvals, and translation. The
developer website should expose the same progression so users encounter the
simplest successful path before protocol details:

| Guide surface | Ruby sample required |
| --- | --- |
| Realtime overview | Minimal text WebSocket with typed deltas and block cleanup |
| WebSocket | Text, PCM16 input/output, manual `receive`, Enumerable iteration, error handling |
| Image input | PNG/JPEG data URI plus text instruction and a completed response |
| Transcription | `connect_transcription`, PCM16 streaming, delta/completed events, and `item_id` correlation |
| WebRTC | Complete browser peer plus Ruby endpoint; Rails and Sinatra variants using `calls.create` |
| Server controls | Preserve `call.call_id`, open sideband, update session, hang up |
| SIP | Verify webhook, accept/reject, sideband, refer, hang up, idempotent webhook handling |
| Conversations | Text item, audio commit, cancel/interruption, truncate played audio |
| Function calling | Detect final arguments, execute locally, send typed output, request final answer |
| Remote MCP | Configure server, inspect approval request, approve/reject, observe completion |
| Translation | Client secret, server WebSocket PCM loop, graceful close; add WebRTC after its call endpoint is public |
| Authentication | Standard key on server, ephemeral browser secret, safety identifier |
| Azure | Deployment/model targeting and provider-owned handshake authentication |
| Operations | Timeout, backpressure, logging event IDs, abnormal close, deliberate reconnect policy |

The WebRTC browser half remains JavaScript because Ruby runs on the trusted
server; Ruby snippets should own secrets, session configuration, SDP proxying,
webhook verification, tools, and business logic.

The local voice example is also exercised against the installed FFmpeg tools,
not only Ruby fakes. In particular, raw PCM playback declares mono input with
ffplay's `-ch_layout mono`; `-ac 1` is an ffmpeg transcoding option and current
ffplay releases reject it. Playback also disables ffplay's terminal statistics:
without `-nostats`, ffplay emits an ANSI clear-line sequence that can erase the
first transcript delta from the terminal. Playback-command compatibility and a
headless PCM process smoke test guard both boundaries.

WebSocket barge-in requires client playback state in addition to server VAD.
On `input_audio_buffer.speech_started`, the voice example stops ffplay, records
the elapsed audio offset, sends `conversation.item.truncate`, and ignores queued
audio and transcript deltas for the cancelled response. A cancelled
`response.done` is an expected interruption outcome in the interactive loop
rather than an exception; deterministic PCM smoke mode requires completion.

The FFmpeg WebSocket loop cannot provide acoustic echo cancellation and must
not be positioned as the default laptop conversation sample. With speakers,
model output can re-enter the microphone and repeatedly trigger VAD, producing
one-word responses. The primary interactive voice example uses browser WebRTC;
the Ruby WebSocket loop remains useful for headless server audio, telephony
bridges, deterministic PCM tests, and protocol debugging.
