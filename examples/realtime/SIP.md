# Signed SIP webhook worker

[`sip_webhook.rb`](sip_webhook.rb) composes the shipped webhook verifier, typed
incoming event, Realtime accept/reject, sideband, and hangup APIs. It runs as a
stdin worker, with one JSON envelope per line and one metadata-only result per
line. It has no HTTP server or new runtime dependency. The optional
`async-websocket` transport used by the other Realtime examples is required to
attach to a real call.

## Trust boundary and setup

Use **one dedicated OpenAI project per application tenant** for this sample.
Configure its API credential, project ID, and webhook signing secret together.
A valid OpenAI signature authenticates an event from that configured webhook;
it does not authenticate the human caller or establish a tenant from SIP headers.
`From`, `To`, `X-Tenant`, and all other SIP metadata remain untrusted, even inside
a signed event. Do not use this sample unchanged to partition multiple tenants
sharing a project/webhook secret.

A trusted application gateway forwards envelopes to this worker over a private
pipe. The gateway authenticates with a separate random `SIP_APPLICATION_TOKEN`;
that credential grants access only to the configured `SIP_TENANT`. It must not
be sent to OpenAI or to callers. The tenant comparison and constant-time token
check run before signature verification or call controls. Neither an envelope
call ID nor SIP metadata can select an API key, project, tenant, or call ID.
The only actionable call ID comes from a successfully verified, typed
`realtime.call.incoming` event. Shape validation is additional defense; it is not
authorization.

Provide these variables through your secret manager or private environment:

| Variable | Meaning |
| --- | --- |
| `OPENAI_API_KEY` | Credential for the tenant's dedicated project |
| `OPENAI_PROJECT_ID` | That project's ID |
| `OPENAI_WEBHOOK_SECRET` | Signing secret for that project's configured webhook |
| `SIP_TENANT` | Fixed application tenant identifier |
| `SIP_APPLICATION_TOKEN` | Separate random gateway credential |
| `SIP_ACCEPT_CALLS` | `true` accepts; default `false` rejects with SIP 486 |
| `OPENAI_REALTIME_MODEL` | Defaults to `gpt-realtime-2.1`; must be available to this project |
| `SIP_CALL_SECONDS` | Positive finite sideband deadline, default 60 seconds |

Start from the repository root:

```sh
bundle exec ruby examples/realtime/sip_webhook.rb
```

Each line has this shape (placeholders below are not valid credentials or signatures):

```json
{"tenant":"example-tenant","application_token":"gateway-secret-placeholder","body":"original raw webhook body","headers":{"webhook-id":"delivery-id","webhook-timestamp":"timestamp","webhook-signature":"signature"}}
```

Preserve the HTTP request body's exact bytes as the JSON string `body`; never
parse and reserialize the webhook body before verification. Preserve the three
signature headers. Do not put the gateway token in command-line arguments or
log envelopes. For a fresh real delivery stored in private files, the following
adapter demonstrates framing without changing the body:

```sh
ruby -rjson -e 'puts JSON.generate(tenant: ENV.fetch("SIP_TENANT"), application_token: ENV.fetch("SIP_APPLICATION_TOKEN"), body: File.binread(ARGV[0]), headers: JSON.parse(File.read(ARGV[1])))' private-body.json private-headers.json |
  bundle exec ruby examples/realtime/sip_webhook.rb
```

This one-shot invocation loses its deduplication state on exit. For repeated
deliveries, keep one worker process alive and feed its stdin. Verification uses
the SDK's five-minute timestamp tolerance; an old capture will be rejected.
The sample does not configure a carrier, webhook endpoint, or live call.

## Ownership and outcomes

The configured admission policy applies only after application authorization,
signature verification, typed dispatch, and an atomic claim by event ID and call
ID. The worker sets a fixed assistant policy with no tools at accept time. The
caller can speak after acceptance; the service handles SIP audio. Ruby observes
typed sideband events and never implements media or WebRTC.

| Phase/result | Ownership and behavior |
| --- | --- |
| `claimed` | This process reserved the incoming event/call; no remote ownership yet. |
| `rejected` | One reject request succeeded; no accept, attach, or hangup. |
| `reject_unknown` | Rejection failed; suppress duplicate actions and reconcile. |
| `accept_unknown` | Accept has not returned success (including timeout, disconnect, or HTTP failure). No retry or hangup; reconcile with the service/operator. |
| `other_owner` | Definitive accept 409: another handler owns the call. Never attach or hang up. |
| `owned` | Accept returned success. This worker is responsible for termination, including failed sideband setup. |
| `hangup_confirmed` | The bounded hangup request succeeded. |
| `cleanup_unconfirmed` | Hangup failed or timed out. Keep the claim and reconcile; do not replay accept. |

Accept, reject, and hangup use zero automatic retries and five-second request
timeouts. Automatic accept retries could turn a lost success into a misleading
409. Ambiguous accept is deliberately quarantined: the sample cannot determine
whether this worker or a competing Realtime/Live handler won. Hanging up in that
state could terminate another owner's call. This policy can leave a call running
and requires operational reconciliation; it is not an orphan-cleanup guarantee.

After successful accept, sideband EOF, API error, cancellation, or the sideband
deadline enters an `ensure` that attempts hangup within five seconds. Cleanup
defers Async cancellation where supported. The original application/transport
exception survives failed socket or hangup cleanup; after a normal sideband
exit a hangup failure is surfaced. A peer can end the call just before hangup:
even a 404/409 leaves cleanup unconfirmed rather than inventing an undocumented
“already ended” contract. Successful EOF handling returns `sideband_closed`,
which means the observer closed and hangup succeeded, not proof of audio quality.

`response.done` and `output_audio_buffer.stopped` end a response/playback turn,
not a SIP call. They cannot cause early hangup or hide a later API error. Current
ordinary Realtime webhook models do not publish a call-ended event. Unknown
webhook events are ignored, including hypothetical terminal names; a production
provider's terminal notifications need their own authenticated contract.

The CLI returns only `status`: `ignored`, `duplicate`, `rejected`, `other_owner`,
`sideband_closed`, or `failed`. Embedded `handle` calls preserve exceptions;
`state(call_id)` inspects local progress without issuing any remote action.
The CLI intentionally omits exception messages, identifiers, headers, prompts,
SIP metadata, and response bodies. A `failed` line needs operator attention;
`duplicate` does **not** imply that an earlier attempt succeeded.

## Persistence and deployment limits

The mutex and hashes are a demonstration of **process-local at-most-one
attempt**, not durable production idempotency. They retain event/call claims
through success, rejection, ambiguity, and cleanup failure without eviction.
Memory grows with unique deliveries. Restarting, running multiple worker
instances, or losing the process destroys/bypasses these claims. Abrupt process
termination can interrupt accept or cleanup. Do not automatically restart and
replay this sample as an unattended production worker.

A production integration needs a durable inbox and queue, atomic tenant-scoped
event/call claims, retained outcomes, crash recovery, and an owner-approved
reconciliation policy for uncertain accept/cleanup outcomes. Retention must
cover webhook retries and the active-call lifetime. Do not assume the REST
endpoint accepts an idempotency key or provides an ownership lookup that is not
published. The synchronous demo can keep a call open for its full deadline;
it is not a webhook HTTP handler. A real gateway must verify at ingress, durably
record/enqueue before acknowledging promptly, and apply application rate limits.
Delayed workers need authenticated queue provenance rather than disabling
signature timestamp checks on old webhook captures.

Only run a live test with a trusted project, configured webhook gateway, and SIP
provider/caller, with a spending limit and an operator who can reconcile calls.
The repository's general example E2E suite excludes this worker. Its dedicated
tests use fake signatures, HTTP responses, and sockets and make no live calls.

## Realtime versus Live; optional controls

As checked against the current generated source and
[webhook reference](https://developers.openai.com/api/reference/resources/webhooks)
on September 15, 2026, the same pending SIP session can emit
`realtime.call.incoming` and `live.transport.incoming`. The first successful
accept selects the runtime. `live.call.incoming` is deprecated. Realtime accepts
an event-provided `rtc_...` call ID via `client.realtime.calls.accept` with
`type: :realtime`. [Live accepts](https://developers.openai.com/api/reference/resources/live/subresources/sessions/methods/accept)
the event-provided `live_...` session ID via `client.live.sessions.accept`, with a
nested `session: {type: :live, ...}`. Use each returned ID unchanged with its own
API. This worker ignores both Live event variants; do not convert prefixes or
use Realtime sideband to control a Live session.

For a later, separately authorized transfer feature, the existing primitive is
`client.realtime.calls.refer(owned_call_id, target_uri: trusted_destination)`.
Authorize a fixed/allowlisted destination in application policy, never directly
from SIP headers or model arguments, and define ownership after transfer before
adding it to the lifecycle. This sample has no transfer or DTMF automation.

Run deterministic checks from the repository root:

```sh
bundle exec ruby test/openai/realtime/sip_webhook_example_test.rb
bundle exec rake test:examples:inventory
```
