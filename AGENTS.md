# Contributor instructions

## Commit conventions

- Use the `examples:` Conventional Commit prefix for changes whose primary
  purpose is updating or fixing examples, including their dedicated tests. Apply
  the same prefix to pull request titles; do not use `fix:` or `fix(examples):`
  for these changes.
- Choose Conventional Commit prefixes based on user impact. Reserve `fix:` for
  changes that materially change the shipped gem's behavior in a way that
  impacts users. CI-only, workflow-only, build/test infrastructure, and
  repository-maintenance changes should use an appropriate non-user-facing
  prefix such as `ci:`. For example, a change like PR #572 should be titled
  `ci: restore Castiron statuses for fork PRs`, not `fix(ci): restore Castiron
  statuses for fork PRs`, because it changes CI behavior rather than gem
  behavior.

## Ruby implementation guidelines

- Prefer direct method calls over Ruby reflection (`send`, `__send__`, or `public_send`) for internal SDK plumbing. When an internal method must be callable across components without becoming supported public API, keep the method public for direct dispatch and mark it `@api private`. Keep its RBI and RBS declarations at the same visibility.

## Release maintenance

When regenerating `gemfiles/bedrock.gemfile.lock`, preserve the
`x-release-please` markers around the local `openai` version. Release Please
uses them to update this lockfile; Bundler can remove them when rewriting it.

## Custom-code budget

Follow [the custom-code guidance](scripts/castiron/CUSTOM_CODE.md). Budget changes
belong in a separate PR containing only `.castiron-ratchet.json`, with an explicit justification
in the PR description. Increases require a **human approving review** before merging.
Agents may investigate and draft proposals, but must not approve budget increases
(including through a human's credentials) or bypass the gate. Do not weaken
counting, broaden exclusions, or alter generation metadata to make a change pass.
The checker and effective budget come from main, not the PR. Keep default CODEOWNERS.

## Security requirements

- Never commit real API keys, access tokens, signing keys, credentials, or
  customer data. Read secrets from environment variables such as
  `OPENAI_API_KEY` and use clearly fake values in examples, tests, and fixtures.
- Redact authorization headers, cookies, tokens, signed URLs, customer data,
  and sensitive request/response bodies, prompts, or uploaded files from logs,
  errors, snapshots, and CI artifacts. Clearly fake or sanitized payloads may
  remain in tests and diagnostics.
- Review direct and transitive dependency changes in `Gemfile`, `Gemfile.lock`,
  `docs/Gemfile`, `docs/Gemfile.lock`, and `openai.gemspec`, including gem
  sources, locked Git revisions, native extensions, and install/build scripts.
  Do not run unreviewed scripts.
- Pin GitHub Actions to full commit SHAs and preserve least-privilege job
  permissions, `permissions: {}`, and `persist-credentials: false`.
- Protect GitHub App private keys and release credentials. Preserve protected
  release environments and RubyGems trusted publishing; grant `id-token: write`
  only to the publishing job and never introduce long-lived publishing tokens.
- Request `@openai/sdks-team` review for changes involving authentication,
  endpoints/transports, redirects, TLS, file uploads/paths, deserialization,
  logging, webhooks, dependencies, or CI/release behavior. Add focused
  regression/security tests and follow the generated-code guidance in
  [CONTRIBUTING.md](CONTRIBUTING.md).
- Report suspected vulnerabilities privately as described in
  [SECURITY.md](SECURITY.md), never in public issues or pull requests.

## Large-payload compatibility

Treat large payloads as a normal API contract, not evidence of malformed or
hostile input. Responses, Chat Completions, and other APIs can legitimately
return large `application/json` bodies and SSE streaming events. Do not introduce
arbitrary fixed limits on HTTP bodies, events, or lines as a security or efficiency
fix. Prefer incremental processing, amortized-linear buffering, timely cleanup,
and caller cancellation. Any new
rejection limit needs an explicit, owner-approved API contract and a review of
existing supported payloads and transports.

Protect this behavior with focused, deterministic public-entrypoint tests using
large synthetic payloads generated in memory, not committed captures or live
image generation. Their high memory use is intentional: do not shrink the
payloads or raise client limits to make the tests pass. Keep coverage to the main
HTTP JSON and streaming categories, and run large cases sequentially to keep peak
memory reasonable. The fixture size is a regression probe, not a new API maximum.
