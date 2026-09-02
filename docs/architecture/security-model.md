# OpenAI Ruby SDK Security Model

This is the canonical detailed threat model for this repository. `SECURITY.md`
remains the authority for disclosure and reportability; this document is the
authority for architecture, trust boundaries, security invariants, attack
surface, and severity calibration. Codex Security scans must load this file
from the scanned revision instead of relying on a duplicated cloud-configured
model.

## 1. Overview

The OpenAI Ruby gem is a caller-embedded Ruby 3.3+ library, not a hosted
service. It converts caller-supplied configuration, parameters, files, and
credentials into authenticated REST, SSE, and optional Realtime WebSocket
requests, then parses remote responses into typed Ruby values
([README.md](../../README.md#L1-L3),
[README.md](../../README.md#L38-L59)).

| Component | Role | Evidence |
| --- | --- | --- |
| `OpenAI::Client` and generated resources | Public REST entry points, credentials, retries, request options | `lib/openai/client.rb:5-41`, `lib/openai/client.rb:129-170` |
| Base transport and HTTP client | URL construction, redirects, retries, serialization, response decoding | `lib/openai/internal/transport/base_client.rb:13-27`, `lib/openai/http_client.rb:138-237` |
| Streaming and Realtime helpers | Construct authenticated WebSocket handshakes, enforce transport policy, and parse SSE/WebSocket JSON into typed events | `lib/openai/internal/stream.rb:19-60`, `lib/openai/helpers/realtime/client_extension.rb:167-280`, `lib/openai/helpers/realtime/transports/async_websocket.rb:185-308`, `lib/openai/helpers/realtime/connection.rb:47-100` |
| Webhook helper | Verify timestamp and HMAC before parsing webhook events | `lib/openai/resources/webhooks.rb:15-119` |
| Providers and workload identity | Azure, Bedrock, subject-token, and X.509 credential paths | `lib/openai/providers/azure.rb:40-58`, `lib/openai/auth/workload_identity_auth.rb:280-330` |
| CI and release workflows | Run repository code, publish trusted Castiron results, live checks, and releases | `.github/workflows/ci.yml:18-32`, `.github/workflows/castiron-custom-code-comment.yml:4-38`, `.github/workflows/create-releases.yml:14-79` |

```mermaid
flowchart LR
  Caller[Embedding application] --> SDK[OpenAI Ruby SDK]
  SDK --> API[Configured API or provider origin]
  API --> Parser[JSON / SSE / WebSocket parsers]
  Parser --> Caller
  Webhook[Webhook sender] --> Verify[HMAC + timestamp verifier]
  Verify --> Caller
  PR[Candidate checkout] --> CI[Ordinary read-only CI]
  PR --> Castiron[Candidate Castiron workflow]
  Castiron --> Trusted[Main-sourced workflow_run publisher]
  Trusted --> GitHub[Statuses and PR comments]
  Main[Main revision] --> Live[Live / release workflows]
  Live --> Secrets[Referenced credentials and publishing authority]
```

| Deployment or workflow | Resource or capability | Configuration and precedence | Safe effective value or location | Readers, writers, or recipients | Enforcing control | Evidence or unknowns |
| --- | --- | --- | --- | --- | --- | --- |
| Default SDK | API/admin bearer credential | Explicit option, then environment fallback; explicit/data-residency base URL, then default | Bearer credential to configured origin; default `https://api.openai.com/v1` | Configured API origin | Configured-origin request construction; cross-origin redirects strip credentials and reject bodies; HTTPS downgrade rejected | `lib/openai/client.rb:669-693`, `lib/openai/internal/transport/base_client.rb:418-452`, `lib/openai/internal/transport/base_client.rb:153-215` |
| Webhook handler | Webhook secret | Explicit argument, then client option, then `OPENAI_WEBHOOK_SECRET` | In-process HMAC key | Local verifier only | Required headers, freshness window, HMAC, timing-safe comparison before `unwrap` parses JSON | `lib/openai/resources/webhooks.rb:15-119` |
| Workload identity | Subject token and exchanged access token | Provider token plus identity/service-account IDs; default issuer URL | Subject token sent to `https://auth.openai.com/oauth/token`; returned token cached in memory | Subject-token provider, issuer, configured API origin | Token-type mapping, timeout/deadline handling, coordinated refresh | `lib/openai/auth/workload_identity_auth.rb:13-15`, `lib/openai/auth/workload_identity_auth.rb:280-330` |
| X.509 workload identity | Attested mTLS transport and detached exchanged bearer token | Client uses the identity-configured transport when present, otherwise a caller-supplied attested `http_client` for a detached identity, and selects `X509TokenExchange` before token acquisition | Exchange POST to `https://mtls.auth.openai.com/oauth/token`; API requests use the selected transport's attested global/US/EU mTLS API origin | OpenAI mTLS issuer and matching attested API origin | Exact issuer endpoint and attested API-origin/header checks, TLS peer/hostname verification, proxy policy, no redirects | `lib/openai/client.rb:616-644`, `lib/openai/client.rb:739-756`, `test/openai/auth/x509_client_test.rb:16-34`, `lib/openai/auth/x509_transport.rb:5-10`, `lib/openai/auth/x509_transport.rb:14-26`, `lib/openai/auth/x509_transport.rb:174-237`, `lib/openai/auth/x509_transport.rb:243-315` |
| Azure provider | API key or Entra bearer token | Explicit endpoint/credential, then Azure environment fallback | Credential attached only to normalized Azure origin | Configured Azure endpoint | Origin validation before credential attachment; conflicting auth rejected | `lib/openai/providers/azure.rb:47-58`, `lib/openai/providers/azure.rb:141-147` |
| Bedrock provider | Bearer token or SigV4 authority | Explicit mode, environment, then AWS credential chain | Credential/signature to configured Bedrock origin | Configured Bedrock endpoint | Origin and endpoint/region validation; SigV4 disables redirects | `lib/openai/providers/bedrock.rb:105-168`, `lib/openai/providers/bedrock.rb:398-427` |
| Realtime WebSocket transport | API/workload bearer credential, WebSocket destination, TLS/proxy policy, and trace confidentiality | Client handshake builder applies bearer auth and optional workload-token refresh; caller may select `websocket_base_url` only within provider restrictions | Authenticated `ws://` or `wss://` handshake to configured Realtime origin; proxy credentials stay on CONNECT | Configured Realtime endpoint and optional proxy | Base URL validation, provider/X.509 restrictions, proxy-authorization stripping, WSS peer/hostname verification, trace redaction | `lib/openai/helpers/realtime/client_extension.rb:167-280`, `lib/openai/helpers/realtime/transports/async_websocket.rb:185-224`, `lib/openai/helpers/realtime/transports/async_websocket.rb:294-378` |
| Diagnostic logging | Request/response diagnostics | Explicit log level, then `OPENAI_LOG`; supplied logger or stderr | Sanitized metadata and structural body summaries | Caller logger or stderr | Credential/query redaction; multipart, streaming, binary, and large JSON bodies omitted | `lib/openai/internal/logging.rb:10-26`, `lib/openai/internal/logging.rb:299-343` |
| Dependency acquisition and installation | Gem source, locked revision, transitive gem, native extension, and install/build-script execution | Contributor/CI `Gemfile` selects `syntax_tree-rbs` from GitHub branch `main` and `Gemfile.lock` pins revision `247832988a850b8df050cf207f652872fda49973`; docs lockfiles and gemspec dependencies select other installed code | Locked RubyGems and Git sources plus package metadata from the reviewed revision | CI runners and consumer Bundler/RubyGems installations | Human/source review of dependency and lockfile changes; CI verifies the reviewed checkout but does not make an unreviewed dependency trustworthy | `AGENTS.md:39-42`, `Gemfile:3-15`, `Gemfile.lock:1-20`, `openai.gemspec:18-48`, `docs/Gemfile:1-8`, `docs/Gemfile.lock:1-21` |
| Ordinary PR CI | Candidate checkout execution | Checked-out PR revision runs lint, typecheck, build, and tests | Candidate code executes with repository-code authority | Ephemeral CI runner | `permissions: {}`, `contents: read`, `persist-credentials: false` | `.github/workflows/ci.yml:18-32`, `.github/workflows/ci-checks.yml:100-120` |
| Trusted Castiron workflow-run publisher | Commit-status and PR-comment writes | Candidate-associated `workflow_run` metadata -> main-sourced reporter recomputes from current Git objects for statuses and successful report comments; fallback failure comments use event/path, current-head, and monotonic-replacement checks | `statuses: write` and `pull-requests: write` only in publisher jobs | GitHub commit statuses and PR comments | Status path: no candidate artifact, run identity validation, exact head/base checks; successful comment path: trusted report artifact; fallback failure-comment path: main-sourced code, event/path filtering, current-head matching, monotonic replacement | `.github/workflows/castiron-custom-code-comment.yml:4-38`, `.github/workflows/castiron-custom-code-comment.yml:40-98`, `.github/workflows/castiron-custom-code-comment.yml:116-171`, `.github/workflows/castiron-custom-code-comment.yml:174-237` |
| Live/release workflows | API keys, X.509 material, GitHub App token, RubyGems OIDC | Main-only conditions plus named environments | Referenced secrets and short-lived publishing authority | Main revision, OpenAI API, GitHub, RubyGems | Repository/ref conditions, separate named environments, least privilege, OIDC only for publishing | `.github/workflows/live-smoke.yml:17-92`, `.github/workflows/create-releases.yml:17-79` |

## 2. Threat Model, Trust Boundaries, and Assumptions

Protected assets include caller API/admin/provider credentials, workload subject
tokens and exchanged access tokens, webhook secrets, X.509 private-key
material, uploaded file contents, request destinations and headers, parsed
response integrity, diagnostic confidentiality, and release/publishing
integrity.

Important boundaries:

- Caller-controlled parameters, headers, files, base URLs, callbacks, loggers,
  and custom transports cross into SDK request construction. These remain
  caller authority inside the embedding process; the SDK is not a sandbox
  (`lib/openai/http_client.rb:138-142`,
  `lib/openai/internal/transport/base_client.rb:293-339`).
- Configured origin to redirect destination is a network boundary. Credential
  headers must not reach a different origin, request bodies must not cross
  origins, and HTTPS must not downgrade to HTTP
  (`lib/openai/internal/transport/base_client.rb:153-215`).
- API, SSE, and WebSocket bytes cross parser/type-conversion boundaries. They
  are parsed as data, not evaluated as code
  (`lib/openai/internal/stream.rb:21-60`,
  `lib/openai/helpers/realtime/connection.rb:61-84`).
- Raw webhook payloads and headers cross an authenticity boundary. `unwrap`
  verifies freshness and HMAC before parsing or coercion
  (`lib/openai/resources/webhooks.rb:15-23`,
  `lib/openai/resources/webhooks.rb:75-119`).
- Subject-token sources, the generic token issuer, and Azure/Bedrock endpoints
  are credential-brokering boundaries. Credentials must remain bound to their
  intended issuer and destination
  (`lib/openai/auth/workload_identity_auth.rb:280-330`,
  `lib/openai/providers/azure.rb:141-147`,
  `lib/openai/providers/bedrock.rb:398-427`).
- X.509 workload identity is a separate credential boundary: the exchange uses
  the fixed mTLS issuer while API requests use the selected transport's attested
  matching mTLS origin. The certificate identity and exchanged bearer token
  remain detached; controls enforce the exact issuer endpoint and approved API
  origin/header/TLS/proxy/no-redirect policy
  (`lib/openai/client.rb:616-644`,
  `lib/openai/client.rb:739-756`,
  `test/openai/auth/x509_client_test.rb:16-34`,
  `lib/openai/auth/x509_transport.rb:5-10`,
  `lib/openai/auth/x509_transport.rb:174-315`).
- Authenticated Realtime handshakes are a transport boundary distinct from
  event parsing. Bearer credentials, caller-selected WebSocket destinations,
  TLS, proxy credentials, and traces must remain bound to their intended
  origin and diagnostic audience
  (`lib/openai/helpers/realtime/client_extension.rb:167-280`,
  `lib/openai/helpers/realtime/transports/async_websocket.rb:185-224`,
  `lib/openai/helpers/realtime/transports/async_websocket.rb:294-378`).
- Runtime/API data crossing into logs, exceptions, objects, or CI artifacts is
  a sensitive sink boundary
  (`lib/openai/internal/logging.rb:299-343`,
  `CONTRIBUTING.md:42-50`).
- Candidate PR code reaching protected CI/release credentials or repository
  write/publishing authority is a genuine boundary
  (`.github/workflows/live-smoke.yml:17-92`,
  `.github/workflows/create-releases.yml:17-79`).
- Candidate-associated `workflow_run` metadata and Git objects crossing into
  the trusted Castiron publisher are a genuine write-capable boundary. The
  status path must preserve run-identity and exact-head/base checks; successful
  report comments must remain bound to the trusted report artifact. The
  fallback failure-comment path has narrower main-sourced event/path,
  current-head, and monotonic-replacement checks that scans must assess
  independently
  (`.github/workflows/castiron-custom-code-comment.yml:34-98`,
  `.github/workflows/castiron-custom-code-comment.yml:116-171`,
  `.github/workflows/castiron-custom-code-comment.yml:174-237`).
- Dependency declarations and locks cross a supply-chain boundary when Bundler
  or RubyGems fetches and executes selected package code in CI or consumer
  applications. A changed source, Git revision, transitive gem, native
  extension, or install/build script needs explicit dependency review. The root
  contributor/CI bundle currently selects `syntax_tree-rbs` from GitHub branch
  `main` and locks revision `247832988a850b8df050cf207f652872fda49973`
  (`AGENTS.md:39-42`, `Gemfile:3-15`, `Gemfile.lock:1-20`,
  `openai.gemspec:18-48`,
  `docs/Gemfile:1-8`, `docs/Gemfile.lock:1-21`).

Checked-in executable source has repository-code authority. Reviewed tracked
examples, tests, fixtures, Rake tasks, build scripts, generators, and other
checkout files are intentionally executable by local development and ordinary
PR CI. A contributor who can modify those tracked files does not gain a new
privilege merely because CI executes them. Do not report that execution alone
as a security finding.

That rule does not suppress a real finding when independently mutable
lower-trust input crosses a parser/evaluator boundary, untrusted runtime/API/
network data reaches a sensitive sink, candidate code can reach protected
secrets or write/publishing authority, or shipped production code violates a
security invariant.

Assumptions:

- The embedding application owns its local filesystem, network, process,
  callback, proxy, and credential authority.
- Custom transports, token providers, and loggers are caller-owned extension
  points, not less-trusted sandboxed plugins.
- Azure and Bedrock custom HTTP endpoints are caller-selected; HTTPS outside
  local/private testing is a caller obligation where the provider permits HTTP.
- External branch protection, environment approval rules, secret configuration,
  and RubyGems trusted-publisher bindings are not proven by repository files.
- Large JSON bodies and SSE events are supported API contracts; arbitrary fixed
  rejection limits are not an acceptable security fix.

## 3. Attack Surface, Mitigations, and Attacker Stories

The following are hypotheses and review guidance, not confirmed findings.

| Priority | Scenario and capability gain | Prerequisites | Impact | Existing controls | Mitigation | Evidence |
| --- | --- | --- | --- | --- | --- | --- |
| High | Redirect or destination confusion sends credentials or a body to an unintended origin | Remote endpoint controls redirect or caller/provider origin handling is bypassed | Credential or payload disclosure | Cross-origin credential stripping, body rejection, HTTPS downgrade rejection, provider origin validation | Preserve origin validation and redirect controls | `lib/openai/internal/transport/base_client.rb:153-215`, `lib/openai/providers/azure.rb:141-147` |
| High | Candidate PR code reaches live/release credentials or publishing authority | Privileged workflow executes candidate code or exposes secrets/write tokens | Credential theft or release compromise | Main-only conditions, named environments, least-privilege permissions, trusted publisher separation | Keep candidate and live/release workflows isolated | `.github/workflows/live-smoke.yml:17-92`, `.github/workflows/create-releases.yml:17-79` |
| High | Candidate-associated workflow metadata or Git objects influence the write-capable Castiron publisher without the path-specific trusted validation | Attacker controls a PR head or associated workflow metadata and a status, successful-comment, or fallback-comment check regresses | Forged or stale commit statuses and PR comments | Statuses use main-sourced recomputation plus run/head/base checks; successful comments use a trusted report artifact; fallback comments rely on main-sourced event/path, current-head, and monotonic-replacement checks | Preserve each path's distinct recomputation, freshness, artifact-binding, or fallback-isolation checks before its write | `.github/workflows/castiron-custom-code-comment.yml:34-98`, `.github/workflows/castiron-custom-code-comment.yml:116-171`, `.github/workflows/castiron-custom-code-comment.yml:174-237` |
| High | A dependency declaration or lockfile selects malicious package code, native extension, or install/build script | Lower-trust change alters a source, Git revision, transitive dependency, or executable package hook that CI or a consumer installs; the contributor/CI bundle currently includes Git-sourced `syntax_tree-rbs` locked at `247832988a850b8df050cf207f652872fda49973` | Code execution in CI or consumer applications | Reviewed lockfiles and dependency policy; ordinary CI executes the selected dependency with its runner authority | Review direct/transitive dependencies, sources, locked revisions, native extensions, and scripts before acceptance | `AGENTS.md:39-42`, `Gemfile:3-15`, `Gemfile.lock:1-20`, `openai.gemspec:18-48`, `docs/Gemfile:1-8`, `docs/Gemfile.lock:1-21` |
| High | Workload/provider token is sent to an unintended issuer or origin | Lower-trust configuration or response can alter a protected destination | Credential disclosure or forged authentication | Fixed/default issuer paths, origin checks, X.509 destination restrictions | Preserve strict destination and proxy/redirect handling | `lib/openai/auth/workload_identity_auth.rb:303-330`, `lib/openai/providers/bedrock.rb:398-427` |
| High | Realtime bearer credentials, proxy credentials, or trace data reach an unintended destination or audience | Lower-trust destination, proxy, TLS, or tracing behavior bypasses handshake controls | Credential disclosure or authenticated connection to the wrong peer | Base-URL/provider restrictions, proxy-header stripping, WSS verification, proxy handling, trace redaction | Preserve destination/TLS/proxy/redaction controls independently from event parsing | `lib/openai/helpers/realtime/client_extension.rb:167-280`, `lib/openai/helpers/realtime/transports/async_websocket.rb:185-224`, `lib/openai/helpers/realtime/transports/async_websocket.rb:294-378` |
| Medium | Malformed or adversarial API/SSE/WebSocket data causes sensitive leakage, type confusion, or availability failure | Victim consumes untrusted remote data | Data exposure, incorrect application behavior, or DoS | JSON parsing, typed coercion, protocol errors, safe unknown events | Keep parsers data-only, incremental where applicable, and redact errors/logs | `lib/openai/internal/stream.rb:21-60`, `lib/openai/helpers/realtime/connection.rb:61-84` |
| Medium | Forged webhook, or replay of a captured valid webhook, becomes an accepted typed event | For forgery, attacker lacks the webhook secret; for replay, attacker can resend a valid signed payload within the tolerance window | Application accepts an unauthentic or repeated event | Required headers, HMAC, and timing-safe comparison reject forgery; timestamp validation bounds replay age but does not deduplicate `webhook-id` | Verify before parsing; callers that need replay prevention must deduplicate `webhook-id` | `lib/openai/resources/webhooks.rb:15-119` |
| Medium | Sensitive runtime data leaks through diagnostics | Logging is enabled and untrusted data reaches logger/error/artifact | Credential, prompt, response, or file disclosure | Redacted headers/queries; unsafe body categories omitted | Preserve redaction and avoid raw sensitive artifacts | `lib/openai/internal/logging.rb:299-343`, `CONTRIBUTING.md:42-50` |
| Not a finding by itself | Contributor changes a tracked test/example/fixture/build script and ordinary CI runs it | Contributor already controls candidate checkout code | No new authority | Read-only ordinary CI without protected secrets | Require a separate privilege or boundary violation before reporting | `.github/workflows/ci.yml:18-32`, `.github/workflows/ci-checks.yml:100-120` |

## 4. Severity Calibration

- Critical: unauthorized release/publishing compromise, protected credential
  theft with broad impact, or a cross-account/tenant boundary failure.
- High: realistic credential disclosure, authenticated request redirection,
  protected CI/release boundary bypass, or forged authentication with meaningful
  account impact.
- Medium: production-reachable parser, webhook, retry, logging, or availability
  failures with bounded impact or meaningful prerequisites.
- Low: narrowly reachable confidentiality/integrity defects with limited impact
  and strong mitigating prerequisites.
- Out of scope without additional authority: ordinary execution of
  contributor-controlled tracked checkout code, caller-chosen dangerous
  configuration, caller-owned callbacks/custom transports, purely local
  self-effects, and hypothetical stories without a realistic lower-trust route
  to a sensitive operation.

Severity depends on the attacker's initial authority, the new capability gained,
reachability, deployment prerequisites, and effective controls. Missing evidence
is an explicit uncertainty, not proof that a control succeeds or fails.
