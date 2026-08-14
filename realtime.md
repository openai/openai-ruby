# Realtime API

The Ruby SDK supports the server-side parts of the Realtime API:

- typed WebSocket sessions for text, images, audio, transcription, function calls, and remote MCP;
- WebRTC SDP negotiation from a trusted Ruby backend;
- sideband WebSocket control for active WebRTC and SIP calls;
- SIP accept, reject, refer, and hangup controls; and
- dedicated WebSocket, client-secret, and WebRTC translation endpoints.

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
before sending and requires non-empty model text plus a completed response.

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
standard API key to browser code.

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
call-lifecycle controls.

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
that is still draining. For browser WebRTC translation, mint an ephemeral secret
with `translations.client_secrets.create`, then post the browser offer with
`translations.calls.create`. That convenience method delegates to the shared
`/v1/realtime/calls` endpoint; translation is selected by the ephemeral secret,
not by a separate calls route.

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
`ResponseDoneEvent` as success; clean EOF during discovery, approval, or tool
execution is still an incomplete workflow, and a response that completes before
the required MCP call is a failure. The approval helper generates item IDs
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

Castiron remains responsible for Realtime HTTP resources, request/response
models, event models, discriminated event unions, RBI, and RBS. The live
connection, resource conveniences, transport adapter, and examples are
handwritten because a bidirectional socket lifecycle is not an OpenAPI request.
No generator feature is required for that boundary.

The handwritten decoder reads the generated event unions at runtime, so newly
generated event variants become typed automatically. A valid event unknown to
an older gem remains an `UnknownServerEvent`. Regeneration review must still
check capability-specific connection types and helper signatures when the
generated client-event shapes change. `calls.create` remains a focused custom
HTTP implementation because the unified WebRTC endpoint returns raw SDP and can
accept either raw `application/sdp` or multipart SDP plus session JSON; ordinary
JSON resource generation does not model that response cleanly.

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
bounded sideband, SIP, and conversation runs. Cleanup must also preserve an
active upload or processing error when a graceful close fails, while surfacing
the close failure after an otherwise successful operation.

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
- Exceptions raised by the application block propagate unchanged; cleanup does
  not replace them with a close error.

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
| Translation | Client secret, browser WebRTC call, server WebSocket PCM loop, graceful close |
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
`response.done` is an expected interruption outcome rather than an exception.

The FFmpeg WebSocket loop cannot provide acoustic echo cancellation and must
not be positioned as the default laptop conversation sample. With speakers,
model output can re-enter the microphone and repeatedly trigger VAD, producing
one-word responses. The primary interactive voice example uses browser WebRTC;
the Ruby WebSocket loop remains useful for headless server audio, telephony
bridges, deterministic PCM tests, and protocol debugging.
