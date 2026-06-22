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

The region is resolved from the explicit `region` option, `AWS_REGION`, `AWS_DEFAULT_REGION`, or the selected AWS profile. Override the endpoint with `base_url` or `AWS_BEDROCK_BASE_URL`:

```ruby
provider = OpenAI::Providers.bedrock(
  region: "us-west-2",
  base_url: "https://bedrock.example.com/v1"
)
```

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

The provider signs each finalized attempt with AWS SigV4 service name `bedrock-mantle`. Standard JSON API requests have replayable bodies and work normally. SigV4 rejects one-shot request streams before sending, and signed requests do not automatically follow redirects because a new target requires a new signature. Response streaming is unaffected.

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

## Security

Use Bedrock from a server-side Ruby runtime. Prefer roles, profiles, SSO, and temporary credentials over long-lived static keys. Do not send AWS access keys, session tokens, bearer credentials, or signed authorization headers to browsers or application logs.
