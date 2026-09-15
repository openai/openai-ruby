# Native browser peers with a Ruby signaling application

Two **ordinary Realtime API** examples share a small, single-operator local app:

1. `/direct`: Ruby issues a short-lived client secret. The browser sends its
   native SDP directly to OpenAI and owns the peer lifetime.
2. `/backend`: Ruby forwards the browser's opaque SDP to the shipped
   `client.realtime.calls.create`. Ruby retains the known call, returns the
   answer, optionally confirms trusted sideband policy, and explicitly hangs up.

These do not use the distinct [Live API example](../../live/webrtc.rb).
`RTCPeerConnection`, `getUserMedia`, browser data channels and browser audio own
all negotiation, ICE, DTLS, RTP, codecs, echo cancellation and device permissions.
Ruby implements only application authentication, signaling and call ownership.

## Run

Use Ruby 3.3+, the repository's installed dependencies (`./scripts/bootstrap`),
and a separately installed WEBrick. WEBrick is an example server, not a gem
runtime dependency. No JavaScript package installation or build is needed.

```sh
gem install webrick -v '~> 1.9'
# Supply OPENAI_API_KEY through your environment/secret manager.
export BROWSER_APP_TOKEN="$(ruby -rsecurerandom -e 'puts SecureRandom.hex(32)')"
ruby examples/realtime/browser/server.rb
```

Open `http://127.0.0.1:9292/direct` or `http://127.0.0.1:9292/backend` in a browser
with microphone and native WebRTC support. Paste **BROWSER_APP_TOKEN**, not the
OpenAI key, into the password field. Start, allow the microphone, wait for
`Connected`, and speak. Stop releases microphone tracks, remote tracks, the data
channel, peer and audio element. Stop works even during a permission prompt;
if permission later resolves, those new tracks are immediately stopped.
Start stays disabled through backend cleanup acknowledgment and a subsequent
five-second creation cooldown. If cleanup fails, Start remains disabled; reload
only after confirming that the backend released the call. This example does not
poll for readiness or automatically retry startup.

The app uses the standard OpenAI endpoint and requires project access to
`gpt-realtime-2.1` (or `OPENAI_REALTIME_MODEL`). Real requests incur API usage.
`PORT` defaults to 9292. Use the exact numeric loopback URL, not `localhost`.
Browsers allow microphone capture on loopback; remote deployment requires HTTPS.
Autoplay may require using the audio controls. Permission and local offer
preparation have a 30-second deadline. Signaling and peer establishment then have
a separate 60-second deadline: up to 15 seconds for creation, 15 for optional
sideband setup, 20 for the server handoff lease, plus delivery time. The server
lease still expires 20 seconds after answer preparation if no acknowledgment
arrives; the longer browser deadline does not extend it.

For the backend's optional existing Ruby sideband example, install
`async-websocket` and launch with `BROWSER_SIDEBAND=1`. Before handing back the
answer, it waits (up to 15 seconds) for a typed `session.updated` acknowledging
its policy. It closes the control socket after the acknowledgement; closing a
sideband alone does not hang up a call. Tools are empty here. Real tool execution
must independently authorize every operation against the authenticated user.

## Authentication and authorization boundary

This is a loopback-only, single-operator example, not a multi-user hosted service.
The random application bearer token grants this operator permission to spend
this project's Realtime quota and control this app's single backend call.
Static assets are public on loopback. Every API operation requires the token
and an exact Origin; every request requires the exact Host. Cross-origin
preflights are rejected. There are no ambient authentication cookies: the
explicit bearer header plus Origin check provides the CSRF boundary. Responses
use `no-store`, a restrictive CSP, no-referrer and same-origin resource policy.
The application token stays in page memory; no credentials enter URLs or web
storage. The standard API key stays on Ruby's backend.

The app limits creation/issuance to one request per five seconds and one known
backend call at a time. It supplies a trusted `OpenAI-Safety-Identifier` derived
from the operator token. For a deployed application, replace this local auth
with your existing login and user entitlements, use a stable pseudonymous user
identifier, add per-user quotas, HTTPS and shared durable call ownership. Never
accept a browser-supplied OpenAI call ID as proof of ownership.

The direct secret expires after 30 seconds, **not** the resulting session.
Secrets can establish multiple sessions before expiration and clients can
change session configuration. They are delegated capabilities, not immutable
policy or single-use grants. A failed token response allocates no backend call;
the unused secret expires. Ruby cannot revoke that secret through an invented
endpoint. Closing a browser peer is best effort remote termination; if a direct
SDP request is accepted but its response is lost, Ruby has no known call to
reconcile. Choose backend ownership when explicit server hangup is needed.

## Backend ownership and failure handling

The shipped SDK owns a known allocation during creation-response buffering and
already cleans up failed delivery to Ruby. This app does not replace that code.
Once `calls.create` returns, the app validates Location against the fixed OpenAI
origin and call path, records the call immediately, and then consumes the answer.
It never returns the call ID to the browser.

The browser supplies a random **application operation ID** before allocation;
Stop can therefore request cleanup even if the answer response is lost. Stopped
operation IDs are retained in memory until process exit, so a Stop that overtakes
its create prevents that later allocation. This single-operator example is
intended for bounded local runs; a deployed service needs durable operation
records and a retention policy tied to a defined request-expiry contract. The
app remains the owner after successful HTTP delivery. It requires `/api/ack`
after native remote-description application, peer connection and channel open.
A 20-second handoff lease is refreshed after answer preparation and optional
sideband setup, before delivery, and expires without that acknowledgement. An acknowledged
call has a 60-second lease, renewed by the browser every ten seconds. A paused
background tab can lose its lease and must Start again. Expired leases cannot
be revived. Page exit sends best effort Stop; the timer covers lost requests.

Answer-write failures, sideband failures and explicit Stop immediately attempt
hangup. Each cleanup attempt has a five-second deadline and no SDK retry. A
failed attempt retains ownership, blocks new allocations, and is retried by the
application timer after five seconds. Never retry uncertain creation requests.
INT/TERM drains HTTP work and attempts one final bounded cleanup.

This small in-memory example cannot recover registry state after SIGKILL or a
machine crash. A missing/invalid Location causes a sanitized 502 and **cannot be
reclaimed without an identifiable allocation**. Neither case is claimed as
reliable cleanup; a production deployment needs a platform-approved durable
reconciliation/TTL contract. HTTP success does not prove browser handoff, and
best effort hangup does not guarantee remote termination during an outage.

## Stable launch and verification contract

A protected live harness can launch this exact server with the environment above,
plus `BROWSER_SIDEBAND=1 BROWSER_MANUAL_TURNS=1`. Manual-turn mode configures
`audio.input.turn_detection: null` **before** media attaches; the harness must
explicitly commit audio/create a response on the native data channel. All modes
start with `max_output_tokens: 128`. Do not log credentials, SDP, audio or events.

The UI has `#token`, `#start`, `#stop`, `#status` and an `audio` element. For more
precise harness control, import `/peer.js` and construct
`new BrowserPeer({mode: 'backend', audio, status})`. `await peer.start(token)`
finishes startup; success requires status `Connected` (failure is handled and
reported through status). Failed startup waits for its bounded backend cleanup
attempt. Autoplay denial leaves `Connected` intact; playback help appears beside
the audio controls. `peer.current.pc` and `.dc` are the native browser
objects. Attach event observers without replacing its lifecycle handlers.
`await peer.stop()` returns `true` only after the backend acknowledges cleanup,
`false` on failed cleanup; a missing run/direct peer has no server acknowledgement.
Local media stops immediately. The cleanup request can wait up to 40 seconds for
serialized creation and sideband setup (up to 30 seconds), hangup (five seconds),
and delivery. Failed startup can wait this additional cleanup interval before
settling. Expired requests remain best effort; server leases and retries still
cover unsuccessful delivery.
The cleanup result does not include the subsequent five-second restart cooldown;
wait until `peer.stopping` is false before starting another run. Failed cleanup
keeps that flag set until reload and displays the recovery guidance above.
Server diagnostics include only fixed lifecycle metadata, including
`[browser] call released` and the existing sideband success marker. The harness
must require successful cleanup and stop the server after its bounded run.

Offline tests (Node 22.7+ for the browser-controller tests):

```sh
bundle exec ruby test/openai/realtime/browser/server_test.rb
node --test test/openai/realtime/browser/peer_test.mjs
```

The required Ruby CI test job also runs the controller suite. The controller
tests simulate browser boundaries; they are not evidence of a
real ICE/media exchange. Ruby tests exercise real SDK serialization with fake
HTTP responses. Live API/audio evidence must be reported separately by the
protected harness; do not equate a rendered page or fake SDP test with a paid
end-to-end call.
