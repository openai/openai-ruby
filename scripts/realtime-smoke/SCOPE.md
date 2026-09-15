# Protected Realtime verification scope

Original outcome: opt-in live verification of shipped committed transcription,
voice, and a native-browser WebRTC call through create, negotiation, sideband,
and explicit hangup.

Acceptance: credentials only in a protected, manually selected job; no retries
or reconnect; fixed synthetic input and token/session/attempt bounds; finite
execution and cleanup deadlines; cleanup of every known owned call on failure;
metadata-only diagnostics; unavailable and skipped runs cannot pass as live
evidence. Deterministic offline tests are separate from live API results.

Affected paths: scripts/realtime-smoke/, focused test/scripts/ tests, a manual
workflow reusing the existing Live Smoke protections, opt-in inventory, and
contributor documentation. Browser verification depends on the sibling browser
reference workflow; this task must not copy or build that application.

Non-goals: runtime/API changes, generated resources/models, Ruby WebRTC/media/SDP,
SIP, translation, Live API, device access, broad example changes, budget changes,
paid runs without explicit bounded authorization, or unrelated cleanup.

Base: 5bdc477abc7e9e040debca40dd14e530b1c80ff1. Verified HEAD equality and 0/0
before edits in /Users/jbeckwith/.codex/worktrees/4a50/openai-ruby.
