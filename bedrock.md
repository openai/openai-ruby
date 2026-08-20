# Amazon Bedrock

Configure the standard `OpenAI::Client` with the Bedrock provider to use [Amazon Bedrock's OpenAI-compatible API](https://docs.aws.amazon.com/bedrock/latest/userguide/models-api-compatibility.html):

```ruby
require "openai"

client = OpenAI::Client.new(
  provider: OpenAI::Providers.bedrock(region: "us-west-2")
)

response = client.responses.create(
  model: ENV.fetch("BEDROCK_MODEL"),
  input: "Say hello!"
)

puts(response.output_text)
```

The provider uses `https://bedrock-mantle.<region>.api.aws/v1` by default and exposes the normal SDK resources. AWS controls which endpoints and features are supported; unsupported calls surface as normal API errors.

## Bedrock Runtime

Pass `endpoint: :runtime` to use the Bedrock Runtime OpenAI-compatible endpoint. The provider routes requests to `https://bedrock-runtime.<region>.amazonaws.com/openai/v1` and uses the AWS SigV4 signing service `bedrock` when AWS credentials are selected:

```ruby
require "openai"

client = OpenAI::Client.new(
  provider: OpenAI::Providers.bedrock(
    endpoint: :runtime,
    region: "us-east-1"
  )
)

completion = client.chat.completions.create(
  model: "us.openai.gpt-5.6-sol",
  messages: [{role: :user, content: "Say hello!"}]
)

puts(completion.choices.first.message.content)
```

Use the inference profile configured for your AWS account, for example `us.openai.gpt-5.6-sol`, `us.openai.gpt-5.6-terra`, or `us.openai.gpt-5.6-luna`. Global inference profiles, such as `global.openai.gpt-5.6-sol`, require the appropriate AWS account and regional permissions. Set `BEDROCK_MODEL` to override the model used by [`examples/bedrock_runtime.rb`](examples/bedrock_runtime.rb). The example uses Chat Completions by default; set `BEDROCK_RESPONSES=1` to also use Responses or `BEDROCK_STREAM=1` to also stream Chat Completions. Set `BEDROCK_AUTH_MODE=sigv4` to explicitly select AWS authentication when a bearer credential is also present.

The same client supports Responses and response streaming when AWS makes those APIs available for the selected model:

```ruby
response = client.responses.create(
  model: "us.openai.gpt-5.6-sol",
  input: "Say hello!"
)

stream = client.chat.completions.stream(
  model: "us.openai.gpt-5.6-sol",
  messages: [{role: :user, content: "Say hello!"}]
)

stream.text.each { |text| print(text) }
```

The existing Mantle endpoint remains the default. Pass `endpoint: :mantle` when you need to explicitly select it. Both endpoint symbols and the strings `"runtime"` and `"mantle"` are accepted.

| Endpoint | Default URL | SigV4 signing service |
| --- | --- | --- |
| `:mantle` (default) | `https://bedrock-mantle.<region>.api.aws/v1` | `bedrock-mantle` |
| `:runtime` | `https://bedrock-runtime.<region>.amazonaws.com/openai/v1` | `bedrock` |

Runtime URLs automatically use the correct DNS suffix for AWS China, European Sovereign Cloud, and isolated partitions. Canonical Runtime, FIPS, and dual-stack `base_url` values automatically select Runtime when `endpoint` is omitted. Canonical AWS endpoint URLs must use HTTPS, match the selected endpoint family, and agree with the configured AWS region.

## Endpoint configuration

The region is resolved from the explicit `region` option, `AWS_REGION`, `AWS_DEFAULT_REGION`, or the selected AWS profile. Override the endpoint with `base_url` or `AWS_BEDROCK_BASE_URL`:

```ruby
provider = OpenAI::Providers.bedrock(
  endpoint: :runtime,
  region: "us-west-2",
  base_url: "https://bedrock.example.com/openai/v1"
)
```

Custom endpoints using AWS credentials default to Mantle signing when `endpoint` is omitted; pass `endpoint: :runtime` to use Runtime signing. Local HTTP proxies remain supported when the endpoint is selected explicitly. Custom endpoints using bearer credentials can omit `endpoint`; in that case the default remains Mantle.

## Authentication

The provider selects authentication in this order:

1. One explicit mode passed to `bedrock(...)`: `api_key`, `token_provider`, static AWS credentials, `profile`, or `credentials_provider`.
2. The Bedrock bearer credential in `AWS_BEARER_TOKEN_BEDROCK`.
3. The standard AWS credential chain.

Explicit bearer and AWS credential modes are mutually exclusive. Configure only one explicit AWS mode at a time.

### AWS credentials and SigV4

AWS authentication is an optional integration so applications that do not use Bedrock do not install or load AWS packages. Add the AWS SDK core gem to your application:

```ruby
gem "aws-sdk-core", "~> 3"
```

Then run `bundle install`. If you are not using Bundler, run `gem install aws-sdk-core`.

Omit explicit authentication to use environment credentials, the shared credentials and config files, SSO or assume-role profiles, web identity, ECS credentials, or EC2 instance credentials:

```ruby
client = OpenAI::Client.new(
  provider: OpenAI::Providers.bedrock(region: "us-west-2")
)
```

Select a named profile with:

```ruby
client = OpenAI::Client.new(
  provider: OpenAI::Providers.bedrock(
    region: "us-west-2",
    profile: "engineering"
  )
)
```

You can omit `region` when that profile defines one in `~/.aws/config`.

Pass temporary credentials directly, including the session token:

```ruby
client = OpenAI::Client.new(
  provider: OpenAI::Providers.bedrock(
    region: "us-west-2",
    access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
    secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY"),
    session_token: ENV["AWS_SESSION_TOKEN"]
  )
)
```

For credentials managed by your application, pass an AWS credential provider or a callable that returns `Aws::Credentials`. It is consulted before every request attempt, including retries:

```ruby
credentials_provider = lambda do
  Aws::Credentials.new(
    ENV.fetch("AWS_ACCESS_KEY_ID"),
    ENV.fetch("AWS_SECRET_ACCESS_KEY"),
    ENV["AWS_SESSION_TOKEN"]
  )
end

client = OpenAI::Client.new(
  provider: OpenAI::Providers.bedrock(
    region: "us-west-2",
    credentials_provider: credentials_provider
  )
)
```

The provider signs each finalized attempt with AWS SigV4 service name `bedrock-mantle` for Mantle or `bedrock` for Runtime. Standard JSON API requests have replayable bodies and work normally. SigV4 rejects one-shot request streams before sending, and signed requests do not automatically follow redirects because a new target requires a new signature. Response streaming is unaffected.

### Bearer authentication

Pass a Bedrock bearer credential directly, set `AWS_BEARER_TOKEN_BEDROCK`, or use a callable to resolve a fresh token before every attempt:

```ruby
client = OpenAI::Client.new(
  provider: OpenAI::Providers.bedrock(
    region: "us-west-2",
    api_key: ENV.fetch("BEDROCK_API_KEY")
  )
)
```

```ruby
client = OpenAI::Client.new(
  provider: OpenAI::Providers.bedrock(
    region: "us-west-2",
    token_provider: -> { refresh_bedrock_token }
  )
)
```

Bearer authentication does not load or require `aws-sdk-core`. Passing `api_key: nil` explicitly skips `AWS_BEARER_TOKEN_BEDROCK` and selects AWS authentication.

## Live verification

Real AWS requests are disabled in the test suite unless `BEDROCK_LIVE_TEST=1` is explicitly set. To exercise Runtime against all three default US inference profiles, run:

```sh
AWS_REGION=us-east-1 BEDROCK_LIVE_TEST=1 \
  BUNDLE_GEMFILE=gemfiles/bedrock.gemfile \
  bundle exec ruby test/openai/providers/bedrock_live_test.rb
```

Set `BEDROCK_AUTH_MODE` to `auto`, `bearer`, `token-provider`, `sigv4`, `static`, or `profile` to select credentials. Use `BEDROCK_MODEL` for one inference profile or `BEDROCK_LIVE_MODELS` for a comma-separated list. Set `BEDROCK_LIVE_RESPONSES=1` to also verify Responses and `BEDROCK_LIVE_STREAM=1` to verify Chat Completions streaming.

## Security

Use Bedrock from a server-side Ruby runtime. Prefer roles, profiles, SSO, and temporary credentials over long-lived static keys. Do not send AWS access keys, session tokens, bearer credentials, or signed authorization headers to browsers or application logs.
