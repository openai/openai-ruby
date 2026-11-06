# Contributor instructions

## Commit conventions

- Use `examples:` for commits and PR titles primarily changing examples or their dedicated tests; never `fix:` or `fix(examples):`.
- Otherwise choose Conventional Commit prefixes by user impact: reserve `fix:` for material shipped-gem behavior changes. CI/workflow/build/test infrastructure and repository maintenance use non-user-facing prefixes such as `ci:`.

## Ruby implementation guidelines

Prefer direct calls over `send`, `__send__`, or `public_send` for internal plumbing. Cross-component internal methods should remain public for direct dispatch, marked `@api private`; match RBI/RBS visibility.

## Release maintenance

Preserve `x-release-please` markers around the local `openai` version when regenerating `gemfiles/bedrock.gemfile.lock`; Bundler can remove them. See [Running tests](CONTRIBUTING.md#running-tests) for the Bedrock bundle workflow.

## Generated-file ownership

Follow [Generated-file ownership](CONTRIBUTING.md#generated-file-ownership) before editing SDK files.

## Security requirements

Apply [CONTRIBUTING's security requirements](CONTRIBUTING.md#security-requirements) for secrets/fixtures, diagnostic redaction (including tokens), dependency review, CI/publishing protections, `@openai/sdks-team` review, and focused regression/security tests. Security review includes all logging changes. Report vulnerabilities privately through [SECURITY.md](SECURITY.md).

## Large-payload compatibility

Large `application/json` bodies and SSE events are normal Responses, Chat Completions, and other API output. Do not add arbitrary fixed HTTP body/event/line limits as security or efficiency fixes. Any new rejection limit requires an explicit owner-approved API contract and review of supported payloads/transports. Prefer incremental processing, amortized-linear buffering, timely cleanup, and caller cancellation.

Use focused deterministic public-entrypoint tests with large synthetic in-memory payloads, not committed captures/live image generation. High memory use is intentional: do not shrink payloads or raise client limits to pass tests. Cover the main HTTP JSON/streaming categories; run large cases sequentially. Fixture sizes are regression probes, not new API maxima.
