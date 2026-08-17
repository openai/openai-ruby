# Contributor instructions

## Ruby implementation guidelines

- Prefer direct method calls over Ruby reflection (`send`, `__send__`, or `public_send`) for internal SDK plumbing. When an internal method must be callable across components without becoming supported public API, keep the method public for direct dispatch and mark it `@api private`. Keep its RBI and RBS declarations at the same visibility.

## Security requirements

- Never commit real API keys, access tokens, signing keys, credentials, or
  customer data. Read secrets from environment variables such as
  `OPENAI_API_KEY` and use clearly fake values in examples, tests, and fixtures.
- Redact authorization headers, cookies, tokens, signed URLs, customer data,
  and sensitive request/response bodies, prompts, or uploaded files from logs,
  errors, snapshots, and CI artifacts. Clearly fake or sanitized payloads may
  remain in tests and diagnostics.
- Review direct and transitive dependency changes in `Gemfile`, `Gemfile.lock`,
  and `openai.gemspec`, including gem sources, locked Git revisions, native
  extensions, and install/build scripts. Do not run unreviewed scripts.
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
