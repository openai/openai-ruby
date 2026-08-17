# X.509 workload identity federation

X.509 workload identity federation is available for HTTP APIs. It replaces the
API key with a short-lived bearer token obtained by presenting a client
certificate. Realtime WebSocket TLS, token resolution, and reconnect behavior
are outside this phase.

## Configuration boundary

`OpenAI::Auth::X509WorkloadIdentity` contains only the identity-provider ID,
service-account ID, and refresh buffer. It has no subject-token provider and
does not retain certificate material.

The injected HTTP transport owns certificate chains, private keys,
passphrases, server trust, proxies, HSM integration, connection pooling, and
rotation. The SDK never closes a caller-supplied transport. Scope the transport
so it presents the client certificate only to the fixed auth origin and the API
origin selected by the application.

## HTTP behavior

The first authenticated request lazily sends this request through the effective
`http_client`:

```text
POST https://mtls.auth.openai.com/oauth/token
Content-Type: application/json

{
  "grant_type": "urn:ietf:params:oauth:grant-type:token-exchange",
  "subject_token_type": "urn:openai:params:oauth:token-type:x509",
  "identity_provider_id": "idp_...",
  "service_account_id": "svc_acct_..."
}
```

The JSON structurally omits `subject_token`. The endpoint is fixed and cannot
be overridden. Redirect responses are rejected. When neither `base_url` nor
`OPENAI_BASE_URL` is configured, only X.509 clients default to
`https://mtls.api.openai.com/v1`; an explicit HTTPS base URL wins.
Provider-owned API origins, including Azure OpenAI endpoints, cannot receive
OpenAI workload credentials, whether configured explicitly, through
`OPENAI_BASE_URL`, or when copying a client with `with_options`.

The configured API base URL establishes the only allowed API origin for that
X.509 client. Before acquiring a token and again immediately before dispatch,
the SDK requires HTTPS and compares the normalized scheme, host, and effective
port. Uppercase hostnames and an explicit default `:443` are equivalent. The
SDK rejects userinfo or ambiguous authorities, cross-origin absolute request
paths and redirects, explicit `Host` headers, and request-hook changes to
credential headers. Header-name checks are case-insensitive and treat `_` as
`-`, matching common reverse-proxy normalization. Target API requests reject
`api-key`, `x-api-key`, and `Proxy-Authorization` aliases; bearer-authenticated
requests also reject per-request `Authorization` overrides. Configure proxy
credentials on the transport so they are added only to CONNECT. This prevents
X.509 mode from silently mixing or forwarding another credential. Explicit
admin-authenticated operations and non-credential request-hook changes remain
supported.

The injected `http_client` must dispatch the exact immutable request supplied
by the SDK. It must not follow redirects internally, rewrite request URLs, or
inject application credentials. Those actions occur inside the caller-owned
transport, beyond the SDK's final controllable validation boundary.

The SDK validates a positive numeric `expires_in`, caches the bearer against a
monotonic clock, clamps the refresh buffer to half the returned TTL, and
collapses concurrent exchanges into one refresh. Transient connection errors,
`408`, `409`, `429`, and `5xx` responses receive bounded retries that honor
`Retry-After`; retryable response bodies are closed without being drained.
OAuth `400`, `401`, and `403` responses are not retried. A present `token_type`
must be `Bearer` (case-insensitive), and access tokens must match the RFC 6750
bearer-token grammar before caching or transmission. A missing `token_type`
remains accepted for compatibility.

An API `401` invalidates the rejected bearer and retries exactly once only when
the original request body is replayable. Streaming and other one-shot bodies
are never replayed automatically. A second `401` invalidates the refreshed
bearer without another replay. API retries also recheck the cache after backoff
and never resend a bearer that another request invalidated or replaced.

## Toggle and native TLS setup

Use an application-owned rollout toggle:

```text
OPENAI_AUTH_MODE=api_key | x509
OPENAI_IDENTITY_PROVIDER_ID=idp_...
OPENAI_SERVICE_ACCOUNT_ID=svc_acct_...
OPENAI_MTLS_CERTIFICATE_CHAIN=/path/client-chain.pem
OPENAI_MTLS_PRIVATE_KEY=/path/client-key.pem
OPENAI_MTLS_PRIVATE_KEY_PASSWORD=optional
OPENAI_BASE_URL=https://mtls.api.openai.com/v1  # optional
```

The certificate-chain file must place the leaf first, followed by required
intermediates. `OpenSSL::PKey.read` supports encrypted PEM keys when the
application supplies the password. The SDK does not implicitly read any of
these certificate-related environment variables. See the complete
[`OPENAI_AUTH_MODE` example](examples/x509_workload_identity.rb).

## Forks and rotation

Create the OpenAI client and its HTTP transport after a process forks. The
default `OpenAI::NetHTTPClient` partitions its pools by origin, so auth-host and
API-host connections do not mix.

Treat the certificate configuration captured by a transport as immutable. To
rotate it, build new HTTP and OpenAI clients together, atomically route new work
to them, and close the application-owned retired HTTP client after its
in-flight work completes.
