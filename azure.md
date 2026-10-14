# Microsoft Azure OpenAI

Configure the standard `OpenAI::Client` with the Azure provider to use the
[Azure OpenAI v1 API](https://learn.microsoft.com/azure/foundry/openai/api-version-lifecycle):

```ruby
require "openai"

client = OpenAI::Client.new(
  provider: OpenAI::Providers.azure(
    endpoint: ENV.fetch("AZURE_OPENAI_ENDPOINT"),
    api_key: ENV.fetch("AZURE_OPENAI_API_KEY")
  )
)

response = client.responses.create(
  model: ENV.fetch("AZURE_OPENAI_DEPLOYMENT"),
  input: "Say hello!"
)

puts(response.output_text)
```

The `model` parameter is the Azure model deployment name. The provider exposes
the normal Ruby SDK resources, request and response models, retries, pagination,
streaming helpers, and custom HTTP transport. Azure controls which resources and
features are available for a deployment; unsupported calls surface as normal API
errors.

## Endpoint configuration

Pass the Azure resource endpoint or set `AZURE_OPENAI_ENDPOINT`:

```ruby
provider = OpenAI::Providers.azure(
  endpoint: "https://my-resource.openai.azure.com",
  api_key: ENV.fetch("AZURE_OPENAI_API_KEY")
)
```

The provider appends `/openai/v1` when it is absent. These values therefore
configure the same base URL:

```text
https://my-resource.openai.azure.com
https://my-resource.openai.azure.com/openai
https://my-resource.openai.azure.com/openai/v1/
```

The endpoint must be an absolute HTTP or HTTPS URL without user information, a
query string, or a fragment. Use HTTPS outside local testing. A path prefix is
preserved for gateways and private routing, for example
`https://gateway.example.com/azure` becomes
`https://gateway.example.com/azure/openai/v1`.

## Authentication

Configure exactly one authentication mode explicitly. If neither is explicit,
the provider uses `AZURE_OPENAI_API_KEY`.

### Azure API key

Pass `api_key` or set `AZURE_OPENAI_API_KEY`. The provider sends it in Azure's
`api-key` header:

```ruby
provider = OpenAI::Providers.azure(
  endpoint: ENV.fetch("AZURE_OPENAI_ENDPOINT"),
  api_key: ENV.fetch("AZURE_OPENAI_API_KEY")
)
```

Passing `api_key: nil` explicitly skips the environment fallback.

### Microsoft Entra bearer token

Pass a callable that returns a current access token for Azure OpenAI. Credential
acquisition stays with the application, so the SDK does not require an Azure
identity package:

```ruby
provider = OpenAI::Providers.azure(
  endpoint: ENV.fetch("AZURE_OPENAI_ENDPOINT"),
  token_provider: -> {
    credential.get_token("https://cognitiveservices.azure.com/.default").token
  }
)
```

An explicit `token_provider` takes precedence over an ambient
`AZURE_OPENAI_API_KEY`. It is invoked immediately before every request attempt,
including API retries, so applications can refresh short-lived tokens without
rebuilding the client.

## Security

The provider validates the request origin before attaching an API key or bearer
token. It refuses to authenticate redirects or custom requests whose origin
differs from the configured Azure endpoint. Custom `Authorization` and `api-key`
headers cannot be combined with provider-owned authentication.

Keep credentials out of source control and logs. Prefer short-lived Microsoft
Entra tokens to long-lived API keys for production workloads.

## Dated Azure APIs

This provider targets the GA Azure OpenAI v1 API. It does not support dated API
versions such as `2025-04-01-preview`, inject `api-version` query parameters, or
rewrite generated resource paths to `/deployments/{deployment}`. Use the v1 API
for new integrations.
